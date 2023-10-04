import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorinryu/model/core/base_url/base_url.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../../../../model/notification_model/notification_get_model.dart';

class WebsocketProvider extends ChangeNotifier {
  TextEditingController notificationController = TextEditingController();
  int notificationCount = 0;
  late final WebSocketChannel channel;
  List<Map<String, dynamic>> receivedMessages = [];

  Future<void> initializeWebSocket(String accessKey) async {
    try {
      final uri =
          Uri.parse('ws://13.233.11.227/ws/notifications/?token=$accessKey');
      channel = WebSocketChannel.connect(uri);
      // ignore: unused_local_variable

      // Listen to incoming messages and filter by "action"
      channel.stream.listen((data) {
        if (data is Map<String, dynamic> &&
            data['action'] == 'see_notification') {
          receivedMessages.add(data);

          notifyListeners(); // Notify listeners about new messages
        }
        if (data is Map<String, dynamic> &&
            data['action'] == 'see_notification') {
          receivedMessages.add(data);

          // Update notification count when a new notification is received
          notificationCount++;

          notifyListeners(); // Notify listeners about new messages
        }
      });
    } catch (e) {
      print('WebSocket connection error: $e');
    }
  }

  void sendDataToWebSocket() {
    // final {"action": "see_notification"} = jsonEncode({"action": "see_notification"}); // Convert the Map to a JSON string
    channel.sink.add({"action": "see_notification"});
  }

  @override
  void dispose() {
    channel.sink.close();
    notificationController.clear();
    super.dispose();
  }

  Future<bool> postNotification() async {
    final jsonData = json.encode({
      'content_message': notificationController.text.toString(),
    });
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // pref.setBool('leaveApply', false);
    final accessKey = prefs.getString('accessKey');

    try {
      final response = await http.post(
        Uri.parse('$baseUrl/sockets/notifications/'),
        body: jsonData,
        headers: {
          'Authorization': 'Bearer $accessKey',
          'Content-Type': 'application/json'
        },
      );

      if (response.statusCode == 201) {
        print('notification submitted successfully.');
        return true;
      } else {
        print('falsssssssssss');
        return false;
      }
    } catch (e) {
      print(e);
      return false;
    }
  }

  List<Message> messages = [];
  Future<List<Message>> fetchNotification() async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final accessKey = prefs.getString('accessKey');

      final response = await http.get(
        Uri.parse('$baseUrl/sockets/notification/get'),
        headers: {
          'Authorization': 'Bearer $accessKey',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body);
        messages = jsonData.map((item) => Message.fromJson(item)).toList();
        return messages;
      } else {
        throw Exception('Failed to load leave requests');
      }
    } catch (e) {
      return [];
    }
  }

  String calculateTimeDifference(DateTime createdDate) {
    final currentDate = DateTime.now();
    final timeDifference = currentDate.difference(createdDate);
    final minutesDifference =
        (timeDifference.inMilliseconds / (1000 * 60)).floor();

    if (minutesDifference < 1) {
      return "Just now";
    } else if (minutesDifference == 1) {
      return "1 minute ago";
    } else if (minutesDifference < 60) {
      return "$minutesDifference minutes ago";
    } else if (minutesDifference < 1440) {
      final hoursDifference = (minutesDifference / 60).floor();
      return "$hoursDifference hour${hoursDifference > 1 ? 's' : ''} ago";
    } else {
      final daysDifference = (minutesDifference / 1440).floor();
      return "$daysDifference day${daysDifference > 1 ? 's' : ''} ago";
    }
  }
}
