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
      syncTimeLink: '',
      pke_mode: 'pke_mode_private',
      dhcp_status: 'true',
      timezones: {
        'Europe': ['Berlin'],
        'Afrika': ['Test']
      },
      current_timezone: 'Europe',
      current_region: 'Berlin',
      licence: 'PKE-Lizenz',
      licence_count: 3);

  @override
  void initState() {
    PchkServices().getPchkConfig().then((value) {
      setState(() {
        pchkConfig = value;
      });
    });
    //pchkConfig = dummyPchkConfig;
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
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.5,
                              child: _userSettings(context))),
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
                      _header(context, 'WLAN-Einstellungen'),
                      _header(context, 'Firmware-Aktualisierung'),
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

  Widget _licenceSettingsChange(context) {
    return Column(
      children: [
        _textFieldSettings(
            context, 'Lizenznehmer:', '', 0.08, _licenceController),
        _textFieldSettings(context, 'Key:', '', 0.08, _licenceKeyController)
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
          _textField(context, pchkConfig.interface_ip[0], 0.03, _ip1Controller),
          _textField(context, pchkConfig.interface_ip[1], 0.03, _ip2Controller),
          _textField(context, pchkConfig.interface_ip[2], 0.03, _ip3Controller),
          _textField(context, pchkConfig.interface_ip[3], 0.03, _ip4Controller)
        ]),
        // Subnetzmaske
        _adressSettings(context, 'Subnetzmaske:', [
          _textField(context, pchkConfig.interface_subnet[0], 0.03,
              _subnet1Controller),
          _textField(context, pchkConfig.interface_subnet[1], 0.03,
              _subnet2Controller),
          _textField(context, pchkConfig.interface_subnet[2], 0.03,
              _subnet3Controller),
          _textField(
              context, pchkConfig.interface_subnet[3], 0.03, _subnet4Controller)
        ]),
        // Gateway
        _adressSettings(context, 'Router:', [
          _textField(context, pchkConfig.interface_gateway[0], 0.03,
              _gateway1Controller),
          _textField(context, pchkConfig.interface_gateway[1], 0.03,
              _gateway2Controller),
          _textField(context, pchkConfig.interface_gateway[2], 0.03,
              _gateway3Controller),
          _textField(context, pchkConfig.interface_gateway[3], 0.03,
              _gateway4Controller)
        ]),
        // DNS
        _adressSettings(context, 'DNS-Server:', [
          _textField(
              context, pchkConfig.interface_dns[0], 0.03, _dns1Controller),
          _textField(
              context, pchkConfig.interface_dns[1], 0.03, _dns2Controller),
          _textField(
              context, pchkConfig.interface_dns[2], 0.03, _dns3Controller),
          _textField(
              context, pchkConfig.interface_dns[3], 0.03, _dns4Controller)
        ]),
        // Hostname
        _textFieldSettings(context, 'Hostname:', pchkConfig.host_name, 0.1,
            _hostnameController),
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
      float boxWidth, TextEditingController controller) {
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
        _textField(context, hintText, boxWidth, controller)
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
      TextEditingController controller) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * boxWidth,
      child: TextField(
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
    );
  }

  Widget _advancedSettings(context) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: Text('PCHK Timeout:',
                    style: TextStyle(color: Colors.white, fontSize: 18.0)),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
              child: TextField(
                controller: _userNameController,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    hoverColor: Theme.of(context).primaryColor,
                    filled: true,
                    fillColor: Colors.black12,
                    border: InputBorder.none,
                    hintText: pchkConfig.user_name,
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16.0)),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
                child: Text('Std.',
                    style: TextStyle(color: Colors.white, fontSize: 18.0)),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
              child: TextField(
                controller: _userNameController,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    hoverColor: Theme.of(context).primaryColor,
                    filled: true,
                    fillColor: Colors.black12,
                    border: InputBorder.none,
                    hintText: pchkConfig.user_name,
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16.0)),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.05,
                child: Text('Min.',
                    style: TextStyle(color: Colors.white, fontSize: 18.0)),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: SizedBox(
                width: MediaQuery.of(context).size.width * 0.1,
                child: Text('PCHK Modul-ID:',
                    style: TextStyle(color: Colors.white, fontSize: 18.0)),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.05,
              child: TextField(
                controller: _userNameController,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    hoverColor: Theme.of(context).primaryColor,
                    filled: true,
                    fillColor: Colors.black12,
                    border: InputBorder.none,
                    hintText: pchkConfig.user_name,
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16.0)),
              ),
            ),
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
                width: MediaQuery.of(context).size.width * 0.2,
                child: Text('Zeitzone:',
                    style: TextStyle(color: Colors.white, fontSize: 18.0)),
              ),
            ),
            DropdownButton(
                style: TextStyle(
                    fontSize: 20.0,
                    color: Colors.white,
                    backgroundColor: Theme.of(context).primaryColor),
                items: pchkConfig.timezones.keys
                    .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(
                          e,
                          style: TextStyle(color: Colors.white),
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
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Text('Datumseinstellung:',
                  style: TextStyle(color: Colors.white, fontSize: 18.0)),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
              child: TextField(
                controller: _userNameController,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    hoverColor: Theme.of(context).primaryColor,
                    filled: true,
                    fillColor: Colors.black12,
                    border: InputBorder.none,
                    hintText: pchkConfig.user_name,
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16.0)),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Text('Zeiteinstellung:',
                  style: TextStyle(color: Colors.white, fontSize: 18.0)),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
              child: TextField(
                controller: _userNameController,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    hoverColor: Theme.of(context).primaryColor,
                    filled: true,
                    fillColor: Colors.black12,
                    border: InputBorder.none,
                    hintText: pchkConfig.user_name,
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16.0)),
              ),
            ),
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Text('LCN Bus Zeitsynchronisation:',
                  style: TextStyle(color: Colors.white, fontSize: 18.0)),
            ),
            Checkbox(
                value: true,
                onChanged: (value) {
                  setState(() {
                    //this.value = value;
                  });
                })
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Text('hole Zeit von NTP-Server:',
                  style: TextStyle(color: Colors.white, fontSize: 18.0)),
            ),
            Checkbox(
                value: true,
                onChanged: (value) {
                  setState(() {
                    //this.value = value;
                  });
                })
          ],
        ),
        Row(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.2,
              child: Text('NTP Zeitserver:',
                  style: TextStyle(color: Colors.white, fontSize: 18.0)),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
              child: TextField(
                controller: _userNameController,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    hoverColor: Theme.of(context).primaryColor,
                    filled: true,
                    fillColor: Colors.black12,
                    border: InputBorder.none,
                    hintText: pchkConfig.user_name,
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16.0)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _userSettings(context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20.0),
      child: Row(children: [
        Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text('Benutzername: ',
                  style: TextStyle(color: Colors.white, fontSize: 16.0)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text('Altes Passwort: ',
                  style: TextStyle(color: Colors.white, fontSize: 16.0)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text('Neues Passwort: ',
                  style: TextStyle(color: Colors.white, fontSize: 16.0)),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: Text('Wiederholung: ',
                  style: TextStyle(color: Colors.white, fontSize: 16.0)),
            ),
          ],
        ),
        Column(
          children: [
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
              child: TextField(
                controller: _userNameController,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    hoverColor: Theme.of(context).primaryColor,
                    filled: true,
                    fillColor: Colors.black12,
                    border: InputBorder.none,
                    hintText: pchkConfig.user_name,
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16.0)),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
              child: TextField(
                controller: _userNameController,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    hoverColor: Theme.of(context).primaryColor,
                    filled: true,
                    fillColor: Colors.black12,
                    border: InputBorder.none,
                    hintText: pchkConfig.user_name,
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16.0)),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
              child: TextField(
                controller: _userNameController,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    hoverColor: Theme.of(context).primaryColor,
                    filled: true,
                    fillColor: Colors.black12,
                    border: InputBorder.none,
                    hintText: pchkConfig.user_name,
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16.0)),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.1,
              child: TextField(
                controller: _userNameController,
                style: TextStyle(color: Colors.white, fontSize: 16.0),
                decoration: InputDecoration(
                    isDense: true,
                    contentPadding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                    hoverColor: Theme.of(context).primaryColor,
                    filled: true,
                    fillColor: Colors.black12,
                    border: InputBorder.none,
                    hintText: pchkConfig.user_name,
                    hintStyle: TextStyle(color: Colors.white, fontSize: 16.0)),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
