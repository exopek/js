<?php
header("Access-Control-Allow-Origin: *");
// get request method
$method = $_SERVER['REQUEST_METHOD'];
if ($method == 'GET') {
    // Access other files
    $lastUpload = file_get_contents("../../../../../pchk/upload_file.txt");
    $data = array(
        'name' => explode("/", $lastUpload)[0],
        'date' => explode("-",explode("/",$lastUpload)[1])[0],
        'time' => explode("-",explode("/",$lastUpload)[1])[1],
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