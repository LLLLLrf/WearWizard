import 'dart:async';
import 'dart:convert';

import 'package:wearwizard/services/api_http.dart';

class User {
  User({
    userId,
    userName,
    phoneNumber,
    email,
    birthday,
    gender,
    selfIntroduction,
    height,
    weight,
    avatar,
    preference,
    imagePost,
    createdAt,
    updatedAt,
    deleted,
    permission,
  });

  factory User.signUp(Map<String, dynamic> json) {
    switch (json) {
      case {
          'code': 0,
          'data': int,
          'message': String,
          'desc': String,
        }:
        return User();
      default:
        throw Exception('Failed to sign up user for api structure error');
    }
  }

  factory User.login(Map<String, dynamic> json) {
    switch (json) {
      case {
          'code': 0,
          'data': {
            'uid': int,
            'username': String,
            'passwd': String,
            'phoneNum': String,
            'email': String,
            'birthday': String,
            'gender': int,
            'selfIntro': String,
            'height': double,
            'weight': double,
            'avatar': String,
            'preference': int,
            'imgPost': String,
            'createdAt': String,
            'updatedAt': String,
            'deleted': int,
            'permission': int,
          },
          'message': String,
          'desc': String,
        }:
        return User(
          userId: json['data']['uid'],
          userName: json['data']['username'],
          phoneNumber: json['data']['phoneNum'],
          email: json['data']['email'],
          birthday: json['data']['birthday'],
          gender: json['data']['gender'],
          selfIntroduction: json['data']['selfIntro'],
          height: json['data']['height'],
          weight: json['data']['weight'],
          avatar: json['data']['avatar'],
          preference: json['data']['preference'],
          imagePost: json['data']['imgPost'],
          createdAt: json['data']['createdAt'],
          updatedAt: json['data']['updatedAt'],
          deleted: json['data']['deleted'],
          permission: json['data']['permission'],
        );
      default:
        throw Exception('Failed to login user for api structure error');
    }
  }

  Future<User> signUp(String userName, String email, String password,
      String verifyPassword) async {
    final response = await ApiService.post('user/register', body: {
      'userName': userName,
      'email': email,
      'password': password,
      'verifyPassword': verifyPassword
    });

    if (response.statusCode == 200) {
      return User.signUp(jsonDecode(response.body));
    } else {
      throw Exception('Failed to sign up user');
    }
  }

  Future<User> login(String email, String password) async {
    final response = await ApiService.post('user/login', body: {
      'email': email,
      'password': password,
    });

    if (response.statusCode == 200) {
      return User.signUp(jsonDecode(response.body));
    } else {
      throw Exception('Failed to login user');
    }
  }
}
