import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// import 'package:shorinryu/controller/provider/admin/revenue_provider/revenue_provider.dart';
import 'package:shorinryu/controller/provider/admin/web_socket/notification_provider.dart';
import 'package:shorinryu/controller/provider/user/user_payment_view/user_payment_provider.dart';
// import 'package:shorinryu/model/notification_model/notification_get_model.dart';
import 'package:shorinryu/view/user/payment/payment_screen.dart';
import 'package:sizer/sizer.dart';

class UserPaymentViewScreen extends StatelessWidget {
  const UserPaymentViewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Consumer<WebsocketProvider>(
          builder: (context, webSocketProvider, child) => Scaffold(
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
                'Updations',
                style: TextStyle(color: Colors.yellowAccent),
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage(
                      'asset/img/karate-graduation-blackbelt-martial-arts.jpg'),
                ),
              ),
              child: Consumer<UserFeesUpdationProvider>(
                builder: (context, messageProvider, _) {
                  final revenue = messageProvider.revenue.reversed.toList();

                  return ListView.builder(
                    itemCount: revenue.length,
                    // reverse: true,
                    itemBuilder: (context, index) {
                      final request = revenue[index];
                      DateFormat outputDateFormat = DateFormat('dd/MMM/yyyy');

                      String outputDate = outputDateFormat
                          .format(DateTime.parse(request.paymentDate));

                      return Card(
                        child: ListTile(
                          leading: Text(
                            outputDate,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w700),
                          ),
                          title: Text(request.paymentId),
                          trailing: Text(
                            request.amount,
                            style: const TextStyle(
                                color: Color.fromARGB(255, 45, 254, 52),
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Colors.yellowAccent,
              child: const Icon(
                Icons.add,
                color: Colors.black,
              ),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PaymentScreen(),
                    ));
              },
            ),
          ),
        );
      },
    );
  }
}
