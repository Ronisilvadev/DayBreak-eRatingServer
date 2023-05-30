<?php
/**
*	联运中间件DB操作
*	$Id: database_union_mid.class.php 13632 2013-01-05 05:51:11Z sunjian $
*/

if(!defined('INTERMODAL')) {
	exit('Access Denied');
}

class database_union_mid extends database {

	public $database_union_mid_object = null;

	public function __construct($config) {
		parent::__construct($config);
	}

	public static function init() {
		global $_config;
		static $object = null;
		if ($object == null) {
			$object = new database_union_mid($_config['database']);
		}
		return $object;
	}

	/**
	 *	充值订单信息记录
	 * 	Return: mysql_insert_id();
	 */
	public static function insert_charging_order_info($charging_param) {
		$database_union_mid_object = database_union_mid::init();
		$charging_param['dateline'] = TIMESTAMP;
		$charging_param['clientIp'] = ip2long($charging_param['clientIp']);
		return easy_db($database_union_mid_object, 'insert', 'charging_order_info', '', $charging_param);
	}

	/**
	 * 	查询充值订单信息
	 * 	Return: Charge Order Info
	 */
	public static function query_charging_order_info($unionCode, $gameid, $gatewayId, $orderId = '', $begin_time = 0, $end_time = 0, $page = 1, $page_num = 10, $chargeResult = '1') {
		$database_union_mid_object = database_union_mid::init();
		$conditions = '';
		$query_charging_order_info_result = array();

		// $gameid 判断
		if ($gameid <= 0 || $gatewayId <= 0) {
			// 游戏Id或者网关Id值不正确
			return -1;
		}
		
		// 条件
		$conditions_array = array(
			'unionCode' => $unionCode,
			'gameid' => $gameid,
			'gatewayId' => $gatewayId,
			'orderId' => $orderId,
			'chargeResult' => $chargeResult,
		);

		// 条件组装
		foreach ($conditions_array as $key => $value) {
			if ($value == '' || $value == 0) {
				continue;
			}
			$conditions .= $key.' = "'. $value.'" AND ';
		}
		$conditions = rtrim($conditions, ' AND ');
		
		// 时间判断
		if ($begin_time > 0) {
			$conditions .= ' AND dateline >= "'.strtotime($begin_time).'"';
		}
		if ($end_time > 0) {
			$conditions .= ' AND dateline <= "'.strtotime($end_time).'"';
		}

		// Limit 判断
		$page = ($page <= 1) ? 1 : $page;
		$cur_page = ($page - 1) * $page_num;
		$page_num = ($page_num >= 20) ? 20 : ($page_num <= 0 ? 10 : $page_num);
		$conditions = ' WHERE '.$conditions.' Limit '.$cur_page.','.$page_num;
		$fields = 'orderId, userName, chargeMoney, chargeAmount, gatewayId';
		return easy_db($database_union_mid_object, 'select', 'charging_order_info', $conditions, false, $fields);
	}

	/**
	 * 	返回错误的SQL语句
	 * 	Return: SQL 
	 */
	public static function fetch_mysql_query() {
		$database_union_mid_object = database_union_mid::init();
		return $database_union_mid_object->fetch_operator();
	}

}