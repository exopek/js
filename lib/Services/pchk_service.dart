import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart';
import 'package:visu/customWidgets/pchk_config.dart';
import 'package:visu/models/models.dart';
import 'package:visu/routes/routes.dart';

class PchkServices {
  Future<Pchkconfig> getPchkConfig() async {
    Uri uri = Uri.parse(EndPoints().getEndpoints()['PCHK_CONFIG']);
    try {
      Response response = await get(uri);
      if (response.statusCode == 200) {
        Map<String, dynamic> pchkConfig = jsonDecode(response.body);
        return Pchkconfig.fromJson(pchkConfig);
      } else {
        print('Cant load');
        throw (Exception('${response.statusCode}'));
      }
    } catch (e) {
      print(e);
      throw (Exception('Can not load pchk config.'));
    }
  }

  Future<bool> postPchkConfig(PchkPostConfig pchkconfig) async {
    Uri uri = Uri.parse(EndPoints().getEndpoints()['PCHK_CONFIG']);
    try {
      var formData = {'save_settings': 'true'};
      print(pchkconfig.toJson());
      var response = await post(uri, body: pchkconfig.toJson());
      print(response.body);
      //response.write(json.encode(formData));
      //response.close();
      /*
      var response = await Client().post(uri,
          /*headers: {'Content-Type': 'application/json'},*/
          body: json.encode(formData) //jsonEncode(pchkconfig.toJson())
          );
      */

      return true;
    } catch (e) {
      print(e);
      throw (Exception('Can not load pchk config.'));
    }
  }
}
