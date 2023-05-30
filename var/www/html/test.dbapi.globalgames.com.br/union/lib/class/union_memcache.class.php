<?php
/**
 * 联运Memcache操作方法
 * 
 * $Id: union_memcache.class.php 13858 2013-01-14 02:02:30Z sunjian $
 */

if(!defined('INTERMODAL')) {
	exit('Access Denied');
}

class union_memcache {

	private $_mhandel = NULL;

	/**
	 * 构造函数
	 * 
	 * @return
	 */
	public function __construct($memcache_config = array()) {
		
		if (!extension_loaded('memcache')) {
			throw_exception('memcache extension load fail, not support memcache.');
		}

		// get memcache config
		if (empty($memcache_config)) {
			$_config =& get_config();
			$memcache_config = $_config['memcache'];
		}
		$this->init($memcache_config);
	}

	/**
	 * 初始化方法
	 * 
	 * @param array $config
	 */
	function init($memcache_config = array()) {
		if (isset($memcache_config['server']) && isset($memcache_config['port']) && isset($memcache_config['timeout'])) {
			$persistent  = !!$memcache_config['pconnect'];
			$this->_mhandel = new Memcache();
			$timeout = intval($memcache_config['timeout']);
			$this->_mhandel->addServer($memcache_config['server'], $memcache_config['port'], $persistent, 1, $timeout);
		}

		// Memcache Resource Judge
		if ($this->_mhandel === NULL || $this->_mhandel === FALSE) {
			$message = 'memcache init fail.';
			log_message('system', $message, 'info');
		}
	}

	/**
	 * 向连接池中添加一个memcache服务器
	 * 
	 * @param string $ip
	 * @param int $port
	 * @return boolean 
	 */
	public function addServer($host, $port = 11211, $persistent = TRUE, $weight = 0, $timeout = 1) {
		return $this->_mhandel->addserver($host, $port, $persistent, $weight, $timeout);
	}

	/**
	 * 加一个条目到缓存服务器
	 * 
	 * @param string $key
	 * @param string $value
	 * @return boolean
	 */
	public function add($key, $value) {
		return $this->_mhandel->add($key, $value);
	}

	/**
	 * Store data at the server
	 * 
	 * @param string $key
	 * @param string $value
	 * @param number $flag
	 * @param number $expire
	 * @return boolean
	 */
	public function set($key, $value, $flag = 0, $expire = 86400) {
		return $this->_mhandel->set($key, $value, $flag, $expire);
	}

	/**
	 * 从服务端检回一个元素
	 * 
	 * @param string $key
	 * @return string
	 */
	public function get($key) {
		return $this->_mhandel->get($key);
	}

	/**
	 * 替换已经存在的元素的值
	 * 
	 * @param unknown $key
	 * @param unknown $value
	 */
	public function replace($key, $value) {
		return $this->_mhandel->replace($key, $value);
	}

	/**
	 * 获取服务器统计信息
	 * 
	 * @return array
	 */
	public function getStats() {
		return $this->_mhandel->getStats();
	}

	/**
	 * 从服务端删除一个元素
	 * 
	 * @param string $key
	 * @return boolean
	 */
	public function del($key) {
		return $this->_mhandel->delete($key);
	}

	/**
	 * 清洗（删除）已经存储的所有的元素
	 * 
	 * @return boolean
	 */
	public function flush() {
		return $this->_mhandel->flush();
	}

	/**
	 * 增加一个元素的值
	 * 
	 * @param string $key
	 * @param number $value
	 */
	public function increment($key, $value = 1) {
		return $this->_mhandel->increment($key, $value);
	}

	/**
	 * 减小元素的值
	 * 
	 * @param string $key
	 * @param number $value
	 */
	public function decrement($key, $value = 1) {
		return $this->_mhandel->decrement($key, $value);
	}

	/**
	 * 
	 * 
	 */
	public function __destruct() {
		unset($this->_mhandel);
	}

}