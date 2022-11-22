<?php

//header('Content-Type: application/json');
header('Access-Control-Allow-Origin: *');
// get request method
$method = $_SERVER['REQUEST_METHOD'];
$defines = require('../../path.php');

if ($method == 'GET') {
    echo "GET IS NOT IMPLEMENTED";
} else if ($method == 'POST') {
    if(isset($_POST["string"])) {
        $mystring = urldecode($_POST["string"]);
        $filename = $defines['traumhausSitemap'];
        $myfile = fopen($filename, "w+");
        $error = fwrite($myfile, $mystring);
        $data = array(
            'status' => $error,
            'message' => 'Sitemap changed successfully',
        ); 
        fclose($myfile);
    } else {
        $data = array(
            'status' => false,
            'message' => 'No string was sent',
        );
    }
    $json_response = json_encode($data);
    echo $json_response;
} else {
    $data = array(
        'status' => false,
        'message' => 'Request method not accepted',
    );
    $json_response = json_encode($data);
    echo $json_response;
}

?>