import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:shorinryu/controller/provider/admin/revenue_prov/revenue_prov.dart';
import 'package:shorinryu/controller/provider/admin/revenue_provider/revenue_provider.dart';
import 'package:shorinryu/model/payment_model/payment_model.dart';
import 'package:sizer/sizer.dart';

class AdminRevenueScreen extends StatefulWidget {
  const AdminRevenueScreen({super.key});

  @override
  State<AdminRevenueScreen> createState() => _AdminRevenueScreenState();
}

class _AdminRevenueScreenState extends State<AdminRevenueScreen> {
  var data;

  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    DateTime currentMonthStart = DateTime(now.year, now.month, 1);
    DateTime currentDate = DateTime(now.year, now.month, now.day);

// Splitting date and time components
    String formattedCurrentMonthStart =
        DateFormat('yyyy-MM-dd').format(currentMonthStart);
    String formattedCurrentDate = DateFormat('yyyy-MM-dd').format(currentDate);
    // final paymentProv = Provider.of<RevenueProvider>(context, listen: false);
    return Sizer(
      builder: (context, orientation, deviceType) {
        return Consumer<AdminRevenueProvider>(
            builder: (context, modelRevPro, child) {
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
                'Revenue',
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
            body: Column(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      width: 90.w,
                      height: 25.h,
                      decoration: BoxDecoration(
                          color: Colors.black45,
                          borderRadius: BorderRadius.circular(30)),
                      child: Center(
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: Padding(
                                padding: EdgeInsets.all(30.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const Icon(
                                      Icons.attach_money_outlined,
                                      color: Color.fromARGB(255, 0, 255, 8),
                                      size: 45,
                                    ),
                                    FutureBuilder(
                                        future: modelRevPro.getUserPayments(
                                            formattedCurrentMonthStart,
                                            formattedCurrentDate),
                                        builder: (context, snapshot) {
                                          if (snapshot.connectionState ==
                                              ConnectionState.waiting) {
                                            return const Center(
                                                child:
                                                    CircularProgressIndicator());
                                          } else if (snapshot.hasError) {
                                            return Text(
                                                'Error: ${snapshot.error}');
                                          } else if (!snapshot.hasData) {
                                            return const Center(
                                                child:
                                                    Text('No data available.'));
                                          } else {
                                            final revenueData = snapshot.data!;

                                            return Text(
                                              revenueData.totalRevenue
                                                  .toString(),
                                              style: TextStyle(
                                                color: Colors.yellowAccent,
                                                fontSize: 30,
                                              ),
                                            );
                                          }
                                        }),
                                  ],
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Container(
                                      width: 25.w,
                                      height: 8.h,
                                      decoration: BoxDecoration(
                                          color: Colors.white54,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: TextFormField(
                                          controller: modelRevPro
                                              .fromdateInputController,
                                          decoration: const InputDecoration(
                                            hintText: 'Date',
                                            border: InputBorder.none,
                                          ),
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1950),
                                              lastDate: DateTime(2101),
                                            );

                                            modelRevPro
                                                .fromRevenueUpdateSelectedDate(
                                                    pickedDate!);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(bottom: 20),
                                    child: Text('To'),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Container(
                                      width: 25.w,
                                      height: 8.h,
                                      decoration: BoxDecoration(
                                          color: Colors.white54,
                                          borderRadius:
                                              BorderRadius.circular(20)),
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: TextFormField(
                                          controller:
                                              modelRevPro.todateInputController,
                                          decoration: const InputDecoration(
                                              hintText: 'Date',
                                              border: InputBorder.none),
                                          onTap: () async {
                                            DateTime? pickedDate =
                                                await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1950),
                                              lastDate: DateTime(2101),
                                            );

                                            modelRevPro
                                                .toRevenueUpdateSelectedDate(
                                                    pickedDate!);
                                          },
                                        ),
                                      ),
                                    ),
                                  ),
                                  TextButton(
                                      onPressed: () {
                                        modelRevPro.getUserPayments(
                                            modelRevPro.fromselectedDate,
                                            modelRevPro.toselectedDate);
                                      },
                                      child: Text('show'))
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: Consumer<RevenueProvider>(
                    builder: (context, messageProvider, _) {
                      final revenue = messageProvider.revenue;

                      return ListView.builder(
                        itemCount: revenue.length,
                        // reverse: true,
                        itemBuilder: (context, index) {
                          final request = revenue[index];

                          DateFormat outputDateFormat =
                              DateFormat('dd/MMM/yyyy');

                          String outputDate = outputDateFormat
                              .format(DateTime.parse(request.paymentDate));

                          return Card(
                            child: ListTile(
                              leading: Text(outputDate.toString()),
                              title: Text(
                                  request.user.name.toString().toUpperCase()),
                              subtitle: Text(request.paymentId),
                              trailing: Text(request.amount),
                            ),
                          );
                        },
                      );
                    },
                  ),
                )
              ],
            ),
          );
        });
      },
    );
  }
}
