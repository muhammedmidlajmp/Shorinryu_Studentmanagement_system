import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorinryu/model/core/base_url/base_url.dart';
import 'package:http/http.dart' as http;

class RegisterProvider extends ChangeNotifier {
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passWordController = TextEditingController();
  // bool isRegisterd = false;
  // UserAuthFunctions reg = UserAuthFunctions();
  Future<void> submitForm(context) async {
    String username = userNameController.text;
    String email = emailController.text;
    String password = passWordController.text;
    Map<String, dynamic> data = {
      'name': username,
      'email': email,
      'password': password
    };

    await registerUser(data, context);
  }

  final formKey = GlobalKey<FormState>();

  Future<bool> registerUser(Map<String, dynamic> userData, context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // final id = await prefs.getString('userId');

    String apiUrl = '$baseUrl/user/register/';
    // Convert user data to JSON
    final jsonData = json.encode(userData);
    prefs.setBool('isRegistered', false);

    try {
      // Send POST request to register the user
      final response =
          await http.post(Uri.parse(apiUrl), body: jsonData, headers: {
        'Content-Type': 'application/json',
      });

      if (response.statusCode == 201) {
        prefs.setBool('isRegistered', true);
        // prefs.setBool('loggind', true);
        prefs
            .setString('refreshKey', jsonDecode(response.body)['refresh'])
            .toString();
        prefs
            .setString('accessKey', jsonDecode(response.body)['access'])
            .toString();
        final otp = prefs.setString('otp', jsonDecode(response.body)['otp']);
        final userData = jsonDecode(response.body)['user'];
        final userId = jsonDecode(response.body)['user']['id'].toString();
        // final String id = userData['id']; // Extract user ID
        await prefs.setString('userId', userId);

        await prefs.setString('user', jsonEncode(userData));
        print(otp);
        notifyListeners();
        return true;
      } else {
        prefs.setBool('isRegistered', false);
        notifyListeners();
        return false;
      }
    } catch (e) {
      prefs.setBool('isRegistered', false);
      print('An error occurred: $e');

      notifyListeners();
      return false;
    }
  }
}
