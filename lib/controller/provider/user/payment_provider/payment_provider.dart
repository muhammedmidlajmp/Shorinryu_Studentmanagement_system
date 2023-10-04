import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorinryu/controller/api/get_new_accesskey.dart';
import 'package:shorinryu/model/core/base_url/base_url.dart';
import 'package:http/http.dart' as http;

class PaymentProvider extends ChangeNotifier {
  TextEditingController paymentTextController = TextEditingController();

  Future<void> postData(String paymentID, String currentDate) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    Map<String, dynamic> data = {
      'amount': paymentTextController.text,
      'payment_id': paymentID,
      'payment_date': currentDate,
    };

    final accessKey = prefs.getString('accessKey');
    String url = '$baseUrl/user/payment/';
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $accessKey',
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // Request was successful
        paymentTextController.clear();

        print('POST request successful');
        print('Response data: ${response.body}');
      } else {
        // Request failed
        print('POST request failed with status: ${response.statusCode}');
        print('Response data: ${response.body}');
      }
    } catch (e) {
      getNewAccessKey();
      postData(paymentID, currentDate);

      // An error occurred
      print('Error sending POST request: $e');
    }
  }
}
