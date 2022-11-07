import 'dart:convert';

import 'package:http/http.dart';

class System {
  Future<dynamic> reboot() async {
    Uri uri = Uri.parse('controller/api/reboot.php');
    Response response = await get(uri);
    if (response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> uploadFile = jsonDecode(response.body);
      return UploadFile.fromJson(uploadFile);
    } else {
      throw (Exception('Can not load last xml file info.'));
    }
  }
}
