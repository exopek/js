import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:isar/isar.dart';
import 'package:visu/customWidgets/header.dart';
import 'package:visu/models/models.dart';
import 'package:visu/responsive/responsive.dart';
import 'package:visu/services/helper_services.dart';
import 'package:visu/services/pchk_service.dart';
import 'package:visu/services/system_service.dart';

class PchkConfig extends StatefulWidget {
  const PchkConfig({Key? key}) : super(key: key);

  @override
  State<PchkConfig> createState() => _PchkConfigState();
}

class _PchkConfigState extends State<PchkConfig> {
  late Pchkconfig pchkConfig;
  late bool _waitOnReboot;
  late String fileName;
  late PlatformFile file;
  late FilePickerResult _filePickerResult;

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
      licence_count: '3',
      active_wlan_hotspot: false,
      pchk_password: 'lcn');

  Future<FilePickerResult> pickfile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowMultiple: false,
      allowedExtensions: ['upke'],
    );

    if (result != null) {
      //PlatformFile file = result.files.first;

      return result;
    } else {
      throw Exception('No file selected.');
      // User canceled the picker
    }
  }

  Future<bool> _waitForPchkConfig() async {
    await Future.delayed(const Duration(seconds: 1));
    return true;
  }

  @override
  void initState() {
    PchkServices().getPchkConfig().then((value) {
      setState(() {
        pchkConfig = value;
      });
    });
    _waitOnReboot = false;
    file = PlatformFile(
      name: '',
      size: 0,
    );
    fileName = '';
    _filePickerResult = FilePickerResult([]);
    //pchkConfig = dummyPchkConfig;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Object>(
        future: _waitForPchkConfig(),
        builder: (context, snapshot) {
          if (!snapshot.hasData && snapshot.data != true) {
            return const Scaffold(
                body: SafeArea(
                    child: Center(
              child: CircularProgressIndicator(),
            )));
          } else {
            return _waitOnReboot
                ? const Scaffold(
                    body: SafeArea(
                        child: Center(
                    child: CircularProgressIndicator(),
                  )))
                : Scaffold(
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
                                    Responsive(
                                      mobile: Center(
                                        child: Container(
                                            //color: Colors.amberAccent,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05,
                                                  top: 10.0,
                                                ),
                                                child: _userSettings(
                                                    context, 160))),
                                      ),
                                      desktop: Center(
                                        child: Container(
                                            //color: Colors.amberAccent,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.02,
                                                  top: 10.0,
                                                ),
                                                child: _userSettings(
                                                    context, 200))),
                                      ),
                                    ),

                                    _header(context,
                                        'Landesspezifische Einstellungen'),
                                    Center(
                                      child: Text('Aktuelle Zeit:',
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0)),
                                    ),
                                    Responsive(
                                      mobile: Center(
                                        child: Container(
                                            //color: Colors.amberAccent,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.05,
                                                  top: 10.0,
                                                ),
                                                child: _timeSettings(
                                                    context, 160, 160))),
                                      ),
                                      desktop: Center(
                                        child: Container(
                                            //color: Colors.amberAccent,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Padding(
                                                padding: EdgeInsets.only(
                                                  left: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.1,
                                                  right: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.02,
                                                  top: 10.0,
                                                ),
                                                child: _timeSettings(
                                                    context, 200, 200))),
                                      ),
                                    ),

                                    // Hier muss noch die aktuelle Zeit angezeigt werden

                                    _header(
                                        context, 'Erweiterte Einstellungen'),
                                    Responsive(
                                      mobile: Center(
                                        child: Container(
                                            //color: Colors.amberAccent,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05,
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05,
                                                top: 10.0,
                                              ),
                                              child: _advancedSettings(
                                                  context, 40),
                                            )),
                                      ),
                                      desktop: Center(
                                        child: Container(
                                            //color: Colors.amberAccent,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.02,
                                                top: 10.0,
                                              ),
                                              child: _advancedSettings(
                                                  context, 40),
                                            )),
                                      ),
                                    ),
                                    _header(context, 'Netzwerkeinstellungen'),
                                    Responsive(
                                      mobile: Center(
                                        child: Container(
                                            //color: Colors.amberAccent,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05,
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05,
                                                top: 10.0,
                                              ),
                                              child: _networkSettings(
                                                  context, 160, 160, 160, 160),
                                            )),
                                      ),
                                      desktop: Center(
                                        child: Container(
                                            //color: Colors.amberAccent,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.08,
                                                top: 10.0,
                                              ),
                                              child: _networkSettings(
                                                  context, 180, 180, 180, 180),
                                            )),
                                      ),
                                    ),

                                    _header(context, 'Lizenzeinstellungen'),
                                    Center(
                                      child: Container(
                                          //color: Colors.amberAccent,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08,
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
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 18.0)),
                                    ),
                                    Center(
                                      child: Container(
                                          //color: Colors.amberAccent,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08,
                                              top: 10.0,
                                            ),
                                            child:
                                                _licenceSettingsChange(context),
                                          )),
                                    ),

                                    _header(context, 'Wartungseinstellungen'),
                                    Center(
                                      child: Container(
                                          //color: Colors.amberAccent,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.5,
                                          child: Padding(
                                            padding: EdgeInsets.only(
                                              left: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.1,
                                              right: MediaQuery.of(context)
                                                      .size
                                                      .width *
                                                  0.08,
                                              top: 10.0,
                                            ),
                                            child:
                                                _maintenanceSettings(context),
                                          )),
                                    ),
                                    _header(context, 'WLAN-Einstellungen'),
                                    _header(context, 'Firmware-Aktualisierung'),
                                    Responsive(
                                      mobile: Center(
                                        child: Container(
                                            //color: Colors.amberAccent,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.8,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05,
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.05,
                                                top: 10.0,
                                              ),
                                              child: _firmwareUpdate(context),
                                            )),
                                      ),
                                      desktop: Center(
                                        child: Container(
                                            //color: Colors.amberAccent,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width *
                                                0.5,
                                            child: Padding(
                                              padding: EdgeInsets.only(
                                                left: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.1,
                                                right: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.08,
                                                top: 10.0,
                                              ),
                                              child: _firmwareUpdate(context),
                                            )),
                                      ),
                                    ),
                                    _footer(context),
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
        });
  }

  Widget _footer(context) {
    return Container(
      height: 50.0,
      width: MediaQuery.of(context).size.width,
      color: Colors.black,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextButton(
              onPressed: () {
                PchkServices().postPchkConfig(PchkPostConfig(
                  save_settings: 'true',
                  username_new: _userNameController.text,
                  passwd_new: _newPasswordController.text,
                  passwd_old: _passwordController.text,
                  passwd_repeat: _newPasswordCheckController.text,
                  pchk_modid: _pchkModIdController.text,
                  ip_1: _ip1Controller.text,
                  ip_2: _ip2Controller.text,
                  ip_3: _ip3Controller.text,
                  ip_4: _ip4Controller.text,
                  subnet_1: _subnet1Controller.text,
                  subnet_2: _subnet2Controller.text,
                  subnet_3: _subnet3Controller.text,
                  subnet_4: _subnet4Controller.text,
                  gw_1: _gateway1Controller.text,
                  gw_2: _gateway2Controller.text,
                  gw_3: _gateway3Controller.text,
                  gw_4: _gateway4Controller.text,
                  dns_1: _dns1Controller.text,
                  dns_2: _dns2Controller.text,
                  dns_3: _dns3Controller.text,
                  dns_4: _dns4Controller.text,
                  hostname: _hostnameController.text,
                  enable_dhcp: pchkConfig.dhcp_status,
                ));
              },
              child: const Text(
                'Einstellungen Speichern',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              )),
          TextButton(
              onPressed: () {
                System().reboot().then((value) {
                  if (value == 'OK') {
                    setState(() {
                      _waitOnReboot = false;
                    });
                    // Fehlermeldung ausgeben
                  } else {
                    //kleines Fenster aufrufen
                    print('Muss noch implementiert werden');
                  }
                });
                setState(() {
                  _waitOnReboot = true;
                });
              },
              child: const Text(
                'Neustart',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              )),
          TextButton(
              onPressed: () {},
              child: const Text(
                'Ausloggen',
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              )),
        ],
      ),
    );
  }

  Widget _firmwareUpdate(context) {
    return Row(
      children: [
        TextButton(
            onPressed: () {
              //Firmware-Update
              pickfile().then((value) {
                setState(() {
                  _filePickerResult = value;
                });
                //print(_filePickerResult.paths.first);
              });
            },
            child: const Text(
              'Datei auswählen',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            )),
        TextButton(
            onPressed: () {
              //Firmware-Update
              Helper().uploadUpke(result: _filePickerResult).then((value) {
                if (value == '200') {
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Datei erfolgreich hochgeladen'),
                  ));
                  // Fehlermeldung ausgeben
                } else {
                  //kleines Fenster aufrufen
                  print('Muss noch implementiert werden');
                }
              });
            },
            child: const Text(
              'hochladen und ausführen',
              style: TextStyle(color: Colors.white, fontSize: 18.0),
            )),
      ],
    );
  }

  Widget _maintenanceSettings(context) {
    return Column(
      children: [
        _textSettings(context, 'Status LCN Verbindung', 'Online',
            Colors.greenAccent, 180, 180),
        _checkBoxSettings(context, 'Aktiviere WLAN-Hotspot',
            pchkConfig.active_wlan_hotspot, 'wlan_hotspot', 180),
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
        _textSettings(context, 'Lizenznehmer:', pchkConfig.licence,
            Colors.white, 180, 180),
        _textSettings(context, 'Verbindungen:',
            pchkConfig.licence_count.toString(), Colors.white, 180, 180),
      ],
    );
  }

  Widget _networkSettings(
      context, double addWidth, double tfWidth, double tWidth, double cWidth) {
    return Column(
      children: [
        // Modus
        _textSettings(
            context,
            'Modus:',
            pchkConfig.pke_mode == 'pke_mode_private'
                ? 'Privates Netzwerk'
                : 'Geschäftlich',
            Colors.white,
            tWidth,
            tWidth), // Text muss für verschiedene Sprachen angepasst werden
        // Schnittstelle
        _textSettings(context, 'Schnittstellenname:', 'eth0', Colors.white,
            tWidth, tWidth),
        // Status
        _textSettings(
            context,
            'Status:',
            pchkConfig.interface_state == 'UP' ? 'Aktiv' : 'Inaktiv',
            pchkConfig.interface_state == 'UP'
                ? Colors.greenAccent
                : Colors.redAccent,
            tWidth,
            tWidth), // Text muss für verschiedene Sprachen angepasst werden
        // DHCP
        _checkBoxSettings(
            context,
            'Aktiviere DHCP:',
            pchkConfig.dhcp_status == 'true' ? true : false,
            'dhcp_status',
            cWidth),
        // IP-Adresse
        _adressSettings(
            context,
            'IP-Addresse:',
            [
              _textField(context, pchkConfig.interface_ip[0], 50,
                  _ip1Controller, null, null, null),
              _textField(context, pchkConfig.interface_ip[1], 50,
                  _ip2Controller, null, null, null),
              _textField(context, pchkConfig.interface_ip[2], 50,
                  _ip3Controller, null, null, null),
              _textField(context, pchkConfig.interface_ip[3], 50,
                  _ip4Controller, null, null, null)
            ],
            addWidth),
        // Subnetzmaske
        _adressSettings(
            context,
            'Subnetzmaske:',
            [
              _textField(context, pchkConfig.interface_subnet[0], 50,
                  _subnet1Controller, null, null, null),
              _textField(context, pchkConfig.interface_subnet[1], 50,
                  _subnet2Controller, null, null, null),
              _textField(context, pchkConfig.interface_subnet[2], 50,
                  _subnet3Controller, null, null, null),
              _textField(context, pchkConfig.interface_subnet[3], 50,
                  _subnet4Controller, null, null, null)
            ],
            addWidth),
        // Gateway
        _adressSettings(
            context,
            'Router:',
            [
              _textField(context, pchkConfig.interface_gateway[0], 50,
                  _gateway1Controller, null, null, null),
              _textField(context, pchkConfig.interface_gateway[1], 50,
                  _gateway2Controller, null, null, null),
              _textField(context, pchkConfig.interface_gateway[2], 50,
                  _gateway3Controller, null, null, null),
              _textField(context, pchkConfig.interface_gateway[3], 50,
                  _gateway4Controller, null, null, null)
            ],
            addWidth),
        // DNS
        _adressSettings(
            context,
            'DNS-Server:',
            [
              _textField(context, pchkConfig.interface_dns[0], 50,
                  _dns1Controller, null, null, null),
              _textField(context, pchkConfig.interface_dns[1], 50,
                  _dns2Controller, null, null, null),
              _textField(context, pchkConfig.interface_dns[2], 50,
                  _dns3Controller, null, null, null),
              _textField(context, pchkConfig.interface_dns[3], 50,
                  _dns4Controller, null, null, null)
            ],
            addWidth),
        // Hostname
        _textFieldSettings(context, 'Hostname:', pchkConfig.host_name, tfWidth,
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

  Widget _checkBoxSettings(
      context, String text, bool status, String variable, double width) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: SizedBox(
            width: width,
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

  Widget _textSettings(context, String text, String value, Color color,
      double firstWidth, double secondWidth) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: SizedBox(
            width: firstWidth,
            child: Text(text,
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ),
        ),
        SizedBox(
          width: secondWidth,
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
            width: 180,
            child: Text(text,
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ),
        ),
        _textField(context, hintText, boxWidth, controller, ending, null, null)
      ],
    );
  }

  Widget _adressSettings(
      context, String text, List<Widget> children, double width) {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
          child: SizedBox(
            width: width,
            child: Text(text,
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ),
        ),
        children[0],
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5.0),
          child: SizedBox(
            width: 5,
            child: Text('.',
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ),
        ),
        children[1],
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5.0),
          child: SizedBox(
            width: 5,
            child: Text('.',
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ),
        ),
        children[2],
        Padding(
          padding: const EdgeInsets.only(top: 10.0, bottom: 10.0, left: 5.0),
          child: SizedBox(
            width: 5,
            child: Text('.',
                style: TextStyle(color: Colors.white, fontSize: 18.0)),
          ),
        ),
        children[3],
      ],
    );
  }

  Widget _textField(
      BuildContext context,
      String hintText,
      float boxWidth,
      TextEditingController? controller,
      String? ending,
      bool? readOnly,
      TextAlign? textAlign) {
    return SizedBox(
      width: boxWidth,
      child: //Row(
          //children: [
          TextField(
        textAlign: textAlign ?? TextAlign.start,
        readOnly: readOnly ?? false,
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

  Widget _advancedSettings(context, double textFieldWidth) {
    return Column(
      children: [
        Row(
          children: [
            _textFieldSettings(
                context,
                'PCHK Timeout:',
                pchkConfig.pchk_timeout_std.toString(),
                textFieldWidth,
                _pchkTimeoutStdController,
                null),
            const SizedBox(width: 2.0),
            _textField(context, "Std.", 60, null, null, true, null),
            const SizedBox(width: 2.0),
            _textField(
                context,
                pchkConfig.pchk_timeout_std.toString(),
                textFieldWidth,
                _pchkTimeoutMinController,
                null,
                null,
                TextAlign.center),
            const SizedBox(width: 2.0),
            _textField(context, "Min.", 60, null, null, true, null),
          ],
        ),
        Row(
          children: [
            _textFieldSettings(
                context,
                'PCHK Modul-ID:',
                pchkConfig.pchk_host_id,
                textFieldWidth,
                _pchkModIdController,
                null),
          ],
        )
      ],
    );
  }

  Widget _timeSettings(context, double textFieldWidth, double cWidth) {
    return Column(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
              child: SizedBox(
                width: 180,
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
        _textFieldSettings(context, 'Datumseinstellung:', '12/05/2022',
            textFieldWidth, _dateController, null),
        _textFieldSettings(context, 'Zeiteinstellung:', '15:25:00',
            textFieldWidth, _timeController, null),
        _checkBoxSettings(context, 'LCN Bus Zeitsynchronisation:', true,
            'bus_synchro', cWidth),
        _checkBoxSettings(
            context, 'hole Zeit von NTP-Server', true, 'ntp-server', cWidth),
        _textFieldSettings(context, 'NTP Zeitserver', pchkConfig.syncTimeLink,
            textFieldWidth, _ntpController, null)
      ],
    );
  }

  Widget _userSettings(context, double textFieldWidth) {
    return Padding(
        padding: const EdgeInsets.only(top: 20.0),
        child: Column(
          children: [
            _textFieldSettings(context, 'Benutzername:', pchkConfig.user_name,
                textFieldWidth, _userNameController, null),
            _textFieldSettings(context, 'Passwort:', pchkConfig.pchk_password,
                textFieldWidth, _passwordController, null),
            _textFieldSettings(context, 'Neues Passwort:', '', textFieldWidth,
                _newPasswordController, null),
            _textFieldSettings(context, 'Wiederholen:', '', textFieldWidth,
                _newPasswordCheckController, null),
          ],
        ));
  }
}
