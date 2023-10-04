import 'dart:io';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorinryu/controller/provider/user/user_profile_update/register_function_prov.dart';
import 'package:shorinryu/view/user/new_applycation/widget/text_form_field.dart';
import 'package:sizer/sizer.dart';

class NewAdmissionScreen extends StatelessWidget {
  NewAdmissionScreen({super.key});

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Sizer(
      builder: (context, orientation, deviceType) {
        return Consumer<RegisterDetailsForm>(
          builder: (context, admissionModelPro, child) => Scaffold(
              backgroundColor: const Color.fromARGB(255, 231, 241, 250),
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
                  'Add Details',
                  style: TextStyle(color: Colors.yellowAccent),
                ),
              ),
              body: ListView(
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      children: [
                        admissionModelPro.fileImage == null
                            ? CircleAvatar(
                                radius: screenHight * 0.10,
                                backgroundImage:
                                    const AssetImage('asset/img/PROFILE.png'),
                              )
                            : CircleAvatar(
                                backgroundImage: FileImage(
                                  File(
                                    admissionModelPro.fileImage!.path,
                                  ),
                                ),
                                radius: screenHight / 10,
                              ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.25,
                              right: screenWidth * 0.25),
                          child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.grey)),
                            onPressed: () {
                              admissionModelPro.getPhoto();
                            },
                            child: const Text('Select Image'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Container(
                            height: screenHight * 0.5,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: const Color.fromARGB(255, 188, 209, 225),
                            ),
                            child: const TextFormFieldFormUpdate(),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              left: screenWidth * 0.25,
                              right: screenWidth * 0.25),
                          child: ElevatedButton(
                            style: const ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.red)),
                            onPressed: () async {
                              SharedPreferences prefs =
                                  await SharedPreferences.getInstance();

                              if (formKey.currentState!.validate()) {
                                // ignore: use_build_context_synchronously
                                await admissionModelPro
                                    .updateFormRegister(context);
                                if (prefs.getBool('isformFilled') == true) {
                                  // ignore: use_build_context_synchronously
                                  Navigator.pop(context);

                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Success'),
                                      backgroundColor: Colors.green,
                                    ),
                                  );
                                } else {
                                  // ignore: use_build_context_synchronously
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content:
                                          Text('Faild: Check The Details '),
                                      backgroundColor: Colors.red,
                                    ),
                                  );
                                }
                              }
                              // await admissionModelPro.clearFormData();
                            },
                            child: const SizedBox(
                                width: 150,
                                height: 35,
                                child: Center(
                                    child: Text('        Submit        '))),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        );
      },
    );
  }
}
