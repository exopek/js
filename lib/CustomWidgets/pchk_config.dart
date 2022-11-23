import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:visu/Services/pchk_service.dart';

class PchkConfig extends StatefulWidget {
  const PchkConfig({Key? key}) : super(key: key);

  @override
  State<PchkConfig> createState() => _PchkConfigState();
}

class _PchkConfigState extends State<PchkConfig> {
  @override
  void initState() {
    PchkServices().getPchkConfig().then((value) => print(value));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 100,
                color: Colors.green,
              ),
              Container(
                color: Colors.red,
              ),
              Container(
                color: Colors.yellowAccent,
              ),
              Container(
                color: Colors.blue,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _header(context, String title) {
    return Container(
      child: Text(title),
    );
  }
}
