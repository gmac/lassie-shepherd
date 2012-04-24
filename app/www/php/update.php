<?php

$dir = "../../projects";

function update_file($source, $dest)
{
    if (is_file($source))
	{
        $c = copy($source, $dest);
        chmod($dest, 0755);
        return $c;
    }
}

if (($handle = opendir($dir)) !== FALSE)
{
	while ($proj = readdir($handle))
	{
		if ($proj != "." && $proj != "..")
		{
			@update_file("../project/index.php", "../../projects/". $proj ."/index.php");
			@update_file("../project/edit.php", "../../projects/". $proj ."/edit.php");
			@update_file("../project/game.php", "../../projects/". $proj ."/game.php");
			@update_file("../project/php/index.php", "../../projects/". $proj ."/php/index.php");
			@update_file("../project/php/config.xml", "../../projects/". $proj ."/php/config.xml");
			echo("updated: ". $proj ."<br/>");
		}
	}
	closedir($handle);
}
echo("complete.");
?>