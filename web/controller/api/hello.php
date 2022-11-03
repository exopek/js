<?php
header("Access-Control-Allow-Origin: *");
// get request method
$method = $_SERVER['REQUEST_METHOD'];
if ($method == 'GET') {
    // Access other files
    $data = require("../../../../../pchk/config.php");
	echo $data['language'];
}
if ($method == 'POST') {
	echo "THIS IS A POST REQUEST";
}
if ($method == 'PUT') {
	echo "THIS IS A PUT REQUEST";
}
if ($method == 'DELETE') {
	echo "THIS IS A DELETE REQUEST";
}

?>