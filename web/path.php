<?php

$os = 'WINDOWS';

if ($os == 'WINDOWS') {
    return array(
        'parser' => 'python3 /Users/js/Desktop/Apache24/pchk/main.py',
        'parserConfig' => '/Users/js/Desktop/Apache24/pchk/config.txt',
        'parserError' => '/Users/js/Desktop/Apache24/pchk/error.txt',
        'uploadFile' => '/Users/js/Desktop/Apache24/pchk/upload_file.txt',
        'traumhausXml' => '/Users/js/Desktop/Apache24/pchk/traumhaus.xml',
        'traumhausSitemap' => '/Users/js/Desktop/Apache24/pchk/traumhaus.sitemap',
    );
} else if ($os == 'LINUX') {
    return array(
        'parser' => 'sudo python3 /pke_scripts/parser/main.py',
        'parserConfig' => '/pke_scripts/parser/config.txt',
        'parserError' => '/pke_scripts/parser/error.txt',
        'uploadFile' => '/var/www/html/VISU/upload_file.txt',
        'traumhausXml' => '/pke_scripts/parser//traumhaus.xml',
        'traumhausSitemap' => '/etc/openhab2/sitemaps/traumhaus.sitemap',
    );
} else {
    return array(
        'parser' => 'python3 ../../main.py',
        'parserConfig' => '../../config.txt',
        'parserError' => '../../error.txt',
        'uploadFile' => '../../upload_file.txt',
        'traumhausXml' => '../../traumhaus.xml',
    );
}



?>

