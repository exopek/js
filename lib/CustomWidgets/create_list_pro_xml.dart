import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:visu/customWidgets/header.dart';
import 'package:visu/models/models.dart';
import 'package:visu/responsive/responsive.dart';
import 'package:visu/views/login_page.dart';

import '../Services/helper_services.dart';

class CreateListProXml extends StatefulWidget {
  const CreateListProXml({Key? key}) : super(key: key);

  @override
  _CreateListProXmlState createState() => _CreateListProXmlState();
}

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

class _CreateListProXmlState extends State<CreateListProXml>
    with TickerProviderStateMixin {
  late String fileName;
  late PlatformFile file;
  late String modules;
  late String rooms;
  late String devices;
  late bool isFileUploaded;
  late AnimationController _controller;
  late bool _showParserResult;
  late bool _showReboot;

  @override
  void initState() {
    fileName = '';
    modules = '';
    rooms = '';
    devices = '';
    isFileUploaded = false;
    _showParserResult = false;
    _showReboot = false;
    _controller =
        AnimationController(vsync: this, duration: const Duration(seconds: 6));
    file = PlatformFile(
      name: '',
      size: 0,
    );
    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        setState(() {
          isFileUploaded = false;
          _showParserResult = true;
        });
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
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
              child: Responsive(
                mobile: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: _showParserResult
                        ? _parserContent()
                        : Stack(
                            children: [
                              _settingsContent(),
                              isFileUploaded ? _parserInfo() : const SizedBox()
                            ],
                          )),
                desktop: AspectRatio(
                    aspectRatio: 16 / 9,
                    child: _showParserResult
                        ? _parserContent()
                        : Stack(
                            children: [
                              _settingsContent(),
                              isFileUploaded ? _parserInfo() : const SizedBox()
                            ],
                          )),
              ),
            ),
          ],
        ),
      ) /*ListTile(
          title: Text('Für alle Ansichten die Gebäudedatei (xml) hochladen:'),
          subtitle: Text('Name:'),
          isThreeLine: true,
        ),*/
          ),
    );
  }

  Widget _reboot() {
    return FutureBuilder(builder: (BuildContext context, snapshot) {
      if (snapshot.hasData && snapshot.data == true) {
        Navigator.of(context).push(MaterialPageRoute(
          builder: (BuildContext context) {
            return SignUpScreen();
          },
        ));
        return SizedBox();
      } else if (snapshot.connectionState == ConnectionState.waiting) {
        return Container(
          child: const CircularProgressIndicator(),
        );
      } else {
        return Text('Reboot fehlgeschlagen');
      }
    });
  }

  Widget _parserContent() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 15.0),
          child: Container(
              child: const Text(
            'Information zum Einleseprozess:',
            style: TextStyle(color: Colors.white, fontSize: 22.0),
          )),
        ),
        const SizedBox(
          height: 20.0,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 15.0),
          child: Container(
              child: Text(
            'Module: $modules',
            style: const TextStyle(color: Colors.white, fontSize: 16.0),
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 15.0),
          child: Container(
              child: Text(
            'Räume: $rooms',
            style: const TextStyle(color: Colors.white, fontSize: 16.0),
          )),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10.0, top: 15.0),
          child: Container(
              child: Text(
            'Schaltbare Element: $devices',
            style: const TextStyle(color: Colors.white, fontSize: 16.0),
          )),
        ),
        Row(
          children: [
            const Icon(
              Icons.info_outline_rounded,
            ),
            const Text(
              'Damit die Visualisierung die Projektdatei übernehmen kann, muss die VISU neu gestartet werden.',
              style: TextStyle(color: Colors.white, fontSize: 16.0),
            )
          ],
        ),
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20.0),
              child: ElevatedButton(
                onPressed: () {
                  setState(() {
                    _showReboot = true;
                  });
                },
                child: const Text('Neustart',
                    style:
                        TextStyle(color: Colors.orangeAccent, fontSize: 16.0)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20.0, left: 10.0),
              child: ElevatedButton(
                onPressed: () {},
                child: const Text('Zurück',
                    style:
                        TextStyle(color: Colors.orangeAccent, fontSize: 16.0)),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _parserInfo() {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Center(
          child: Container(
            height: 300,
            width: 600,
            color: Colors.black.withOpacity(1.0 * _controller.value),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text('Ihr Projekt wurde erfolgreich hochgeladen.',
                      style: TextStyle(
                        color:
                            Colors.white.withOpacity(1.0 * _controller.value),
                        fontSize: 24.0,
                      )),
                ),
                Icon(
                  Icons.check_circle_outline,
                  color: Colors.green.withOpacity(1.0 * _controller.value),
                  size: 180.0,
                ),
                /*
                const Text(
                    'Damit die Visualisierung die Projektdatei übernehmen kann, muss die VISU neu gestartet werden.'),
                const Text('Information zum Einleseprozess:'),
                Text('Module: $modules'),
                Text('Räume: $rooms'),
                Text('Schaltbare Elemente: $devices'),
                */
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _settingsContent() {
    print('try to load file');
    return FutureBuilder<UploadFile>(
        future: Helper().loadLastUploadXml(),
        builder: (context, snapshot) {
          print(snapshot.data);
          if (snapshot.hasData) {
            return Container(
              color: Theme.of(context).primaryColor,
              child: Column(
                children: [
                  Row(
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, top: 15.0),
                            child: Container(
                                child: const Text(
                              'Für alle Ansichten die Gebäudedatei (xml) hochladen:',
                              style: TextStyle(
                                  color: Colors.white, fontSize: 22.0),
                            )),
                          ),
                          const SizedBox(
                            height: 20.0,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, top: 15.0),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Container(
                                  color: Colors.white10,
                                  child: Text(
                                    'Aktuelle Konfigurationsdatei: ${snapshot.data!.name}',
                                    style: const TextStyle(
                                        color: Colors.white, fontSize: 16.0),
                                  )),
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, top: 15.0),
                            child: Container(
                                child: Text(
                              'Datum Konfigurationsdatei: ${snapshot.data!.date}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            )),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.only(left: 10.0, top: 15.0),
                            child: Container(
                                child: Text(
                              'Uhrzeit Konfigurationsdatei: ${snapshot.data!.time}',
                              style: const TextStyle(
                                  color: Colors.white, fontSize: 16.0),
                            )),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          TextButton(
                              style: ButtonStyle(
                                  backgroundColor:
                                      MaterialStateProperty.all(Colors.black45),
                                  overlayColor: MaterialStateProperty.all(
                                      const Color.fromARGB(255, 233, 145, 31))),
                              onPressed: () {
                                pickfile().then((value) {
                                  setState(() {
                                    fileName = value.name;
                                    file = value;
                                  });
                                });
                              },
                              child: const Text('Datei Auswählen')),
                          Text('Ausgewählte Datei: $fileName')
                        ],
                      )
                    ],
                  ),
                  Center(
                    child: TextButton(
                      child: const Text(
                        'hochladen und ausführen',
                        style: TextStyle(
                            color: Colors.orangeAccent, fontSize: 20.0),
                      ),
                      onPressed: () {
                        Helper()
                            .uploadXml(file: file)
                            .then<ParserResponse>((value) {
                          if (value.status) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('Datei erfolgreich hochgeladen'),
                            ));
                            setState(() {
                              isFileUploaded = true;
                              modules = value.modules;
                              rooms = value.rooms;
                              devices = value.devices;
                              _controller.forward(from: 0.0);
                            });
                            throw (Exception('Complete'));
                          } else {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content:
                                  Text('Datei konnte nicht hochgeladen werden'),
                            ));
                            throw (Exception('Incomplete'));
                          }
                        });
                      },
                    ),
                  )
                ],
              ),
            );
          } else {
            /// Hier kann ein Ladebereich eingebaut werden
            return Container(
              height: 100.0,
              width: 100.0,
              color: Theme.of(context).primaryColor,
              child: const CircularProgressIndicator(),
            );
          }
        });
  }
}
