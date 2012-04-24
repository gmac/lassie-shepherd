<?php
/**
* Login data manager.
* @author Greg MacWilliam.
*/
class login_manager {
	var $_file;
	var $_login;
	
	function login_manager($root) {
		$this->_file = (isset($root) ? $root : "") . "php/login.txt";
		$this->_login = array();
		$this->load();
	}
	
	/**
	* Loads all data from the login file into the object.
	*/
	function load() {
		// read in the contents of the login data file
		$fp = fopen($this->_file, "r");
		$fc = explode(",", fread($fp, filesize($this->_file)));
		fclose($fp);
		
		// loop through and assemble all name/pass pairs
		for ($i = 0; $i < count($fc); $i+=2) {
			$this->_login[$fc[$i]] = $fc[$i+1];
		}
	}
	
	/**
	* Saves all data from the object into the login file.
	*/
	function save() {
		// compile login name/value pairs into an array
		$fc = array();
		reset($this->_login);
		
		while (list($n, $p) = each($this->_login)) {
			array_push($fc, $n);
			array_push($fc, $p);
		}
		// save data as a comma-seperated list.
		$fp = fopen($this->_file, 'w');
		fwrite($fp, implode(",", $fc));
		fclose($fp);
	}
	
	/**
	* Tests a set of login credentials against all login accounts.
	*/
	function test_login($n, $p) {
		return $this->_login[ $n ] == md5($p);
	}
	
	/**
	* Adds a set of login credentials.
	*/
	function add_login($n, $p) {
		$this->_login[ $n ] = md5($p);
		$this->save();
		
		return 'Login was successfully added.';
	}
	
	/**
	* Deletes a login name.
	*/
	function delete_login($n) {
	
		if (isset($this->_login[$n])) {
			unset($this->_login[$n]);
			$this->save();
			
			return 'Login was successfully deleted.';
		}
		else {
			return 'Could not delete login "'. $n .'" becasue it does not exist.';
		}
	}
	
	/**
	* Gets a list of all login names.
	*/
	function get_login_names() {
		$all = array();
		reset($this->_login);
		
		while (list($n, $p) = each($this->_login)) {
			array_push($all, $n);
		}
		return $all;
	}
}

?>