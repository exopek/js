import 'dart:convert';
import 'package:dart_ipify/dart_ipify.dart';
import 'package:http/http.dart';
import 'package:visu/Models/models.dart';

class Authentication {
  Future<Auth> login(String username, String password) async {
    final ipv64 = await Ipify.ipv64();
    print(ipv64);
    final String pchk_config = 'security.php';
    Uri uri = Uri.parse(pchk_config);
    Response res = await post(uri, body: {
      'user': username,
      'pass': password,
    });

    if (res.statusCode == 200) {
      print('200....................200');
      Map<String, dynamic> userMap = jsonDecode(res.body);
      var loginData = Auth.fromJson(userMap);
      print('_-_-_-_-_-');
      print(loginData.success);
      print(loginData.pass);
      return loginData;
    } else {
      throw "Unable to retrieve posts.";
    }
  }
}
