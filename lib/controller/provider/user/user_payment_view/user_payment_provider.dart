import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorinryu/controller/api/get_new_accesskey.dart';
import 'package:shorinryu/model/core/base_url/base_url.dart';
import 'package:shorinryu/model/payment_model/payment_model.dart';
import 'package:http/http.dart' as http;

class UserFeesUpdationProvider extends ChangeNotifier {
  List<Payment> revenue = [];
  Future<List<Payment>> fetchPayment() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessKey = prefs.getString('accessKey');

    final response = await http.get(
      Uri.parse('$baseUrl/user/payment/user_payments/'),
      headers: {
        'Authorization': 'Bearer $accessKey',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      revenue = jsonData.map((item) => Payment.fromJson(item)).toList();
      notifyListeners();
      return revenue;
    } else {
      getNewAccessKey();
      fetchPayment();
      throw Exception('Failed to load leave requests');
    }
  }
}
