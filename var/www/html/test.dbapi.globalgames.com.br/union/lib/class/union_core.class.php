<?php
/**
 * UNION Core: union core | Example.com
 * 
 * $Id: union_core.class.php 14056 2013-01-20 22:27:05Z sunjian $
 */

if(!defined('INTERMODAL')) {
	exit('Access Denied');
}

class union_core {

	// Instance Union Core
	private $_instance = FALSE;

	/**
	 * Union Core Class Initialization
	 * 
	 * @return NULL
	 */
	public function init() {
		if ($this->_instance) {
			return TRUE;
		}
		$this->_instance = TRUE;
		if (UNION_DEBUG) {
			error_reporting(E_ALL);
		} else {
			register_shutdown_function(array(&$this, '_shutdown_function'));
			set_error_handler(array(&$this, '_error_handler'));
			set_exception_handler(array(&$this, '_exception_handler'));
		}
	}

	/**
	 *  自定义错误处理
	 *
	 * Example: trigger_error("Cannot divide by zero", E_USER_ERROR);
	 * @param number $errno
	 * @param string $errstr
	 * @param string $errfile
	 * @param number $errline
	 * @return NULL
	 */
	public function _error_handler($errno, $errstr, $errfile, $errline) {
		$show = $save = $halt = false;
		$errorstr = '';
		switch($errno) {
			case E_ERROR:
			case E_PARSE:
			case E_CORE_ERROR:
			case E_COMPILE_ERROR:
			case E_USER_ERROR:
				ob_end_clean();
				$show = $save = $halt = true;
				break;
			case E_STRICT:
			case E_USER_WARNING:
			case E_USER_NOTICE:
			default:
				$save = true;
				$errorstr .= '['.$errno.']';
				break;
		}
		$errfile = str_replace(array(FRONT_ROOT, CORE_ROOT), array('', ''), $errfile);
		$errorstr .= $errstr.' on line'.$errline.' in file '.$errfile;
		$union_error =& load_class('union_error');
		$union_error->system_error($errorstr, $show, $save, $halt);
	}

	/**
	 * Register a function for execution on shutdown
	 * 
	 * @return NULL
	 */
	public function _shutdown_function() {
		if (function_exists('error_get_last')) {
			$error = error_get_last();
			$this->_error_handler($error['type'], $error['message'], $error['file'], $error['line']);
		}
	}

	/**
	 * 自定义异常处理
	 *
	 * @param NULL
	 */
	public function _exception_handler($exception) {
		$union_error =& load_class('union_error');
		$union_error->exception_error($exception);
	}
}
