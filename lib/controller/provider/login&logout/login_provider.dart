import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorinryu/model/core/base_url/base_url.dart';

class LoginProvier extends ChangeNotifier {
  final loginKey = GlobalKey<FormState>();
  TextEditingController loginEmailController = TextEditingController();
  TextEditingController loginPasswordController = TextEditingController();
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  void _setIsLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> loginUser(Map<String, dynamic> loginData, context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    const String apiUrl = '$baseUrl/user/login/';

    final jsonData = json.encode(loginData);

    try {
      // Send POST request to login the user
      final response =
          await http.post(Uri.parse(apiUrl), body: jsonData, headers: {
        'Content-Type': 'application/json',
      });
      prefs.setBool("isSuperUserlogInd", false);
      prefs.setBool('isLogined', false);

      if (response.statusCode == 200) {
        await prefs.setString(
            'refreshKey', jsonDecode(response.body)['refresh']);
        await prefs.setString('accessKey', jsonDecode(response.body)['access']);
        final userData = jsonDecode(response.body)['user'];
        await prefs.setString('user', jsonEncode(userData));
        final userId = jsonDecode(response.body)['user']['id'].toString();
        await prefs.setString('userId', userId);
        final isSuperUser = jsonDecode(response.body)['user']['is_superuser'];

        if (isSuperUser == true) {
          prefs.setBool("isSuperUserlogInd", true);
        } else {
          prefs.setBool('isLogined', true);
          prefs.setBool('isUserLogined', true);
        }

        notifyListeners();
        return true;
      } else {
        notifyListeners();
        return false;
      }
    } catch (e) {
      notifyListeners();
      return false;
    }
  }
  Future<void> loginSubmitForm(context) async {
    _setIsLoading(true);
    String email = loginEmailController.text;
    String password = loginPasswordController.text;
    Map<String, dynamic> data = {'email': email, 'password': password};
    _setIsLoading(false);
    await loginUser(data, context);
  }
}
