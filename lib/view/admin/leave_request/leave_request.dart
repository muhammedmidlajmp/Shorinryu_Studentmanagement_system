import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shorinryu/controller/provider/admin/leave_rqst_get_provdr/leave_request_get_pro.dart';
// import 'package:shorinryu/model/leave_request_get_model/leave_request_get_model.dart';
import 'package:shorinryu/model/user_leave_request_model/user.dart';
import 'package:shorinryu/model/user_leave_request_model/user_leave_request_model.dart';
// import 'package:shorinryu/model/leave_request_get_model/leave_request_get_model.dart';
import 'package:sizer/sizer.dart';

class AdminLeaveRequestViewScreen extends StatelessWidget {
  const AdminLeaveRequestViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final userReservationProvider =
        Provider.of<LeaveRequestGetProvider>(context);
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
                'Leave Request',
                style: TextStyle(color: Colors.yellowAccent),
              ),
            ),
            body: FutureBuilder<List<UserLeaveRequestModel>>(
              future: userReservationProvider.fetchLeaveRequests(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else {
                  List<UserLeaveRequestModel> leaveRequests = snapshot.data!;

                  return ListView.builder(
                    itemCount: leaveRequests.length,
                    itemBuilder: (context, index) {
                      final UserLeaveRequestModel request =
                          leaveRequests[index];
                      final User user = request.user!;

                      return ListTile(
                        leading: ClipOval(
                          child: user.profilePicture != null
                              ? Image.network(
                                  user.profilePicture!,
                                  width: 50,
                                  height: 50,
                                  fit: BoxFit.cover,
                                )
                              : const Icon(Icons.person),
                        ),
                        title: Text(user.name!),
                        subtitle: Text(
                            'Start: ${request.start} \n End: ${request.end}'),
                        trailing: Column(
                          children: [
                            Flexible(
                                flex: 1,
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: ElevatedButton(
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                Color.fromARGB(
                                                    255, 36, 234, 43))),
                                    onPressed: () {},
                                    child: const Text('Accept'),
                                  ),
                                )),
                          ],
                        ),
                        onTap: () {
                          showLeaveContent(context, request);
                        },
                        // Customize the ListTile as needed
                      );
                    },
                  );
                }
              },
            ));
      },
    );
  }

  void showLeaveContent(context, final request) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            actions: [
              const Align(
                  alignment: Alignment.topLeft,
                  child: Text(
                    'Reason   : ',
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                  )),
              Text(' ${request.reasone}')
            ],
          );
        });
  }
}
