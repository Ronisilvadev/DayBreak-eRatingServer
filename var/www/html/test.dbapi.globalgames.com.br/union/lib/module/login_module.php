<?php

if(!defined('INTERMODAL')) exit('Access Denied');

require CLASS_PATH.'/union_module.class.php';

class Login_Module extends union_module{
	
	public static $union_param = array();
	public static $login_params = array();
	protected static $type = 1;
	protected static $userpwd = 1;
	protected static $uid = '';
	
	public static function run(){
		self::$login_params = $_REQUEST;
		
		$request_string = ab2log(self::$login_params);
		log_message('login',$request_string,'info:request_string');
		
		self::login();
	}
	
	/**
	*	登陆
	*/
	public static function login(){
		
		global $_config;
		
		//参数验证
		if (! self::verify_login()) {
			
			log_message('login', 'login_sign_verification_failed', 'error:login_sign_error');
			self::_redirect_error('-101');
		}
		
		//联运参数赋值
		$union_param = self::$union_param;
		
		//时间校验
		$diff_time = TIMESTAMP - $union_param['time'];
		
		if($diff_time>$_config['expire_time']){
			
			//做日志记录
			$message = trace_message('Time validation fails, current time = ' . date ('Y-m-d H:i:s') . ', login_time = '.date ('Y-m-d H:i:s', $union_param ['time']));
			log_message('login', $message, 'error:time_expired');
			
			self::_redirect_error('-102');
		}
		
		//做登陆游戏的签名
		$intermodal = load_class('intermodal');
		$union_param ['sign'] = $intermodal -> get_mysign($union_param);
		$union_param ['serverId'] = strtoupper ( $union_param ['serverId'] );
		
		//记录参数
		$union_param_string = ab2log($union_param);
		$union_param_string = trace_message('The union_params:',array('union_param'=>$union_param_string));
		log_message('login','union_params:'.$union_param_string,'info:sign_success');
		
		// 登陆游戏
		$login_param = array (
			'username' 	=> urlencode ( $union_param ['username'] ),
			'uid' 		=> $union_param ['username'],
			'time' 		=> $union_param ['time'],
			'serverId' 	=> $union_param ['serverId'],
			'isAdult' 	=> $union_param ['adult'],
			'sign' 		=> $union_param ['sign'],
		);
		
		$domain = 'http://' . $union_param ['serverId'] . '.' . $_config['domain'];
		$login_query = http_build_query ( $login_param );
		$login_url = $domain . '/daybreak.html?' . $login_query;
		//$login_url = $domain . '/daybreak_vn.html?' . $login_query;//越南测试服
		
		//跳转登陆页面
		self::_redirect ( $login_url );
		
	}
	
	public static function verify_login(){
		
		global $_config;
		
		$input_params = self::$login_params;
		$sign = get_array_value('sign', $input_params);
		$sort_args = self::sort_args_login($input_params);
		$mysign = self::generate_mysign($sort_args, 'MD5');
		
		return (($sign == $mysign) || !$_config['verify_api_param']) ? true : false ;
	}
	
	/**
	*
	*	登陆参数排序
	*/
	
	public static function sort_args_login($param){
		global $_config;
		
		// 获取配置参数
		$gameid = intval($_config['gameid']);
		$key = trim($_config['security_key']);
		
		// 参数获取
		$username = urldecode(get_array_value('userName', $param));
		$time = get_array_value('time', $param);
		$adult = get_array_value('adult', $param);
		$redirectUrl = get_array_value('redirectUrl', $param);
		$serverId = get_array_value('serverId', $param);	
		
		// 获取联运接口服务器配置信息
		$serverinfo = self::get_server_info($serverId);
		$gatewayId = $serverinfo['gatewayid'];
		
		// 联运设置默认值
		$userpwd = self::$userpwd;
		$type = self::$type;
		
		// 定义待签名数组
		$sort_args = array(
			'userName' => $username,
			'serverId' => $serverId,
			'time' => $time,
			'key' => $key,
			'adult' => $adult,
		);
		
		// 定义接口验证通过返回数据
		self::$union_param = array(
			'username' 		=> $username,
			'uid' 			=> $username,
			'userpwd' 		=> $userpwd,
			'serverinfo' 	=> $serverinfo,
			'serverId' 		=> $serverId,
			'gameid' 		=> $gameid,
			'gatewayId'		=> $gatewayId,
			'time' 			=> $time,
			'type' 			=> $type,
			'adult' 		=> $adult,
			'redirecturl' 	=> $redirectUrl,
			'version' 		=> 2.0,
		);
		
		return $sort_args;
		
	}
	
	/**
	*	生成签名参数
	*	Return: $mysign
	*/
	public static function generate_mysign($sort_args, $sign_type) {
		// 把数组所有元素, 拼接成字符串 
		$prestr = implode('', $sort_args);
		// 把最终的字符串签名，获得签名结果
		return sign($prestr, $sign_type);
	}
	
	/**
	 * 页面跳转
	 * Location: $url
	 */
	public static function _redirect($url) {
		header ( 'Location: ' . $url );
		die ();
	}
	
}