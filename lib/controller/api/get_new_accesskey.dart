import 'dart:convert';

import 'package:either_dart/either.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:shorinryu/model/core/base_url/base_url.dart';
import 'package:shorinryu/model/error/error_model.dart';


   Future<Either<ErrorModel, String>> getNewAccessKey() async {
    try {
      SharedPreferences pref = await SharedPreferences.getInstance();
      String refresh = pref.getString('refreshKey')!;
      final response = await http.post(Uri.parse('$baseUrl/user/token/'),
          body: jsonEncode({'refresh': refresh}),
          headers: {
            'Content-Type': 'application/json',
          });
      if (response.statusCode == 200) {
        String newAccessKey = jsonDecode(response.body)['access'];
        pref.setString('accessKey', newAccessKey);
        return Right(newAccessKey);
      }
      return Left(ErrorModel('session Expired'));
    } catch (e) {
      return Left(ErrorModel(e.toString()));
    }
  }

