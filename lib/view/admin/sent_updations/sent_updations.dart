import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shorinryu/controller/provider/admin/web_socket/web_socket_provider.dart';
// import 'package:shorinryu/controller/provider/websocket_api/websocket_api.dart';
import 'package:sizer/sizer.dart';

// Make sure to import this

class AdminSentUpdationScreen extends StatelessWidget {
  const AdminSentUpdationScreen({Key? key})
      : super(key: key); // Fixed the super constructor

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.yellowAccent,
          ),
        ),
        title: const Text(
          'Sent Daily Updation',
          style: TextStyle(color: Colors.yellowAccent),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              Colors.black.withOpacity(0.7300000190734863),
              Colors.black,
              Colors.black.withOpacity(0.7300000190734863),
            ]),
          ),
        ),
      ),
      body: Consumer<WebsocketProvider>(
        builder: (context, webSocketProvider, child) {
          return ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 50.h,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 221, 209, 209),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          controller: webSocketProvider.notificationController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            border: InputBorder.none,
                          ),
                          maxLines: 19,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                 ElevatedButton(
                    onPressed: () {
                      if (webSocketProvider.notificationController.text.isNotEmpty) {
                        webSocketProvider.webSocketSentMessage();
                        webSocketProvider.notificationController.clear();
                      }
                    },
                    child: Text("Send"),
                  ),
                 
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}