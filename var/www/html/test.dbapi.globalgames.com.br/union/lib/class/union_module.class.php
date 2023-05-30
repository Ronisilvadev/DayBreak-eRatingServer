<?php


if(!defined('INTERMODAL')) {
	exit('Access Denied');
}

class union_module {
	
	public static $union_memcache = null;
	public static $cache_file_enable = false;
	public static $cache_memcache_enable = false;
	
	public static $_intput_param  = array();

	/**
	 * 接口参数初始化
	 * 
	 */
	public static function init() {
		// 
		self::$_intput_param = $_REQUEST;
	}
	
	
	/*
	*	处理参数
	*
	*/
	public static function process(){
		 
		 
	}
	
	
	
	/**
	 * 	联运系统接口初始化
	 * 	
	 */
	 
	public static function _init_config() {
		global $_config;

		// 缓存Memcache设置
		if ($_config['cache']['memcache']) {
			include_once LIB_PATH.'/class/union_memcache.class.php';
			self::$union_memcache = new union_memcache();
			if (is_object(self::$union_memcache)) {
				self::$cache_memcache_enable = TRUE;
			}
		}
		
		// File 缓存设置
		if ($_config['cache']['file']) {
			$cache_dir = DATA_PATH.'/cache';
			if (!is_dir($cache_dir)) {
				mkdir_recursive($cache_dir, '0755');
			}
			if (is_writable($cache_dir)) {
				self::$cache_file_enable = TRUE;
			}
		}
	}
	
	/**
	*	获取服务器信息
	*	Return: Array
	*/
	
	public static function get_server_info($serverId){
		global $_config;
		static $file_cache = array();
		$serverId = strtolower($serverId);
		
		//从缓存文件file_cache读取
		$f_cache_path = DATA_PATH.'/server/server_info.php';
		$f_cache = array();
		if(file_exists($f_cache_path)){
			if(isset($file_cache[$serverId])){
				return $file_cache[$serverId];
			}else{
				@include_once $f_cache_path;
				if(isset($f_cache[$serverId])){
					$file_cache = $f_cache;
					return $file_cache[$serverId];
				}else{
					$message = trace_message('Input serverId wrong',array('serverId'=>$serverId));
					$file = substr(CURSCRIPT, 0, -4);
					log_message($file,$message,'error:server_error');
					
					if(CURSCRIPT == 'login_api'){
						self::_redirect_error('-1002');
					}else{						
						exit('-1002');
					}
				}
			}
		}else{
			trigger_error('class_union_module_get_server_info', E_USER_WARNING);
		}
	}

	/**
	 * 	联运接口IP检测
	 * 	Return:
	 */
	public static function ip_safe_check($_config) {
		$allow_state = 1;
		if ($_config['checkip'] && !ipaccess($_config['client_ip'], $_config['charging_allow_ip'])) {
			$union_log =& load_class('union_log');
			$union_log_result = $union_log->write_Log('ip_access_prohibit', 'union_module:ip_safe_check, prohibit_access_ip.','error:ip_error');
			//trigger_error('prohibit_access_ip', E_USER_ERROR);
			exit('-11000');//-11000:非法ip调用
		}
		return $allow_state;
	}
	
	/*
		跳转错误页面
	
	*/
	public static function _redirect_error($err_code = ''){
		global $_config;
		self::init();
		
		$error_url = get_array_value('redirectUrl',self::$_intput_param);
		
		if('' == $error_url){
			$error_url = $_config['error_url']."?err=".$err_code;
		}
		header ('Location: '.$error_url);
		exit;
	}
	
}

// Union Module End