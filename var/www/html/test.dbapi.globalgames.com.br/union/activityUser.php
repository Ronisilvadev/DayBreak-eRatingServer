<?php

$post_data = $_REQUEST;
$url = 'http://test.dbapi.globalgames.com.br/union/activate.php';//巴西测试服

$ch = curl_init () ;
curl_setopt ( $ch , CURLOPT_POST , 1 ) ;
curl_setopt ( $ch , CURLOPT_HEADER , 0 ) ;
curl_setopt ( $ch , CURLOPT_URL , $url ) ;
curl_setopt ( $ch , CURLOPT_POSTFIELDS , $post_data ) ;
curl_exec ( $ch ) ;
