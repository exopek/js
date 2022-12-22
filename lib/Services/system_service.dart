import 'dart:convert';
import 'package:visu/routes/routes.dart';
import 'package:http/http.dart';

class System {
  Future<String> reboot() async {
    Uri uri = Uri.parse(EndPoints().getEndpoints()['PCHK_CONFIG']);
    var rebootCommand = {'reboot_sw': 'true'};
    var response = await post(uri, body: rebootCommand);
    if (response.statusCode == 200) {
      Map<String, dynamic> rebootStatus = jsonDecode(response.body);
      if (rebootStatus['status'] == 'success') {
        return Future.delayed(const Duration(seconds: 200), () => 'OK');
      } else {
        return Future.delayed(const Duration(seconds: 10), () => 'Failed');
      }
    } else {
      throw (Exception('Reboot failed'));
    }
  }
}
