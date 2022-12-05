import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:isar/isar.dart';
import 'package:visu/CustomWidgets/header.dart';
import 'package:visu/Models/models.dart';
import 'package:visu/Services/pchk_service.dart';

class PchkConfig extends StatefulWidget {
  const PchkConfig({Key? key}) : super(key: key);

  @override
  State<PchkConfig> createState() => _PchkConfigState();
}

class _PchkConfigState extends State<PchkConfig> {
  late Pchkconfig pchkConfig;

  TextEditingController _userNameController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  TextEditingController _newPasswordCheckController = TextEditingController();
  TextEditingController _ip1Controller = TextEditingController();
  TextEditingController _ip2Controller = TextEditingController();
  TextEditingController _ip3Controller = TextEditingController();
  TextEditingController _ip4Controller = TextEditingController();
  TextEditingController _subnet1Controller = TextEditingController();
  TextEditingController _subnet2Controller = TextEditingController();
  TextEditingController _subnet3Controller = TextEditingController();
  TextEditingController _subnet4Controller = TextEditingController();
  TextEditingController _gateway1Controller = TextEditingController();
  TextEditingController _gateway2Controller = TextEditingController();
  TextEditingController _gateway3Controller = TextEditingController();
  TextEditingController _gateway4Controller = TextEditingController();
  TextEditingController _dns1Controller = TextEditingController();
  TextEditingController _dns2Controller = TextEditingController();
  TextEditingController _dns3Controller = TextEditingController();
  TextEditingController _dns4Controller = TextEditingController();
  TextEditingController _hostnameController = TextEditingController();
  TextEditingController _licenceController = TextEditingController();
  TextEditingController _licenceKeyController = TextEditingController();
  TextEditingController _pchkTimeoutStdController = TextEditingController();
  TextEditingController _pchkTimeoutMinController = TextEditingController();
  TextEditingController _pchkModIdController = TextEditingController();
  TextEditingController _ntpController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  Pchkconfig dummyPchkConfig = Pchkconfig(
      status: true,
      message: 'message',
      version: 'version',
      wifi_status: 'wifi_status',
      wifi_automatic: 'wifi_automatic',
      pchk_version: '3.04',
      pchk_host_id: '4',
      pchk_timeout_std: 0,
      pchk_timeout_min: 30,
      interface_state: 'UP',
      interface_ip: ['0', '0', '0', '0'],
      interface_subnet: ['0', '0', '0', '0'],
      interface_gateway: ['0', '0', '0', '0'],
      interface_dns: ['0', '0', '0', '0'],
      host_name: 'LCN-VISU',
      user_name: 'Test User',
      syncTime: 'SyncNtpTime',
      syncTimeLink: 'org.lcnvisu.syncTime',
      pke_mode: 'pke_mode_private',
      dhcp_status: 'true',
      timezones: {
        'Europe': {
          'Europe\/Berlin': 'Berlin',
          'Europe\/Paris': 'Paris',
          'Europe\/London': 'London'
        },
        'Afrika': {
          'Africa\/Abidjan': 'Abidjan',
          'Africa\/Accra': 'Accra',
          'Africa\/Addis_Ababa': 'Addis Ababa'
        },
      },
      current_timezone: 'Europe',
      current_region: 'Berlin',
      licence: 'PKE-Lizenz',
      licence_count: 3,
      active_wlan_hotspot: false,
      pchk_password: 'lcn');

