import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
// import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorinryu/controller/api/get_new_accesskey.dart';
import 'package:shorinryu/model/chat_model/chat_model.dart';
import 'package:shorinryu/model/core/base_url/base_url.dart';

class MessageProvider extends ChangeNotifier {
  final TextEditingController chattextEditingController =
      TextEditingController();
  final TextEditingController userChattextEditingController =
      TextEditingController();

  Future<void> postData(String receiverId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString('userId');
    Map<String, dynamic> data = {
      'text': chattextEditingController.text.toString(),
      'type': 'text',
      'sender': userId,
      'receiver': receiverId,
    };

    final accessKey = prefs.getString('accessKey');
    String url = '$baseUrl/sockets/message/';
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
        print('POST request successful');
        print('Response data: ${response.body}');
        // You may want to update the local message list here
      } else {
        // Request failed
        print('POST request failed with status: ${response.statusCode}');
        print('Response data: ${response.body}');
      }
    } catch (e) {
      // An error occurred
      print('Error sending POST request: $e');
    }
  }

  List<MessageChat> chatmessagess = [];
  Future<List<MessageChat>> fetchNotification() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    final accessKey = prefs.getString('accessKey');

    final response = await http.get(
      Uri.parse('$baseUrl/sockets/message/'),
      headers: {
        'Authorization': 'Bearer $accessKey',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonData = json.decode(response.body);
      chatmessagess =
          jsonData.map((item) => MessageChat.fromJson(item)).toList();
      print(chatmessagess);
      notifyListeners();
      return chatmessagess;
    } else {
      getNewAccessKey();
      fetchNotification();
      notifyListeners();

      throw Exception('Failed to load MESSAGE requests');
    }
  }
}
