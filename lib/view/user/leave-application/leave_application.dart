import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shorinryu/controller/provider/user/leave_appplication_provider/leave_apply_provi.dart';
import 'package:shorinryu/controller/provider/user/user_leave_application_get.dart';
import 'package:shorinryu/model/core/colors.dart';
import 'package:sizer/sizer.dart';

class LeaveApplicationFormScreen extends StatelessWidget {
  LeaveApplicationFormScreen({super.key});

  final leavFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    // final screenHight = MediaQuery.of(context).size.height;
    final leavegetPro =
        Provider.of<UserLeaveApplycationGet>(context, listen: false);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Consumer<LeaveApplyProvider>(
          builder: (context, leaveApplyProMod, child) => Scaffold(
            backgroundColor: scaffoldBackgrundColor,
            appBar: AppBar(
              centerTitle: true,
              leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: titleTextColor,
                  )),
              backgroundColor: scaffoldBackgrundColor,
              title: const Text(
                'Leave Application',
                style: TextStyle(color: titleTextColor),
              ),
            ),
            body: ListView(scrollDirection: Axis.vertical, children: [
              Form(
                key: leavFormKey,
                child: Column(
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 47.w,
                          height: 15.h,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              controller:
                                  leaveApplyProMod.startdateInputController,
                              decoration: InputDecoration(
                                contentPadding: EdgeInsets.only(left: 10),
                                icon: Icon(Icons.date_range_rounded),
                                filled: true,
                                fillColor: Colors.white30,
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Date';
                                } else {
                                  return null;
                                }
                              },
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2101),
                                );

                                leaveApplyProMod
                                    .leveStartUpdateSelectedDate(pickedDate!);
                              },
                            ),
                          ),
                        ),
                        const Text('To',
                            style: TextStyle(color: titleTextColor)),
                        SizedBox(
                          width: 47.w,
                          height: 15.h,
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              controller:
                                  leaveApplyProMod.enddateInputController,
                              decoration: InputDecoration(
                                  contentPadding: EdgeInsets.only(left: 10),
                                  icon: const Icon(Icons.date_range_rounded),
                                  filled: true,
                                  fillColor: Colors.white30,
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(30))),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Date';
                                } else {
                                  return null;
                                }
                              },
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2101),
                                );

                                leaveApplyProMod
                                    .leveEndUpdateSelectedDate(pickedDate!);
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        shadowColor: Colors.grey,
                        child: Container(
                          height: 400,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.white54,
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: TextFormField(
                              textCapitalization: TextCapitalization.characters,
                              controller: leaveApplyProMod.leaveResonController,
                              maxLines: 20,
                              decoration: const InputDecoration(
                                  hintText: 'Reason',
                                  filled: true,
                                  fillColor: Colors.transparent,
                                  border: InputBorder.none),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Enter Reason';
                                } else {
                                  return null;
                                }
                              },
                            ),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(buttenColor)),
                      onPressed: () async {
                        SharedPreferences pref =
                            await SharedPreferences.getInstance();

                        if (leavFormKey.currentState!.validate()) {
                          // ignore: use_build_context_synchronously
                          await leaveApplyProMod.leaveSubmitForm();
                          if (pref.getBool('leaveApply') == true) {
                            // ignore: use_build_context_synchronously
                            Navigator.pop(context);
                            // ignore: use_build_context_synchronously
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.success,
                              text: "Application Submitted",
                            );
                          } else {
                            // ignore: use_build_context_synchronously
                            CoolAlert.show(
                              context: context,
                              type: CoolAlertType.error,
                              text: "Submission Fail",
                            );
                          }
                          await leaveApplyProMod.cleanSubmitData();
                          await leavegetPro.userFetchLeaveRequests();
                        }
                      },
                      child: const SizedBox(
                        width: 100,
                        height: 50,
                        child: Center(
                          child: Text('Submit'),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
