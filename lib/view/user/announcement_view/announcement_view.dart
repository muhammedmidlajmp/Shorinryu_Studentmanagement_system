import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shorinryu/controller/provider/admin/web_socket/notification_provider.dart';
import 'package:shorinryu/model/notification_model/notification_get_model.dart';
import 'package:sizer/sizer.dart';

class AnnouncementViewScreen extends StatelessWidget {
  const AnnouncementViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final websocketPro = Provider.of<WebsocketProvider>(context);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Consumer<WebsocketProvider>(
          builder: (context, webSocketProvider, child) => Scaffold(
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.yellowAccent,
                  )),
              backgroundColor: Colors.black.withOpacity(0.7300000190734863),
              title: const Text(
                'Updations',
                style: TextStyle(color: Colors.yellowAccent),
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      'asset/img/karate-graduation-blackbelt-martial-arts.jpg'),
                ),
              ),
              child: FutureBuilder<List<Message>>(
                future: websocketPro.fetchNotification(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else {
                    List announcementList = snapshot.data!;

                    return ListView.builder(
                      itemCount: announcementList.length,
                      itemBuilder: (context, index) {
                        announcementList = announcementList.reversed.toList();

                        final Message request = announcementList[index];

                        final date = websocketPro.calculateTimeDifference(
                            DateTime.parse(request.createdAt));
                        return Card(
                          child: ListTile(
                            leading: Text(date.toString()),
                            title: Text(request.contentMessage.toString()),
                            // subtitle: Text(
                            //     'Start: ${request.start} \n End: ${request.end}'),
                            trailing: Text(
                              '',
                              style: TextStyle(),
                            ),
                            onTap: () {
                              showAnnouncementContent(
                                  context, request.contentMessage.toString());
                            },
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ),
        );
      },
    );
  }

  void showAnnouncementContent(context, String content) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [Center(child: Text(content))],
          );
        });
  }
}
