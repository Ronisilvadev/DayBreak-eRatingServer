<?php
/**
*	三国演义联运入口地址
*	$Id: mcache.class.php 13632 2013-01-05 05:51:11Z sunjian $
*/

if(!defined('INTERMODAL')) {
	exit('Access Denied');
}

class mcache extends Memcache {

	var $_mhandel = null;
	
	function __construct() {}
	
	/**
	*	初始化方法
	*	Return: 
	*/
	function init(& $config) {
		if (isset($config['memcache']['server']) && isset($config['memcache']['port'])) {
			$this->_mhandel = new Memcache();
			$timeout = intval($config['memcache']['timeout']);
			$this->_mhandel->addServer($config['memcache']['server'], $config['memcache']['port'], $config['memcache']['pconnect'], 1, $timeout);
		} else {
			// 载入缓存失败
			trigger_error('load_mcache_fail', E_USER_WARNING);
		}		
	}
	
	/**
	*	向连接池中添加一个memcache服务器
	*	Return: 
	*/
	function addServer($ip, $port) {
		$this->_mhandel->addServer($ip, $port);
	}
	
	/**
	*	加一个条目到缓存服务器
	*	Return:
	*/
	function add($key, $value) {
		$this->_mhandel-add($key, $value);
	}
	
	/**
	*	Store data at the server
	*
	*/
	function set($key, $value, $flag = 0, $expire = 86400) {
		return $this->_mhandel->set($key, $value, $flag, $expire);
	}
	
	/**
	*	从服务端检回一个元素
	*
	*/
	function get($key) {
		return $this->_mhandel->get($key);	
	}
	
	/**
	*	替换已经存在的元素的值
	*
	*/
	function replace($key, $value) {
		return $this->_mhandel->replace($key, $value);
	}
	
	/**
	*	获取服务器统计信息
	*
	*/
	function getStats() {
		return $this->_mhandel->getStats();
	}
	
	/**
	*	从服务端删除一个元素
	*
	*/
	function del($key) {
		return $this->_mhandel->delete($key);	
	}
	
	/**
	*	清洗（删除）已经存储的所有的元素
	*
	*/
	function flush() {
		$this->_mhandel->flush();
	}
	
	/**
	*	增加一个元素的值
	*	Return: 
	*/
	function increment($key, $value = 1) {
		return $this->_mhandel->increment($key, $value);
	}
	
	/**
	*	减小元素的值
	*	Return: 
	*/
	function decrement($key, $value = 1) {
		return $this->_mhandel->decrement($key, $value);
	}
	
	function __destruct() {
		
	}
}