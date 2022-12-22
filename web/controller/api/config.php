<?php

//GLOBALS
include("../security.php");

$config = require('/var/www/config.php');
$textcontent = include("../language/".$config['language']);

$config_file = '/var/www/config.php'; 	//file contains configuration data
$err_type = "success";		//standard error is "success" -> everything was fine
$date_changed = false;		//flag for avoid overwriting -> see section DATE AND TIME CHANGES
$wait_time = 5;			//default waiting time for transition 5 seconds
$reboot_device = false;
$new_ip_address = "";		//used later to correctly redirect user in case of ip address changing
$return_text = 0;		//variable to return user message at the end
$get_dld = 0;



header("Access-Control-Allow-Origin: *");
//header('Content-Type: application/json');
// get request method
$method = $_SERVER['REQUEST_METHOD'];

// Wird im Post Request benötigt
function mask2cidr($mask){
	//calculate CIDR from netmask
     $long = ip2long($mask);
     $base = ip2long('255.255.255.255');
     return 32-log(($long ^ $base)+1,2);
}

// Wird im Post Request benötigt
function set_config_wifi($setting, $replace){
    //function to set wifi settings
    //read line per line and compare with requested setting $setting
    //replace with new setting $replace
            $ap_config = file_get_contents("/etc/create_ap.conf");
            $config_array = preg_split("/\n/", $ap_config);
            foreach($config_array as $line){
                    $here = explode("=",$line);
                    if($here[0] == $setting){
                    //match found
                        $temp_line = str_replace($here[1], $replace, $line);
                $ap_config = str_replace($line, $temp_line, $ap_config);
                file_put_contents("/etc/create_ap.conf", $ap_config);
                    }
            }
    }

// Wird im Post Request benötigt
function change_date_time_settings(){
    global $config;
    global $pchk_config;
    $pchk_changes = 0;

    if($_POST["current_date"] != $_POST["date"]){
        //change date
        if (DateTime::createFromFormat('m/d/Y', $_POST["date"])){
            shell_exec("sudo /pke_scripts/change_settings.sh date ".explode("/",$_POST["date"])[0].explode("/",$_POST["date"])[1].explode(":",$_POST["current_time"])[0].explode(":",$_POST["current_time"])[1].explode("/",$_POST["date"])[2]);
            $date_changed = true;
        }
        else{
            //date has invalid format
            $err_type = 5;
            $wait_time = 1;
        }
    }
    if($_POST["current_time"] != $_POST["time"]){
        //change time
        if (DateTime::createFromFormat('H:i:s', $_POST["time"]))
            shell_exec("sudo /pke_scripts/change_settings.sh date ".explode("/",($date_changed == true ? $_POST["date"] : $_POST["current_date"]))[0].explode("/",($date_changed == true ? $_POST["date"] : $_POST["current_date"]))[1].explode(":",$_POST["time"])[0].explode(":",$_POST["time"])[1].explode("/",($date_changed == true ? $_POST["date"] : $_POST["current_date"]))[2]);
        else{
            //time has invalid format
            $err_type = 6;
            $wait_time = 1;
        }
    }
    if($_POST["current_tzone"] != $_POST["tzone"] && $_POST["tzone"] != "none"){
        shell_exec("sudo /pke_scripts/change_settings.sh timezone ".$_POST["tzone"]);
        $wait_time = 2;
    }
    if(isset($_POST["enable_rtc_sync"]))
    {	//if RTC sync has been enabled
        if($pchk_config->LcnRealTimeClockSync->attributes("xsi",TRUE)['type'] == "SyncDisabled")
        {
            $pchk_config->LcnRealTimeClockSync->attributes("xsi",TRUE)['type'] = "SyncSystemTime";
            $pchk_changes++;
        }

        if(isset($_POST["get_time_from_ntp"]))
        {
            //user want to get time from NTP server
            if($pchk_config->LcnRealTimeClockSync->attributes("xsi",TRUE)['type'] != "SyncNtpTime")
                                $pchk_changes++;
            $pchk_config->LcnRealTimeClockSync->attributes("xsi",TRUE)['type'] = "SyncNtpTime";
            //change ntp server if different from config file
            if($_POST["ntp_server"] != $pchk_config->LcnRealTimeClockSync)
            {
                if(!empty($_POST["ntp_server"]))
                {
                       $pchk_config->LcnRealTimeClockSync = $_POST["ntp_server"];
                    //equalize settings for local ntp server in background
                    pclose(popen("sudo /pke_scripts/change_settings.sh ntp ".$_POST["ntp_server"]." &","r"));
                    $pchk_changes++;
                }
                else
                {
                    $err_type = 12;
                    $wait_time = 1;
                }
            }
        }
        else
        {
            //user want to use local system time
            if($pchk_config->LcnRealTimeClockSync->attributes("xsi",TRUE)['type'] != "SyncSystemTime")
                $pchk_changes++;
            $pchk_config->LcnRealTimeClockSync->attributes("xsi",TRUE)['type'] = "SyncSystemTime";
            shell_exec("sudo /pke_scripts/change_settings.sh ntp 255.255.255.255 &");
        }

    }//if RTC sync has been disabled
    else if($pchk_config->LcnRealTimeClockSync->attributes("xsi",TRUE)['type'] != "SyncDisabled")
    {
        $pchk_config->LcnRealTimeClockSync->attributes("xsi",TRUE)['type'] = "SyncDisabled";
        $pchk_changes++;
    }
    return $pchk_changes;
}





