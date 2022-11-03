
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

Future<List> pickfile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();

  if (result != null) {
    //Uint8List file = result.files.first.bytes!;
    String fileName = result.files.first.name;
    return [fileName];
  } else {
    return [];
    // User canceled the picker
  }
}

class _CreateListProXmlState extends State<CreateListProXml> {

  late String fileName;


  @override
  void initState() {
    fileName = '';
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
                      aspectRatio: 16 / 9, child: settingsContent()),
                  desktop: AspectRatio(
                      aspectRatio: 16 / 9, child: settingsContent())),
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

  Widget settingsContent() {
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
                          padding: const EdgeInsets.only(left: 10.0, top: 15.0),
                          child: Container(
                              child: Text('Für alle Ansichten die Gebäudedatei (xml) hochladen:',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22.0
                                ),
                              )
                          ),
                        ),
                        SizedBox(height: 20.0,),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 15.0),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Container(
                                color: Colors.white10,
                                child: Text('Aktuelle Konfigurationsdatei: ${snapshot.data!.name}',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16.0
                                  ),
                                )
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 15.0),
                          child: Container(
                              child: Text('Datum Konfigurationsdatei: ${snapshot.data!.date}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0
                                ),
                              )
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10.0, top: 15.0),
                          child: Container(
                              child: Text('Uhrzeit Konfigurationsdatei: ${snapshot.data!.time}',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16.0
                                ),
                              )
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        TextButton(

                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all(Colors.black45),
                                overlayColor: MaterialStateProperty.all(Colors.orangeAccent)
                            ),
                            onPressed: () {
                              pickfile().then((value) {
                                setState(() {
                                  fileName = value[0];
                                  //File file = value[1];
                                });
                              });
                            },
                            child: Text('Datei Auswählen')),
                        Text('Ausgewählte Datei: $fileName')
                      ],
                    )
                  ],
                ),
                Center(
                  child: TextButton(
                    child: Text('hochladen und ausführen',
                      style: TextStyle(
                          color: Colors.orangeAccent,
                          fontSize: 20.0
                      ),
                    ),
                    onPressed: () {

                    },
                  ),
                )
              ],
            ),
          );
        } else {
          return Container(
            color: Theme.of(context).primaryColor,
            child: CircularProgressIndicator(),
          );
        }

      }
    );
  }
}
