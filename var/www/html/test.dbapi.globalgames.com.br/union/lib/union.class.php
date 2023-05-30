<?php
/**
*	三国演义联运中间件访问接口
*	$Id: union.class.php 13632 2013-01-05 05:51:11Z sunjian $
*/

if(!defined('INTERMODAL')) {
	exit('Access Denied');
}

class union {
	
	private $sign_type = 'MD5';
	
	/**
	 *	生成签名参数
	 *	Return: $mysign
	 */
	function generate_mysign($sort_args, $sign_type) {
		// 把数组所有元素, 拼接成字符串
		$prestr = implode('', $sort_args);
		// 把最终的字符串签名，获得签名结果
		return sign($prestr, $sign_type);
	}

	/**
	*	充值接口
	*	Return: 
	*/
	public function charging($unionCode, $orderId, $userName, $chargeTime, $chargeMoney, $chargeAmount, $gatewayId, $gameId, $clientIp) {
		global $_config;
		//$chargeAmount = sprintf("%.2f",$chargeAmount);
		// 组装签名数组
		$charging_param = array(
			'unionCode' => $unionCode,
			'orderId' => $orderId,
			'userName' => $userName,
			'chargeTime' => $chargeTime,
			'chargeMoney' => $chargeMoney,
			'chargeAmount' => $chargeAmount,
			'gatewayId' => $gatewayId,
			'gameId' => $gameId,
			'key' => $_config['charging_key'],
		);

		// 生成签名
		$mysign = $this->generate_mysign($charging_param, $this->sign_type);
		$charging_param['clientIp'] = $clientIp;
		$charging_param['sign'] = $mysign;
		unset($charging_param['key']);
		
		// 组装请求字符串
		//$pre_query = $this->create_http_query($charging_param);
		$pre_query = http_build_query($charging_param);
		$union_mid_url = $_config['union_mid_address'].'/union_mid/charging.do?'.$pre_query;

		// 请求联运中间件接口
		$response = $this->http_request($union_mid_url);
		
		// 充值订单DB记录
		if (!class_exists('database')) {
			@include LIB_PATH.'/class/database.class.php';
		}
		@include_once LIB_PATH.'/class/driver/database/database_union_mid.class.php';
		try {
			unset($charging_param['sign']);
			$charging_param['chargeResult'] = $response;
			$insert_result = database_union_mid::insert_charging_order_info($charging_param);
			
			if (!$insert_result) {
				$fetch_mysql_query = database_union_mid::fetch_mysql_query();
				log_level('SQL ERROR:'.$fetch_mysql_query);
			}
		} catch (Exception $e) {
			log_level('charging exception:'.$e);
		}
		return $response;
	}
	
	
	/**
	 * 道具赠送接口
	 * 
	 * @param string $unionCode 联运方代号，由蓝港在线生成，告知联运方
	 * @param int $gameId 游戏编号，蓝港在线运营游戏代号
	 * @param string $userName 用户标识，最长为32个字节，英文字母大小写敏感
	 * @param string $gatewayId 将物品赠送到某一个游戏网关。(此值与部分游戏在登陆时传的serverId相同)
	 * @param long $activityId 活动编号，联运方需和游戏制作方确认。
	 * @param string $logId 赠送流水号，最长为32个字节，唯一标识一次赠送操作
	 * @param string $sendTime 赠送时间，必须为14位字符，格式20091124162507，表示2009年11月24日16时25分07秒
	 * @param string $startTime 允许玩家领取物品的开始时间，必须为14位字符，格式20091124162507，表示2009年11月24日16时25分07秒
	 * @param string $endTime 允许玩家领取物品的结束时间，必须为14位字符，格式20091124162507，表示2009年11月24日16时25分07秒
	 * @param string $itemString 最多4000个字节。赠送物品。格式如下：
	 * 		itemcode1+,+赠送数量$itemcode2+,+赠送数量$itemcode3+,+赠送数量
	 * 		Itemcode需和游戏产品负责人确认。示例，i-32200,1$i-32100,5$i-32700,10
	 * @param sign String MD5签名，小写英文字母与数字组合
	 * 		md5(unionCode+gameId+userName+gatewayId+activityId+logId+sendTime+startTime+endTime+itemString+key)
	 * 		key 由蓝港在线生成，告知联运方。
	 * @return string
	 */
	public function giveItem($unionCode, $gameId, $userName, $gatewayId, $activityId, $logId, $sendTime, $startTime, $endTime, $itemString) {
		global $_config;
		
		// 组装签名数组
		$give_item_param = array(
			'unionCode' => $unionCode,
			'gameId' => $gameId,
			'userName' => $userName,
			'gatewayId' => $gatewayId,
			'activityId' => $activityId,
			'logId' => $logId,
			'sendTime' => $sendTime,
			'startTime' => $startTime,
			'endTime' => $endTime,
			'itemString' => $itemString,
			'key' => $_config['charging_key'],
		);
		
		// 生成签名
		$mysign = $this->generate_mysign($give_item_param, $this->sign_type);
		$give_item_param['sign'] = $mysign;
		unset($give_item_param['key']);
		
		// 组装请求字符串		
		$post_data = http_build_query($give_item_param);
		$union_mid_url = $_config['union_mid_address'].'/union_mid/giveItem.do';
		
		// 请求联运中间件
		$response = $this->uc_fopen($union_mid_url, 500000, $post_data, '', true, '', $timeout = 15);
		
		return $response;
	}

	
	/**
	*	角色信息查询
	*	Return: 
	*/
	function getRoleList($unionCode, $gameId, $userName, $gatewayId) {
		global $_config;
		
		// 组装签名数组
		$role_list_param = array(
			'unionCode' => $unionCode,
			'gameId' => $gameId,
			'userName' => $userName,
			'gatewayId' => $gatewayId,
			'key' => $_config['charging_key'],
		);
		
		// 生成签名
		$mysign = $this->generate_mysign($role_list_param, $this->sign_type);
		$role_list_param['sign'] = $mysign;
		unset($role_list_param['key']);
		
		// 组装请求字符串
		$pre_query = $this->create_http_query($role_list_param);
		//$union_mid_url = $_config['union_mid_address'].'/union_mid/getRoleList.do?'.$pre_query;
		$union_mid_url = $_config['union_mid_address'].'/union_mid/getRoleListJson.do?'.$pre_query;
		
		// 请求联运中间件接口
		$response = $this->http_request($union_mid_url);
		return $response;
	}
	
