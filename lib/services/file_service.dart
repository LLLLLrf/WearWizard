import 'dart:async';
import 'dart:convert';

import 'package:wearwizard/services/api_http.dart';
import 'package:http/http.dart' as http;

const previewHostname = 'https://ww-1301781137.cos.ap-guangzhou.myqcloud.com';

class File {
  final String filename;
  File({
    required this.filename,
  });

  factory File.upload(Map<String, dynamic> json) {
    if (json['code'] == 20000 &&
        json['msg'] == "ok" &&
        json['desc'] is String) {
      return File(filename: previewHostname + json['data']);
    } else if (json['msg'] is String && json['desc'] is String) {
      throw Exception(json['msg'] + ' Description: ' + json['desc']);
    } else {
      throw Exception('Failed to upload file for API structure error');
    }
  }

  Future<File> upload(String biz, String file) async {
    final response = await ApiService.postFile('file/upload',
        body: {'biz': biz}, file: {'file': file});

    if (response.statusCode == 200) {
      return File.upload(jsonDecode(response.body));
    } else {
      throw Exception('Failed to upload file');
    }
  }
}
