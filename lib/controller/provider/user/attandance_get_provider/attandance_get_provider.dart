import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorinryu/model/attandance_get_model/attantance_get_model.dart';
import 'package:shorinryu/model/core/base_url/base_url.dart';

class AttandanceGetProvider extends ChangeNotifier {
  final TextEditingController _starDateInputController =
      TextEditingController();
  TextEditingController get startdateInputController =>
      _starDateInputController;
  final TextEditingController _endDateInputController = TextEditingController();
  TextEditingController get endDateInputController => _endDateInputController;
  List<AttendanceRecord> attendanceRecords = [];

  int presentCount = 0;
  int absentCount = 0;

  Future<void> fetchAttendance(String startDate, String endDate) async {
    try {
      // Check if startDate or endDate is null before proceeding
      if (startDate == null || endDate == null) {
        throw Exception('Start date or end date is null');
      }

      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final accessKey = prefs.getString('accessKey');

      if (accessKey == null) {
        throw Exception('Access key not found');
      }

      final Map<String, dynamic> requestData = {
        'start_date': startDate,
        'end_date': endDate,
      };

      final Uri uri = Uri.parse('$baseUrl/user/attendance/filter/')
          .replace(queryParameters: requestData);

      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $accessKey',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        print(jsonData);
        attendanceRecords.clear();
        presentCount = 0;
        absentCount = 0;

        for (var item in jsonData) {
          final record = AttendanceRecord.fromJson(item);
          print('Parsed record: $record');
          attendanceRecords.add(record);
          if (record.isPresent) {
            presentCount++;
          } else {
            absentCount++;
          }
        }

        notifyListeners();
      } else {
        throw Exception('Failed to load attendance records');
      }
    } catch (e) {
      // Handle exceptions here, e.g., print an error message or show a dialog.
      print('Error: $e');
    }
  }

  String _startselectedDate = "";

  startDateInputProvider() {
    _starDateInputController.text = _startselectedDate;
  }

  String get startselectedDate => _startselectedDate;

  void StartUpdateSelectedDate(DateTime pickedDate) {
    // ignore: unnecessary_null_comparison
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      _startselectedDate = formattedDate;
    } else {
      _startselectedDate = "Date is not selected";
    }
    _starDateInputController.text = _startselectedDate;
    notifyListeners();
  }

  String _endselectedDate = "";

  endDateInputProvider() {
    _endDateInputController.text = _endselectedDate;
  }

  String get endselectedDate => _endselectedDate;

  void EndUpdateSelectedDate(DateTime pickedDate) {
    // ignore: unnecessary_null_comparison
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      _endselectedDate = formattedDate;
    } else {
      _endselectedDate = "Date is not selected";
    }
    _endDateInputController.text = _endselectedDate;
    notifyListeners();
  }
}
