<?php 
$user = isset($user) ? $user : "";
$root = isset($root) ? $root : "";
?>

<div id="nav">
	<div class="login">
		Welcome <?php echo($user); ?>, <a href="<?php echo($root); ?>login.php?logout=1">logout</a>.
	</div>
	<ul>
		<li><a href="<?php echo($root); ?>index.php">Home</a></li>
		<li><a href="<?php echo($root); ?>help.php">Help</a></li>
	</ul>
</div>