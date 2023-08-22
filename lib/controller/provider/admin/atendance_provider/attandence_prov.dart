import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorinryu/controller/provider/admin/user_get_details/user_details_get_prov.dart';
import 'package:shorinryu/model/core/base_url/base_url.dart';
import 'dart:convert';
import 'package:shorinryu/view/admin/attendence/attendence_mark.dart';

class AttandenceState extends ChangeNotifier {
  final List<Map<String, dynamic>> _attendanceDataList = [];
  List<CheckboxState> _users = [];

  List<Map<String, dynamic>> get attendanceDataList => _attendanceDataList;

  void addAttendanceData(Map<String, dynamic> attendanceData) {
    _attendanceDataList.add(attendanceData);
  }

  // Pass the user provider instance to the constructor
  AttandenceState(UserGetProvider userProvider) {
    final numberOfUsers = userProvider.users.length;
    _users = List.generate(1000, (_) => CheckboxState());
  }

  List<CheckboxState> get users => _users;
  void updateValue(int index, bool newValue) {
    _users[index].value = newValue;
    notifyListeners();
  }

  void removeAttendanceData(int userId) {
    _attendanceDataList.removeWhere((data) => data['user_id'] == userId);
    notifyListeners();
  }

  Future<void> postAttendanceData(
      List<Map<String, dynamic>> attendanceDataList) async {
    final SharedPreferences prfrc = await SharedPreferences.getInstance();
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final accessKey = prefs.getString('accessKey');
      prfrc.setBool('isAttantanceMark', false);

      final response = await http.post(
        Uri.parse('$baseUrl/user/attendance/mark_attendance_bulk/'),
        body: jsonEncode({
          'attendance_data': attendanceDataList,
        }),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessKey',
        },
      );
      print(attendanceDataList);
      print(accessKey);

      if (response.statusCode == 200) {
        prfrc.setBool('isAttantanceMark', true);
       
        print('Attendance data posted successfully');
      } else {
        print(
            'Failed to post attendance data - Status Code: ${response.statusCode}');
      }
    } catch (error) {
      print('Error while posting attendance data: $error');
    }
  }
}
