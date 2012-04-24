<?php
session_start();

$mssg = "";

// if GET
if ($_SERVER['REQUEST_METHOD'] == 'GET') {
	// notify that login was required by another page
	if (@$_GET['require'] == 1) {
		$mssg = "Login is required.";
	}

	// notify that login was required by another page
	if (@$_GET['logout'] == 1) {
		session_destroy();
		$mssg = "You have been logged out.";
	}
}

// if POST
if ($_SERVER['REQUEST_METHOD'] == 'POST') {
	// get user information
	include "php/login_manager.php";
	$login = new login_manager("");
	$user = (@$_POST['user'] != "") ? $_POST['user'] : "";
	$pass = (@$_POST['pass'] != "") ? $_POST['pass'] : "";

	if ($login->test_login($user, $pass)) {
		$_SESSION['user'] = $user;
		$_SESSION['key'] = md5($user);
		header("Location:index.php");
	}
	else {
		$mssg = "Invalid login.";
	}
}
?>

<html>
<head>
	<title>Lassie Shepherd</title>
	<link href="styles/init.css" rel="stylesheet" type="text/css">
	<link href="styles/lassie.css" rel="stylesheet" type="text/css">
</head>
<body>

	<div id="page">
		<div class="col main">
			<h1>Lassie Shepherd</h1>
			
			<p>Welcome to Lassie Shepherd. Please provide your login credentials to enter this development site.</p>
            
			<h2>Log In</h2>
			<form action="login.php" method="post">
<?php
if ($mssg != "") {
	echo('<p class="error">' . $mssg . '</p>');
}
?>
				<p><label>user:</label><input type="text" name="user"/></p>
				<p><label>pass:</label><input type="password" name="pass"/></p>
				<p class="submit"><input type="submit" value="Login" /></p>
			</form>

<?php include "php/footer.php"; ?>