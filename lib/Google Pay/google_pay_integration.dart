import 'dart:io';
import 'package:flutter/material.dart';
import 'package:pay/pay.dart';

class GPayIntegration extends StatefulWidget {
  const GPayIntegration({super.key});

  @override
  State<GPayIntegration> createState() => _GooglePayIntegrationState();
}

class _GooglePayIntegrationState extends State<GPayIntegration> {
  late final Future<PaymentConfiguration> _googlePayConfigFuture;
  @override
  void initState() {
    _googlePayConfigFuture = Platform.isAndroid ? PaymentConfiguration.fromAsset('default_google_pay_config.json') : PaymentConfiguration.fromAsset('default_apple_pay_config.json');
    super.initState();
  }

  void onGooglePayResult(paymentResult) {
    successDialog();
    debugPrint(paymentResult.toString());
  }

  void onApplePayResult(paymentResult) {
    successDialog();
    debugPrint(paymentResult.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepOrangeAccent,
        title: const Text(
          'GPay Payment',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: FutureBuilder<PaymentConfiguration>(
            future: _googlePayConfigFuture,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Platform.isAndroid
                    ? GooglePayButton(
                        width: 200,
                        paymentConfiguration: snapshot.data!,
                        paymentItems: const [PaymentItem(label: 'Total', amount: "100", status: PaymentItemStatus.final_price, type: PaymentItemType.total)],
                        type: GooglePayButtonType.buy,
                        margin: const EdgeInsets.only(top: 15.0),
                        onPaymentResult: onGooglePayResult,
                        loadingIndicator: const Center(
                          child: CircularProgressIndicator(
                            color: Colors.black,
                          ),
                        ),
                      )
                    : ApplePayButton(
                        paymentConfiguration: snapshot.data!,
                        paymentItems: const [PaymentItem(label: 'Total', amount: "100", status: PaymentItemStatus.final_price, type: PaymentItemType.total)],
                        style: ApplePayButtonStyle.black,
                        height: 50,
                        width: 200,
                        type: ApplePayButtonType.buy,
                        margin: const EdgeInsets.only(top: 15.0),
                        onPaymentResult: onApplePayResult,
                        loadingIndicator: const Center(
                          child: CircularProgressIndicator(color: Colors.black),
                        ),
                      );
              } else if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator(color: Colors.black);
              } else {
                return const SizedBox.shrink();
              }
            }),
      ),
    );
  }

  successDialog() {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.white,
            contentPadding: EdgeInsets.zero,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            insetPadding: const EdgeInsets.all(15),
            content: SizedBox(
              // height: 130,
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      const Spacer(),
                      IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: const Icon(
                            Icons.clear,
                            color: Colors.black,
                          ))
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Icon(Icons.check_circle, size: 100, color: Colors.green),
                  Text("Success", style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w700)),
                  Text("Transaction Completed SuccessFully!", style: Theme.of(context).textTheme.subtitle1?.copyWith(color: Colors.black, fontSize: 16)),
                  const SizedBox(
                    height: 30,
                  )
                ],
              ),
            ),
          );
        });
  }

}
