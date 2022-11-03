import 'dart:convert';

import 'package:http/http.dart';

class OpenhabServices {


  Future<dynamic> getIP() async {
    final String ip ;
    Uri uri = Uri.parse('controller/api/hello.php');
    Response res = await get(uri);
    if (res.statusCode == 200) {
      //var data = jsonDecode(res.body);
      return res.body;
    } else {
      throw 'unable to receive data.';
    }
  }


}