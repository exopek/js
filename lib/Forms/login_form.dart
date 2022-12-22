import 'dart:convert';
import 'dart:html';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:provider/provider.dart';
import 'package:visu/controller/menu_controller.dart';
import 'package:visu/models/models.dart';
import 'package:visu/routes/routes.dart';
import 'package:visu/views/visu_home_page.dart';
import 'package:xml/xml.dart';
import 'package:filesystem_picker/filesystem_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:visu/services/auth_service.dart';
//import 'package:dotenv/dotenv.dart' show load, env;
//import 'package:json_serializable/json_serializable.dart';

class SignUpForm extends StatefulWidget {
  const SignUpForm();

  @override
  _SignUpFormState createState() => _SignUpFormState();
}

class _SignUpFormState extends State<SignUpForm> {
  final _passwordTextController = TextEditingController();
  final _usernameTextController = TextEditingController();

  double _formProgress = 0;

  var pchk_config;
  late var _value;
  List language = ['de_Deutsch.php', 'en_English.php', 'es_Espanol.php'];

  Future<Response> changeLanguage(var index) async {
    final String pchk_config = 'http://127.0.0.1/security.php';
    Uri uri = Uri.parse(pchk_config);
    return Future.delayed(Duration(microseconds: 1000)).then((value) async {
      Response res = await post(uri, body: {
        'lang_select': language[index - 1],
      });

      if (res.statusCode == 200) {
        print('200....................200');
        print(res.body);
        return res;
      } else {
        throw "Unable to retrieve posts.";
      }
    });
  }

  Future<String> loadAsset() async {
    return await rootBundle.loadString('assets/config/lcnpchk.xml');
  }

  @override
  void initState() {
    _value = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LinearProgressIndicator(value: _formProgress),
          Text('Anmeldung', style: Theme.of(context).textTheme.headline4),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: DropdownButton(
                items: const [
                  DropdownMenuItem(
                    child: Text('Deutsch'),
                    value: 1,
                  ),
                  DropdownMenuItem(
                    child: Text('English'),
                    value: 2,
                  ),
                  DropdownMenuItem(
                    child: Text('Espanol'),
                    value: 3,
                  )
                ],
                onChanged: (value) {
                  if (value != null) {
                    changeLanguage(value);
                  }
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _usernameTextController,
              decoration: const InputDecoration(hintText: 'Benutzername'),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: _passwordTextController,
              decoration: const InputDecoration(hintText: 'Passwort'),
            ),
          ),
          TextButton(
            style: ButtonStyle(
              foregroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.white;
              }),
              backgroundColor: MaterialStateProperty.resolveWith(
                  (Set<MaterialState> states) {
                return states.contains(MaterialState.disabled)
                    ? null
                    : Colors.orangeAccent;
              }),
            ),
            onPressed: () {
              Authentication()
                  .login(_usernameTextController.text,
                      _passwordTextController.text)
                  .then((value) {
                if (value.success) {
                  //Navigator.pushNamed(context, RoutesName.HOME_PAGE);
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) {
                      return MultiProvider(providers: [
                        ChangeNotifierProvider(
                            create: (context) => MenuController()),
                      ], child: HomePage());
                    },
                  ));
                }
              });

              /// Wenn der post request durchgeht kann zur nächsten Seite geroutet werden
            },
            child: const Text('Anmelden'),
          ),
        ],
      ),
    );
  }
}