if ($method == 'GET') {
    
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
            $time = new DateTime('', new DateTimeZone($timezone)); // NULL
            // Us dumb Americans can't handle millitary time
            $ampm = $time->format('H') > 12 ? ' ('. $time->format('g:i a'). ')' : '';
            // Remove region name and add a sample time
            $timezones[$name][$timezone] = substr($timezone, strlen($name) + 1);// . ' - ' . $time->format('H:i') . $ampm;
        }
    }
    // Name der PKE Lizenz
    $licence = shell_exec("/pke_scripts/pchk_request lic");

    // Anzahl der Lizenzen
    $licenceCount = explode(",",shell_exec("/pke_scripts/pchk_request clic"))[3];
    
	$data = array(
		'status' => true,
		'message' => 'All for pchk config',
		'version' => $version,
		'pchk_version' => $pchk_config->Header->Generator['0'],
        'pchk_host_id' => $pchk_config->Communication->HostId['0'],
        'pchk_timeout_std' => $pchk_timeout_std,
        'pchk_timeout_min' => $pchk_timeout_min,
        'interface_state' => get_interface_state("eth0"), // String "UP" or "DOWN"
        'interface_ip' =>  get_interface($interfaces,"eth0") != 255 ? explode(".",$interfaces[get_interface($interfaces,"eth0")]['ip']) : $zeros, // List ip address
        'interface_subnet' => get_interface($interfaces,"eth0") != 255 ? explode(".",$interfaces[get_interface($interfaces,"eth0")]['netmask']) : $zeros, // List subnet mask
        'interface_gateway' => explode(".",$default_route[1])[0] == "" ? $zeros : explode(".",$default_route[1]), // List default gateway
        'interface_dns' => explode(".",$primary_dns[2])[0] == "" ? $zeros : explode(".",$primary_dns[2]), // List primary dns server
        'host_name' => $hostname, // String
        'user_name' => explode(":",$pchk_config->Communication->User)[0], // String
        'syncTime' => $pchk_config->LcnRealTimeClockSync->attributes("xsi", TRUE)['type']['0'], // String "SyncDisabled" or "SyncNtpTime"
        'syncTimeLink' => $pchk_config->LcnRealTimeClockSync['0'], // String de.pool.ntp.org
        'version_year' => $config['version_year'],
        'pke_mode' => $config['pke_mode'], // String "0", "pke_mode_private"
        'dhcp_status' => $config['dhcp_on'], // String "true", "false"
        'wifi_status' => $config['wifi_on'], // String "true", "false"
        'wifi_automatic' => $config['wifi_automatic'], // String "true", "false"
        'timezones' => $timezones,
        'current_timezone' => $current_tzname, // Wichtig als Voreinstellung
        'current_region' => $current_region, // Wichtig als Voreinstellung
        'licence' => $licence == 'null' ? 'Keine Lizenz' : $licence,
        'licenceCount' => substr($licenceCount, 0),
        'active_wlan_hotspot' => $config['wifi_on'] == 'true' ? true : false,
	);
    

    /*
    $dummyData = array(
		'status' => true,
		'message' => 'All for pchk config',
		'version' => '3.04',
		'pchk_version' => '3.3.1',
        'pchk_host_id' => '4',
        'pchk_timeout_std' => 0,
        'pchk_timeout_min' => 30,
        'interface_state' => 'UP',
        'interface_ip' => array('0', '0', '0', '0'),
        'interface_subnet' => array('0', '0', '0', '0'),
        'interface_gateway' => array('0', '0', '0', '0'),
        'interface_dns' => array('0', '0', '0', '0'),
        'host_name' => 'LCN-VISU',
        'user_name' => 'Test User',
        'syncTime' => 'SyncNtpTime',
        'syncTimeLink' => 'de.pool.ntp.org',
        'pke_mode' => '0',
        'dhcp_status' => 'true',
        'wifi_status' => 'true',
        'wifi_automatic' => 'true',
        'timezones' => $timezones,//array('EUROPE', 'ASIA', 'AMERICA'),
        'current_timezone' => 'Europe',
        'current_region' => 'Berlin',
        'licence' => 'PKE-Lizenz',
        'licenceCount' => 3,
	);
    */


	//$json_response = json_encode($data);
    $json_response = json_encode($data);
    echo $json_response;
    
    

}
if ($method == 'POST' || isset($_SERVER['QUERY_STRING'])) //if site is opened via POST-request OR via direct QUERY-string)
	{

	//############################### APPLIANCE #################################
	//---------------------------------------------------------------------------
		//BUTTON REBOOT WAS PRESSED
		//MUST BE FIRST!!! otherwise server_query will not reach this!!
		if(isset($_POST['reboot_sw']) || (isset($_SERVER['QUERY_STRING']) && $_SERVER['QUERY_STRING'] == "rst")){
			//send reboot command and do not wait for reply so splash screen can be loaded before
			//network reset is happening
			$return_text = 1;
			pclose(popen("sudo /pke_scripts/change_settings.sh reboot &","r"));
			$wait_time = 50;
		}
		//FIRST_ASSIST BUTTON SAVE WAS PRESSED
		else if(isset($_POST['first_assist_finish']))
			{
				if (!empty($_POST['pke_mode_select']))
				{
					set_config("pke_mode",$_POST['pke_mode_select'],"/var/www/config.php");
					if($_POST['pke_mode_select'] == "pke_mode_public")
					{
						set_config("smb_on","false","/var/www/config.php");
						shell_exec("sudo /pke_scripts/change_settings.sh disable_smb &");
						shell_exec("sudo /pke_scripts/change_settings.sh disable_http &");
						$wait_time = 15;
					}
				}
			}

		//BUTTON NTP DATE/TIME FETCH WAS PRESSED
		else if(isset($_POST['ntp_fetch']))
		{
			//apply possible changes
			$pchk_changes = change_date_time_settings();
			
			//if no ntp server was specified
			if(empty($_POST['ntp_server']))
			{
				$err_type = 12;
				$wait_time = 1;
			}
			else
			{
				shell_exec("sudo /pke_scripts/change_settings.sh ntpdate ".$_POST["ntp_server"]);
				$wait_time=1;
			}

			//if changes were made, restart PCHK daemon to apply
			if(($advanced_settings_changes > 0) || ($user_changes > 0) || ($pchk_changes > 0))
			{
				$pchk_config->asXML('/var/lib/lcnpchk/lcnpchk.xml');
				shell_exec("sudo /pke_scripts/change_settings.sh lcnpchk_restart");
			}
		}

		//BUTTON START BUS MONITOR WAS PRESSED
		else if(isset($_POST['start_bus_monitor'])){
			shell_exec("sudo /pke_scripts/change_settings.sh start_bus_monitor");
		}

		//BUTTON STOP BUS MONITOR WAS PRESSED
		else if(isset($_POST['stop_bus_monitor'])){
			$file = "/pke_scripts/bus_log/bus_log.zip";
			shell_exec("sudo /pke_scripts/change_settings.sh stop_bus_monitor");
			$get_dld = 1;
			}

		//BUTTON KEY ADD WAS PRESSED
		else if(isset($_POST['add_license']))
		{
			$key = $_POST["key"]; //remove blank spaces
			$replace_chars = array(" ","\t","\n","\r","\0","\x0B","-");
			$output = str_replace($replace_chars,"",$key); //remove hyphens
			$output = htmlspecialchars($output, ENT_XML1); //escape chars like & for XML usage
			$licensee = shell_exec("/pke_scripts/pchk_request lic");
			//check if standard PKE license is available or user had installed full version
			if(shell_exec("/pke_scripts/pchk_request lic") == "null" || explode(",",shell_exec("/pke_scripts/pchk_request clic"))[3] <= 2)
			{
				if(str_replace($replace_chars,"",shell_exec("/pke_scripts/pchk_request ipk \"".$_POST["licensee"]."\" \"".$output."\"")) == "success")
				{
					$wait_time = 1;
				}
				else
				{
					$err_type = 19;
					$wait_time = 1;
				}
			}
			else
			{
				if(str_replace($replace_chars,"",shell_exec("/pke_scripts/pchk_request iuk \"".$licensee."\" \"".$output."\"")) == "success")
				{
					$wait_time = 1;
				}
				else
				{
					$err_type = 19;
					$wait_time = 1;
				}
			}
		}
		//BUTTON FIRMWARE UPDATE WAS PRESSED
		else if(isset($_POST['fw_update_sw']))
		{
			$return_text = 3;
			if($_FILES['update_file']['error'] == 0)
			{
				$uploaddir = '/var/www/html/pke_webconfig/tmp_uploaded/';
				$uploadfile = $uploaddir . "tmp_update.upke";
				move_uploaded_file($_FILES['update_file']['tmp_name'],$uploadfile);
				$update_exit = shell_exec("sudo /pke_scripts/apply_firmware_update.sh ".$uploadfile." > /dev/null 2>&1; echo $?");
				if($update_exit != 0)
				{
					//$err_type = 14-16 reserved for this error
					if($update_exit == 16)//perform reboot
					{ 
						$return_text = 1;
						pclose(popen("sudo /pke_scripts/change_settings.sh reboot &","r"));
						$wait_time = 150;
					}
					//if no special action is required, print error from exit state of update script
					else
					{
						$err_type = $update_exit;
						$wait_time = 1;
					}
				}
			}
			else
			{
				$err_type = 3;
				$wait_time = 1;
			}
		}

		//BUTTON SAVE SETTINGS WAS PRESSED
		else if(isset($_POST['save_settings']))
		{
	//-------------- USERNAME AND PASSWORD CHANGES -------------------------------
			//initialize changes counter
			$user_changes = 0;
			//if $username_new or $password_new are set
			if (!empty($_POST["username_new"]))
			{
				//change username
				if($_POST["username_new"] != explode(":",$pchk_config->Communication->User)[0])
				{
					$pchk_config->Communication->User = $_POST["username_new"].":".explode(":",$pchk_config->Communication->User)[1];
					$username=$_POST["username_new"];
					pclose(popen("sed -i 's/.*\//$username\//' /var/lib/lcnpchk/pass.txt","r"));
					pclose(popen("sed -i 's/\"username\":.*/\"username\": \"$username\"/' /var/lib/openhab2/jsondb/org.eclipse.smarthome.core.thing.Thing.json","r"));
					$user_changes++;
				}
			}
		//if new password is set user probably want to change current password
		//further check if new password and repeat of new password were set and matching
			if(!empty($_POST["passwd_new"]))
			{
				if(empty($_POST["passwd_repeat"]))
				{
				//new password is set, but repeated is not
					$err_type="1";
					$wait_time = 1;
				}
				else if($_POST["passwd_new"] != $_POST["passwd_repeat"])
				{
					//repeated password does not match
					$err_type="2";
					$wait_time = 1;
				}
				else if(explode(":",$pchk_config->Communication->User)[1] != hash("md5",$_POST["passwd_old"]))
				{
					//old password was not correctly
					$err_type="21";
					$wait_time = 1;
				}
				else
				{
					//apply new password, save everything to lcnpchk config file
					$pchk_config->Communication->User = explode(":",$pchk_config->Communication->User)[0].":".hash("md5",$_POST["passwd_new"]);
					$password=$_POST["passwd_new"];
					pclose(popen("sed -i 's/\/.*/\/$password/' /var/lib/lcnpchk/pass.txt","r"));
					pclose(popen("sed -i 's/\"password\":.*/\"password\": \"$password\"/' /var/lib/openhab2/jsondb/org.eclipse.smarthome.core.thing.Thing.json","r"));
					$user_changes++;
				}
			}

	//-------------------- DATE AND TIME CHANGES ----------------------------

			$pchk_changes = change_date_time_settings();

	//-------------------- ADVANCED SETTINGS CHANGES ----------------------------

			$advanced_settings_changes = 0;
			$timeout_in_sec = (($_POST["pchk_timeout_std"]*60)*60)+($_POST["pchk_timeout_min"]*60);
			if($timeout_in_sec != $pchk_config->Communication->TCPInactivityTimeout)//value not equal to actual value
			{ 
				if($timeout_in_sec <= 172800)//smaller than 48 hrs maximum timeout
				{ 
					$pchk_config->Communication->TCPInactivityTimeout = $timeout_in_sec;
					$advanced_settings_changes++;
				}
				else
				{
					$err_type = 18;
					$wait_time = 1;
				}
			}
			if(!empty($_POST["pchk_modid"]))
			{
				if($_POST["pchk_modid"] != $pchk_config->Communication->HostId)
				{
					if($_POST["pchk_modid"] == 1 || $_POST["pchk_modid"] == 2 || ($_POST["pchk_modid"] > 3 && $_POST["pchk_modid"] < 255))//check if id is in valid range
					{ 
						$pchk_config->Communication->HostId = $_POST["pchk_modid"];
						$advanced_settings_changes++;
					}
					else
					{
						$err_type = 17;
						$wait_time = 1;
					}
				}
			}

	//---------------------- IP CHANGES -------------------------------------
			
			$temp_ip = implode(".",array($_POST["ip_1"], $_POST["ip_2"], $_POST["ip_3"], $_POST["ip_4"]));
			$temp_mask = implode(".",array($_POST["subnet_1"],$_POST["subnet_2"],$_POST["subnet_3"],$_POST["subnet_4"]));
			$temp_gw = implode(".",array($_POST["gw_1"],$_POST["gw_2"],$_POST["gw_3"],$_POST["gw_4"]));
			$temp_dns = implode(".",array($_POST["dns_1"], $_POST["dns_2"], $_POST["dns_3"], $_POST["dns_4"]));
			//if fields are disabled nothing is transmitted here, no check is possible
			//check if first field is disabled, guess all other are disabled too
			if(isset($_POST["ip_1"])){
			//check submitted addresses if valid?
				$validation_counter = 0;
				if(filter_var($temp_ip, FILTER_VALIDATE_IP))
					$validation_counter++;
				else{
					$err_type = 7;
					$wait_time = 1;
				}
				if(filter_var($temp_mask, FILTER_VALIDATE_IP))
					$validation_counter++;
				else{
					$err_type = 8;
					$wait_time = 1;
				}
				if(filter_var($temp_gw, FILTER_VALIDATE_IP))
					$validation_counter++;
				else{
					$err_type = 9;
					$wait_time = 1;
				}
				if(filter_var($temp_dns, FILTER_VALIDATE_IP))
					$validation_counter++;
				else{
					$err_type = 10;
					$wait_time = 1;
				}
			}

			//only apply network changes if dhcp is turned off
			if(!isset($_POST["enable_dhcp"]) && $validation_counter == 4)
			{
				//save ip settings to config file
				if($_POST["current_ip"] != $temp_ip)
				{
					set_config("ip_address", $temp_ip, $config_file);
				}
				else
				{
					set_config("ip_address", $_POST["current_ip"], $config_file);
				}
				//save netmask
				if($_POST["current_subnet"] != $temp_mask)
				{
					set_config("netmask", $temp_mask, $config_file);
				}
				else
				{
					set_config("netmask", $_POST["current_subnet"], $config_file);
				}
				//save gateway
				if($_POST["current_gw"] != $temp_gw)
				{
					set_config("gateway", $temp_gw, $config_file);
				}
				else
				{
					set_config("gateway", $_POST["current_gw"], $config_file);
				}
				//save dns server
				if($_POST["current_dns"] != $temp_dns)
				{
					set_config("dns_server", $temp_dns, $config_file);
				}
				else if(!empty($_POST["current_dns"]))
				{
					set_config("dns_server", $_POST["current_dns"], $config_file);
				}
				//reload config file
				opcache_invalidate('/var/www/config.php');
				$config = include('/var/www/config.php');
				//apply changes!
				if($config["dhcp_on"] == "true")
				{
					set_config("dhcp_on", "false", $config_file);
					$new_ip_address = $config["ip_address"]; //later do redirect to this new IP
					pclose(popen("sudo /pke_scripts/change_settings.sh ip add ".$config["ip_address"]." ".mask2cidr($config["netmask"])." ".$config["gateway"]." ".$config["dns_server"]." &","r"));

				}
				else
				{
					//reload config file
					opcache_invalidate('/var/www/config.php');
					$config = include('/var/www/config.php');
					$new_ip_address = $config["ip_address"]; //later do redirect to this new IP
					pclose(popen("sudo /pke_scripts/change_settings.sh ip modify ".$config["ip_address"]." ".mask2cidr($config["netmask"])." ".$config["gateway"]." ".$config["dns_server"]." &","r"));

				}
			}
			else
			{
				if($config["dhcp_on"] != "true")
				{
					set_config("dhcp_on", "true", $config_file);
					$return_text = 2;
					pclose(popen("sudo /pke_scripts/change_settings.sh ip dhcp &", "r"));
				}
			}

			if((trim ($_POST["current_hostname"]," \t\n\r\0\x0B") != (trim ($_POST["hostname"]," \t\n\r\0\x0B"))) && !empty($_POST["hostname"]))
			{
				set_config_wifi("SSID",$_POST["hostname"]);	//replace WIFI-SSID
				shell_exec("sudo /pke_scripts/change_settings.sh wifi restart &");	//apply wifi settings
				shell_exec("sudo /pke_scripts/change_settings.sh hostname ".$_POST["hostname"]);	//apply hostname settings
				$return_text = 1;
			}
	//------------------- MAINTENANCE AND WIFI SETTINGS ---------------------
			$temp_wifi_ip = implode(".",array($_POST["wifi_ip_1"],$_POST["wifi_ip_2"],$_POST["wifi_ip_3"],$_POST["wifi_ip_4"]));
			
			if(isset($_POST["enable_wireless"]))
			{
				//update config wlan = ON
				$previous_wifi_state = $config['wifi_on'];
				set_config("wifi_on", "true", $config_file);
				//initialize changes counter to test if restart is required
				$wifi_changes = 0;
				//check if IP has been changed and configured ip is valid
				//if wifi was previously unset, wifi_ip_1..2..3..4 fields are not set -> skip this test
				if(isset($_POST["wifi_ip_1"]))
				{
					if($_POST["current_wifi_ip"] != $temp_wifi_ip)
					{
						if(filter_var($temp_wifi_ip, FILTER_VALIDATE_IP) && $temp_wifi_ip != "0.0.0.0")
						{
							set_config_wifi("GATEWAY", $temp_wifi_ip);
							$wifi_changes++;
						}
						else
						{
							//wifi ip is invalid
							$err_type = 11;
							$wait_time = 1;
						}
					}
				}
				//continue check only if wpa key has been POST transmitted
				if(isset($_POST["wifi_wpa_key"]))
				{
				//check if WPA passphrase has been changed
					if($_POST["current_wifi_wpa_key"] != $_POST["wifi_wpa_key"])
					{
						if(strlen($_POST["wifi_wpa_key"]) > 7)
						{
							set_config_wifi("PASSPHRASE",$_POST["wifi_wpa_key"]);
							$wifi_changes++;
						}
						else
						{
							$err_type = strlen($_POST["wifi_wpa_key"]);
							$wait_time = 1;
						}
					}
				}
				if(isset($_POST["enable_automatic"]))
				{
					set_config("wifi_automatic", "true", $config_file);
				}
				else
				{
					set_config("wifi_automatic", "false", $config_file);
				}
				//apply wifi settings
				if($wifi_changes > 0)
				{
					shell_exec("sudo /pke_scripts/change_settings.sh wifi restart");
					$wait_time = 8;
				}
				
				//refresh config file
				opcache_invalidate('/var/www/config.php');
				$config = require('/var/www/config.php');
				if($previous_wifi_state != $config['wifi_on'])
				{
					pclose(popen("sudo /pke_scripts/change_settings.sh wifi on","r"));
					//longer wait_time is needed if wifi settings were changed -> network interface must be built
					$wait_time = 8;
				}
			}
			else
			{
				//update config wlan = OFF
				set_config("wifi_on", "false", $config_file);
				pclose(popen("sudo /pke_scripts/change_settings.sh wifi off","r"));
			}
			
			//Enable SMBD-Service
			if(isset($_POST['enable_smb']))
			{
				set_config("smb_on", "true", $config_file);
				shell_exec("sudo /pke_scripts/change_settings.sh enable_smb");
			}
			else //Disable SMBD-Service
			{
				set_config("smb_on", "false", $config_file);
				shell_exec("sudo /pke_scripts/change_settings.sh disable_smb");
			}

			//if changes were made, restart PCHK daemon to apply
			if(($advanced_settings_changes > 0) || ($user_changes > 0) || ($pchk_changes > 0))
			{
				$pchk_config->asXML('/var/lib/lcnpchk/lcnpchk.xml');
				shell_exec("sudo /pke_scripts/change_settings.sh lcnpchk_restart");
			}
		}
	}


?>