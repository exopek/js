import 'dart:convert';
//import 'dart:ffi';
import 'dart:html';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:visu/Models/models.dart';

class Helper {
  Future<Image> loadAsset({required String assetPath}) async {
    ByteData assetBundle = await rootBundle.load(assetPath);
    print('assetBundle');
    print(assetBundle);
    Image image = Image.memory(assetBundle.buffer.asUint8List());
    return image;
  }

  Future<UploadFile> loadLastUploadXml() async {
    Uri uri = Uri.parse('controller/api/upload.php');
    Response response = await get(uri);
    if (response.statusCode == 200) {
      Map<String, dynamic> uploadFile = jsonDecode(response.body);
      return UploadFile.fromJson(uploadFile);
    } else {
      throw (Exception('Can not load last xml file info.'));
    }
  }

  Future<bool> uploadXml({required PlatformFile file}) async {
    Uri uri = Uri.parse('controller/api/upload.php');
    List<int> bytes = file.bytes!; // Uint8List to List<int>
    String base64 = base64Encode(bytes);
    Response response = await post(uri, body: {'file': base64});
    if (response.statusCode == 200) {
      //var responseData = await response.stream.toBytes();
      //var responseToString = String.fromCharCodes(responseData);
      //var jsonBody = jsonDecode(responseToString);
      //print(jsonBody);

      /// Get echo from request back
      //String echo = await response.stream.bytesToString();
      //print(echo);
      return true;
    } else {
      throw (Exception('Can not upload xml file.'));
    }
  }
}
