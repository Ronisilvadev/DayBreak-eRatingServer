<?php

define ('CURSCRIPT', 'charging_api');

define ('UNION_DEBUG',true);

define ('FRONT_ROOT', dirname(__FILE__));

//加载入口文件
require './lib/growing_boy.php';

//加载充值模块
require LIB_PATH.'/module/charging_module.php';

Charging_Module::run();
