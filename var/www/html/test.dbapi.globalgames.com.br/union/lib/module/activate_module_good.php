<?php
/**
 * 黎明之光激活接口模块
 * 
 * $Id: activate.module.php 14044 2013-01-19 17:36:20Z hcz $
 */

if(!defined('INTERMODAL')) {
	exit('Access Denied');
}

/**
 * 载入联运模块
 *
 *
 */
include_once LIB_PATH.'/class/union_module.class.php';

class activate_module extends union_module {

	public static $activate_param = array();
	public static $union_param = array();
	
	/**
	 * 激活接口运行方法
	 */
	public static function run() {
		// 获取激活参数
		self::$activate_param = $_REQUEST;
		// 调用激活模块方法
		self::activate_action();
	}

	/**
	 * 联运激活模块方法
	 * 
	 * @return echo 
	 */
	public static function activate_action() {
		
		global $_config;
		
		// 获取激活接口参数
		$userName = @trim($_REQUEST['userName']);
		$keyCode = @trim($_REQUEST['keyCode']);
		$gatewayId = @trim($_REQUEST['gatewayId']);
		$gameId = @trim($_REQUEST['gameId']);
		
		$unionCode	= trim($_config['union_code']);
		$clientIp = get_client_ip();
		
		// 激活接口参数判断
		if (empty($userName) || empty($keyCode) || empty($gatewayId)) {
			$message = 'parameter is incomplete, params:'.ab2log(self::$activate_param);
			log_message('activate', $message, 'error:params_incomplete');
			exit('-101');
			
		}else{
			//记录参数
			$message = ab2log(self::$activate_param);
			log_message('activate', $message, 'info:request_params');
		}
		
		//gameId 判断
		if($gameId != $_config['gameid']){
			
			$message = 'gameId wrong:'.$gameId;
			log_message('activate', $message, 'error:gameId wrong');
			exit('-102');
		}
		
		//中间件数组
		self::$union_param = array(
			'unionCode'=>$unionCode,
			'userName' => $userName,
			'gameId' => $gameId,
			'gatewayId'=>$gatewayId,
			'keyCode' => $keyCode,
			'clientIp' => $clientIp,
		);
		
		// 联运参数
		$union_param = self::$union_param;
		
		// 联运中间件接口调用
		try {
			$union_object	=& load_class('union');
			
			$union_result = $union_object->activityUserBy($union_param['unionCode'], $union_param['userName'], $union_param['gameId'], $union_param['gatewayId'], $union_param['keyCode'], $union_param['clientIp']);
			
			//记录激活参数和结果
			$union_mid_strings = ab2log($union_param);
			$message = 'union mid param: '.$union_mid_strings.', union_result='.$union_result;
			log_message('activate', $message, 'info:union_mid_param');
			
			// 输出激活模块方法的结果
			$union_object -> output_result($union_result);
			
		} catch (Exception $e) {
			throw_exception($e, $type = 'Union_Exception', $code = 0);
		}
		
		
	}

}