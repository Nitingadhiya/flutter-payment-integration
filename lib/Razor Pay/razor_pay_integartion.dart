import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorPayIntegration extends StatefulWidget {
  const RazorPayIntegration({super.key});

  @override
  State<RazorPayIntegration> createState() => _RazorPayIntegrationState();
}

class _RazorPayIntegrationState extends State<RazorPayIntegration> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: const Text(
          'Razor Pay Payment',
          style: TextStyle(color: Colors.white, fontSize: 25),
        ),
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network('https://sellonboard.com/wp-content/uploads/2021/09/razorpay.png', height: 80),
            ElevatedButton(
              onPressed: () async {
                try {
                  var url = 'https://api.razorpay.com/v1/orders';
                  var headers = {
                    'content-type': 'application/json',
                    // add yor "key_id" and "key_secret", it's received to you into your razor pay admin account
                    'Authorization': 'Basic ${base64Encode(utf8.encode('${'add_your_key_id'}:${'add_your_key_secret'}'))}',
                  };
                  var orderData = json.encode({
                    "amount": 100,
                    "currency": "INR",
                    "receipt": "qwsaq1",
                    "partial_payment": true,
                    "first_payment_min_amount": 230,
                    "notes": {"key1": "value3", "key2": "value2"}
                  });

                  try {
                    var response = await http.post(
                      Uri.parse(url),
                      headers: headers,
                      body: orderData,
                    );

                    if (response.statusCode == 200) {
                      print('Success: ${response.body}');
                      print("Razor payment");
                      Razorpay razorpay = Razorpay();

                      var options = {
                        // add your "key_id" here
                        'key': "key_id",
                        'amount': 100,
                        'name': 'Trevy',
                        'description': '',
                        'retry': {'enabled': true, 'max_count': 100},
                        'send_sms_hash': true,
                        'prefill': {'contact': "1471471470", 'email': "email@gmail.com"},
                        'method': {
                          'wallet': false,
                        },
                      };
                      razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                      razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
                      razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
                      razorpay.open(options);
                    } else {
                      print('Error: ${response.statusCode} ${response.reasonPhrase}');
                    }
                  } catch (e) {
                    print('Exception: $e');
                  }
                } catch (e) {
                  print('-----------error----------$e');
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: const Padding(
                padding: EdgeInsets.all(12.0),
                child: Text(
                  "Razorpay Payment",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(context, "External Wallet Selected", "${response.walletName}");
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
