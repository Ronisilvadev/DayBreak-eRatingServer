<?php
/**
*	三国演义联运入口地址
*	$Id: database.class.php 13632 2013-01-05 05:51:11Z sunjian $
*/

if(!defined('INTERMODAL')) {
	exit('Access Denied');
}

class database {
	
	protected $conn;
	protected $dbtag = '';
	protected $operator = array();
	
	public function __construct($config) {
		// 获取DB连接资源
		$this->conn =& database::object($config);
		// 设置数据表前缀
		if(isset($config['dbtag'])) $this->dbtag = $config['dbtag'];
	}
	
	/**
	 * 	db link
	 * 	Return: mysql link resource
	 */
	public function connect_db($config) {
		$conn = mysql_connect($config['host'], $config['username'], $config['password']);
		mysql_query("set names " . $config['charset'], $conn);
		if($config['database']){
			mysql_select_db($config['database'], $conn);
		}
		return $conn;
	}
	
	/**
	 *	获取mysql link resource
	 *	@return unknown
	 */
	public function &object($config) {
		static $db;
		if(empty($db)) $db = database::connect_db($config);
		return $db;
	}

	/**
	 * mysql query
	 *
	 * @param string $sql
	 * @return resourse
	 */
	public function query($sql){
		$this->operator[] = $sql;
		return mysql_query($sql, $this->conn);
	}
	
	/**
	*	显示操作
	*	@return	echo data;
	*/
	public function show_operator() {
		echo '<pre>';
		var_dump($this->operator);
		echo '</pre>';
	}
	
	/**
	 *	获取DB操作 
	 * 	@return	
	 */
	public function fetch_operator($glue = "\n") {
		return @implode($glue, $this->operator);
	}

	/**
	 * 选择多行数据
	 *
	 * @param string $table
	 * @param string $where
	 * @param string $fields
	 * @return array
	 */
	public function select($table, $where = false, $fields = '*'){
		$sql = "select " . $fields . " from " . $this->dbtag . $table;
		
		//如果limit 0，那么返回所有
		$ind = strpos($where, 'limit 0');
		if($ind !== false){
			$str = substr($where, $ind + 7);
			if($str) $str = trim($str);
			if($str && strlen($str) > 0){
				if($str[0] != ',') $where = str_replace('limit 0', '', $where);
			}
			else{
				$where = str_replace('limit 0', '', $where);
			}
		}
		
		if($where){
			$sql .= " " . $where;
		}
		
		$res = $this->query($sql);
		if(!$res) return false;

		$result = array();
		$row = @mysql_fetch_array($res);
		while($row){
			$result[] = $row;
			$row = @mysql_fetch_array($res);
		}
		
		return $result;
	}
	
	/**
	 * 选择一行数据
	 *
	 * @param string $table
	 * @param string $where
	 * @param string $fields
	 * @return array
	 */
	public function node($table, $where = false, $fields = '*'){
		$sql = "select " . $fields . " from " . $this->dbtag . $table;
		
		if($where){
			$sql .= " " . $where;
		}
		
		$res = $this->query($sql);
		if(!$res) return false;
		
		return @mysql_fetch_array($res);
	}
	
	/**
	 * 插入一条数据
	 *
	 * @param string $table
	 * @param array $data
	 * @return mixed
	 */
	public function insert($table, $data){
		$sql = "insert into " . $this->dbtag . $table . " ";
		
		$fields = "(";
		$values = "(";
		foreach($data as $key => $value){
			$fields .= $key . ",";
			$values .= '\'' . mysql_real_escape_string($value, $this->conn) . "',";
		}
		
		$fields = trim($fields, ',') . ')';
		$values = trim($values, ',') . ')';
		
		$sql .= $fields . " values" . $values;
		$res = $this->query($sql);
		if(!$res){
			return false;
		}
		return mysql_insert_id($this->conn);
	}
	
	/**
	 * 更新一条数据
	 *
	 * @param string $table
	 * @param array $data
	 * @param string $where
	 * @return boolean
	 */
	public function update($table, $data, $where = false){
		$sql = "update " . $this->dbtag . $table . " set ";
		foreach($data as $key => $value){
			$sql .= $key . "='" . mysql_real_escape_string($value, $this->conn) . "',";
		}
		
		$sql = trim($sql, ',');
		if($where){
			$sql .= " " . $where;
		}
		
		return $this->query($sql);
	}
	
	/**
	 * 删除一条数据
	 *
	 * @param string $table
	 * @param string $where
	 * @return boolean
	 */
	public function delete($table, $where = false){
		$sql = "delete from " . $this->dbtag . $table;
		
		if($where){
			$sql .= " " . $where;
		}
		
		return $this->query($sql);
	}
	
	/**
	 * 字段自增
	 *
	 * @param string $table
	 * @param string $field
	 * @param string $where
	 * @param int $step
	 * @return boolean
	 */
	public function increase($table, $field, $where = false, $step = 1){
		$sql = "update " . $this->dbtag . $table . " set " . $field . "=" . $field . "+" . $step;
		
		if($where){
			$sql .= " " . $where;
		}
		
		return $this->query($sql);
	}
	
	/**
	 * 影响的行数
	 *
	 * @return int
	 */
	public function affected_rows(){
		return mysql_affected_rows($this->conn);
	}
	
	public function __destruct(){
		
	}	
}
