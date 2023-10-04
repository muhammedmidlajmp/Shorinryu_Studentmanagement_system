import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorinryu/controller/api/get_new_accesskey.dart';
// import 'package:shorinryu/model/user_leave_request_model/user.dart';

Future<bool> postLeaveRequest(
    Map<String, dynamic> leaveData, String url, String accessKey) async {
  final jsonData = json.encode(leaveData);
  SharedPreferences pref = await SharedPreferences.getInstance();
  pref.setBool('leaveApply', false);

  try {
    final response = await http.post(
      Uri.parse(url),
      body: jsonData,
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $accessKey',
      },
    );
    final applicationId = jsonDecode(response.body)['id'];
    await pref.setInt('applicationId', applicationId);

    if (response.statusCode == 201) {
      pref.setBool('leaveApply', true);

      return true;
    } else {
      return false;
    }
  } catch (e) {
    getNewAccessKey();
    postLeaveRequest(leaveData, url, accessKey);
    return false;
  }
}
