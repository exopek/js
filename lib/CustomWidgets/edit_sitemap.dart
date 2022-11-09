import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:visu/Services/openhab_service.dart';

class EditSiteMap extends StatefulWidget {
  const EditSiteMap({Key? key}) : super(key: key);

  @override
  State<EditSiteMap> createState() => _EditSiteMapState();
}

class _EditSiteMapState extends State<EditSiteMap> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SafeArea(
      child: SingleChildScrollView(
        child: FutureBuilder<dynamic>(
            future: OpenhabServices().getSiteMap(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Text(
                  snapshot.data,
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    ));
  }
}
