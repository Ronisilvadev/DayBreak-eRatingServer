<?php

ob_start();
$GLOBALS['_begintime'] = microtime(true);

define('INTERMODAL', true);

if (!defined('FRONT_ROOT') || !is_dir(FRONT_ROOT)) {
	die('no define front path or front path is not directory.');
}

if (!defined('CORE_ROOT'))	define('CORE_ROOT', dirname(dirname(__FILE__)));
//定义路径
if (!defined('FRONT_ROOT'))	define('FRONT_ROOT', FALSE);
define('FRONT_CONFIG_PATH', FRONT_ROOT.'/config');
define('LIB_PATH', dirname(__FILE__));
define('ROOT_PATH', dirname(LIB_PATH));
define('UNION_ROOT', dirname(LIB_PATH));
define('LANG_PATH', ROOT_PATH.'/lang');
define('UNION_CONFIG', 'config');
define('CONFIG_PATH', ROOT_PATH .'/config');
define('DATA_PATH', ROOT_PATH.'/data');
define('CLASS_PATH', LIB_PATH.'/class');
define('FUNCTION_PATH', LIB_PATH.'/function');
define('TIMESTAMP', time());
define('MAGIC_QUOTES_GPC', function_exists('get_magic_quotes_gpc') && get_magic_quotes_gpc());


//设置日志路径
define('IS_WIN', strstr(PHP_OS, 'WIN') ? TRUE : FALSE);
define('LOG_PATH', DATA_PATH.'/union_log');

//加载公共函数
require FUNCTION_PATH.'/common.func.php';

//获取配置信息
$_config = array();
$_config = & get_config();

//设置字符编码, 禁止缓存当前文档
header('Cache-Control: no-cache, no-store, max-age=0, must-revalidate');
header('Expires: Mon, 26 Jul 1997 05:00:00 GMT');
$charset = ($_config['charset'] === 'gbk') ? 'gbk' : 'utf-8';
header('Content-Type: text/html; charset='.$charset);

//时区设置
if(function_exists('date_default_timezone_set')) @date_default_timezone_set($_config['timezone_set']);

//加载调试文件
$debug_file = CLASS_PATH.'/union_debug_class.php';
if(UNION_DEBUG && file_exists($debug_file)){
	require $debug_file;
}

// 定义对象的引用
$objects = array();

// mcache init 
if ($_config['cache']['memcache']) {
	$objects['mcache'] = load_class('mcache');
	$objects['mcache']->init($_config);
}

//实例化union_core类
$union_core = load_class('union_core');
$union_core -> init();
