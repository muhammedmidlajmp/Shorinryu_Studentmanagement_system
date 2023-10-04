import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorinryu/controller/api/get_new_accesskey.dart';
import 'package:shorinryu/model/core/base_url/base_url.dart';
import 'package:shorinryu/model/user_leave_request_model/user_leave_request_model.dart';

class UserLeaveApplycationGet extends ChangeNotifier {
  Future<List<UserLeaveRequestModel>> userFetchLeaveRequests() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessKey = prefs.getString('accessKey');

    final response = await http.get(
      Uri.parse('$baseUrl/user/get_leave_applications/'),
      headers: {
        'Authorization': 'Bearer $accessKey',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      return jsonData
          .map((item) => UserLeaveRequestModel.fromJson(item))
          .toList();
    } else {
      getNewAccessKey();
      userFetchLeaveRequests();
      throw Exception('Failed to load leave requests');
    }
  }
}
