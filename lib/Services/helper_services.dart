import 'dart:convert';
import 'dart:html';

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
      return  UploadFile.fromJson(uploadFile);
    } else {
      throw(Exception('Can not load last xml file info.'));
    }
  }


}