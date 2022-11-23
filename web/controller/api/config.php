<?php
header("Access-Control-Allow-Origin: *");
//header('Content-Type: application/json');
// get request method
$method = $_SERVER['REQUEST_METHOD'];
if ($method == 'GET') {
    /*
    $pchk_config = simplexml_load_file("/var/lib/lcnpchk/lcnpchk.xml"); // das geht
    $version = file_get_contents('/var/www/version.inf');
    $config = include('/var/www/config.php');

    //get default timezone from /etc/timezone file
    $timezone_str = file_get_contents("/etc/timezone");
    //remove any whitespace character
    $timezone_str = rtrim($timezone_str);
    //set default timezone for page
    date_default_timezone_set($timezone_str);
    //find pos of first slash
    $slash_pos = strpos($timezone_str,"/");
    $current_region = substr($timezone_str,0,$slash_pos);
    $current_tzname = substr($timezone_str,$slash_pos+1);

    $current_date_and_time = date("D m/d/Y H:i:s");
    $current_time = date("H:i:s");

    $wifi_passphrase = "undefined";
    $hostname = file_get_contents("/etc/hostname");


    exec("/sbin/ip route", $route_data);	//get route infromation from cli
    exec("/sbin/ifconfig eth0", $data);		//get ip information from cli
    exec("/sbin/ifconfig ap0", $dataWifi);		//get ip information from cli hier vllt wlan0
    exec("/usr/bin/nmcli device show eth0 | grep IP4.DNS", $dns_data); //get dns server information

    //remove linefeeds to avoid splitting into array
    $data = implode("\n", $data);
    $dataWifi = implode("\n", $dataWifi);
    $route_data = implode("\n", $route_data);

    //create arrays to insert preg matches
    $interfaces = array();
    $default_route = array();
    $primary_dns = array();

    //read only first line (we want to get primary DNS from
    //"nmcli...." command (see above) and get current primary dns server
    preg_match("/^(.+)\s+([0-9.]*)/",$dns_data[0], $primary_dns);

    //read "ip route" command and get default gateway
    preg_match("/^default via ([0-9.]*)/", $route_data, $default_route);

    //read complete output of "ifconfig" and split into paragraphs
    //read ip and netmask information and save to "interfaces" array
    foreach (preg_split("/\n\n/", $data) as $int) {
            $interface = array();
            preg_match("/^[A-z]*\d/",$int,$temp);
            $interface['name'] = $temp[0];
            preg_match("/inet ([0-9.]+)/",$int,$temp);
            $interface['ip'] = $temp[1];
            preg_match("/netmask ([0-9.]+)/",$int,$temp);      
            $interface['netmask'] = $temp[1];
            $interfaces[] = $interface;
    }

    foreach (preg_split("/\n\n/", $dataWifi) as $int) {
        $interface = array();
        preg_match("/^[A-z]*\d/",$int,$temp);
        $interface['name'] = $temp[0];
        preg_match("/inet ([0-9.]+)/",$int,$temp);
        $interface['ip'] = $temp[1];
        preg_match("/netmask ([0-9.]+)/",$int,$temp);      
        $interface['netmask'] = $temp[1];
        $interfaces[] = $interface;
    }



    //function for getting state of connection
    //input name of connection
    //return DOWN = connection is disabled or not connected,
    //return UP = connection is active and/or connected
    //return UNDEFINED = connection was not found
    function get_interface_state($iface){
        exec("ip link show ".$iface,$temp_data);
        foreach($temp_data as $str){
            preg_match("/^.+state\s([A-Z]*).*+/",$str,$regex);
            if(!empty($regex)){
                return $regex[1];
            }
        }
        return "UNDEFINED";
    }

    //function for getting specific network interface
    //input $array to read from ($interfaces)
    //input $iface as string to find
    //return index from specified interface in $interfaces
    function get_interface($array, $iface){
            $index = 0;
            foreach($array as $val){
                    if($val['name'] == $iface)
                return $index;
            else
                $index++;
            }

            return 255;
    }

    $zeros = array('0', '0', '0', '0');
    */
    //generate timezone list

    $regions = array(
        'Africa' => DateTimeZone::AFRICA,
        'America' => DateTimeZone::AMERICA,
        'Antarctica' => DateTimeZone::ANTARCTICA,
        'Asia' => DateTimeZone::ASIA,
        'Atlantic' => DateTimeZone::ATLANTIC,
        'Europe' => DateTimeZone::EUROPE,
        'Indian' => DateTimeZone::INDIAN,
        'Pacific' => DateTimeZone::PACIFIC
    );

    $timezones = array();

    foreach ($regions as $name => $mask)
    {
        $zones = DateTimeZone::listIdentifiers($mask);
        foreach($zones as $timezone)
        {
            // Lets sample the time there right now
            $time = new DateTime(NULL, new DateTimeZone($timezone));
            // Us dumb Americans can't handle millitary time
            $ampm = $time->format('H') > 12 ? ' ('. $time->format('g:i a'). ')' : '';
            // Remove region name and add a sample time
            $timezones[$name][$timezone] = substr($timezone, strlen($name) + 1);// . ' - ' . $time->format('H:i') . $ampm;
        }
    }

    /*
	$data = array(
		'status' => true,
		'message' => 'All for pchk config',
		'version' => $version,
		'pchk_version' => $pchk_config->Header->Generator,
        'pchk_host_id' => $pchk_config->Communication->HostId,
        'pchk_timeout_std' => $pchk_timeout_std,
        'pchk_timeout_min' => $pchk_timeout_min,
        'interface_state' => get_interface_state("eth0"), // String "UP" or "DOWN"
        'interface_ip' =>  get_interface($interfaces,"eth0") != 255 ? explode(".",$interfaces[get_interface($interfaces,"eth0")]['ip']) : $zeros, // List ip address
        'interface_subnet' => get_interface($interfaces,"eth0") != 255 ? explode(".",$interfaces[get_interface($interfaces,"eth0")]['netmask']) : $zeros, // List subnet mask
        'interface_gateway' => explode(".",$default_route[1])[0] == "" ? $zeros : explode(".",$default_route[1]), // List default gateway
        'interface_dns' => explode(".",$primary_dns[2])[0] == "" ? $zeros : explode(".",$primary_dns[2]), // List primary dns server
        'host_name' => $hostname, // String
        'user_name' => explode(":",$pchk_config->Communication->User)[0], // String
        'syncTime' => $pchk_config->LcnRealTimeClockSync->attributes("xsi", TRUE)['type'], // String "SyncDisabled" or "SyncNtpTime"
        'syncTimeLink' => $pchk_config->LcnRealTimeClockSync, // String de.pool.ntp.org
        'version_year' => $config['version_year'],
        'pke_mode' => $config['pke_mode'], // String "0", "pke_mode_private"
        'dhcp_status' => $config['dhcp_on'], // String "true", "false"
        'wifi_status' => $config['wifi_on'], // String "true", "false"
        'wifi_automatic' => $config['wifi_automatic'], // String "true", "false"
        'timezones' => $timezones,
        'current_timezone' => $current_tzname, // Wichtig als Voreinstellung
        'current_region' => $current_region, // Wichtig als Voreinstellung
	);
    */

    $dummyData = array(
		'status' => true,
		'message' => 'All for pchk config',
		'version' => '3.04', // String
		'pchk_version' => '3.3.1', // String
        'pchk_host_id' => '4', // String
        'pchk_timeout_std' => 0, // int
        'pchk_timeout_min' => 30, // int
        'interface_state' => 'UP', // String "UP" or "DOWN"
        'interface_ip' => array('0', '0', '0', '0'),
        'interface_subnet' => array('0', '0', '0', '0'),
        'interface_gateway' => array('0', '0', '0', '0'),
        'interface_dns' => array('0', '0', '0', '0'),
        'host_name' => 'LCN-VISU', // String
        'user_name' => 'Test User', // String
        'syncTime' => 'SyncNtpTime', // String 
        'syncTimeLink' => 'de.pool.ntp.org',
        'pke_mode' => '0', // String "0", "pke_mode_private"
        'dhcp_status' => 'true', // String "true", "false"
        'wifi_status' => 'true', // String "true", "false"
        'wifi_automatic' => 'true', // String "true", "false"
        'timezones' => $timezones, // List
        'current_timezone' => 'Europe', // Wichtig als Voreinstellung
        'current_region' => 'Berlin', // Wichtig als Voreinstellung
	);


	$json_response = json_encode($dummyData);
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