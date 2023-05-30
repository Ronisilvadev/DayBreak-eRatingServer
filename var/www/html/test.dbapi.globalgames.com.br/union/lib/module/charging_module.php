<?php

if(!defined('INTERMODAL')) exit('Access Denied');

require CLASS_PATH.'/union_module.class.php';

class Charging_Module extends union_module{
	
	public static $charging_param = array();
	public static $union_param = array();
	
	public static function run(){
		self::$charging_param = $_REQUEST;
		
		$request_string = ab2log(self::$charging_param);
		log_message('charging',$request_string,'info:request_string');
		
		self::charge();
	}
	
	public static function charge(){
		global $_config;
		
		// IP Limit
		self::ip_safe_check($_config);
		
		$verify_result = self::verify_charging();
		//参数验证
		if($verify_result){
			$union_param = self::$union_param;
			
			//加载联运中间件
			$union_object = load_class('union');
			
			$union_result = $union_object->charging($union_param['unionCode'], $union_param['orderId'], $union_param['userName'], $union_param['chargeTime'], $union_param['chargeMoney'], $union_param['chargeAmount'], $union_param['gatewayId'], $union_param['gameId'], $union_param['clientIp']);
			
			//记录充值参数和结果
			$union_mid_strings = ab2log($union_param);
			$message = 'union mid param: '.$union_mid_strings.', union_result='.$union_result;
			log_message('charging', $message, 'info:union_mid_param');
			
			$union_object -> output_result($union_result);
			
		}else {
			// 接口调用参数验证失败
			$message = trace_message('signature_verification_failed',array('args'=>self::$charging_param));
			log_message('charging',$message,'error:sign_error');
			exit('-101');
		}
	}
	
	/**
	
	*	签名验证
	*/
	public static function verify_charging(){
		global $_config;
		$charging_param = self::$charging_param;
		
		$sign = get_array_value('sign', $charging_param);
		$sort_args = self::sort_args_charging($charging_param);
		$mysign = generate_mysign($sort_args, 'MD5');
		
		return (($sign == $mysign) || !$_config['verify_api_param']) ? true : false ;
		
	}
	
	/**
	*
	*	充值参数排序
	*/
	public static function sort_args_charging($param){
		global $_config;
		
		// 获取配置
		$unionCode = $_config['union_code'];
		$gameId = intval($_config['gameid']);
		$key = trim($_config['charging_key']);
		$chargeTime = date('YmdHis');
		// 获取参数
		$userName = urldecode(get_array_value('userName', $param));
		$serverId = get_array_value('serverId', $param);
		$orderId = get_array_value('orderId', $param);
		$chargeMoney = sprintf("%.2f", get_array_value('chargeMoney', $param));
		$clientIp = get_array_value('clientIp', $param);
		$chargeAmount = ceil($chargeMoney * $_config['charging_ratio']);
		
		// 获取联运接口服务器配置信息
		$server_info = self::get_server_info(strtolower($serverId));		
		$gatewayId = intval(get_array_value('gatewayid', $server_info));
		$gatewayId <= 0 && log_level('sort_args_charging:gatewayId <= 0');
		
		
		// 定义待签名数组
		$sort_args = array(
			'userName' => $userName,
			'serverId' => $serverId,
			'orderId' => $orderId,
			'chargeMoney' => $chargeMoney,
			'key' => $key,
		);
		
		//记录签名数组
		$sort_args_record = array(
			'userName' => $userName,
			'serverId' => $serverId,
			'orderId' => $orderId,
			'chargeMoney' => $chargeMoney,
		);
		$sort_args_strings = ab2log($sort_args_record);
		log_message('charging',$sort_args_strings,'info:sort_args');
		
		
		// 定义接口验证通过返回数据
		self::$union_param = array(
			'unionCode' => $unionCode,
			'orderId' => $orderId,
			'userName' => $userName,
			'chargeTime' => $chargeTime,
			'chargeMoney' => $chargeMoney,
			'chargeAmount' => $chargeAmount,
			'gatewayId' => $gatewayId,
			'gameId' => $gameId,
			'clientIp' => $clientIp,
			'version' => 2.0,
		);
		
		return $sort_args;	
		
	}
	
}