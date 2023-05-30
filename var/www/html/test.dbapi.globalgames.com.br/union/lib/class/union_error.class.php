<?php
/**
 * UNION ERROR: ERROR INFO | Example.com
 * 
 * $Id: union_error.class.php 13858 2013-01-14 02:02:30Z sunjian $
 */

if(!defined('INTERMODAL')) {
	exit('Access Denied');
}

class union_error {

	/**
	*	系统默认错误处理方法
	*/
	public function system_error($message, $show = true, $save = true, $halt = true, $jump = false) {
		global $_config;
		
		// $message
		if (!empty($message)) {
			$message = lang($message);
		} else {
			$message = lang('unkonw error');
		}
		$debug_backtrace = '';
		if (UNION_DEBUG) {
			$debug_backtrace = self::debug_backtrace();
		}
		
		// Save 
		if ($save) {
			$union_log =& load_class('union_log');
			$union_log->write_log('system_error', $message.$debug_backtrace);
		}
		// Halt
		if ($halt) {
			// Login, Index 异常跳转, Jump Page
			$curscript = strtolower(CURSCRIPT);
			if ($jump || FALSE !== strpos($curscript, 'index') || FALSE !== strpos($curscript, 'login')) {
				//http_header(302, $_config['error_url']);
				echo 'error';
			}
			// show
			if ($show) {
				echo $message;
			}
			exit();
		} else {
			return $message;
		}
	}

	/**
	 *	获取调试日志信息
	 * 	Return: $debug_log
	 */
	public function debug_backtrace() {
		$debug_log = '';
		$debug_backtrace = debug_backtrace();
		$file = $line = $function = $class = $type = $args = '';
		$i = 0;
		krsort($debug_backtrace);
		foreach ($debug_backtrace as $k => $error) {
			$file =str_replace(array(UNION_ROOT, '\\'), array('', '/'), $error['file']) ;
			$func = isset($error['class']) ? $error['class'] : '';
			$func .= isset($error['type']) ? $error['type'] : '';
			$func .= isset($error['function']) ? $error['function'] : '';
			$args = implode(',', array_values($error['args']));
			$error['line'] = sprintf('%04d', $error['line']);
			$debug_log .= " [Line: $error[line]] ".$file.' '.$func;
			$debug_log .= (!empty($args) ? '('.$args.')' : '') ;
		}
		return $debug_log;
	}
	
	/**
	*	事件错误处理
	*/
	public function exception_error($exception) {
		$exception_string = $exception->__toString();
		$this->system_error($exception_string, true, true, true);
		exit();
	}
}
