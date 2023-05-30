<?php

// 填写默认预处理接口的名称， 称, 根据配置名称加载适当的接口参数, 默认值为default
$_config['union_drivers'] = 'brazil';

// 联运方代号, 由蓝港在线生成，告知联运方
$_config['union_code'] = 'lmzg_1204';

// 系统消息文件定义
$_config['lang'] = 'zh_cn';

// 设置网页的字符编码
$_config['charset'] = 'utf-8';

// 时区设置
$_config['timezone_set'] = 'Etc/GMT-8';

//游戏配置
$_config['gameid'] = 1204;
$_config['security_key'] = '59adbef96631063f59d8f8a80ba5a8be';

//充值配置
$_config['charging_key'] = 'bbe134cbdb73c42b095c8a2f0e7cb711';

//充值比例
$_config['charging_ratio'] = 1;

//默认开启参数验证
$_config['verify_api_param'] = true;

// 登陆信息有效期验证
$_config['expire_time'] = 600;

//游戏域名
$_config['domain'] = 'test.jogue.daybreak.globalgames.com.br';

// 定义系统发生错误时跳转页面
$_config['error_url'] = 'http://test.dbapi.globalgames.com.br/union/html/error.php';

//全局配置
//数据库配置
$_config['database']['host'] = '192.168.177.94:6306';
$_config['database']['username'] = 'lmzg';
$_config['database']['password'] = 'VGD6SOqGjqlz3Lkmx93c';
$_config['database']['charset'] = 'utf8';
$_config['database']['database'] = 'lmzg';
$_config['database']['dbtag'] = 'intermodal_';

// 文件缓存开启， 默认开启
$_config['cache']['file'] = true;

//memcache默认开启
$_config['cache']['memcache'] = false;

// memcache 配置
$_config['memcache']['server'] = '';
$_config['memcache']['port'] = '';
$_config['memcache']['pconnect'] = 1;
$_config['memcache']['timeout'] = 1;
$_config['memcache']['expire_time'] = 0;

// 联运中间件地址, 地址格式: http://ip:port
$_config['union_mid_address'] = 'http://192.168.177.94:8080';//测试服

// 充值接口IP限制检测
$_config['checkip'] =  false;

// 充值IP
$_config['charging_allow_ip'] = <<<EOF
EOF;
