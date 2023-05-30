<?php

if(!defined('INTERMODAL')) exit('Access Denied');

require CLASS_PATH.'/union_module.class.php';

class GiveItem_Module extends union_module{
	
	protected static $item_param = array();
	
	public static function run(){
		self::$item_param = $_REQUEST;
		
		$request_string = ab2log(self::$item_param);
		log_message('giveItem',$request_string,'info:request_string');
		
		self::give_item();
	}
	
	public static function give_item(){
		global $_config;
		
		// IP Limit
		self::ip_safe_check($_config);
		
		//参数验证
		if(self::verify_giveItem()){
			
			$item_param = self::$item_param;
			
			//加载联运中间件
			$union_object = load_class('union');
			
			$union_result = $union_object->giveItem($item_param['unionCode'], $item_param['gameId'], strtolower($item_param['userName']), $item_param['gatewayId'], $item_param['activityId'], $item_param['logId'], $item_param['sendTime'], $item_param['startTime'], $item_param['endTime'], $item_param['itemString']);
			
			//记录日志
			$union_mid_strings = ab2log($item_param);
			$message = 'giveItem_module::give_item union_mid_param:'.$union_mid_strings.', union_result='.$union_result;
			log_message('giveItem', $message, 'info:union_mid_param');
			
			$union_object -> output_result($union_result);
			
		}else {
			
			//记录日志
			$union_mid_strings = ab2log(self::$item_param);
			$message = 'giveItem_module::give_item request_param:'.$union_mid_strings;
			log_message('giveItem', $message, 'error:sign_error');
			exit('-101');
		}
		
	}
	
	protected static function verify_giveItem(){
		global $_config;
		
		$item_param = self::$item_param;
		$sign = get_array_value('sign', $item_param);
		$sort_args = self::sort_args_giveItem($item_param);
		$mysign = generate_mysign($sort_args, 'MD5');
		return (($sign == $mysign) || !$_config['verify_api_param']) ? true : false ;
	}
	
	
	public static function sort_args_giveItem($param){
		global $_config;
		
		//获取配置
		$unionCode = $_config['union_code'];
		$gameId = intval($_config['gameid']);
		$key = trim($_config['charging_key']);
		
		//获取参数
		$userName = urldecode(get_array_value('userName', $param));
		$activityId = get_array_value('activityId', $param);
		$logId = get_array_value('logId', $param);
		$sendTime = get_array_value('sendTime', $param);
		$startTime = get_array_value('startTime', $param);
		$endTime = get_array_value('endTime', $param);
		$itemString = get_array_value('itemString', $param);
		$serverId = get_array_value('serverId', $param);
		
		// 获取联运接口服务器配置信息
		$server_info = self::get_server_info($serverId);
		$gatewayId = intval(get_array_value('gatewayid', $server_info));
		$gatewayId <= 0 && log_level('sort_args_charging:gatewayId <= 0');
		
		//待签名数组
		$sort_args = array(
			'userName' => $userName,
			'serverId' => $serverId,
			'activityId' => $activityId,
			'logId' => $logId,
			'sendTime' => $sendTime,
			'startTime' => $startTime,
			'endTime' => $endTime,
			'itemString' => $itemString,
			'key' => $key
		);
		
		
		// 定义接口验证通过返回数据
		self::$item_param = array(
			'unionCode' => $unionCode,
			'gameId' => $gameId,
			'userName' => $userName,
			'serverId' => $serverId,
			'gatewayId' => $gatewayId,
			'activityId' => $activityId,
			'logId' => $logId,
			'sendTime' => $sendTime,
			'startTime' => $startTime,
			'endTime' => $endTime,
			'itemString' => $itemString,
		);
		
		return $sort_args;
		
	}	
	
}
