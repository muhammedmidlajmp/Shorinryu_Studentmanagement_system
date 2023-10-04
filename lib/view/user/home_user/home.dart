import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorinryu/controller/provider/admin/web_socket/notification_provider.dart';
import 'package:shorinryu/controller/provider/chat_wbsocket_provider/chat_websocket_privider.dart';
import 'package:shorinryu/controller/provider/user/attandance_get_provider/attandance_get_provider.dart';
import 'package:shorinryu/controller/provider/user/user_payment_view/user_payment_provider.dart';
import 'package:shorinryu/view/user/announcement_view/announcement_view.dart';
import 'package:shorinryu/view/user/attendence_view/attendence_view.dart';
import 'package:shorinryu/view/user/home_user/widget/darawer.dart';
import 'package:shorinryu/view/user/leave-application/leave_request_status.dart';
import 'package:shorinryu/view/user/new_applycation/new_admission.dart';
import 'package:shorinryu/view/user/payment/payment_detail.dart';
import 'package:shorinryu/view/user/user_chat/user_chat_screen.dart';
import 'package:sizer/sizer.dart';

class HomePageUser extends StatelessWidget {
  const HomePageUser({super.key});

  @override
  Widget build(BuildContext context) {
    final chat = Provider.of<ChatWebsocketProvider>(context, listen: false);
    chat.chatWebInitializer();
    final webPro = Provider.of<WebsocketProvider>(context, listen: false);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          backgroundColor: const Color.fromARGB(255, 231, 241, 250),
          drawer: const DrawerWidget(),
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DrawerWidget(),
                      ));
                },
                icon: const Icon(
                  Icons.account_circle_outlined,
                  color: Colors.yellowAccent,
                )),
            title: const Text(
              'Home',
              style: TextStyle(color: Colors.yellowAccent),
            ),
            // toolbarHeight: 60,
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.black.withOpacity(0.7300000190734863),
                Colors.black,
                Colors.black.withOpacity(0.7300000190734863),
              ])),
            ),
          ),
          body: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: double.infinity,
                  height: 30.h,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      color: const Color.fromARGB(255, 188, 209, 225)),
                ),
              ),
              Expanded(
                child: GridView.count(
                  crossAxisCount: 2,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Container(
                          width: 40.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 188, 209, 225),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Column(children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.supervised_user_circle_sharp,
                                // color: Colors.white50,
                                size: 55,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                'New Addmission',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ]),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => NewAdmissionScreen(),
                              ));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          final SharedPreferences prefs =
                              await SharedPreferences.getInstance();
                          var id = prefs.getString('userId');
                          // ignore: use_build_context_synchronously
                          // Provider.of<MessageProvider>(context, listen: false)
                          //     .fetchNotification();
                          // print(id);

                          // ignore: use_build_context_synchronously
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    UserChatScreen(id: int.parse(id!)),
                              ));
                        },
                        child: Container(
                          width: 40.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 188, 209, 225),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Column(children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.chat,
                                size: 55,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                'Chat With Master',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ]),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Container(
                          width: 40.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 188, 209, 225),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Column(children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.no_accounts_sharp,
                                size: 55,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                'Leave Application',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ]),
                        ),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const LeaveRequestStatusScreen(),
                              ));
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        child: Container(
                          width: 40.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 188, 209, 225),
                              borderRadius: BorderRadius.circular(20)),
                          child: const Column(children: [
                            Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Icon(
                                Icons.payment,
                                size: 55,
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(15.0),
                              child: Text(
                                'Pay Fees',
                                style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black),
                                textAlign: TextAlign.center,
                              ),
                            )
                          ]),
                        ),
                        onTap: () {
                          // Splitting date and time components

                          Provider.of<UserFeesUpdationProvider>(context,
                                  listen: false)
                              .fetchPayment();
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const UserPaymentViewScreen(),
                              ));
                        },
                      ),
                    ),
                    Consumer<AttandanceGetProvider>(
                      builder: (context, value, child) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () async {
                            DateTime now = DateTime.now();
                            DateTime currentMonthStart =
                                DateTime(now.year, now.month, 1);
                            DateTime currentDate =
                                DateTime(now.year, now.month, now.day);

                            // Splitting date and time components
                            String formattedCurrentMonthStart =
                                DateFormat('yyyy-MM-dd')
                                    .format(currentMonthStart);
                            String formattedCurrentDate =
                                DateFormat('yyyy-MM-dd').format(currentDate);
                            // String formattedCurrentTime =
                            //     DateFormat('HH:mm:ss').format(now);

                            value.fetchAttendance(formattedCurrentMonthStart,
                                formattedCurrentDate);

                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const AttendenceViewScreen(),
                                ));
                          },
                          child: Container(
                            width: 40.w,
                            height: 20.h,
                            decoration: BoxDecoration(
                                color: const Color.fromARGB(255, 188, 209, 225),
                                borderRadius: BorderRadius.circular(20)),
                            child: const Column(
                              children: [
                                Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Icon(
                                    Icons.follow_the_signs_sharp,
                                    size: 55,
                                  ),
                                ),
                                Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    'Attendance',
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black),
                                    textAlign: TextAlign.center,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () async {
                          // ignore: use_build_context_synchronously
                          Provider.of<WebsocketProvider>(context, listen: false)
                              .fetchNotification();

                          // ignore: use_build_context_synchronously
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  const AnnouncementViewScreen(),
                            ),
                          );
                        },
                        child: Container(
                          width: 40.w,
                          height: 20.h,
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 188, 209, 225),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              const Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.all(8.0),
                                    child: Icon(
                                      Icons.notification_important_sharp,
                                      size: 55,
                                    ),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.all(15.0),
                                    child: Text(
                                      'Daily Updations',
                                      style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.black,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ],
                              ),
                              if (webPro.notificationCount > 0)
                                Positioned(
                                  top: 5, // Adjust the position as needed
                                  right: 5, // Adjust the position as needed
                                  child: Container(
                                    padding: const EdgeInsets.all(6),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color:
                                          Colors.red, // Badge background color
                                    ),
                                    child: Text(
                                      webPro.notificationCount.toString(),
                                      style: const TextStyle(
                                        color: Colors.black, // Badge text color
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
