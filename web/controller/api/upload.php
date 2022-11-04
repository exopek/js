<?php
header('Content-Type: application/json');
// get request method
$method = $_SERVER['REQUEST_METHOD'];
$target_dir = "../../../../../pchk/"; //"/pke_scripts/parser/";
$target_file = $target_dir . "traumhaus.xml";

if ($method == 'GET') {
    //print(PHP_OS);
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
    if (isset($_POST["file"])) {
        //print("File is set");
        $base64_string = $_POST["file"];
        $fileHandler = fopen($target_file, "wb");
        fwrite($fileHandler, base64_decode($base64_string));
        fclose($fileHandler);
        // python script to parse the file
        $command = escapeshellcmd('python3 /Users/js/Desktop/Apache24/pchk/main.py');
        if (shell_exec($command) != NULL) {
            $return["status"] = "success";
        } else {
            $return["status"] = "error";
        } //shell_exec("sudo python3 /pke_scripts/parser/main.py");

        
        // Es muss der Prozess gestartet werden, der die Datei verarbeitet
    } else {
        $return["status"] = "error";
        $return["message"] = "No file was sent";
    }
    $json_response = json_encode($return);
    echo $json_response;
}
if ($method == 'PUT') {
	echo "THIS IS A PUT REQUEST";
}
if ($method == 'DELETE') {
	echo "THIS IS A DELETE REQUEST";
}

?>