<?php

if(!defined('INTERMODAL')) exit('Access Denied');

require CLASS_PATH.'/union_module.class.php';

class GetRoleList_Module extends union_module{
	
	public static $request_param = array();
	public static $union_param = array();
	public static $log_file = '';
	
	public static function run(){
		
		self::$request_param = $_REQUEST;
		self::$log_file = substr(CURSCRIPT, 0, -4);
		
		$request_string = ab2log(self::$request_param);
		log_message(self::$log_file,$request_string,'info:request_param');
		
		self::do_run();
	}
	
	public static function do_run(){
		global $_config;
		
		$verify_result = self::verify_param();
		
		//参数验证
		if($verify_result){
			
			$union_param = self::$union_param;
			
			//加载联运中间件
			$union_object = load_class('union');
			
			$union_result = $union_object->getRoleList($union_param['unionCode'], $union_param['gameId'], $union_param['userName'], $union_param['gatewayId']);
						
			//记录充值参数和结果
			$union_mid_strings = ab2log($union_param);
			$message = 'union mid param: '.$union_mid_strings.', union_result='.$union_result;
			log_message(self::$log_file, $message, 'info:union_mid_param');
			
			$union_object -> output_result($union_result);
			
		}else {
			// 接口调用参数验证失败
			$message = trace_message('signature_verification_failed',array('args'=>self::$request_param));
			log_message(self::$log_file,$message,'error:sign_error');
			exit('-101');
		}
	}
	
	/**
	
	*	签名验证
	*/
	public static function verify_param(){
		global $_config;
		$request_param = self::$request_param;
		
		$sign = get_array_value('sign', $request_param);
		$sort_args = self::sort_args_charging($request_param);
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
		
		// 获取参数
		$userName = urldecode(get_array_value('userName', $param));
		$serverId = get_array_value('serverId', $param);
		$time = get_array_value('time', $param);
		
		// 获取联运接口服务器配置信息
		$server_info = self::get_server_info($serverId);
		$gatewayId = intval(get_array_value('gatewayid', $server_info));
		
		if($gatewayId <= 0){
			$message = trace_messaage('gatewayId is wrong.',array('server_info'=>$server_info));
			log_message(self::$log_file,$message,'error');
			exit('-1003');
		}
		
		// 定义待签名数组
		$sort_args = array(
			'userName' => $userName,
			'serverId' => $serverId,
			'time' => $time,
			'key' => $key,
		);
		
		//记录签名数组
		$sort_args_record = array(
			'userName' => $userName,
			'serverId' => $serverId,
			'time' => $time
		);
		
		$sort_args_strings = ab2log($sort_args_record);
		log_message(self::$log_file,$sort_args_strings,'info:sort_args');
		
		// 定义接口验证通过返回数据
		self::$union_param = array(
			'unionCode' => $unionCode,
			'userName' => $userName,
			'gatewayId' => $gatewayId,
			'gameId' => $gameId,
			'version' => 2.0,
		);
		return $sort_args;	
		
	}
	
}