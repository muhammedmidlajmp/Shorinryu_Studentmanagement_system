import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shorinryu/controller/provider/login&logout/logout_prov.dart';
import 'package:sizer/sizer.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: 70.w,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60)),
      child: SafeArea(
        child: Container(
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(20)),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // const CircleAvatar(
              //   radius: 70,
              // ),
              // const SizedBox(
              //   height: 15,
              // ),
              // const Text('User Name'),
              // const SizedBox(
              //   height: 10,
              // ),
              // ElevatedButton(
              //   onPressed: () {},
              //   child: const Text('    Edit Profile   '),
              // ),
              SizedBox(
                height: 100,
              ),
              const Card(
                child: ListTile(
                  leading: Icon(Icons.settings),
                  title: Text('Settings'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
              const Card(
                child: ListTile(
                  leading: Icon(Icons.share),
                  title: Text('Share'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
              Card(
                child: ListTile(
                  leading: const Icon(Icons.logout_rounded),
                  title: const Text('Log Out'),
                  trailing: const Icon(Icons.arrow_forward_ios),
                  onTap: () {
                    showLogoutConformContent(context);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showLogoutConformContent(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              SizedBox(
                height: 150,
                child: Stack(
                  children: [
                    const Align(
                        alignment: Alignment.topCenter,
                        child: Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: Text(
                            'Log out of your account?',
                            style: TextStyle(
                                fontSize: 19, fontWeight: FontWeight.bold),
                          ),
                        )),
                    Align(
                      alignment: Alignment.bottomLeft,
                      child: TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                            style: TextStyle(color: Colors.black),
                          )),
                    ),
                    Align(
                      alignment: Alignment.bottomRight,
                      child: TextButton(
                          onPressed: () {
                            Provider.of<LogOutProvider>(context, listen: false)
                                .logOut(context);
                          },
                          child: const Text(
                            'Log Out',
                            style: TextStyle(color: Colors.red),
                          )),
                    ),
                  ],
                ),
              )
            ],
          );
        });
  }
}
