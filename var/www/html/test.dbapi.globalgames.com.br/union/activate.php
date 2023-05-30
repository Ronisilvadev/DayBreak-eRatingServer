<?php
/**
 * 黎明之光 激活接口
 * 
 * $Id: activate.php 15292 2013-04-03 11:24:25Z  $
 */

// 定义入口脚本
define('CURSCRIPT', 'activate');

// 添加调试模式支持, TRUE: 开启调试模式， FALSE: 关闭调试模式
define('UNION_DEBUG', FALSE);

// 定义当前站点应用的路径
define('FRONT_ROOT', dirname(__FILE__));

// 加载入口文件
require './lib/growing_boy.php';

// 加载登录模块文件
require LIB_PATH.'/module/activate_module.php';

// 执行联运接口
activate_module::run();
