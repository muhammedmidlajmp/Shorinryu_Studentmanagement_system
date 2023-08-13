import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shorinryu/controller/provider/user/leave_appplication_provider/leave_apply_provi.dart';
import 'package:sizer/sizer.dart';

class LeaveApplicationFormScreen extends StatelessWidget {
  LeaveApplicationFormScreen({super.key});

  final leavFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final screenHight = MediaQuery.of(context).size.height;
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Consumer<LeaveApplyProvider>(
          builder: (context, leaveApplyProMod, child) => Scaffold(
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
                'Leave Application',
                style: TextStyle(color: Colors.yellowAccent),
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        'asset/img/karate-graduation-blackbelt-martial-arts.jpg')),
              ),
              child: ListView(scrollDirection: Axis.vertical, children: [
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
                                  hintText: 'yyyy/mm/dd',
                                  filled: true,
                                  fillColor:
                                      const Color.fromARGB(153, 189, 184, 184),
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
                              style: TextStyle(color: Colors.yellowAccent)),
                          SizedBox(
                            width: 47.w,
                            height: 15.h,
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: TextFormField(
                                controller:
                                    leaveApplyProMod.enddateInputController,
                                decoration: InputDecoration(
                                    hintText: 'yyyy/mm/dd',
                                    filled: true,
                                    fillColor: const Color.fromARGB(
                                        153, 189, 184, 184),
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
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
                        child: Container(
                          height: 400,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: const Color.fromARGB(153, 189, 184, 184),
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
                      SizedBox(
                        height: screenHight / 8,
                      ),
                      ElevatedButton(
                        style: const ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(Colors.red)),
                        onPressed: () async {
                          if (leavFormKey.currentState!.validate()) {
                            await leaveApplyProMod.leaveSubmitForm(context);
                          }
                          await leaveApplyProMod.cleanSubmitData();
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
          ),
        );
      },
    );
  }
}
