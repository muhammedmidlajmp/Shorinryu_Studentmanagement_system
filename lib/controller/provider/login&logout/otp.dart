import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorinryu/controller/provider/otp_provider/otp_provider.dart';
import 'package:shorinryu/model/core/colors.dart';
import 'package:shorinryu/view/user/home_user/home.dart';
import 'package:sizer/sizer.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<OtpProvider>(
      builder: (context, otpProviderModel, child) => Sizer(
        builder: (context, orientation, deviceType) {
          return Scaffold(
            backgroundColor: scaffoldBackgrundColor,
            body: SafeArea(
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: SizedBox(
                        width: 90.w,
                        height: 30.h,
                        child: Lottie.asset('asset/lottie/otp_lottie.json')),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: Pinput(
                      controller: otpProviderModel.otpController,
                      length: 6,
                      defaultPinTheme: PinTheme(
                        width: 10.w,
                        height: 7.h,
                        textStyle:const TextStyle(
                          fontSize: 22,
                          color: titleTextColor,
                        ),
                        decoration: BoxDecoration(
                            color: Colors.blue.shade100,
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.transparent)),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 70),
                    child: Align(
                        alignment: Alignment.bottomCenter,
                        child: ElevatedButton(
                            onPressed: () async {
                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              otpProviderModel.checckOtp();
                              if (prefs.getBool('otpStatus') == true) {
                                // ignore: use_build_context_synchronously
                                Navigator.pushAndRemoveUntil(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const HomePageUser(),
                                    ),
                                    (route) => false);
                                // ignore: use_build_context_synchronously
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.success,
                                  text: "Verification Success",
                                );
                              } else {
                                // ignore: use_build_context_synchronously
                                CoolAlert.show(
                                  context: context,
                                  type: CoolAlertType.error,
                                  text: "Otp Not Match ",
                                );
                              }
                            },
                            child: const Text('Submit'))),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
