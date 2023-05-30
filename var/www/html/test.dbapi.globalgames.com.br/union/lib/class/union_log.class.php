<?php
/**
 * 联运日志方法
 * 
 * $Id: union_log.class.php 13858 2013-01-14 02:02:30Z sunjian $
 */

if(!defined('INTERMODAL')) {
	exit('Access Denied');
}

class union_log {

	private $_log_path;
	private $_date_fmt	= 'Y-m-d H:i:s';
	private $_enabled	= TRUE;
	private $_levels	= array('ERROR' => '1', 'DEBUG' => '2',  'INFO' => '3', 'ALL' => '4');

	/**
	 * 构造函数
	 * 
	 * @return
	 */
	public function __construct() {
		global $_config;

		// 日志目录检测
		$year_month_date = date('Y-m-d');
		//$union_drivers = $_config['union_drivers'];
		if (empty($union_drivers)) $union_drivers = 'system_log';
		$this->_log_path = LOG_PATH.'/'.$year_month_date;
		if (!is_dir($this->_log_path)) make_dir($this->_log_path);
		if (!is_dir($this->_log_path) || !is_really_writable($this->_log_path)) {
			$this->_enabled = FALSE;
		}
	}

	/**
	 * Write Log File
	 * 
	 * @param string $file
	 * @param string $msg
	 * @param string $level
	 * @return boolean
	 */
	public function write_Log($file, $msg = '', $level = 'error') {
		global $_config;
		
		if ($this->_enabled === FALSE) {
			return FALSE;
		}
		$level = strtoupper($level);
		$filepath = $this->_log_path.DIRECTORY_SEPARATOR.$file.'.txt';
		$message  = '';
		// 文件大小判断
		if (@filesize($filepath) > 2048000) {
			$dir = opendir($this->_log_path);
			$length = strlen($file);
			$maxid = $id = 0;
			while (false !== ($entry = readdir($dir))) {
				if (strpos($entry, $file) !== false) {
					$id = intval(substr($entry, $length + 1, -4));
					$id > $maxid && $maxid = $id;
				}
			}
			closedir($dir);
			$newfilepath = $this->_log_path.DIRECTORY_SEPARATOR.$file.'_'.($maxid + 1).'.txt';
			@rename($filepath, $newfilepath);
		}
		if (!$fp = @fopen($filepath, 'ab')) {
			return FALSE;
		}
		$message .= $_config['client_ip']."\t".date($this->_date_fmt)."\t[".$level."]\t".strip_tags(str_replace(array("\r", "\n"), '', $msg))."\n";
		flock($fp, LOCK_EX);
		fwrite($fp, $message);
		flock($fp, LOCK_UN);
		fclose($fp);
		
		@chmod($filepath, 0666);
		return TRUE;
	}

}
