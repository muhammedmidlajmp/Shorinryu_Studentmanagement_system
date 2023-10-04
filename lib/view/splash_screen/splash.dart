import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorinryu/view/login&register/login.dart';
import 'package:shorinryu/view/user/home_user/home.dart';
import 'package:sizer/sizer.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _checkLoginStatus(context);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHight = MediaQuery.of(context).size.height;
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          body: Container(
            width: screenWidth,
            height: screenHight,
            decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        'asset/img/karate-graduation-blackbelt-martial-arts.jpg'))),
            child: Stack(
              children: [
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Work Hard,\n        Fight Easy',
                      style:
                          TextStyle(color: Colors.yellowAccent, fontSize: 25),
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Lottie.asset('asset/lottie/animation_lnbq123a.json'),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  void _checkLoginStatus(BuildContext context) async {
    await Future.delayed(const Duration(milliseconds: 4000), () {});
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool isLoggedIn = prefs.getBool('isUserLogined') ?? false;

    if (isLoggedIn) {
      // If the user is logged in, navigate to the home page.
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomePageUser()),
      );
    } else {
      // If not logged in, navigate to the login page.
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => LoginPage()),
      );
    }
  }
}
