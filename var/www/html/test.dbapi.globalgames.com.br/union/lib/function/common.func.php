<?php

/**
 * 获取联运配置
 * 
 * @return array $_config
 */
function &get_config() {
	static $_config;

	if (isset($_config)) {
		return $_config;
	}

	// Load global config, db, memcache config
	require_once CONFIG_PATH.'/config.php';
	// Load config
	$http_host = get_http_host();
	if (UNION_CONFIG === 'domain_config') {
		$sub_domain_name = substr($http_host, (strpos($http_host, '.') + 1));
		$domain_config_file = FONT_CONFIG_PATH.'/'.$sub_domain_name.'.php';
		if (preg_match("/[a-zA-Z0-9][-a-zA-Z0-9]{0,62}(\.[a-zA-Z0-9][-a-zA-Z0-9]{0,62})+\.?/", $sub_domain_name) 
				&& file_exists($domain_config_file)) {
			require_once $domain_config_file;
		} else {
			die('Failed to load the domain configuration');
		}
	} else {
		require_once FRONT_CONFIG_PATH.'/config.php';
	}
	
	// Does the $config array exist in the file?
	if (!isset($_config) || !is_array($_config)) {
		die('Your config file does not appear to be formatted correctly.');
	}
	// 
	$_config['HTTP_HOST'] = $http_host;
	// 获取 client_ip
	$_config['client_ip'] = get_client_ip();
	return $_config;
}


/**
*	加载类
*/
function & load_class($class, $sub_path = ''){
	$class_name = false;
	$class_file = CLASS_PATH.'/'.$class.'.class.php';
	if($sub_path != ''){
		$class_file = CLASS_PATH.'/'.$sub_path.'/'.$class.'.class.php';
	}
	
	if(file_exists($class_file)){
		$class_name = $class;
		if (class_exists($class) === false) {
			include_once $class_file;
		}
	}
	
	if($class_name === false){
		exit('Unable to locate the specified class: '.$class);
	}
	$class_object = & get_instance($class_name);
	
	return $class_object;
}

/**
	`实例化
*/
function &get_instance($class) {
	static $_loaded_classes = array();
	// class exists, return instance
	if (isset($_loaded_classes[$class])) {
		return $_loaded_classes[$class];
	}	
	$_loaded_classes[$class] = new $class();
	return $_loaded_classes[$class];
}

/**
	生成签名
*/
function sign($prestr, $sign_type = 'MD5') {
	$sign = '';
	$sign_type = strtoupper($sign_type);
	if ($sign_type == 'MD5') {
		$sign = md5($prestr);
	} else if ($sign_type == 'SHA1') {
		$sign = sha1($prestr);
	}
	return $sign;
}

/**
	生成我方签名
*/
function generate_mysign($sort_args, $sign_type){
	// 把数组所有元素, 拼接成字符串	
	$prestr = implode('', $sort_args);
	// 把最终的字符串签名，获得签名结果
	return sign($prestr, $sign_type);
}

/**
*	获取数组中指定的值
*	Return: $value
*/
function get_array_value($key, $array) {
	$return = null;
	if (is_string($key) && is_array($array)) {
		$value = isset($array[$key]) ? $array[$key] : null;
		$return = is_string($value) ? trim($value) : $value;
	}
	return $return;
}

/**
*	获取主机host
*	Return: $http_host
*/
function get_http_host() {
	$http_host = '';
	if ($http_host = get_array_value('HTTP_X_FORWARDED_HOST', $_SERVER)) {
		$elements = explode(',', $http_host);
		$http_host = trim(end($elements));
	} else {
		if (!$http_host = $_SERVER['HTTP_HOST']) {
			if (!$http_host = $_SERVER['SERVER_NAME']) {
				$http_host = !empty($_SERVER['SERVER_ADDR']) ? $_SERVER['SERVER_ADDR'] : '';
			}
		}
	}

	// Remove port number from host
	$http_host = preg_replace('/:\d+$/', '', $http_host);
	return trim($http_host);	
}

/**
 * 获取客户端 client_ip
 *
 * @return unknown
 */
