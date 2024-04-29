import 'dart:convert';

import 'package:http/http.dart' as http;
import '../../core/constants/endpoints.dart';

class NetworkHelper {
  static Future<http.Response> post(
      {bool login = false,
        required String endPoint,
        required dynamic body}) async {
    String url = baseUrl + endPoint;
    Uri uri = Uri.parse(url);
    String? token;


    var res = await http.post(uri, body: json.encode(body), headers: {
      if (!login) "Authorization": "bearer $token",
      "Content-Type": "application/json"
    });
    return res;
  }

  static Future<http.Response> put(
      {bool login = false,
        required String endPoint,
        required dynamic body}) async {
    String url = baseUrl + endPoint;
    Uri uri = Uri.parse(url);
    String? token;

    var res = await http.put(uri, body: json.encode(body));
    return res;
  }

  static Future<http.Response> get({required String endPoint}) async {
    String url = baseUrl + endPoint;
     Uri uri = Uri.parse(url);
    var res = await http.get(
      uri,

    );
    return res;
  }
}