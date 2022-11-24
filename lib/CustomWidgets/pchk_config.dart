import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
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
      interface_state: '',
      interface_ip: ['0', '0', '0', '0'],
      interface_subnet: ['0', '0', '0', '0'],
      interface_gateway: ['0', '0', '0', '0'],
      interface_dns: ['0', '0', '0', '0'],
      host_name: 'LCN-VISU',
      user_name: 'Test User',
      syncTime: 'SyncNtpTime',
      syncTimeLink: '',
      pke_mode: 'pke_mode',
      dhcp_status: 'true',
      timezones: {
        'Europe': ['Berlin'],
        'Afrika': ['Test']
      },
      current_timezone: 'Europe',
      current_region: 'Berlin');

  @override
  void initState() {
    //PchkServices().getPchkConfig().then((value) => print(value));
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
                      Center(
                        child: Text('Benutzereinstellungen',
                            style:
                                TextStyle(color: Colors.white, fontSize: 20.0)),
                      ),
                      Center(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: _userSettings(context))),
                      Center(
                        child: Text('Landesspezifische Einstellungen',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.0,
                                fontWeight: FontWeight.bold)),
                      ),
                      Center(
                        child: Text('Aktuelle Zeit:',
                            style:
                                TextStyle(color: Colors.white, fontSize: 18.0)),
                      ),
                      Center(
                          child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              child: _timeSettings(context)))
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
