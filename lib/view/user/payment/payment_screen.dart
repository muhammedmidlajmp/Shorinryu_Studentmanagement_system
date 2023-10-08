import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shorinryu/controller/provider/user/payment_provider/payment_provider.dart';
import 'package:shorinryu/controller/provider/user/user_payment_view/user_payment_provider.dart';
import 'package:shorinryu/model/core/colors.dart';
import 'package:sizer/sizer.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var _razorpay = Razorpay();

  @override
  void initState() {
    // TODO: implement initState
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    DateTime now = DateTime.now();
    DateTime currentDate = DateTime(now.year, now.month, now.day);
    String formattedCurrentMonth = DateFormat('yyyy-MM-dd').format(currentDate);
    print(currentDate);
    var paymentProvider = Provider.of<PaymentProvider>(context, listen: false);

    await paymentProvider.postData(
        response.paymentId.toString(), formattedCurrentMonth);

    // Payment was successful, handle the success data here
    paymentProvider.paymentTextController.clear();
    // ignore: use_build_context_synchronously
    CoolAlert.show(
      context: context,
      type: CoolAlertType.success,
      text: "Payment Success Full!",
    );
    print("Payment Successful: ${response.paymentId}");
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Payment failed, handle the failure data here
    print("Payment Error: ${response.code} - ${response.message}");
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Handle external wallet events here (like PayTM, Google Pay, etc.)
    print("External Wallet: ${response.walletName}");
  }

  final paymentformKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final paymentProvider =
        Provider.of<PaymentProvider>(context, listen: false);

    final screenHight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;

    return Sizer(
      builder: (context, orientation, deviceType) {
        return Scaffold(
          backgroundColor: scaffoldBackgrundColor,
          appBar: AppBar(
            centerTitle: true,
            leading: IconButton(
                onPressed: () {
                  Navigator.pop(context);
                  Provider.of<UserFeesUpdationProvider>(context, listen: false)
                      .fetchPayment();
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: titleTextColor,
                )),
            backgroundColor: scaffoldBackgrundColor,
            title: const Text(
              'Pay Fee',
              style: TextStyle(color: titleTextColor),
            ),
          ),
          body: ListView(
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      color: containarBackgruoundcolor,
                      child: Container(
                          width: screenWidth / 1,
                          height: 200,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: containarBackgruoundcolor),
                          child: Lottie.asset('asset/lottie/payments.json')),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Form(
                      key: paymentformKey,
                      child: Card(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          controller: paymentProvider.paymentTextController,
                          decoration: const InputDecoration(
                              icon: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.payments_sharp,
                                  color: Colors.grey,
                                ),
                              ),
                              hintText: 'Enter Fees Amount',
                              border: InputBorder.none),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter Amount';
                            } else {
                              return null;
                            }
                          },
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: screenHight / 4,
                  ),
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(buttenColor)),
                      onPressed: () {
                        if (paymentformKey.currentState!.validate() ||
                            paymentProvider
                                .paymentTextController.text.isNotEmpty) {
                          var options = {
                            'key': 'rzp_test_g408urDfkHx1PE',
                            'amount': (int.parse(paymentProvider
                                    .paymentTextController.text) *
                                100),
                            'name': 'Shorinryu',
                            'description': 'Pay Fees',
                            'timeout': 300,
                            'prefill': {
                              'contact': '9742588812',
                              'email': 'muhammedmidlaj@gmail.com'
                            }
                          };
                          _razorpay.open(options);
                          CoolAlert.show(
                            context: context,
                            type: CoolAlertType.loading,
                            text: "Loading...!",
                            autoCloseDuration: const Duration(
                                seconds: 3), // Set the duration here
                          );
                        }
                      },
                      child: const Text(
                        '        Pay       ',
                        style: TextStyle(color: Colors.black),
                      ))
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
