import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
// import 'package:shorinryu/controller/provider/admin/revenue_provider/revenue_provider.dart';
import 'package:shorinryu/controller/provider/admin/web_socket/notification_provider.dart';
import 'package:shorinryu/controller/provider/user/user_payment_view/user_payment_provider.dart';
import 'package:shorinryu/model/core/colors.dart';
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
                'Transaction History',
                style: TextStyle(color: titleTextColor),
              ),
            ),
            body: Consumer<UserFeesUpdationProvider>(
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
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color.fromARGB(255, 132, 156, 175),
              child: const Icon(
                Icons.payments_outlined,
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
