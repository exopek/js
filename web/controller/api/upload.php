<?php
//header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
// get request method
$method = $_SERVER['REQUEST_METHOD'];
$defines = require('../../path.php');

if ($method == 'GET') {
    //print(PHP_OS);
    // Access other files
    
    $lastUpload = file_get_contents($defines['uploadFile']);
    $data = array(
        'name' => explode("/", $lastUpload)[0],
        'date' => explode("-",explode("/",$lastUpload)[1])[0],
        'time' => explode("-",explode("/",$lastUpload)[1])[1],
    );
    
    /*
    $data = array(
        'name' => 'test',
        'date' => 'test',
        'time' => 'test',
    );
    */
    $json_response = json_encode($data);
	echo $json_response;
}
if ($method == 'POST') {
    if (isset($_POST["file"])) {
        $base64_string = $_POST["file"];
        $fileHandler = fopen($defines['traumhausXml'], "wb");
        fwrite($fileHandler, base64_decode($base64_string));
        fclose($fileHandler);
        // python script to parse the file
        $command = escapeshellcmd($defines['parser']);
        if (shell_exec($command) != NULL) {
            if (filesize($defines['parserConfig'])>0) {
                $lines = file($defines['parserConfig']); 
                foreach($lines as $line_num => $line){
                    $parserInfo[] = $line;
                }
                $data = array(
                    'status' => true,
                    'message' => 'File uploaded successfully',
                    'modules' => $parserInfo[0],
                    'rooms' => $parserInfo[1],
                    'devices' => $parserInfo[2],
                );
            } else {
                $data = array(
                    'status' => false,
                    'message' => 'File uploaded successfully, but no config file was created',
                );
            } 
        } else {
            if (filesize($defines['parserError'])>0){ 
                $error = file_get_contents($defines['parserError']);
                $data = array(
                    'status' => false,
                    'message' => $error,
                );
            } else {
                $data = array(
                    'status' => false,
                    'message' => 'File could not be uploaded',
                );
            }
        }
    } else {
        $data = array(
            'status' => false,
            'message' => 'No file was uploaded',
        );
    }
    $json_response = json_encode($data);
    echo $json_response;
}
if ($method == 'PUT') {
	echo "THIS IS A PUT REQUEST";
}
if ($method == 'DELETE') {
	echo "THIS IS A DELETE REQUEST";
}

?>