  Future<PlatformFile> pickfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['xml'],
    );

    if (result != null) {
      PlatformFile file = result.files.first;
      return file;
    } else {
      throw Exception('No file selected.');
      // User canceled the picker
    }
  }

  @override
  void initState() {
    /*
    PchkServices().getPchkConfig().then((value) {
      setState(() {
        pchkConfig = value;
      });
    });
    */

    pchkConfig = dummyPchkConfig;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const Header(),
              const SizedBox(height: 16.0),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Container(
                  color: Theme.of(context).primaryColor,
                  child: Column(
                    children: [
                      _header(context, 'Benutzereinstellungen'),
                      Center(
                        child: Container(
                            //color: Colors.amberAccent,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Padding(
                                padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.1,
                                  right:
                                      MediaQuery.of(context).size.width * 0.08,
                                  top: 10.0,
                                ),
                                child: _userSettings(context))),
                      ),
                      _header(context, 'Landesspezifische Einstellungen'),

                      Center(
                        child: Text('Aktuelle Zeit:',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0)),
                      ),
                      // Hier muss noch die aktuelle Zeit angezeigt werden
                      Center(
                        child: Container(
                            //color: Colors.amberAccent,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Padding(
                                padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width * 0.1,
                                  right:
                                      MediaQuery.of(context).size.width * 0.08,
                                  top: 10.0,
                                ),
                                child: _timeSettings(context))),
                      ),
                      _header(context, 'Erweiterte Einstellungen'),
                      /*
                      Center(
                        child: Container(
                            //color: Colors.amberAccent,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.1,
                                right: MediaQuery.of(context).size.width * 0.08,
                                top: 10.0,
                              ),
                              child: _advancedSettings(context),
                            )),
                      ),
                      
                      _header(context, 'Netzwerkeinstellungen'),
                      Center(
                        child: Container(
                            //color: Colors.amberAccent,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.1,
                                right: MediaQuery.of(context).size.width * 0.08,
                                top: 10.0,
                              ),
                              child: _networkSettings(context),
                            )),
                      ),
                      _header(context, 'Lizenzeinstellungen'),
                      Center(
                        child: Container(
                            //color: Colors.amberAccent,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.1,
                                right: MediaQuery.of(context).size.width * 0.08,
                                top: 10.0,
                              ),
                              child: _licenceSettingsFix(context),
                            )),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Center(
                        child: Text('Upgrade-Key eingeben',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0)),
                      ),
                       Center(
                        child: Container(
                            //color: Colors.amberAccent,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.1,
                                right: MediaQuery.of(context).size.width * 0.08,
                                top: 10.0,
                              ),
                              child: _licenceSettingsChange(context),
                            )),
                      ),
                      _header(context, 'Wartungseinstellungen'),
                      Center(
                        child: Container(
                            //color: Colors.amberAccent,
                            width: MediaQuery.of(context).size.width * 0.5,
                            child: Padding(
                              padding: EdgeInsets.only(
                                left: MediaQuery.of(context).size.width * 0.1,
                                right: MediaQuery.of(context).size.width * 0.08,
                                top: 10.0,
                              ),
                              child: _maintenanceSettings(context),
                            )),
                      ),
                      _header(context, 'WLAN-Einstellungen'),
                      _header(context, 'Firmware-Aktualisierung'),*/
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _maintenanceSettings(context) {
    return Column(
      children: [
        _textSettings(
            context, 'Status LCN Verbindung', 'Online', Colors.greenAccent),
        _checkBoxSettings(context, 'Aktiviere WLAN-Hotspot',
            pchkConfig.active_wlan_hotspot, 'wlan_hotspot'),
      ],
    );
  }

  Widget _licenceSettingsChange(context) {
    return Column(
      children: [
        _textFieldSettings(
            context, 'Lizenznehmer:', '', 0.08, _licenceController, null),
        _textFieldSettings(
            context, 'Key:', '', 0.08, _licenceKeyController, null)
      ],
    );
  }

  Widget _licenceSettingsFix(context) {
    return Column(
      children: [
        _textSettings(
            context, 'Lizenznehmer:', pchkConfig.licence, Colors.white),
        _textSettings(context, 'Verbindungen:',
            pchkConfig.licence_count.toString(), Colors.white),
      ],
    );
  }

  Widget _networkSettings(context) {
    return Column(
      children: [
        // Modus
        _textSettings(
            context,
            'Modus:',
            pchkConfig.pke_mode == 'pke_mode_private'
                ? 'Privates Netzwerk'
                : 'Geschäftlich',
            Colors
                .white), // Text muss für verschiedene Sprachen angepasst werden
        // Schnittstelle
        _textSettings(context, 'Schnittstellenname:', 'eth0', Colors.white),
        // Status
        _textSettings(
            context,
            'Status:',
            pchkConfig.interface_state == 'UP' ? 'Aktiv' : 'Inaktiv',
            pchkConfig.interface_state == 'UP'
                ? Colors.greenAccent
                : Colors
                    .redAccent), // Text muss für verschiedene Sprachen angepasst werden
        // DHCP
        _checkBoxSettings(context, 'Aktiviere DHCP:',
            pchkConfig.dhcp_status == 'true' ? true : false, 'dhcp_status'),
        // IP-Adresse
        _adressSettings(context, 'IP-Addresse:', [
          _textField(
              context, pchkConfig.interface_ip[0], 0.03, _ip1Controller, null),
          _textField(
              context, pchkConfig.interface_ip[1], 0.03, _ip2Controller, null),
          _textField(
              context, pchkConfig.interface_ip[2], 0.03, _ip3Controller, null),
          _textField(
              context, pchkConfig.interface_ip[3], 0.03, _ip4Controller, null)
        ]),
        // Subnetzmaske
        _adressSettings(context, 'Subnetzmaske:', [
          _textField(context, pchkConfig.interface_subnet[0], 0.03,
              _subnet1Controller, null),
          _textField(context, pchkConfig.interface_subnet[1], 0.03,
              _subnet2Controller, null),
          _textField(context, pchkConfig.interface_subnet[2], 0.03,
              _subnet3Controller, null),
          _textField(context, pchkConfig.interface_subnet[3], 0.03,
              _subnet4Controller, null)
        ]),
        // Gateway
        _adressSettings(context, 'Router:', [
          _textField(context, pchkConfig.interface_gateway[0], 0.03,
              _gateway1Controller, null),
          _textField(context, pchkConfig.interface_gateway[1], 0.03,
              _gateway2Controller, null),
          _textField(context, pchkConfig.interface_gateway[2], 0.03,
              _gateway3Controller, null),
          _textField(context, pchkConfig.interface_gateway[3], 0.03,
              _gateway4Controller, null)
        ]),
        // DNS
        _adressSettings(context, 'DNS-Server:', [
          _textField(context, pchkConfig.interface_dns[0], 0.03,
              _dns1Controller, null),
          _textField(context, pchkConfig.interface_dns[1], 0.03,
              _dns2Controller, null),
          _textField(context, pchkConfig.interface_dns[2], 0.03,
              _dns3Controller, null),
          _textField(
              context, pchkConfig.interface_dns[3], 0.03, _dns4Controller, null)
        ]),
        // Hostname
        _textFieldSettings(context, 'Hostname:', pchkConfig.host_name, 0.1,
            _hostnameController, null),
      ],
    );
  }

  Widget _header(context, String text) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0, bottom: 20.0),
      child: Center(
        child: Text(text,
            style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _checkBoxSettings(context, String text, bool status, String variable) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
            child: Text(text,
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ),
        ),
        Checkbox(
            value: status,
            hoverColor: Colors.transparent,
            onChanged: (value) {
              setState(() {
                switch (variable) {
                  case 'dhcp_status':
                    setState(() {
                      pchkConfig.dhcp_status = value.toString();
                    });
                    break;
                  case 'wlan_hotspot':
                    setState(() {
                      pchkConfig.active_wlan_hotspot = value!;
                    });
                    break;
                  case 'bus_synchro':
                    setState(() {
                      //pchkConfig. = value!;
                    });
                    break;
                  case 'ntp-server':
                    setState(() {
                      //pchkConfig. = value!;
                    });
                    break;
                }
                //this.status = value;
              });
            })
      ],
    );
  }

  Widget _textSettings(context, String text, String value, Color color) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
            child: Text(text,
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ),
        ),
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.1,
          child: Text(value, style: TextStyle(color: color, fontSize: 18.0)),
        ),
      ],
    );
  }

  Widget _textFieldSettings(context, String text, String hintText,
      float boxWidth, TextEditingController controller, String? ending) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
            child: Text(text,
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ),
        ),
        _textField(context, hintText, boxWidth, controller, ending)
      ],
    );
  }

  Widget _adressSettings(context, String text, List<Widget> children) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.1,
            child: Text(text,
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ),
        ),
        children[0],
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.01,
            child: Text('.',
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ),
        ),
        children[1],
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.01,
            child: Text('.',
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ),
        ),
        children[2],
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5.0),
          child: SizedBox(
            width: MediaQuery.of(context).size.width * 0.01,
            child: Text('.',
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ),
        ),
        children[3],
      ],
    );
  }

  Widget _textField(BuildContext context, String hintText, float boxWidth,
      TextEditingController controller, String? ending) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * boxWidth,
      child: //Row(
          //children: [
          TextField(
        controller: controller,
        style: TextStyle(color: Colors.white, fontSize: 16.0),
        decoration: InputDecoration(
            isDense: true,
            contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
            hoverColor: Theme.of(context).primaryColor,
            filled: true,
            fillColor: Colors.black12,
            border: InputBorder.none,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.white, fontSize: 16.0)),
      ),
      /*Padding(
            padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
              child: Text(ending ?? '',
                  style: TextStyle(color: Colors.white, fontSize: 18.0)),
            ),
          ),*/
      // ],
    );
  }

  Widget _advancedSettings(context) {
    return Column(
      children: [
        Row(
          children: [
            _textFieldSettings(
                context,
                'PCHK Timeout',
                pchkConfig.pchk_timeout_std.toString(),
                0.1,
                _pchkTimeoutStdController,
                'Std.'),
            _textField(context, pchkConfig.pchk_timeout_min.toString(), 0.1,
                _pchkTimeoutMinController, 'Min.'),
          ],
        ),
        Row(
          children: [
            _textFieldSettings(context, 'PCHK Modul-ID',
                pchkConfig.pchk_host_id, 0.1, _pchkModIdController, 'Std.'),
          ],
        )
      ],
    );
  }

  Widget _timeSettings(context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: Text('Zeitzone:',
                    style: TextStyle(color: Colors.white, fontSize: 18.0)),
              ),
            ),
            DropdownButton(
                hint: Text(pchkConfig.current_region),
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor),
                items: pchkConfig.timezones.keys
                    .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          pchkConfig.timezones[e]!.values.first,
                          style: TextStyle(
                              color: Colors.white), // ToDo: DropDown Menu
                        )))
                    .toList(),
                icon: const Icon(Icons.arrow_downward),
                /* hint: Text(_selectedIcon == ''
                    ? _floors[_floorIndex].rooms[index].icon
                    : _selectedIcon),*/
                onChanged: (Object? newValue) {
                  setState(() {
                    //print(_selectedIcon);
                    //_selectedIcon = newValue!;
                  });
                }),
          ],
        ),
        _textFieldSettings(context, 'Datumseinstellung:', '12/05/2022', 0.1,
            _dateController, null),
        _textFieldSettings(context, 'Zeiteinstellung:', '15:25:00', 0.1,
            _timeController, null),
        _checkBoxSettings(
            context, 'LCN Bus Zeitsynchronisation:', true, 'bus_synchro'),
        _checkBoxSettings(
            context, 'hole Zeit von NTP-Server', true, 'ntp-server'),
        _textFieldSettings(context, 'NTP Zeitserver', pchkConfig.syncTimeLink,
            0.1, _ntpController, null)
      ],
    );
  }

  Widget _userSettings(context) {
    return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            _textFieldSettings(context, 'Benutzername:', pchkConfig.user_name,
                0.1, _userNameController, null),
            _textFieldSettings(context, 'Passwort:', pchkConfig.pchk_password,
                0.1, _passwordController, null),
            _textFieldSettings(context, 'Neues Passwort:', '', 0.1,
                _newPasswordController, null),
            _textFieldSettings(context, 'Wiederholen:', '', 0.1,
                _newPasswordCheckController, null),
          ],
        ));
  }
}
