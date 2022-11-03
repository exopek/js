<?php
//##################### GLOBALS #########################
//include("../security.php");
//$textcontent = include("../language/".$config['language']);

exec("/sbin/ifconfig eth0", $data);		//get ip information from cli
$data = implode("\n",$data);
foreach (preg_split("/\n\n/", $data) as $int) {
	preg_match("/inet ([0-9.]+)/",$int,$temp);
	$localIP = $temp[1];
}

//try to retrieve VISU local IP address from wifi interface, if ethernet is not yet setup
if(!isset($localIP)) {
	exec("/sbin/ifconfig ap0", $data);		//get ip information from cli
	$data = implode("\n",$data);
	foreach (preg_split("/\n\n/", $data) as $int) {
		preg_match("/inet ([0-9.]+)/",$int,$temp);
		$localIP = $temp[1];
	}
}

//$return "192.168.0.62";
//$return["message"] = json_encode("192.169.0.62");
$return["message"] = '192.168.0.62';//$temp[1];
$return["session"] = $_SESSION;
//$return["request method"] = $_SERVER['REQUEST_METHOD'];


        		
if(isset($_SESSION['logged_in']) && $_SESSION['logged_in'] == true){
        $return["success"] = true;
}
?>