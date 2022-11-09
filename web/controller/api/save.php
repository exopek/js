<?php
$mystring = urldecode($_POST["string"]);
$filename = "/etc/openhab2/sitemaps/traumhaus.sitemap";
$myfile = fopen($filename, "w+");
$error = fwrite($myfile, $mystring);
echo $error;
fclose($myfile);
?>