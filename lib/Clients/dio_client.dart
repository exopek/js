import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:xml/xml.dart';

class DioClient {
  final Dio _dio = Dio();
  final CookieJar _cookieJar = CookieJar();
  /// Methods
  Future<XmlDocument> getPchk() async {
    _dio.interceptors.add(CookieManager(_cookieJar));
    Response response = await _dio.get('lcnpchk.xml');
    XmlDocument pchk_config = response.data;
    return pchk_config;
  }



}