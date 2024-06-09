import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';

class ApiService {
  static const String _baseUrl = 'http://8.134.164.130:8080/api/';

  static Future<http.Response> get(String endpoint) async {
    var cookie = localStorage.getItem('cookie');
    return http.get(Uri.parse('$_baseUrl$endpoint'), headers: {
      'Content-Type': 'application/json; charset=UTF-8',
      'Cookie': cookie!,
    });
  }

  static Future<http.Response> post(String endpoint,
      {Map<String, dynamic>? body}) async {
    var cookie = localStorage.getItem('cookie');
    return http.post(
      Uri.parse('$_baseUrl$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Cookie': cookie!,
      },
      body: body != null ? jsonEncode(body) : null,
    );
  }

  static Future<http.Response> postFile(String endpoint,
      {Map<String, dynamic>? body, Map<String, dynamic>? file}) async {
    var request =
        http.MultipartRequest('POST', Uri.parse('$_baseUrl$endpoint'));
    var cookie = localStorage.getItem('cookie');
    request.headers['Cookie'] = cookie!;

    if (body != null) {
      body.forEach((key, value) {
        request.fields[key] = value;
      });
    }

    if (file != null) {
      file.forEach((key, value) async {
        request.files.add(await http.MultipartFile.fromPath(key, value));
      });
    }

    return http.Response.fromStream(await request.send());
  }
}
