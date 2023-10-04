import 'dart:async';

import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorinryu/model/chat_websocket_model/chat_websocket_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

late WebSocketChannel channel;
StreamController<MessageWeb> messageStreamController = StreamController<MessageWeb>.broadcast();

class ChatWebsocketProvider extends ChangeNotifier {
  bool isListening =
      false; // Add a flag to track whether the listener is active

  Future<void> chatWebInitializer() async {
    if (!isListening) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      final accessKey = prefs.getString('accessKey');

      channel = WebSocketChannel.connect(
        Uri.parse('ws://13.233.11.227/ws/messages/?token=$accessKey'),
      );

      // Add a listener to the WebSocket channel only if it's not already listening
      channel.stream.listen((dynamic data) {
        // Parse the incoming data and convert it to MessageWeb objects
        final message = MessageWeb.fromJson(data);
        messageStreamController.add(message); // Add the message to the stream
      });

      isListening =
          true; // Set the flag to indicate that the listener is active
    }
  }
}
