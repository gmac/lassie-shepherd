<?php

if (isset($path))
{
	if (($handle = opendir($path)) !== FALSE)
	{
		$count = 0;
		
		while (($file = readdir($handle)) !== FALSE)
		{
			if (!is_dir($file) && $file != "." && $file != "..")
			{
				$target = $path ."/". $file;
				$name = "<a href='". $target ."' class='file-name'>". $file . "</a> ";
				$size = "<span class='file-size'>". round(filesize($target)/1000) . "Kb</span> ";
				$date = "<span class='file-date'>". date('r', filectime($target)) . "</span>";
				echo "<li>". $name ." . . . ". $size .", ". $date. "</li>";
				$count++;
			}
		}
		closedir($handle);
		
		if ($count == 0) {
			echo "<li><em>No files</em></li>";
		}
	}
}

?>