<?php 
$title = "Lassie Shepherd";
include "php/header.php";
include "php/login_manager.php";
$logins = new login_manager("");

$result_create_project = "";
$result_create_login = "";
$result_delete_login = "";

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
	$method = (@$_POST['method'] != "") ? $_POST['method'] : "";
	
	if ($method == "create_project") {
		// create a new project directory
		$proj = (@$_POST['project'] != "") ? $_POST['project'] : "";
		
		if ($proj != "") {
			copyr("template/", "projects/". $proj);
			$result_create_project = "Project was created";
		}
	}
	else if ($method == "create_login") {
		// create a new user login
		$new_name = (@$_POST['name'] != "") ? $_POST['name'] : "";
		$new_pass = (@$_POST['pass'] != "") ? $_POST['pass'] : "";
		$result_create_login = $logins->add_login($new_name, $new_pass);
	}
	else if ($method == "delete_login") {
		// delete a user login
		$delete_name = (@$_POST['login'] != "") ? $_POST['login'] : "";
		$result_delete_login = $logins->delete_login($delete_name);
	}
}

function copyr($source, $dest)
{
    // Simple copy for a file
    if (is_file($source)) {
        $c = copy($source, $dest);
        chmod($dest, 0755);
        return $c;
    }

    // Make destination directory
    if (!is_dir($dest)) {
        $oldumask = umask(0);
        mkdir($dest, 0755);
        umask($oldumask);
    }

    // Loop through the folder
    $dir = dir($source);

    while (false !== $entry = $dir->read()) {
    
        // Skip pointers
        if ($entry == "." || $entry == "..") {
           continue;
        }
        // Deep copy directories
        if ($dest !== "$source/$entry") {
            copyr("$source/$entry", "$dest/$entry");
        }
    }
    // Clean up
    $dir->close();
    return true;
}
?>
			<p>Welcome to Lassie Shepherd. Please select from a project below, or create a new project.</p>			

			<h2>Projects</h2>
			<ul class="contents">
            
<?php 
$dir = "projects";
$file = "";

if (($handle = opendir($dir)) !== FALSE)
{
	while ($file = readdir($handle))
	{
		if (strpos($file, ".") === FALSE)
		{
			$print = '<li><strong>'. $file .'</strong> . . . ';
			$print = $print .'<a href="projects/'. $file .'/edit.php">edit</a> &nbsp;/&nbsp; ';
			$print = $print .'<a href="projects/'. $file .'/play.php">play</a> &nbsp;/&nbsp; ';
			$print = $print .'<a href="projects/'. $file .'/library.php">library</a> &nbsp;/&nbsp; ';
			$print = $print .'<a href="projects/'. $file .'/xml.php">xml</a></li>';
			echo($print);
		}
	}
	closedir($handle);
}
?>
			</ul>


<?php if ($user == $admin) { ?>


			<h2>Create a Project</h2>
			<form action="index.php" method="post">
				<?php if ($result_create_project != "") echo('<p class="error">'. $result_create_project .'</p>'); ?>
                <input type="hidden" name="method" value="create_project"/>
				<p><label>name:</label><input type="text" name="project" /></p>
				<p class="submit"><input type="submit" value="Create Project" /></p>
			</form>




			<h2>Manage Logins</h2>
            <form action="index.php" method="post">
            	<?php if ($result_delete_login != "") echo('<p class="error">'. $result_delete_login .'</p>'); ?>
                <input type="hidden" name="method" value="delete_login"/>
<?php
$login_names = $logins->get_login_names();

for ($i = 0; $i < count($login_names); $i++) {
	$n = $login_names[$i];
	echo '<p>'. (($n != $admin) ? '<input type="radio" name="login" value="'. $n .'"/> ' : '<strong>Locked:</strong> ') . $n .'</p>';
}
?>
                <p class="submit"><input type="submit" value="Delete Selected Login" /></p>
            </form>
            
            
            
            
            
            <h2>Create a Login</h2>
			<form action="index.php" method="post">
				<?php if ($result_create_login != "") echo('<p class="error">'. $result_create_login .'</p>'); ?>
                <input type="hidden" name="method" value="create_login"/>
				<p><label>user:</label><input type="text" name="name" /></p>
				<p><label>pass:</label><input type="password" name="pass" /></p>
				<p class="submit"><input type="submit" value="Create Login" /></p>
			</form>
            
<?php } ?>
<?php include "php/footer.php"; ?>