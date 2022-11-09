import 'dart:convert';

import 'package:http/http.dart';

class System {
  Future<bool> reboot() async {
    Uri uri = Uri.parse('controller/api/reboot.php');
    Response response = await get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> rebootStatus = jsonDecode(response.body);
      if (rebootStatus['status'] == true) {
        return Future.delayed(const Duration(seconds: 150), () => true);
      } else {
        return Future.delayed(const Duration(seconds: 10), () => false);
      }
    } else {
      throw (Exception('Can not load last xml file info.'));
    }
  }
}
