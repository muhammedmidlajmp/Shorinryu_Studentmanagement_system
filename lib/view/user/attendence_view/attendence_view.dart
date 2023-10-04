import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shorinryu/controller/provider/user/attandance_get_provider/attandance_get_provider.dart';
import 'package:sizer/sizer.dart';
import 'package:intl/intl.dart';

class AttendenceViewScreen extends StatelessWidget {
  const AttendenceViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final attandanceProvider = Provider.of<AttandanceGetProvider>(context);

    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
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
              'Attendence Details',
              style: TextStyle(color: Colors.yellowAccent),
            ),
          ),
          body: SingleChildScrollView(
            child: Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage(
                          'asset/img/karate-graduation-blackbelt-martial-arts.jpg')),
                  gradient: LinearGradient(
                    colors: [Colors.white, Colors.white38, Colors.white],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  )),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 20.h,
                        width: 35.5.w,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(149, 0, 0, 0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Precent Days',
                                style: TextStyle(
                                    color: Colors.yellowAccent, fontSize: 17),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                attandanceProvider.presentCount.toString(),
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 1, 255, 9),
                                    fontSize: 35,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Container(
                        height: 20.h,
                        width: 35.5.w,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(149, 0, 0, 0),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Text(
                                'Absent Days',
                                style: TextStyle(
                                    color: Colors.yellowAccent, fontSize: 17),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                attandanceProvider.absentCount.toString(),
                                style: const TextStyle(
                                    color: Color.fromARGB(255, 255, 17, 0),
                                    fontSize: 35,
                                    fontWeight: FontWeight.w800),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      child: Container(
                        height: 10.h,
                        width: 35.5.w,
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(149, 0, 0, 0),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          children: [
                            const Text(
                              'From Date',
                              style: TextStyle(
                                  color: Colors.yellowAccent, fontSize: 17),
                            ),
                            TextFormField(
                              controller:
                                  attandanceProvider.startdateInputController,
                              decoration:
                                  InputDecoration(border: InputBorder.none),
                              style: TextStyle(color: Colors.yellowAccent),
                              keyboardType: TextInputType.number,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2101),
                                );

                                attandanceProvider.StartUpdateSelectedDate(
                                    pickedDate!);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 20, left: 20, bottom: 10),
                      child: Container(
                        height: 10.h,
                        width: 35.5.w,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(149, 0, 0, 0),
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          children: [
                            const Text(
                              'To Date',
                              style: TextStyle(
                                  color: Colors.yellowAccent, fontSize: 17),
                            ),
                            TextFormField(
                              controller:
                                  attandanceProvider.endDateInputController,
                              decoration: const InputDecoration(
                                  border: InputBorder.none),
                              style:
                                  const TextStyle(color: Colors.yellowAccent),
                              keyboardType: TextInputType.number,
                              onTap: () async {
                                DateTime? pickedDate = await showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime(1950),
                                  lastDate: DateTime(2101),
                                );

                                attandanceProvider.EndUpdateSelectedDate(
                                    pickedDate!);
                              },
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(Colors.red)),
                    onPressed: () async {
                      await attandanceProvider.fetchAttendance(
                          attandanceProvider.startdateInputController.text,
                          attandanceProvider.endDateInputController.text);
                    },
                    child: const Text('Get')),
                Consumer<AttandanceGetProvider>(
                    builder: (context, value, child) {
                  final record = value.attendanceRecords;

                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: double.infinity,
                      height: 62.h,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(185, 0, 0, 0),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: record.length,
                        itemBuilder: (context, index) {
                          final request = record[index];
                          DateFormat outputDateFormat =
                              DateFormat('dd/MMM/yyyy');

                          String outputDate = outputDateFormat
                              .format(DateTime.parse(request.date));
                          return ListTile(
                            leading: Text(
                              outputDate,
                              style: const TextStyle(
                                fontSize: 25,
                                color: Colors.yellowAccent,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            trailing: Text(
                              request.isPresent ? 'Present' : 'Absent',
                              style: TextStyle(
                                fontSize: 18,
                                color: request.isPresent
                                    ? const Color.fromARGB(255, 0, 255, 8)
                                    : const Color.fromARGB(255, 255, 0, 0),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }),
              ]),
            ),
          ),
        );
      },
    );
  }
}
