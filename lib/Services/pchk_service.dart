import 'dart:convert';

import 'package:http/http.dart';
import 'package:visu/Routes/routes.dart';

class PchkServices {
  Future<Map<String, dynamic>> getPchkConfig() async {
    Uri uri = Uri.parse(EndPoints().getEndpoints()['PCHK_CONFIG']);
    Response response = await get(uri);
    if (response.statusCode == 200) {
      // Hier alles in ein Model
      Map<String, dynamic> pchkConfig = jsonDecode(response.body);
      return pchkConfig;
    } else {
      throw (Exception('Can not load pchk config.'));
    }
  }
}
