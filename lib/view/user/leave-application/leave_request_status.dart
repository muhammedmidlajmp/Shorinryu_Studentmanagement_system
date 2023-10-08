import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shorinryu/controller/api/get_new_accesskey.dart';
// import 'package:shorinryu/controller/provider/user/leave_appplication_provider/leave_apply_provi.dart';
import 'package:shorinryu/controller/provider/user/user_leave_application_get.dart';
import 'package:shorinryu/model/core/colors.dart';
import 'package:shorinryu/model/user_leave_request_model/user_leave_request_model.dart';
import 'package:shorinryu/view/user/leave-application/leave_application.dart';
import 'package:sizer/sizer.dart';

class LeaveRequestStatusScreen extends StatelessWidget {
  const LeaveRequestStatusScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Consumer<UserLeaveApplycationGet>(
          builder: (context, userReservationProvider, child) => Scaffold(
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
                'Leave Request Status',
                style: TextStyle(color: titleTextColor),
              ),
            ),
            body: FutureBuilder<List<UserLeaveRequestModel>>(
              future: userReservationProvider.userFetchLeaveRequests(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  getNewAccessKey();

                  return Text('Error: ${snapshot.error}');
                } else {
                  List<UserLeaveRequestModel> leaveRequests = snapshot.data!;

                  return ListView.builder(
                    itemCount: leaveRequests.length,
                    itemBuilder: (context, index) {
                      leaveRequests = leaveRequests.reversed.toList();

                      final UserLeaveRequestModel request =
                          leaveRequests[index];

                      DateFormat outputDateFormat = DateFormat('dd/MMM/yyyy');

                      String start = outputDateFormat
                          .format(DateTime.parse(request.start!));

                      String end =
                          outputDateFormat.format(DateTime.parse(request.end!));

                      return Card(
                        child: ListTile(
                          leading: Text("$start\n$end"),
                          title: Text(request.reasone.toString()),
                          // subtitle: Text(
                          //     'Start: ${request.start} \n End: ${request.end}'),
                          trailing: Text(
                            request.isApproved == true ? 'Accepted' : 'Pending',
                            style: TextStyle(
                                color: request.isApproved == true
                                    ? const Color.fromARGB(255, 58, 242, 64)
                                    : Colors.red),
                          ),
                          // Customize the ListTile as needed
                        ),
                      );
                    },
                  );
                }
              },
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 132, 156, 175),
              child: const Icon(
                Icons.add_circle,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LeaveApplicationFormScreen(),
                    ));
              },
            ),
          ),
        );
      },
    );
  }
}
