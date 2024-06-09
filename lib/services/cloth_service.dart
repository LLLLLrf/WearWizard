import 'dart:async';
import 'dart:convert';

import 'package:wearwizard/services/api_http.dart';
import 'package:wearwizard/services/file_service.dart';

enum Season { spring, summer, autumn, winter }

enum Style { casual, formal, sporty, elegant }

enum CategoryType { base, bottom, outerwear, accessories }

Map<CategoryType, String> categoryMap = {
  CategoryType.base: 'base',
  CategoryType.bottom: 'bottom',
  CategoryType.outerwear: 'outerwear',
  CategoryType.accessories: 'accessories',
};

class Cloth {
  String picture;
  Cloth({
    id,
    this.picture = '',
    note,
    category,
    season,
    colorType,
    style,
  });

  factory Cloth.add(Map<String, dynamic> json) {
    if (json['code'] == 20000 &&
        json['msg'] is String &&
        json['desc'] is String) {
      return Cloth();
    } else if (json['msg'] is String && json['desc'] is String) {
      throw Exception(json['msg'] + ' Description: ' + json['desc']);
    } else {
      throw Exception('Failed to add cloth for API structure error');
    }
  }

  Future<Cloth> add(String picture, String note, String category, Season season,
      String colorType, Style style) async {
    File file = File(filename: '');
    file = await file.upload('clothes_img', picture);
    final response = await ApiService.post('clothes/add', body: {
      'pic': file.filename,
      'note': note,
      'category': category,
      'season': season.index,
      'colorType': colorType,
      'style': style.index,
    });

    if (response.statusCode == 200) {
      return Cloth.add(jsonDecode(response.body));
    } else {
      throw Exception('Failed to add cloth for API error');
    }
  }

  Future<List<Cloth>> getClothesByCategory(
      CategoryType category, int page, int pageSize) async {
    final response = await ApiService.get(
        'clothes/getByCategory?category=${categoryMap[category]}&page=$page&pageSize=$pageSize');

    if (response.statusCode == 200) {
      var json = jsonDecode(response.body);
      try {
        List<Cloth> clothes = [];
        for (var item in json['data']) {
          clothes.add(Cloth(
            picture: item,
          ));
        }
        return clothes;
      } catch (e) {
        throw Exception('Failed to get clothes for API structure error');
      }
    } else {
      throw Exception('Failed to get clothes for API error');
    }
  }
}
