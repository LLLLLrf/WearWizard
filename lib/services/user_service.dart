import 'dart:async';
import 'dart:convert';

import 'package:flutter/cupertino.dart';
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
    if (json['code'] == 20000 &&
        json['msg'] is String &&
        json['desc'] is String) {
      return User();
    } else {
      throw Exception('Failed to sign up user for API structure error');
    }
  }

  factory User.login(Map<String, dynamic> json) {
    if (json['code'] == 20000 && json['data'] is Map<String, dynamic>) {
      var data = json['data'];
      return User(
        userId: data['uid'],
        userName: data['username'],
        phoneNumber: data['phoneNum'] ?? '',
        email: data['email'],
        birthday: data['birthday'] ?? '',
        gender: data['gender'] ?? 0,
        selfIntroduction: data['selfIntro'] ?? '',
        height: (data['height']?.toDouble()) ?? 0.0,
        weight: (data['weight']?.toDouble()) ?? 0.0,
        avatar: data['avatar'] ?? '',
        preference: data['preference'] ?? 0,
        imagePost: data['imgPost'] ?? '',
        createdAt: data['createdAt'] ?? '',
        updatedAt: data['updatedAt'] ?? '',
        deleted: data['deleted'] ?? 0,
        permission: data['permission'],
      );
    } else {
      throw Exception('Failed to login user for API structure error');
    }
  }
  

  Future<User> signUp(String userName, String email, String password,
      String verifyPassword) async {
    final response = await ApiService.post('user/register', body: {
      'userEmail': email,
      'userName': userName,
      'userPassword': password,
      'verifyPassword': verifyPassword
    });

    if (response.statusCode == 200) {
      debugPrint('12345');
      return User.signUp(jsonDecode(response.body));
    } else {
      throw Exception('Failed to sign up user');
    }
  }

  Future<User> login(String email, String password) async {
    final response = await ApiService.post('user/login', body: {
      'userEmail': email,
      'userPassword': password
    });
    if (response.statusCode == 200) {
      // return User.signUp(jsonDecode(response.body));
      return User.login(jsonDecode(response.body));
    } else {      
      throw Exception('Failed to login user');
    }
  }
}
