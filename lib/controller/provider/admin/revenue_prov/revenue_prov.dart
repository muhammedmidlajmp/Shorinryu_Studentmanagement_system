import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorinryu/model/calculate_revenue_model/calculate_revenue_model.dart';
import 'package:shorinryu/model/core/base_url/base_url.dart';
import 'package:http/http.dart' as http;

class AdminRevenueProvider extends ChangeNotifier {
  final TextEditingController _fromLeavedateInputController =
      TextEditingController();
  TextEditingController get fromdateInputController =>
      _fromLeavedateInputController;

  final TextEditingController _toLeavedateInputController =
      TextEditingController();
  TextEditingController get todateInputController =>
      _toLeavedateInputController;

  String _fromselectedDate = "";

  fromRevenueDateInputProvider() {
    _fromLeavedateInputController.text = _fromselectedDate;
  }

  String get fromselectedDate => _fromselectedDate;

  void fromRevenueUpdateSelectedDate(DateTime pickedDate) {
    // ignore: unnecessary_null_comparison
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      _fromselectedDate = formattedDate;
    } else {
      _fromselectedDate = "Date is not selected";
    }
    _fromLeavedateInputController.text = _fromselectedDate;
    notifyListeners();
  }

  String _toselectedDate = "";

  toRevenueDateInputProvider() {
    _toLeavedateInputController.text = _toselectedDate;
  }

  String get toselectedDate => _toselectedDate;

  void toRevenueUpdateSelectedDate(DateTime pickedDate) {
    // ignore: unnecessary_null_comparison
    if (pickedDate != null) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
      _toselectedDate = formattedDate;
    } else {
      _toselectedDate = "Date is not selected";
    }
    _toLeavedateInputController.text = _toselectedDate;
    notifyListeners();
  }

 Future<RevenueData> getUserPayments(String startDate, String endDate) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessKey = prefs.getString('accessKey');

    final Map<String, dynamic> requestData = {
      'start_date': startDate,
      'end_date': endDate,
    };
    final Uri uri = Uri.parse('$baseUrl/user/payment/calculate_revenue/')
        .replace(queryParameters: requestData);
    try {
      final response = await http.get(
        uri,
        headers: {
          'Authorization': 'Bearer $accessKey',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);

        print('Response Body: $jsonData');
        return RevenueData.fromJson(jsonData);
      } else {
        print('Request failed with status: ${response.statusCode}');
      }
    } catch (error) {
      print('Error: $error');
    }
    return RevenueData(totalRevenue: 0);
  }

}
