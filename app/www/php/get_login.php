<?php
$root = (isset($root)) ? $root : "";
$fn = $root . "php/login.txt";
$fp = fopen($fn, "r");
$cred = explode(",", fread($fp, filesize($fn)));
fclose($fp);

// expand CSV into a key table
$_LOGIN = array();

for ($i = 0; $i < count($cred); $i+=2) {
	$_LOGIN[$cred[$i]] = $cred[$i+1];
}
?>