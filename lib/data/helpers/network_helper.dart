// import 'dart:convert';
//
// import 'package:altadamun_coordinator/clean/core/service_locator/service_locator.dart';
// import 'package:altadamun_coordinator/util/constants/strings.dart';
// import 'package:altadamun_coordinator/util/helpers/cache_helper.dart';
// import 'package:http/http.dart' as http;
// import '../constants/endpoints.dart';
//
// class NetworkHelper {
//   static Future<http.Response> post(
//       {bool login = false,
//         required String endPoint,
//         required dynamic body}) async {
//     String url = baseUrl + endPoint;
//     Uri uri = Uri.parse(url);
//     String? token;
//
//     if (!login) {
//       token = serviceLocator<CacheHelper>().getData(key: accessTokenKey);
//     }
//     var res = await http.post(uri, body: json.encode(body), headers: {
//       if (!login) "Authorization": "bearer $token",
//       "Content-Type": "application/json"
//     });
//     return res;
//   }
//
//   static Future<http.Response> put(
//       {bool login = false,
//         required String endPoint,
//         required dynamic body}) async {
//     String url = baseUrl + endPoint;
//     Uri uri = Uri.parse(url);
//     String? token;
//
//     if (!login) {
//       token =serviceLocator<CacheHelper>().getData(key: accessTokenKey);
//     }
//     var res = await http.put(uri, body: json.encode(body), headers: {
//       if (!login) "Authorization": "bearer $token",
//       "Content-Type": "application/json"
//     });
//     return res;
//   }
//
//   static Future<http.Response> get({required String endPoint}) async {
//     String url = baseUrl + endPoint;
//     String token = serviceLocator<CacheHelper>().getData(key: accessTokenKey);
//     Uri uri = Uri.parse(url);
//     var res = await http.get(
//       uri,
//       headers: {
//         "Authorization": "bearer $token",
//         "Content-Type": "application/json"
//       },
//     );
//     return res;
//   }
// }