import 'dart:convert';
//import 'dart:ffi';
import 'dart:html';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart';
import 'package:visu/Models/models.dart';
import 'package:visu/Routes/routes.dart';

class Helper {
  Future<Image> loadAsset({required String assetPath}) async {
    ByteData assetBundle = await rootBundle.load(assetPath);
    print('assetBundle');
    print(assetBundle);
    Image image = Image.memory(assetBundle.buffer.asUint8List());
    return image;
  }

  Future<UploadFile> loadLastUploadXml() async {
    Uri uri = Uri.parse(EndPoints().getEndpoints()['UPLOAD_FILE']);
    Response response = await get(uri);
    if (response.statusCode == 200) {
      print(response.body);
      Map<String, dynamic> uploadFile = jsonDecode(response.body);
      return UploadFile.fromJson(uploadFile);
    } else {
      throw (Exception('Can not load last xml file info.'));
    }
  }

  Future<ParserResponse> uploadXml({required PlatformFile file}) async {
    Uri uri = Uri.parse(EndPoints().getEndpoints()['UPLOAD_FILE']);
    if (file.bytes!.isEmpty) {
      return ParserResponse(false, 'File is empty.', '', '', '');
    }
    List<int> bytes = file.bytes!; // Uint8List to List<int>
    String base64 = base64Encode(bytes);
    Response response = await post(uri, body: {'file': base64});
    if (response.statusCode == 200) {
      Map<String, dynamic> parserRespopnse = jsonDecode(response.body);
      return ParserResponse.fromJson(parserRespopnse);
    } else {
      throw (Exception('Can not upload xml file.'));
    }
  }
}
