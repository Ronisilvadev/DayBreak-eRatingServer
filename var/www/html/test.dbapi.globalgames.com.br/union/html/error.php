<?php

$err_arr = array(

	'-101' => 'Login_Sign_Verify_Failed',
	'-102' => 'Time_Expired',
	'-1002' => 'Wrong_ServerId'
);

$err = '';

if(isset($_GET['err'])){
	
	$err = strval($_GET['err']);
	
	if(isset($err_arr[$err])){
		
		echo $err . " : " . $err_arr[$err];
		exit;
		
	}else{
		
		exit('Login_Error');
	}
	
}else{
	
	exit("Login_Error");
}