	/**
	 *	联运激活接口,根据gatewayId单服激活
	 * 	Return:
	 */
	public function activityUserBy($unionCode, $userName, $gameId, $gatewayId, $serialNumber, $clientIp) {
		global $_config;
	
		// 组装签名数组
		$activity_user_param = array(
			'unionCode' => $unionCode,
			'userName' => $userName,
			'gameId' => $gameId,
			'gatewayId' => $gatewayId,
			'serialNumber' => $serialNumber,
			'clientIp' => $clientIp,
			'key' => $_config['charging_key'],
		);
		
		// 生成签名
		$mysign = $this->generate_mysign($activity_user_param, $this->sign_type);
		$activity_user_param['sign'] = $mysign;
		unset($activity_user_param['key']);
	
		// 组装请求字符串
		$pre_query = $this->create_http_query($activity_user_param);
		$union_mid_url = $_config['union_mid_address'].'/union_mid/activityUserBy.do?'.$pre_query;
		// 请求联运中间件
		$response = $this->http_request($union_mid_url);
		return $response;
		
	}
	
	/**
	 *	建立请求字符串
	 *	Return: $query
	 */
	function create_http_query($sort_args) {
		$query = '';
		while(list($key, $val) = each($sort_args)) {
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
	 *	GET 方式获取返回值
	 */
	function http_request($url, $timeout = 15) {
		global $_config;
		// uc_fopen
		$result = $this->uc_fopen($url, 500000, '', '', TRUE, '', $timeout);
		
		return $result;
	}
	
	/**
	 *	uc socket open
	 * 	Return: 
	 */
	function uc_fopen($url, $limit = 0, $post = '', $cookie = '', $bysocket = FALSE, $ip = '', $timeout = 15, $block = TRUE) {
		$return = '';
		$matches = parse_url($url);
		!isset($matches['host']) && $matches['host'] = '';
		!isset($matches['path']) && $matches['path'] = '';
		!isset($matches['query']) && $matches['query'] = '';
		!isset($matches['port']) && $matches['port'] = '';
		$host = $matches['host'];
		$path = $matches['path'] ? $matches['path'].($matches['query'] ? '?'.$matches['query'] : '') : '/';
		$port = !empty($matches['port']) ? $matches['port'] : 80;
		$http_user_agent = get_array_value('HTTP_USER_AGENT', $_SERVER);
		if($post) {
			$out = "POST $path HTTP/1.0\r\n";
			$out .= "Accept: */*\r\n";
			//$out .= "Referer: $boardurl\r\n";
			$out .= "Accept-Language: zh-cn\r\n";
			$out .= "Content-Type: application/x-www-form-urlencoded\r\n";
			$out .= "User-Agent: 8864.com/v1.0 $http_user_agent\r\n";
			$out .= "Host: $host\r\n";
			$out .= 'Content-Length: '.strlen($post)."\r\n";
			$out .= "Connection: Close\r\n";
			$out .= "Cache-Control: no-cache\r\n";
			$out .= "Cookie: $cookie\r\n\r\n";
			$out .= $post;
		} else {
			$out = "GET $path HTTP/1.0\r\n";
			$out .= "Accept: */*\r\n";
			//$out .= "Referer: $boardurl\r\n";
			$out .= "Accept-Language: zh-cn\r\n";
			$out .= "User-Agent: 8864.com/v1.0 $http_user_agent\r\n";
			$out .= "Host: $host\r\n";
			$out .= "Connection: Close\r\n";
			$out .= "Cookie: $cookie\r\n\r\n";
		}

		if(function_exists('fsockopen')) {
			$fp = @fsockopen(($ip ? $ip : $host), $port, $errno, $errstr, $timeout);
		} elseif (function_exists('pfsockopen')) {
			$fp = @pfsockopen(($ip ? $ip : $host), $port, $errno, $errstr, $timeout);
		} else {
			$fp = false;
		}
		
		if(!$fp) {
			return '';
		} else {
			stream_set_blocking($fp, $block);
			stream_set_timeout($fp, $timeout);
			@fwrite($fp, $out);
			$status = stream_get_meta_data($fp);
			if(!$status['timed_out']) {
				while (!feof($fp)) {
					if(($header = @fgets($fp)) && ($header == "\r\n" ||  $header == "\n")) {
						break;
					}
				}
	
				$stop = false;
				while(!feof($fp) && !$stop) {
					$data = fread($fp, ($limit == 0 || $limit > 8192 ? 8192 : $limit));
					$return .= $data;
					if($limit) {
						$limit -= strlen($data);
						$stop = $limit <= 0;
					}
				}
			}
			@fclose($fp);
			return $return;
		}
	}
	
	
	/**
	 *	输出联运接口返回结果
	 * 
	 */
	function output_result($result){
		echo $result;
		exit();
	}

}