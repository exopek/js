import 'dart:convert';

import 'package:http/http.dart';
import 'package:visu/CustomWidgets/pchk_config.dart';
import 'package:visu/Models/models.dart';
import 'package:visu/Routes/routes.dart';

class PchkServices {
  Future<Pchkconfig> getPchkConfig() async {
    Uri uri = Uri.parse(EndPoints().getEndpoints()['PCHK_CONFIG']);
    Response response = await get(uri);
    if (response.statusCode == 200) {
      print('function getPchkConfig');
      print(response.body);
      // Hier alles in ein Model
      Map<String, dynamic> pchkConfig = jsonDecode(response.body);

      return Pchkconfig.fromJson(pchkConfig);
    } else {
      throw (Exception('Can not load pchk config.'));
    }
  }
}
