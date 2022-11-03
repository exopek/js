<?php
    session_start();

    //refresh config.php everytime page loads
    //opcache_invalidate('pchk/config.php');
    $config = include('C:/Users/js/Desktop/Apache24/pchk/config.php');
    $textcontent = include("C:/Users/js/Desktop/Apache24/pchk/language/".$config['language']);
    $pchk_config = simplexml_load_file("C:/Users/js/Desktop/Apache24/pchk/lcnpchk.xml");

    $option_array = "";
    $content_of_lang_dir = scandir("C:/Users/js/Desktop/Apache24/pchk/language");
    unset($content_of_lang_dir[0]);
    unset($content_of_lang_dir[1]);

    function set_config($setting, $replace, $target_file){
    //function to compare post sent setting ($setting) with available config file ($target_file) and replace it with post
    //value if different
        $current_file = file_get_contents($target_file);

        foreach (preg_split("/\n/", $current_file) as $str) {
            preg_match("^.*\'([A-z0-9]*)\'.*\'([A-z0-9.]*)\'^", $str, $regex);
            if (!empty($regex)) {
                if($regex[1] == $setting){
                    //replace current setting in THIS line, write to temporary variable
                    $str_temp = str_replace($regex[2], $replace, $str);
                    //replace THIS line in current file
                    $current_file = str_replace($str, $str_temp, $current_file);
                    //write whole file to target file
                    file_put_contents($target_file, $current_file);
                }
            }
        }
        return $replace;
    }

    foreach($content_of_lang_dir as $file){
        $option_array .= "<option value=\"".$file."\"".($file == $config['language'] ? " selected " : "" ).">".substr(explode("_",$file)[1],0,strpos(explode("_",$file)[1],"."))."</option>"."\n";
    }



    $return["error"] = false;
    $return["success"] = false;
    $return["message"] = "";
    $return["session"] = $_SESSION;
    $return["request method"] = $_SERVER['REQUEST_METHOD'];
    $return["user"] = $_POST['user'];
    $return["pass"] = $_POST['pass'];
    //$return["lang select"] = $_POST['lang_select'];


    //echo "<script>console.log($_SESSION['logged_in']);</script>";




    if (!isset($_SESSION['logged_in']))
    {
        if ($_SERVER['REQUEST_METHOD'] == 'POST' && !isset($_POST['lang_select']))
        {
            if (empty($_POST['user']) || empty($_POST['pass']))
            {
                //echo $main_page;
                //echo "<script type='text/javascript'>activateStatusBox(\"".$textcontent['login_err_empty_fields']."\");</script>";
                $return["message"] = $textcontent['login_err_empty_fields'];
                $return["error"] = true;
            }
            elseif ((explode(":",$pchk_config->Communication->User)[0] != $_POST['user']) || (explode(":",$pchk_config->Communication->User)[1] != hash("md5",$_POST['pass'])))
            {
                //echo $main_page;
                //echo "<script type='text/javascript'>activateStatusBox(\"".$textcontent['login_err_credentials_invalid']."\");</script>";
                $return["message"] = $textcontent['login_err_credentials_invalid'];
                $return["error"] = true;
            }
            elseif ((explode(":",$pchk_config->Communication->User)[0] == $_POST['user']) && (explode(":",$pchk_config->Communication->User)[1] == hash("md5",$_POST['pass'])))
            {
                $_SESSION['logged_in'] = true;
                $temp = $_POST['user']."/".$_POST['pass'];
                file_put_contents("C:/Users/js/Desktop/Apache24/pchk/pass.txt",$temp);
                $return["success"] = true;
            }
            else
            {
                //echo $main_page;
                //echo "<script type='text/javascript'>activateStatusBox(\"".$textcontent['login_err_unknown']."\");</script>";
                $return["message"] = $textcontent['login_err_unknown'];
                $return["error"] = true;
            }
        }
        else if(isset($_POST['lang_select']) && $_POST['lang_select'] != $config['language'])
        {
            //language has been changed
            //set_config("language",$_POST['lang_select'],"../config.php");
            $return["message"] = "language has been changed";
            set_config("language",$_POST['lang_select'],"C:/Users/js/Desktop/Apache24/pchk/config.php");
            //header('Location: '.$_SERVER['REQUEST_URI']);
        }
        else
        {
            //exit($main_page);
            $return["message"] = "Something went wrong!";
            $return["error"] = true;
        }
    }

    //Hier wird alles an die UI übergeben
    header('Content-Type: application/json');
    echo json_encode($return);

?>