function get_client_ip() {
	$ip = $_SERVER['REMOTE_ADDR'];
	if (isset($_SERVER['HTTP_CLIENT_IP']) && preg_match('/^([0-9]{1,3}\.){3}[0-9]{1,3}$/', $_SERVER['HTTP_CLIENT_IP'])) {
		$ip = $_SERVER['HTTP_CLIENT_IP'];
	} elseif(isset($_SERVER['HTTP_X_FORWARDED_FOR']) AND preg_match_all('#\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3}#s', $_SERVER['HTTP_X_FORWARDED_FOR'], $matches)) {
		foreach ($matches[0] as $xip) {
			if (!preg_match('#^(10|172\.16|192\.168|127\.0)\.#', $xip)) {
				$ip = $xip;
				break;
			}
		}
	}
	return $ip;
}

/**
 * http code 
 * 
 * @param unknown $status_code
 * @param string $header_info
 */
function http_header($status_code, $header_info = '') {
	$status_code = intval($status_code);
	switch ($status_code) {
		case 301:
			// 301 moved permanently (redirect): 
			header('HTTP/1.1 301 Moved Permanently');
		case 302:
			// 302 moved temporarily(redirect): 
			header('Location: '.$header_info);
			break;
		case 403:
			header("http/1.1 403 Forbidden");
			break;
		case 404:
			// 404 Page Not Found:
			header('HTTP/1.1 404 Not Found');
			break;
		case 503:
			// Service not avaliable: 
			header('HTTP/1.1 503 Service Temporarily Unavailable');
			header('Status: 503 Service Temporarily Unavailable');
			header('Retry-After: 60');
			break;
		default:
			// NULL
			header($header_info);
	}
}


/**
 * 自定义异常处理
 * 
 * @return
 */
function throw_exception($msg, $type = 'Union_Exception', $code = 0) {
	if (class_exists($type, false)) {
		throw new $type($msg, $code, true);
	} else {
		// 异常类型不存在则输出错误信息字串
		$union_error =& load_class('union_error');
		$union_error->system_error($msg, true, true, true);
	}
}

/**
 * 读取语言文件
 * 
 * @param string $key
 * @param string $value
 * @return multitype:|Ambigous <unknown, boolean>|unknown
 */
function lang($key, $value = null) {
	static $_static_lang = array();
	
	// 打印语言文件
	if (empty($key)) {
		return $_static_lang;
	}
	
	// 获取联运配置
	$_config =& get_config();
	
	// 语言模板加载
	if (empty($_static_lang)) {
		$lang = array();
		include_once LANG_PATH.'/'.$_config['lang'].'.lang.php';
		$_static_lang = @array_merge($_static_lang, $lang);
		$_static_lang['is_loaded'] = true;
	}
	// 返回语言定义
	if (is_string($key)) {
		if (is_null($value)) {
			return isset($_static_lang[$key]) ? $_static_lang[$key] : $key;
		}
		$_static_lang[$key] = $value;
	}
	return $key;
}

/**
 * Makes directory and returns BOOL(TRUE) if exists OR made.
 *
 * @param string $path
 * @param number $mode
 * @return boolean
 */
function make_dir($path, $mode = 0755) {
	is_dir(dirname($path)) || make_dir(dirname($path), $mode);
	return is_dir($path) || @mkdir($path, $mode);
}

/**
 * Tests for file writability
 *
 * @param unknown $file
 * @return boolean
 */
function is_really_writable($file) {
	if (DIRECTORY_SEPARATOR == '/' AND @ini_get("safe_mode") == FALSE) {
		return is_writable($file);
	}

	if (is_dir($file)) {
		$file = rtrim($file, '/').'/'.md5(mt_rand(1,100).mt_rand(1,100));
		if (($fp = @fopen($file, 'ab')) === FALSE) {
			return FALSE;
		}

		fclose($fp);
		@chmod($file, 0755);
		@unlink($file);
		return TRUE;
	} elseif (!is_file($file) OR ($fp = @fopen($file, 'ab')) === FALSE) {
		return FALSE;
	}
	fclose($fp);
	return TRUE;
}

/**
 *	建立文件夹
 * 
 */
function mkdir_recursive($pathname, $mode) {
	is_dir(dirname($pathname)) || mkdir_recursive(dirname($pathname), $mode);
	return is_dir($pathname) || @mkdir($pathname, $mode);
}

