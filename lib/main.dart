import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shorinryu/controller/provider/admin/admin_dilog_pro.dart';
import 'package:shorinryu/controller/provider/admin/atendance_provider/attandence_prov.dart';
import 'package:shorinryu/controller/provider/admin/leave_rqst_get_provdr/leave_request_get_pro.dart';
import 'package:shorinryu/controller/provider/admin/revenue_prov/revenue_prov.dart';
import 'package:shorinryu/controller/provider/admin/revenue_provider/revenue_provider.dart';
import 'package:shorinryu/controller/provider/admin/user_get_details/user_details_get_prov.dart';
import 'package:shorinryu/controller/provider/admin/web_socket/notification_provider.dart';
import 'package:shorinryu/controller/provider/chat_wbsocket_provider/chat_websocket_privider.dart';
import 'package:shorinryu/controller/provider/login&logout/login_provider.dart';
import 'package:shorinryu/controller/provider/login&logout/logout_prov.dart';
import 'package:shorinryu/controller/provider/register/register_provider.dart';
import 'package:shorinryu/controller/provider/user/attandance_get_provider/attandance_get_provider.dart';
import 'package:shorinryu/controller/provider/user/leave_appplication_provider/leave_apply_provi.dart';
import 'package:shorinryu/controller/provider/user/payment_provider/payment_provider.dart';
import 'package:shorinryu/controller/provider/user/user_leave_application_get.dart';
import 'package:shorinryu/controller/provider/user/user_payment_view/user_payment_provider.dart';
import 'package:shorinryu/controller/provider/user/user_profile_update/register_function_prov.dart';
import 'package:shorinryu/view/splash_screen/splash.dart';
import 'controller/provider/admin/chat_provider/chat_provider.dart';
// import 'package:shorinryu/splash_screen/splash.dart';

void main(List<String> args) {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => RegisterDetailsForm()),
        ChangeNotifierProvider(create: (context) => LeaveApplyProvider()),
        ChangeNotifierProvider(create: (context) => AdminRevenueProvider()),
        ChangeNotifierProvider(create: (context) => UserLeaveApplycationGet()),
        ChangeNotifierProvider(create: (context) => AdminLogoutDilog()),
        ChangeNotifierProvider(create: (context) => LeaveRequestGetProvider()),
        ChangeNotifierProvider(
            create: (context) =>
                UserGetProvider()), // Create UserGetProvider first
        ChangeNotifierProvider(
            create: (context) => AttandenceState(UserGetProvider())),
        ChangeNotifierProvider(create: (context) => WebsocketProvider()),
        ChangeNotifierProvider(create: (context) => RegisterProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvier()),
        ChangeNotifierProvider(create: (context) => LogOutProvider()),
        ChangeNotifierProvider(create: (context) => MessageProvider()),
        ChangeNotifierProvider(create: (context) => AttandanceGetProvider()),
        ChangeNotifierProvider(create: (context) => PaymentProvider()),
        ChangeNotifierProvider(create: (context) => RevenueProvider()),
        ChangeNotifierProvider(create: (context) => ChatWebsocketProvider()),
        ChangeNotifierProvider(create: (context) => UserFeesUpdationProvider()),


      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        home: SplashScreen(),
      ),
    );
  }
}
