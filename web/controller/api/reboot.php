<?php
header("Access-Control-Allow-Origin: *");
//header('Content-Type: application/json');
// get request method
$method = $_SERVER['REQUEST_METHOD'];
if ($method == 'GET') {
    try {
        //pclose(popen("sudo /pke_scripts/change_settings.sh reboot &","r"));
        $data = array(
            'status' => true,
            'message' => 'rebooting',
        );
        $json_response = json_encode($data);
        echo $json_response;
    } catch (Exception $e) {
        $data = array(
            'status' => false,
            'message' => 'reboot failed',
        );
        $json_response = json_encode($data);
        echo $json_response;
    }
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