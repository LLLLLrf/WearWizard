import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiService {
  static const String _baseUrl = 'http://127.0.0.1:8080/api/';

  static Future<http.Response> get(String endpoint) async {
    return http.get(Uri.parse('$_baseUrl$endpoint'));
  }

  static Future<http.Response> post(String endpoint,
      {Map<String, dynamic>? body}) async {
    return http.post(
      Uri.parse('$_baseUrl$endpoint'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: body != null ? jsonEncode(body) : null,
    );
  }
}
