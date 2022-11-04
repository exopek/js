import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:visu/CustomWidgets/header.dart';
import 'package:visu/Models/models.dart';
import 'package:visu/Responsive/responsive.dart';

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

class _CreateListProXmlState extends State<CreateListProXml> {
  late String fileName;
  late PlatformFile file;
  late String modules;
  late String rooms;
  late String devices;
  late bool isFileUploaded;

  @override
  void initState() {
    fileName = '';
    modules = '';
    rooms = '';
    devices = '';
    isFileUploaded = false;
    file = PlatformFile(
      name: '',
      size: 0,
    );
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
              child: Responsive(
                  mobile: AspectRatio(
                      aspectRatio: 16 / 9,
                      child:
                          isFileUploaded ? _parserInfo() : _settingsContent()),
                  desktop: AspectRatio(
                      aspectRatio: 16 / 9,
                      child:
                          isFileUploaded ? _parserInfo() : _settingsContent())),
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

  Widget _parserInfo() {
    return AnimatedContainer(
      duration: const Duration(seconds: 2),
      curve: Curves.easeIn,
      child: Column(
        children: [
          const Text('Ihr Projekt wurde erfolgreich hochgeladen.'),
          const Text(
              'Damit die Visualisierung die Projektdatei übernehmen kann, muss die VISU neu gestartet werden.'),
          const Text('Information zum Einleseprozess:'),
          Text('Module: $modules'),
          Text('Räume: $rooms'),
          Text('Schaltbare Elemente: $devices'),
        ],
      ),
    );
  }

  Widget _settingsContent() {
    return FutureBuilder<UploadFile>(
        future: Helper().loadLastUploadXml(),
        builder: (context, snapshot) {
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
