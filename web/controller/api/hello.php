<?php
header("Access-Control-Allow-Origin: *");
//header('Content-Type: application/json');
// get request method
$method = $_SERVER['REQUEST_METHOD'];
if ($method == 'GET') {
    // Access other files
    //$data = require("../../../../../pchk/config.php");
	$data = array(
		'status' => true,
		'message' => 'File uploaded successfully',
		'modules' => 'module1',
		'rooms' => 'room1',
		'devices' => 'device1',
	);
	$json_response = json_encode($data);
    echo $json_response;

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