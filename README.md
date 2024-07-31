# demo_payment_integrations

A new Flutter project.

## Getting Started

This project was built using the following tools:

- Flutter 3.19.6
- Dart 3.3.4

---
## Getting Started 🚀

In this demo app contains five different Payment Integrations

- GPay
- Apple Pay
- PayPal
- Razor Pay
- Stripe

* In this all Payment Integration you should need to give "Network permission"
  --> Open the AndroidManifest.xml file located at <your_project>/android/app/src/main and add the following line:
      <manifest xmlns:android="...">
         <uses-permission android:name="android.permission.INTERNET"/> <!-- Add this -->
      </manifest>

###  GPay and Apple Pay setup

* Add package --> "pay: <latest_version>"
* Package Link: https://pub.dev/packages/pay
* Create assets directory
* Holding the payment configuration details need to add .json files in assets directory
  --> When use GPay payment integration need to add - "default_google_pay_config.json"  
* For receive "default_google_pay_config.json" file code click below link
  (https://github.com/google-pay/flutter-plugin/blob/main/pay/example/lib/payment_configurations.dart#L63)
  --> When use Apple Pay payment integration need to add - "default_apple_pay_config.json"
* For receive "default_apple_pay_config.json" file code click below link
  (https://github.com/google-pay/flutter-plugin/blob/main/pay/example/lib/payment_configurations.dart#L27)

###  PayPal setup

* Add package --> "flutter_paypal: <latest_version>"
* Package Link: https://pub.dev/packages/flutter_paypal
* When use PayPal payment method need to add "clientId" and "secretKey" in "UsePaypal" function widget
  --> For creating "clientId" and "secretKey" follow below steps :
      1. Make a PayPal business account. First things: Make sure that you have an active PayPal business account.
      2. Log into the PayPal Developer Dashboard.
      3. Create a new app.
      4. Copy the Client ID and Secret Key.
  (Click this link to Log into the PayPal: https://www.paypal.com/us/webapps/mpp/account-selection)
* For PayPal implementing you should to call "UsePaypal" widget in your payment button's onTap
  (This code is easily received you in package documentation)

###  Razor Pay setup

* Add package --> "razorpay_flutter: <latest_version>"
* Package Link: https://pub.dev/packages/razorpay_flutter
* Sign up for a Razorpay Account and generate the API Keys from the Razorpay Dashboard.
* When you have to generating "order id" then you need to call "orders" api
  --> Used this url "https://api.razorpay.com/v1/orders" to call "orders" api
  --> If you have to call order api you also need to add "key_secret" which should you generate to Razorpay Account
  (Click this link to Log into the RazorPay: https://accounts.razorpay.com/auth/?redirecturl=https%3A%2F%2Fdashboard.razorpay.com&auth_intent=login&screen=sign_in)
  --> Add "key_id" and "key_secret" in Postman --> Basic Auth --> "Username" and "Password"
      (In "Username" add "key_id" and In "Password" add "key_secret")
  --> For more information about "order api" click below link and follow all steps for implement order api:
  (https://www.geeksforgeeks.org/how-to-integrate-razorpay-payment-gateway-in-flutter/)
* Follow below steps for implementation
  1. Import package
  2. Create Razorpay instance
     --> _razorpay = Razorpay();
  3. Attach event listeners
     (The event names are exposed via the constants EVENT_PAYMENT_SUCCESS, EVENT_PAYMENT_ERROR and EVENT_EXTERNAL_WALLET from the Razorpay class.)
  4. Setup options

###  Stripe setup

* Add package --> "flutter_stripe: <latest_version>"
* Package Link: https://pub.dev/packages/flutter_stripe
* Add "Stripe.publishableKey" in main.dart file
* For creating "Stripe.publishableKey and secretKey" follow below steps
* Reveal a secret API key for test mode. In test mode, you can reveal a secret API key as many times as you want.
  --> To reveal a secret key in test mode:
      1. In the Stripe Developers Dashboard, select the API keys tab.
      2. In the Standard keys list, in the Secret key row, click Reveal test key.
      3. Copy the key value by clicking it.
      4. Save the key value.
  (Follow same steps when you Reveal a secret or publishableKey API key for live mode)
  (Click this link to Log into the Stripe: https://dashboard.stripe.com/register)
* You have to call stripe payment_intents api use this api url "https://api.stripe.com/v1/payment_intents"
  (A PaymentIntent details you through the process of collecting a payment from your customer)
# Requirements
* Using a descendant of Theme.AppCompat for your activity, It's required for stripe
  --> we need to replace "style.xml" files code for theme change
  (both file locations is here)
  --> <your_project>/android/app/src/main/res/values-night/style.xml
  --> <your_project>/android/app/src/main/res/values/style.xml
  (This file new code you which you should replace it's have easily receive into package documentations)
* You need to add the following rules to your proguard-rules.pro file (If you don't have this file then create this file on below location)
  --> (file location): <your_project>/android/app/proguard-rules.pro
      add this all lines into "proguard-rules.pro" file:
      -dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivity$g
      -dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Args
      -dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter$Error
      -dontwarn com.stripe.android.pushProvisioning.PushProvisioningActivityStarter
      -dontwarn com.stripe.android.pushProvisioning.PushProvisioningEphemeralKeyProvider
