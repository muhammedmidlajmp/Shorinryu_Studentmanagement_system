import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class AdminSentUpdationScreen extends StatelessWidget {
  const AdminSentUpdationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
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
                )),
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
              ])),
            ),
          ),
          body: ListView(
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
                          borderRadius: BorderRadius.circular(30)),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: TextFormField(
                          decoration: const InputDecoration(
                              filled: true,
                              fillColor: Colors.transparent,
                              border: InputBorder.none),
                          maxLines: 19,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
                  ElevatedButton(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.red)),
                      onPressed: () {},
                      child: Text("  Sent "))
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