/**
*	保存数据缓存
*	Return: null
*/
function save_local_data($filename, $data, $filemode = 'w', $pathmode = 0755) {
	// 目录判断
	if (!is_dir($pathname = dirname($filename))) {
		mkdir_recursive($pathname, $pathmode);
	}
	// 日志记录
	$fp = @fopen($filename, $filemode);
	if($fp) {
		flock($fp, LOCK_EX);
		fwrite($fp, $data);
		flock($fp, LOCK_UN);
		fclose($fp);
	}
}

/**
 *	按行格式化日志
 *	Return:
 */
function strip_tags_line_log($data = '') {
	$client_ip = get_client_ip();
	$log_line = $client_ip."\t".strftime("%Y-%m-%d %H:%M:%S", time())."\t".strip_tags(str_replace(array("\r", "\n"), '', $data))."\n";
	return $log_line;
}

/**
 * 数组对象字符串拼接， 将数据按照有序对规则拼接成字符串， 例如：拼接成query, ?a=b&c=d
 *  
 * 
 * @param array|object $data
 * @param string $e_symbol
 * @param string $c_symbol
 * @param string $encode
 * @return string
 */
function ab2log($data, $e_symbol = '=', $c_symbol = '|', $encode = false, $range = false) {
	// 定义起始字符
	$string = '';
	$data = (array)$data;
	// 循环遍历将数组连接成字符串
	foreach ($data as $key => $val) {
		if (is_array($val) || is_object($val)) {
			$val = ab2log($val, $e_symbol, $c_symbol, $encode, $range);
			if ($range) {
				$string .= $key.'=>';
			}
		} else{
			$val = ($encode === true) ? urlencode($val) : strval($val);
			$string .= $key.$e_symbol;
		}
		$string .= $val.$c_symbol;
	}
	// 去除最后一个字符$c_symbol
	$string = rtrim($string, $c_symbol);
	// 范围指定
	if ($range) {
		$string = '{'.$string.'}';
	}
	// 如果存在转义字符，那么去掉转义
	if (get_magic_quotes_gpc()) {
		$string = stripslashes($string);
	}
	return $string;
}

/**
 * 日志写入
 * 
 * @param unknown $file
 * @param string $msg
 * @param string $level
 * @return unknown
 */
function log_message($file, $msg = '', $level = 'error') {
	$union_log =& load_class('union_log');
	$union_log_result = $union_log->write_Log($file, $msg, $level);
	return $union_log_result;
}

/**
 * 日志记录
 * Write: Log Message
 */ 
function write_log($file, $log) {
	global $_config;
	
	// 设置日志文件
	$year_month_date = date('Y-m-d');
	$log_dir = DATA_PATH.'/union_log/lmzg/'.$year_month_date;
	$log_file = $log_dir.'/'.$file.'.txt';
	
	// 文件大小判断
	if (@filesize($log_file) > 2048000) {
		$dir = opendir($log_dir);
		$length = strlen($file);
		$maxid = $id = 0;
		while (false !== ($entry = readdir($dir))) {
			if (strpos($entry, $file) !== false) {
				$id = intval(substr($entry, $length + 1, -4));
				$id > $maxid && $maxid = $id;
			}
		}
		closedir($dir);
		$log_file_bak = $log_dir.'/'.$file.'_'.($maxid + 1).'.txt';
		@rename($log_file, $log_file_bak);
	}
	$log_line = strip_tags_line_log($log);
	save_local_data($log_file, $log_line, 'a');
}


/**
*	错误日志 - 按日期自动分割
*	Return: 
*/
function log_level($debuginfo = '', $date_format = 'Y-m-d') {
	global $_config;
	$type = substr(CURSCRIPT, 0, -4);
	
	// 设置日志路径
	$logfile = DATA_PATH.'/union_log/'.CURSCRIPT.'/'.date($date_format).'/'.$type.'.txt';
	$log_line = strip_tags_line_log($debuginfo);
	save_local_data($logfile, $log_line, 'a');
}

/**
 *	获取完整的日志记录消息
 *
 */
