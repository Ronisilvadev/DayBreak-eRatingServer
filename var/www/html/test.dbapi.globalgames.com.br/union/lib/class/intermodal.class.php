<?php
/**
*	三国演义联运接口 - 联运商接入访问方法
*	$Id: intermodal.class.php 13631 2013-01-05 05:46:07Z sunjian $
*/

if(!defined('INTERMODAL')) {
	exit('Access Denied');
}

class intermodal {
	
	private $sign_type = 'MD5';
	
	/**
	*	参数排序
	*
	*/
	function sort_args($param) {
		global $_config;
		
		$sort_args = array(
			'uname' => get_array_value('username', $param),
			'uid' => get_array_value('uid', $param),
			'ServerId' => get_array_value('serverid', $param),
			'key' => trim($_config['security_key']),
			'time' => get_array_value('time', $param),
		);
		
		return $sort_args;
	}
	
	/**
	*	参数过滤
	*	Return: $filter_args
	*/
	function filter_args($args) {
		$filter_args = array();
		foreach ($args as $key => $val) {
			if ($key == 'sign' || $key == 'sign_type' || $val == '') {
				continue;	
			} else {
				$filter_args[$key] = $val;
			}
		}
		return $filter_args;
	}
	
	/**
	 *	建立请求字符串
	 *	Return: $query
	 */	
	function create_http_query($sort_args) {
		$query = '';
		foreach ($sort_args as $key => $val) {
			$query .= $key.'='.$val.'&';
		}
	
		// 去除最后一个&字符
		$query = rtrim($query, '&');
	
		// 如果存在转义字符，那么去掉转义
		if (get_magic_quotes_gpc()) {
			$query = stripslashes($query);
		}
		return $query;
	}

	/**
	*	根据参数获取Sign数字签名
	*
	*/
	function get_mysign($param) {
		// 去除待签名数组中的空值和签名参数
		$filter_args = $this->filter_args($param);
		
		// 对待签名的数组进行排序
		$sort_args = $this->sort_args($filter_args);
		
		// 生成签名结果
		$sign_type = strtoupper(trim($this->sign_type));
		$my_sign = $this->generate_mysign($sort_args, $sign_type);
		return $my_sign;
	}
	
	/**
	*	生成签名参数
	*	Return: $mysign
	*/
	function generate_mysign($sort_args, $sign_type) {
		// 把数组所有元素，按照“参数=参数值”的模式用“&”字符拼接成字符串
		$prestr = $this->create_http_query($sort_args);

		// 把最终的字符串签名，获得签名结果
		$mysign = sign($prestr, $sign_type);
		return $mysign;
	}
}
