<?php
//this file returns translations

return array(
//security.php
	'login_username' => 'Benutzername',
	'login_password' => 'Passwort',
	'login_btn_login' => 'Einloggen',
	'login_err_empty_fields' => 'Bitte alle Felder füllen',
	'login_err_credentials_invalid' => 'Daten ungültig',
	'login_err_unknown' => 'Entschuldigung, etwas ging schief',
//index.php
	'index_err_1' => 'Bitte Passwort-Wiederholung eingeben',
	'index_err_2' => 'Passwort und Wiederholung stimmen nicht überein',
	'index_err_3' => 'Datei f&uuml;r Firmware-Aktualisierung ung&uuml;ltig',
	'index_err_4' => 'Neues Passwort nicht gesetzt. Bitte Feld für aktuelles Passwort löschen, falls keine Änderung gewünscht!',
	'index_err_5' => 'Das eingegebenes Datum ist ungültig',
	'index_err_6' => 'Die eingegebene Zeit ist ungültig',
	'index_err_7' => 'Die eingegebene IP-Adresse ist ungültig',
	'index_err_8' => 'Die eingegebene Subnetz-Maske ist ungültig',
	'index_err_9' => 'Das eigegebene Gateway ist ungültig',
	'index_err_10' => 'Der eigegebene DNS-Server ist ungültig',
	'index_err_11' => 'Die eingegebene WLAN-IP-Adresse ist ungültig',
	'index_err_12' => 'Kein NTP-Server eingegeben',
	'index_err_13' => 'Der eingegebene WLAN-WPA-Schlüssel ist ungültig',
	'index_err_14' => 'Bei der Update-Verarbeitung trat ein Fehler auf. Versuchen Sie es erneut.',
	'index_err_15' => 'Die von Ihnen gew&auml;hlte Update-Datei hat eine &auml;ltere Version, als die momentan installierte.',
	//index_err_16 is reserved for committing restart
	'index_err_17' => 'Die eingegebene PCHK Modul-ID ist ung&uuml;ltig',
	'index_err_18' => 'Das angegebene PCHK-Timeout ist ung&uuml;ltig',
	'index_err_19' => 'Fehler bei Upgrade-Key Eingabe!',
	'index_err_20' => 'Die installierte Version ist mit diesem Update nicht kompatibel',
	'index_err_21' => 'Das alte Passwort für die Passwort-Änderung war nicht korrekt',
	'index_err_default' => 'Ein unerwarteter Fehler ist aufgetreten, welcher bisher nicht definiert wurde!',

	'index_q_reboot' => 'Wollen Sie den LCN-VISU wirklich neu starten?\nEin Neustart benötigt etwa drei Minuten.\nDie Kommunikation mit dem LCN-Bus wird in dieser Zeit unterbrochen.',
	
	'index_h1_configuration_page' => 'PCHK-Dienst Konfiguration',
	'index_h2_user_settings' => 'Benutzereinstellungen',
	'index_username' => 'Benutzername:',
	'index_old_password' => 'Altes Passwort:',
	'index_new_password' => 'Neues Passwort:',
	'index_repeat_password' => 'Wiederholung:',
	'index_info_username' => 'Die hier zu w&auml;hlenden Zugangsdaten gelten gleichermaßen f&uuml;r den Zugang zur Weboberfl&auml;che und zum Login zum PCHK-Dienst',
	'index_show_password' => 'Passwort anzeigen',
	
	'index_h2_localization_settings' => 'Landesspezifische Einstellungen',
	'index_current_time' => 'Aktuelle Zeit:',
	'index_select_tz' => 'Zeitzone:',
	'index_edit_date' => 'Datumseinstellung:',
	'index_edit_time' => 'Zeiteinstellung:',
	'index_enable_rtc_sync' => 'LCN Bus Zeitsynchronisation',
	'index_get_time_from_ntp' => 'hole Zeit von NTP-Server',
	'index_ntp_server' => 'NTP Zeitserver:',
	'index_btn_fetch_time' => 'Zeit holen',
	
	'index_h2_advanced_settings' => 'Erweiterte Einstellungen',
	'index_pchk_timeout' => 'PCHK Timeout:',
	'index_pchk_timeout_h' => 'Std.',
	'index_pchk_timeout_m' => 'Min.',
	'index_pchk_modid' => 'PCHK Modul-ID:',
	'index_info_pchk_timeout' => 'TCP-Timeout bei inaktiver Verbindung. Standard: 30 Min., max.: 48 Std., Deaktiviert: 0 (nicht empfohlen!)',
	'index_info_pchk_modid' => 'Standard: 4, G&uuml;ltige IDs: 1,2,4-254',
	
	'index_h2_network_settings' => 'Netzwerkeinstellungen',
	'index_eth_pke_mode' => 'Modus:',
	'index_eth_interface_name' => 'Schnittstellenname:',
	'index_eth_interface_state' => 'Status:',
	'index_eth_interface_state_up' => 'Aktiv',
	'index_eth_interface_state_down' => 'Inaktiv',
	'index_enable_dhcp' => 'Aktiviere DHCP:',
	'index_eth_ip_address' => 'IP Addresse:',
	'index_info_ipchange' => 'Bei Änderung der IP-Adresse kann es bis zu 10 Minuten dauern bis der Hostname auf die neue IP-Adresse zeigt.',
	'index_eth_subnet_mask' => 'Subnetzmaske:',
	'index_eth_gateway' => 'Router:',
	'index_eth_dns' => 'DNS-Server:',
	'index_info_hostname' => 'Der hier eingegebene Name wird (wenn vorhanden) dem lokalen DNS-Server (z.B. Fritz!Box) gemeldet. Sie k&ouml;nnen den Aufruf der Weboberfl&auml;che und die Verbindung zur LCN-PRO-Software durch Eingabe dieses Namens anstelle der IP-Adresse durchf&uuml;hren. Dieser Name entspricht zugleich dem WLAN-Hotspot. Der Hostname ist auf 15 Zeichen begrenzt. Neustart erforderlich!',
	'index_eth_hostname' => 'Hostname: ',
	
	'index_h2_license_settings' => 'Lizenzeinstellungen',
	'index_lic_licensee' => 'Lizenznehmer: ',
	'index_lic_pke_default' => 'PKE-Lizenz',
	'index_lic_total_conn' => 'Verbindungen: ',
	'index_lic_add' => 'Upgrade-Key eingeben',
	'index_lic_input_licensee' => 'Lizenznehmer: ',
	'index_lic_input_key' => 'Key: ',
	'index_lic_btn_add' => 'Key hinzuf&uuml;gen',

	'index_h2_maintenance_settings' => 'Wartungseinstellungen',
	'index_actual_temperature' => 'VISU-Temperatur: ',
	'index_actual_speed' => 'CPU Geschwindigkeit: ',
	'index_lcn_conn_stat' => 'Status LCN Verbindung: ',
	'index_maintenance_bus_monitor' => 'Busaufzeichnung: ',
	'index_maintenance_bus_mon_stopped' => 'gestoppt',
	'index_maintenance_bus_mon_started' => 'gestartet ',
	'index_maintenance_bus_mon_at' => 'am ',
	'index_maintenance_start_mon' => 'Start',
	'index_maintenance_stop_mon' => 'Stop',
	'index_enable_maintenance_wifi' => 'Aktiviere WLAN-Hotspot:',
	'index_enable_wifi_automatic' => 'Aktiviere automatische Abschaltung:',
	'index_h2_wifi_settings' => 'WLAN-Einstellungen',
	'index_wifi_wpa_passphrase' => 'WPA2-Schlüssel:',
	'index_info_wpa_key' => 'W&auml;hlen Sie ein Passwort zwischen 8 und 20 Zeichen',
	'index_enable_smb' => 'Aktiviere SMB-Dienst:',

	'index_h2_update' => 'Firmware-Aktualisierung',
	'index_btn_upload_file' => 'hochladen und ausf&uuml;hren',
	'index_btn_upload_wait' => 'bitte warten...',
	
	'index_btn_save_settings' => 'Einstellungen speichern',
	'index_btn_reboot' => 'LCN-VISU neustarten',
	'index_btn_logout' => 'Ausloggen',
	'index_btn_back' => 'Zurück',

//action.php
	'action_device_reboot' => 'Gerät startet neu, bitte warten...',
	'action_settings_applied' => 'Änderungen werden übernommen, bitte warten...',
	'action_update_processed' => 'Update wird durchgef&uuml;hrt...<br />Bitte schalten Sie das Gerät nicht ab!',
	'action_set_dhcp_warn' => 'Hinweis: IP-Konfiguration wurde auf DHCP ge&auml;ndert!<br /><br />Um die Konfigurationsseite erneut zu &ouml;ffnen nutzen Sie bitte die WLAN-Verbindung des LCN-VISU<br />oder Ihren lokalen DHCP-Server (z.B. Fritz!Box) um die neuen IP-Adressinformationen zu erhalten.',
	'action_updt_finished' => 'Updatevorgang beendet',
	'action_updt_altern_back' => 'Sollte die automatische Weiterleitung nicht funktionieren bitte',
	'action_updt_altern_back_click' => 'hier klicken',
	'action_updt_reboot' => 'Updatevorgang beendet, starte neu...',
	'action_download_started' => 'Daten der Busaufzeichnung werden zum Download vorbereitet...',
	'action_get_back_after_dld' => 'Sollte der Download nicht starten klicken Sie <a href="download.php">hier</a><br />Klicken Sie nach dem Download <br /><a href="index.php">hier</a>, um zur&uuml;ck zu gelangen',

//first_assist.php
	'first_assist_h2_header' => 'Assistent zur Ersteinrichtung',
	'first_assist_introduction' => 'Um Ihnen den Einstieg mit dem LCN-VISU zu erleichern<br />wählen Sie bitte aus folgenden Optionen das für Sie zutreffendste aus:',
	'first_assist_pke_mode_private' => 'Privates Netzwerk',
	'first_assist_default_setting' => '<b>(Standardeinstellung)</b>',
	'first_assist_pke_mode_private_desc' => 'Sie nutzen den LCN-VISU haupts&auml;chlich in einem privaten Netzwerkumfeld (z.B. Zuhause),<br />in dem der Zugriff durch Dritte unkritisch ist. In diesem Fall bleibt ihnen der einfache<br />Zugriff mittels HTTP und Hostname erhalten.',
	'first_assist_pke_mode_public' => 'Firmen- oder &ouml;ffentliches Netzwerk',
	'first_assist_pke_mode_public_desc' => 'Sie nutzen den LCN-VISU innerhalb eines &ouml;ffentlichen- oder Firmennetzes, in dem der Zugriff<br />durch Dritte nicht ausgeschlossen werden kann. Der Zugriff per HTTP sowie einige<br/>Portfreigaben werden in diesem Fall deaktiviert. Dies hat u. U. Folgen f&uuml;r die Erreichbarkeit<br />per Eingabe des Hostnamens.',
	'first_assist_pke_mode_public_notify' => '<b>Achtung!</b> Nach dem Speichern dieser Einstellung wird diese Seite unerreichbar.<br /> Bitte verbinden Sie sich manuell per HTTPS neu.',
	'first_assist_btn_finish' => 'Speichern',

//logout.php
	'logout_credentials_changed' => 'Benutzereinstellungen wurden übernommen. <br /> Sie wurden ausgeloggt. Nutzen Sie ihre neuen Zugangsdaten und loggen Sie sich erneut ein.',
	'logout_logout_success' => 'Logout erfolgreich. <br /> Schließen Sie das Browserfenster, um ihre Daten zu schützen.',

//VISU_pagename.php
	'VISU_sitemap_label' => 'Der Text wird in der Sitemap angezeigt',
	'VISU_sitemap_name' => 'Der Text muss bei der Erstellung des Items in OpenHab angegeben werden.',
	'VISU_mobile_information_header'=> 'Information für die App ',
	'VISU_mobile_information_1'=> 'Für die mobile Benutzung muss sich bei <span style="color:white;"></span><i>myopenhab</i></span> registrieren.',
	'VISU_mobile_information_2'=> 'Dazu benötigen Sie die <span style="color:#16e900;">UUID</span> und das "interne Passwort" <span style="color:red;">Secret</span>. Diese finden Sie hier:',
	'VISU_mobile_login'=> 'Hier geht es zur Anmeldung:',
	'VISU_mobile_register'=> 'Registrierung',
	'VISU_mobile_manual'=> 'Und so klappt es beim Handy:',
	'VISU_mobile_manual_first_step'=> '>Laden Sie die App herunter und öffnen Sie diese',
	'VISU_mobile_manual_second_step'=> 'Gehen Sie zu den Einstellungen',
	'VISU_mobile_manual_third_step'=> 'Klicken Sie auf Server openhab',
	'VISU_mobile_manual_fourth_step'=> 'Klicken sie auf Fernzugriff',
	'VISU_mobile_manual_fifth_step'=> 'Tragen Sie ihre Daten ein:',
	'VISU_mobile_manual_fifth_step_user'=> 'Name ihres User bei myOpenHab',
	'VISU_mobile_manual_fifth_step_password'=> 'Passwort des Accounts bei myOpenHab',
	'VISU_info_manual_first' => '1. Für <b>alle Ansichten</b> die Gebäudedatei (xml) hochladen:',
	'VISU_info_manual_config' => 'Konfiguration',
	'VISU_info_manual_second' => '2. Für die <b>Kachel-Ansicht</b>:',
	'VISU_info_manual_kachel' => 'Für die <b>Kachelansicht</b> muss zusätzlich die Konfigurationsdatei eingefügt werden. <br> Gehen Sie dazu auf die Konfigurationsseite der Kachelansicht und klicken Sie dort in das Textfeld. <br>	Danach benutzen Sie &lt; Strg &gt - A und &lt; Strg &gt - V , um die Konfiguration einzufügen. Zum Schluss speichern.',
	'VISU_info_manual_copy_tipp' => 'Die Visualisierung wird beim Klicken auf dem Link in ihre Zwischenablage geladen.',
	'VISU_info_manual_more_pc' => 'Falls Sie mit mehreren Rechnern auf die Kachelansicht zugreifen möchten,<br> muss die eben lokal gespeicherte Konfigurationsdatei als Panel-Konfiguration gespeichert werden. <br> Gehen Sie dazu zur Einstellung der Kachelansicht und speichern die aktuelle Konfiguration in eine neuen Panel-Konfiguration.<br>Diese können Sie dann von beliebigen Rechnern aufrufen.',
	'VISU_info_manual_setting' => 'Einstellung',
	'VISU_visu_liste' => 'Listenansicht',
	'VISU_visu_kachel' => 'Kachelansicht',
	'VISU_index_pchk' => 'PCHK konfigurieren',
	'VISU_index_mobile' => 'Mobile Benutzung einrichten',
	'VISU_index_views' => 'Ansichten erstellen',
	'VISU_index_list_edit' => 'Listenansicht bearbeiten',
	'VISU_parserinfo_success' => ' Ihr Projekt wurde erfolgreich bearbeitet! <br>	Damit die Visualisierung die Projektdatei übernehmen kann, muss die VISU neugestartet werden.',
	'VISU_parserinfo_info' => 'Information zum Einleseprozess:',
	'VISU_parserinfo_module' => 'Module',
	'VISU_parserinfo_room' => 'Räume',
	'VISU_parserinfo_switchable_item' => 'Schaltbare Elemente',
	'VISU_parserinfo_reboot' => 'Daten übernehmen und Neustart',
	'VISU_reboot_info' => 'Die VISU wird neugestartet. Der Neustart kann bis zu 3 Minuten dauern. Sie werden automatisch auf die Menü-Seite weitergeleitet.',
	'VISU_reboot_step' => 'Die Listenansicht wurde erstellt. Nachdem Neustart können Sie entweder die Kachelansicht erstellen oder zur Visualisierung gehen.',
	'VISU_upload_info' => ' wurde erfolgreich hochgeladen. Ihre Projektdatei wird nun bearbeitet. Dies kann bis zu einer halben Minute dauern.',
	'VISU_upload_error' => 'Es ist ein Fehler beim Hochladen aufgetreten',
	'VISU_sitemap_header' => 'Listenansicht bearbeiten',
	'VISU_sitemap_room' => 'Räume',
	'VISU_sitemap_items' => 'Elemente',
	'VISU_sitemap_menue' => 'Menü',
	'VISU_sitemap_items_add' => 'Element hinzufügen',
	'VISU_sitemap_save_all' => 'Alles speichern',
	'VISU_sitemap_item_change' => 'Item ändern',
	'VISU_sitemap_label_select' => 'Wähle ein Label:',
	'VISU_sitemap_icon_select' => 'Wähle ein Icon',
	'VISU_sitemap_humidity' => 'Feuchtigkeit',
	'VISU_sitemap_rollershutter' => 'Jalousie',
	'VISU_sitemap_apply' => 'Änderung bestätigen',
	'VISU_sitemap_close' => 'Schließen',
	'VISU_sitemap_room_change' => 'Raum ändern',
	'VISU_sitemap_name_select' => 'Wähle ein Name:',
	'VISU_sitemap_saved' => 'Gespeichert!',
	'VISU_sitemap_kidsroom' => 'Kinderzimmer',
	'VISU_sitemap_kitchen' => 'Küche',
	'VISU_sitemap_bath' => 'Badezimmer',
	'VISU_sitemap_toilet' => 'Toilette',
	'VISU_sitemap_floor' => 'Flur',
	'VISU_sitemap_sofa' => 'Wohnzimmer',
	'VISU_sitemap_changing' => 'Ankleidezimmer',
	'VISU_sitemap_dining' => 'Esszimmer',
	'VISU_sitemap_bed' => 'Schlafzimmer',
	'VISU_sitemap_pantry' => 'Hauswirtschaftsraum',
	'VISU_sitemap_office' => 'Arbeitszimmer',
	'VISU_sitemap_party' => 'Partyraum',
	'VISU_sitemap_suitcase' => 'Gästezimmer',
	'VISU_sitemap_vk' => 'Verteilung',
	'VISU_sitemap_light' => 'Licht',
	'VISU_sitemap_motion' => 'Bewegung',
	'VISU_sitemap_regler' => 'Regler',
	'VISU_sitemap_switch' => 'Schalter',
	'VISU_sitemap_relay' => 'Relais',
	'VISU_sitemap_temperature' => 'Temperatur',
	'first_index_views' => 'Ansichten',
	'first_index_install' => 'Einrichtung',
	'VISU_extern_first_header' => '1. Einbinden der externen Geräte',
	'VISU_extern_second_header' => '2. Erstellen von Elemente für externes Gerät',
	'VISU_extern_third_header' => '3. Erstellen von Elemente in der Listenansicht',
	'VISU_extern_forth_header' => '4. Steuern von extern Geräten mittels GT-Taster',
	'VISU_extern_first' => 'Die externen Geräte von Sonos oder Philips Hue müssen mit dem lokalen Netzwerk verbunden sein.<br>	Damit diese der Visualisierung bekannt wird, müssen sie hinzugefügt werden. <br> Gehen Sie dafür auf die Suchseite und fügen Sie durch Klicken auf ihr Gerät dies hinzu.<br><br> Bei der Philips Hue Bridge müssen Sie nachdem hinzufügen, den mittleren Knopf der Bridge drücken, damit der Benutzername der Visualisierung bekannt gemacht wird. Danach muss obiger Schritt wiederholt werden. ',
	'VISU_extern_second' => 'Um die hinzugefügten Geräte zu steuern, müssen Elemente erstellt werden. <br>	Gehen Sie dafür auf die Geräteliste, wählen Sie ihr externes Gerät aus und klicken Sie auf den Button neben der Eigenschaft, die Sie steuern wollen.<br>	Erstellen Sie durch Auswählen von "Create new Item" bei "Please select the item to link" ein neues Element. <br>	Beim Erstellen des Elementes kopieren Sie sich den Namen oder benennen Sie ihn um, dieser wird in Schritt 3 noch benötigt.',
	'VISU_extern_third' => 'Um die neuen Elemente auch in der Listenansicht steuern zu können, müssen diese unter "Listenansicht bearbeiten" hinzugefügt werden. <br>	Gehen Sie auf ihren Raum, in dem sich das externe Gerät befindet bzw. in dem Sie es steuern wollen und klicken Sie auf "Elemente hinzufügen". <br>	In dem neuem Fenster müssen Sie den im Schritt 2 generierten Namen einfügen, sowie ein Label einfügen.<br> Das Label ist die Bezeichnung, die in der Listenansicht zu sehen ist. ',
	'VISU_extern_forth_first' => 'Um externe Geräte durch Drücken von LCN-Tasten zu ermöglichen, muss die besagte Taste in der LCN-Pro programmiert werden. Sie müssen das Kommando "Sende Taste" an Modul 4 senden.<br>	Weitere Erläuterung entnehmen Sie bitte folgender Dokumentation: <a class="link" href="https://www.openhab.org/addons/bindings/lcn/#command-from-an-lcn-module-to-openhab" target="_blank"> Doku </a><br><br>	Damit die Visualisierung auf das Kommando reagiert, muss eine sogenannte Regel erstellt werden.<br> Diese folgt den Schema "Wenn das passiert, mach dies" und kann hier eingestellt werden:',
	'VISU_extern_forth_second' => 'Bei "When" wählen Sie zuerst "trigger channel fires" aus, danach wählen Sie unter Channel ihr Modul mit der Endung "hostcommand#sendKeys" aus und bei Event wählen Sie Tabelle(A,B,C)Taste(1-8):Tastendruck(HIT,MAKE,BREAK) zb.: A1:HIT <br>	Bei "then" wählen Sie zuerst "send a command" aus, danach wählen Sie unter Item das Element was sie Steuern möchten, bei Command könne Sie je nach Element ein Kommando hinzufügen oder aus der Liste auswählen.<br>	Im folgenden Dokument sind verfügbare Kommandos zu den jeweiligen Elementtyp zu finden: ',
	'VISU_extern_first_button' => 'Suchen',
	'VISU_extern_second_button' => 'Geräteliste',
	'VISU_extern_third_button' => 'Listenansicht bearbeiten',
	'VISU_extern_forth_button' => 'Regel erstellen',
	'VISU_backup_load' => 'Die Backupdatei wird hochgeladen',

);

?>