function trace_message($message, $param = array()) {
	$debug_backtrace = debug_backtrace();
	$debug_info = $debug_backtrace[1];
	$file = isset($debug_info['file']) ? basename($debug_info['file']) : '';
	$func = isset($debug_info['class']) ? $debug_info['class'] : '';
	$func .= isset($debug_info['type']) ? $debug_info['type'] : '';
	$func .= isset($debug_info['function']) ? $debug_info['function'] : '';
	$args = json_encode(array_values($debug_info['args']));
	$line = isset($debug_info['line']) ? sprintf('%04d', $debug_info['line']) : '';
	// 不转义中文字符的 json 编码方法
	$json_param = preg_replace("#\\\u([0-9a-f]+)#ie", "iconv('UCS-2', 'UTF-8', pack('H4', '\\1'))", json_encode($param));
	if (!empty($file) && !empty($line)) {
		return sprintf("%s\t%s\t%s\tIn %s On Line [%04d],", $func, $message, $json_param, $file, $line);
	} else {
		return sprintf("%s\t%s\t%s", $func, $message, $json_param);
	}
}

/**
 *	Ip 访问检测
 * 	Return: Boolean 
 */
function ipaccess($ip, $accesslist) {
	return preg_match("/^(".str_replace(array("\r\n", "\n", ' '), array('|', '|', ''), preg_quote($accesslist, '/')).")/", $ip);
}

/**
 *	数据库快速操作方法（此方法源自文凯DB操作方法）
 *	@date 2012.10.18
 *	@author z.w.k
 * 	@param array $db_object  数据库类对象
 *	@param string $operation  数据库操作 
 *	@param string $table    表名
 *	@param string $where  条件语句
 *	@param array $data    写入或更新的数据
 * 	@param string $filed 查询时的字段,默认'*'
 *	@return	
 */
function easy_db($db_object, $operation, $table = '', $where = '', $data = array(), $fields = '*') {
	// db object check
	if (!is_object($db_object) || !method_exists($db_object, 'query')) {
		log_level('function: easy_db, $db_object is not object. in common.func.php, row = '.__LINE__);
		return false;
	}
	
	// 操作方法判断
	if (!in_array($operation, array('select', 'node', 'update', 'insert'))) {
		log_level('function: easy_db, $operation is not support. in common.func.php, row = '.__LINE__);
		return false;
	}

	// Table 判断
	if (empty($table)) {
		log_level('function: easy_db, $table is null. in common.func.php, row = '.__LINE__);
		return false;
	}

	switch ($operation) {
		case 'select':
			$db_result = $db_object->select($table, $where, $fields);
			break;
		case 'node':
			$db_result = $db_object->node($table, $where, $fields);
			break;
		case 'insert':
			$db_result = $db_object->insert($table, $data);
			break;
		case 'update':
			$db_result = $db_object->update($table, $data, $where);
			break;
		default:
			log_level('function: easy_db, $operation is not support. in common.func.php, row = '.__LINE__);
			$db_result = false;
	}
	return $db_result;
}


/**
 *	数组拼接, 将数组按照有序的规则拼接成字符串, 例如：拼接成query, ?a=b&c=d
 *	@param unknown_type $e_symbol	等值符号
 *	@param unknown_type $c_symbol	连接符号
 *	@param unknown_type $encode		是否编码
 *	Return: $line
 */
function array_splice2($array, $encode = false, $e_symbol = '=', $c_symbol = '&') {
	$line = '';
	while(list($key, $val) = each($array)) {
		$val = ($encode == true) ? urlencode($val) : $val;
		$line .= $key.$e_symbol.$val.$c_symbol;
	}

	// 去除最后一个&字符
	$line = rtrim($line, $c_symbol);

	// 如果存在转义字符，那么去掉转义
	if (get_magic_quotes_gpc()) {
		$line = stripslashes($line);
	}
	return $line;
}

/**
 *	转换充值地址
 * 	Return: Strings
 */
function transform_charging_url($charging_url, $trans_array = array(), $union_param = array()) {
	$trans_charing_url = '';
	if (empty($charging_url)) {
		return $trans_charing_url;
	}

	// $trans_array, 空值检查
	if (!is_array($trans_array)) {
		$trans_array = array();
	}

	// 固定参数格式
	$fixed_array = array(
		'[serverid]' => substr(get_array_value('serverid', $union_param), 1),
		'[username]' => get_array_value('username', $union_param),
		'[gatewayId]' => get_array_value('gatewayid', $union_param),
		'[gameId]' => get_array_value('gameid', $union_param),
		'[pName]' => get_array_value('username', $union_param),
	);
	$trans_array = array_merge($fixed_array, $trans_array);
	$trans_charing_url = strtr($charging_url, $trans_array);
	return $trans_charing_url;
}
