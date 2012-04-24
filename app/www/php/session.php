<?php
$root = (isset($root)) ? $root : "";

session_start();
if (md5(@$_SESSION['user']) != @$_SESSION['key']) {
	header("Location:". $root ."login.php?require=1");
}

$admin = "admin";
$user = (@$_SESSION['user'] != "") ? $_SESSION['user'] : "";
?>