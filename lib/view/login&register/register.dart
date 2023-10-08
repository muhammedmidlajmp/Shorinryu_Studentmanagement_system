import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorinryu/controller/provider/login&logout/otp.dart';
import 'package:shorinryu/controller/provider/register/register_provider.dart';
import 'package:shorinryu/view/login&register/login.dart';
import 'package:sizer/sizer.dart';
// import '../../../api/authenticate/register/register_authenticat.dart';

// ignore: must_be_immutable
class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Consumer<RegisterProvider>(
          builder: (context, rgProModel, child) => Scaffold(
            backgroundColor: const Color.fromARGB(255, 231, 241, 250),
            body: Container(
              decoration: const BoxDecoration(),
              child: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Lottie.asset('asset/lottie/register.json'),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Container(
                      width: double.infinity,
                      height: 60.h,
                      decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 213, 233, 250),
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(30),
                            topRight: Radius.circular(30)),
                      ),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Form(
                          key: rgProModel.formKey,
                          child: Column(
                            children: <Widget>[
                              const Align(
                                alignment: Alignment.topCenter,
                                child: Padding(
                                  padding: EdgeInsets.all(15.0),
                                  child: Text(
                                    'Register',
                                    style: TextStyle(
                                      color: Color.fromARGB(255, 22, 20, 141),
                                      fontWeight: FontWeight.w700,
                                      fontSize: 25,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextFormField(
                                    controller: rgProModel.userNameController,
                                    decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.only(left: 25),
                                        filled: true,
                                        fillColor: Colors.white30,
                                        hintText: 'User Name',
                                        hintStyle: const TextStyle(
                                          color: Colors.black,
                                        ),
                                        border: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(30))),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter User Name';
                                      } else {
                                        return null;
                                      }
                                    }),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextFormField(
                                  controller: rgProModel.emailController,
                                  decoration: InputDecoration(
                                    contentPadding:
                                        const EdgeInsets.only(left: 25),
                                    filled: true,
                                    fillColor: Colors.white30,
                                    hintText: 'Email',
                                    hintStyle: const TextStyle(
                                      color: Colors.black,
                                    ),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Enter Email';
                                    } else {
                                      return null;
                                    }
                                  },
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: TextFormField(
                                    obscureText: true,
                                    controller: rgProModel.passWordController,
                                    decoration: InputDecoration(
                                      contentPadding:
                                          const EdgeInsets.only(left: 25),
                                      filled: true,
                                      fillColor: Colors.white30,
                                      hintText: 'Password',
                                      hintStyle: const TextStyle(
                                        color: Colors.black,
                                      ),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter Password';
                                      } else {
                                        return null;
                                      }
                                    }),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  final SharedPreferences prefs =
                                      await SharedPreferences.getInstance();

                                  if (rgProModel.formKey.currentState!
                                      .validate()) {
                                    // ignore: use_build_context_synchronously
                                    CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.loading,
                                        text: "Loading......",
                                        autoCloseDuration:
                                            const Duration(seconds: 3));
                                    // ignore: use_build_context_synchronously
                                    await rgProModel.submitForm(context);

                                    if (prefs.getBool('isRegistered') == true) {
                                      // ignore: use_build_context_synchronously
                                      await Navigator.pushAndRemoveUntil(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const OtpScreen(),
                                        ),
                                        (route) => false,
                                      );
                                      // ignore: use_build_context_synchronously
                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.success,
                                        text: "Register Success",
                                      );
                                    } else {
                                      // ignore: use_build_context_synchronously
                                      CoolAlert.show(
                                        context: context,
                                        type: CoolAlertType.error,
                                        text: "Error",
                                      );
                                    }
                                  }
                                },
                                style: ButtonStyle(
                                  backgroundColor: MaterialStateProperty.all(
                                      Color.fromARGB(255, 22, 20, 141)),
                                ),
                                child: const Text('Register'),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  const Padding(
                                    padding: EdgeInsets.only(left: 20),
                                    child: Text(
                                      "Already have an account?",
                                      style: TextStyle(
                                          color:
                                              Color.fromARGB(255, 22, 20, 141)),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5),
                                    child: TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  const LoginPage(),
                                            ));
                                      },
                                      child: const Text('Login'),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
