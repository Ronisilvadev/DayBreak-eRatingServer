<?php

define ('CURSCRIPT', 'getRoleList_api');

define ('UNION_DEBUG',true);

define ('FRONT_ROOT', dirname(__FILE__));

//加载入口文件
require './lib/growing_boy.php';

//加载充值模块
require LIB_PATH.'/module/getRoleList_module.php';

GetRoleList_Module::run();