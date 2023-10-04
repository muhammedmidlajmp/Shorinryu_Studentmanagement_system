import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shorinryu/controller/api/get_new_accesskey.dart';
import 'package:shorinryu/controller/provider/admin/admin_dilog_pro.dart';
import 'package:shorinryu/controller/provider/admin/revenue_prov/revenue_prov.dart';
import 'package:shorinryu/controller/provider/admin/revenue_provider/revenue_provider.dart';
import 'package:shorinryu/controller/provider/chat_wbsocket_provider/chat_websocket_privider.dart';
import 'package:shorinryu/view/admin/attendence/attendence_mark.dart';
import 'package:shorinryu/view/admin/chat/chat_list/chat_list.dart';
import 'package:shorinryu/view/admin/fee_updation/fee_updation.dart';
import 'package:shorinryu/view/admin/leave_request/leave_request.dart';
import 'package:shorinryu/view/admin/revenue/revenue_screen.dart';
import 'package:shorinryu/view/admin/sent_updations/sent_updations.dart';
import 'package:shorinryu/view/admin/student_details/student_list.dart';
import 'package:sizer/sizer.dart';

class AdminHomeScreen extends StatelessWidget {
  const AdminHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    getNewAccessKey();
    Provider.of<ChatWebsocketProvider>(context, listen: false)
        .chatWebInitializer();
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            title: const Text(
              'Home',
              style: TextStyle(color: Colors.yellowAccent),
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                Colors.black.withOpacity(0.7300000190734863),
                Colors.black,
                Colors.black.withOpacity(0.7300000190734863),
              ])),
            ),
            actions: [
              const Center(
                  child: Text(
                'Log Out',
                style: TextStyle(color: Colors.yellowAccent),
              )),
              IconButton(
                  onPressed: () {
                    Provider.of<AdminLogoutDilog>(context, listen: false)
                        .adminShowLogoutConformContent(context);
                  },
                  icon: const Icon(
                    Icons.logout,
                    color: Colors.yellowAccent,
                  ))
            ],
          ),
          body: Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                    'asset/img/karate-graduation-blackbelt-martial-arts.jpg',
                  )),
            ),
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
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Column(children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.task_outlined,
                            size: 55,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            'Mark Attendance',
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
                                const AdminAttendenceMarkScreen(),
                          ));
                    },
                  ),
                ),
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: GestureDetector(
                //     child: Container(
                //       width: 40.w,
                //       height: 20.h,
                //       decoration: BoxDecoration(
                //           color: Colors.white30,
                //           borderRadius: BorderRadius.circular(20)),
                //       child: const Column(children: [
                //         Padding(
                //           padding: EdgeInsets.all(8.0),
                //           child: Icon(
                //             Icons.monetization_on,
                //             size: 55,
                //           ),
                //         ),
                //         Padding(
                //           padding: EdgeInsets.all(15.0),
                //           child: Text(
                //             'Fee Updation',
                //             style: TextStyle(
                //                 fontSize: 25,
                //                 fontWeight: FontWeight.bold,
                //                 color: Colors.black),
                //             textAlign: TextAlign.center,
                //           ),
                //         )
                //       ]),
                //     ),
                //     onTap: () {
                //       Navigator.push(
                //           context,
                //           MaterialPageRoute(
                //             builder: (context) =>
                //                 const FeeUpadationStatusScreen(),
                //           ));
                //     },
                //   ),
                // ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    child: Container(
                      width: 40.w,
                      height: 20.h,
                      decoration: BoxDecoration(
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Column(children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.supervised_user_circle_sharp,
                            size: 55,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            'Student Details',
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
                              const AdminStudentListViewScreen(),
                        ),
                      );
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
                          color: Colors.white30,
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
                            'Chat With Student',
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
                      // Provider.of<ChatWebSocketProvider>(context, listen: false)
                      //     .inisialazeChatWebsocket();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AdminChatListScreen(),
                        ),
                      );
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
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Column(children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.no_accounts,
                            size: 55,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            'Leave Request',
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
                              const AdminLeaveRequestViewScreen(),
                        ),
                      );
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
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Column(children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.monetization_on_outlined,
                            size: 55,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            'Revenue',
                            style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                            textAlign: TextAlign.center,
                          ),
                        )
                      ]),
                    ),
                    onTap: () {
                      DateTime now = DateTime.now();
                      DateTime currentMonthStart =
                          DateTime(now.year, now.month, 1);
                      DateTime currentDate =
                          DateTime(now.year, now.month, now.day);

// Splitting date and time components
                      String formattedCurrentMonthStart =
                          DateFormat('yyyy-MM-dd').format(currentMonthStart);
                      String formattedCurrentDate =
                          DateFormat('yyyy-MM-dd').format(currentDate);

                      Provider.of<RevenueProvider>(context, listen: false)
                          .fetchPayment();
                      Provider.of<AdminRevenueProvider>(context, listen: false)
                          .getUserPayments(
                              formattedCurrentMonthStart, formattedCurrentDate);

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const AdminRevenueScreen(),
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
                          color: Colors.white30,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Column(children: [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.announcement,
                            size: 55,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(15.0),
                          child: Text(
                            'Sent Updation',
                            style: TextStyle(
                                fontSize: 20,
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
                            builder: (context) => AdminSentUpdationScreen(),
                          ));
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
