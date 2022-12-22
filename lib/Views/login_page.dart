import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:visu/clients/dio_client.dart';
import 'package:visu/forms/login_form.dart';
import 'package:xml/xml.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen();

  /*
  Future<List> getPchkConfig() async {
    final String pchk_config = '/web/lcnpchk.xml';
    Uri uri = Uri.file(pchk_config);
    Response res = await get(uri);

    if (res.statusCode == 200) {
      print('200....................200');
      print(res);
      return [];
    } else {
      throw "Unable to retrieve posts.";
    }
  }

   */

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[800],
        body: const Center(
          child: SizedBox(
            width: 400,
            child: Card(
              child: SignUpForm(),
            ),
          ),
        ));
  }
}
