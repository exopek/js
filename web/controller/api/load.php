<?php
header("Access-Control-Allow-Origin: *");
//$filename = "/etc/openhab2/sitemaps/traumhaus.sitemap";
$method = $_SERVER['REQUEST_METHOD'];
$defines = require('../../path.php');


if ($method == 'GET') {
	if (file_exists($defines['traumhausSitemap']))
{
	$myfile = fopen($defines['traumhausSitemap'], "r");
	$file="";
	$item="";
	while(!feof($myfile)) {
	  $line = fgets($myfile);
	  $file .=$line ."#"; // Um im Nachgang mit split in subStrings in einer Liste zu speichern
	  //$file .=$line;
	}
	echo $file;
	//echo 'SUCCES';
	fclose($myfile);
}
} else {
	$data = array(
		'status' => false,
		'message' => 'Sitemap could not be loaded',
	);
	echo json_encode($data);
}



?>