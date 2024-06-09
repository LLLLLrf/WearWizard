import 'dart:async';
import 'dart:convert';
import 'package:wearwizard/services/api_http.dart';

class socialStatistics {
  int? moment_num;
  int? follow_num;
  int? follower_num;

  socialStatistics({
    this.moment_num,
    this.follow_num,
    this.follower_num,
  });

  factory socialStatistics.getsocialStatistics(Map<String, dynamic> json) {
    if (json['code'] == 20000 && json['data'] is Map<String, dynamic>) {
      var data = json['data'];
      return socialStatistics(
        moment_num: data['momentCnt'],
        follow_num: data['followedCnt'],
        follower_num: data['followerCnt'],
      );
    } else {
      throw Exception('Failed to get social statistics for API structure error');
    }
  }

  Future<socialStatistics> getsocialStatistics() async {
    final response = await ApiService.get('user/socialStatistics');
    if (response.statusCode == 200) {
      return socialStatistics.getsocialStatistics(jsonDecode(response.body));
    } else {
      throw Exception('Failed to get social statistics');
    }
  }

}
