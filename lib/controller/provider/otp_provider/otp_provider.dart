import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OtpProvider extends ChangeNotifier {
  final otpController = TextEditingController();

  Future<void> checckOtp() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool('otpStatus', false);
    final otp = prefs.get('otp');

    if (otpController.text == otp) {
      prefs.setBool('otpStatus', true);
    } else {
      prefs.setBool('otpStatus', false);
    }
  }
}
