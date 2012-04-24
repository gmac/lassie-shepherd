<?php 
$root = isset($root) ? $root : "";
$title = isset($title) ? $title : "Lassie Shepherd";
include $root."php/session.php";
?>

<html>
<head>
	<title><?php echo($title); ?></title>
	<link href="<?php echo($root); ?>styles/init.css" rel="stylesheet" type="text/css">
	<link href="<?php echo($root); ?>styles/lassie.css" rel="stylesheet" type="text/css">
</head>
<body>

	<div id="page">
		<?php include $root."php/nav.php"; ?>
		<div class="col main">
			<h1><?php echo($title); ?></h1>