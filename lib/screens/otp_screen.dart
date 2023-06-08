// ignore_for_file: prefer_const_constructors, prefer_final_fields, unused_local_variable, avoid_print, no_leading_underscores_for_local_identifiers, use_build_context_synchronously, unnecessary_null_comparison, unused_catch_clause, empty_catches
import 'package:agripharm/screens/login_home.dart';
import 'package:agripharm/screens/sign_in_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../reusable_widgets/reusable_widgets.dart';
import '../utils/colors_utils.dart';
import 'package:pinput/pinput.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  String otpCode = "";
  final String verificationId = Get.arguments[0];
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void dispose() {
    super.dispose();
  }

  void verifyOtp(String verificationId, String userOtp) async {
    try {
      PhoneAuthCredential creds = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: userOtp);
      User? user = (await auth.signInWithCredential(creds)).user;
      if (user != null) {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ),
            (route) => false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("User Logged In successfully"),
        ));
      }
    } on FirebaseAuthException catch (error) {
      if (error.code == "invalid-verification-code") {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Invalid OTP entered"),
        ));
      }
    }
  }

  void _login() {
    if (otpCode != null) {
      verifyOtp(verificationId, otpCode);
    } else if (otpCode.length != 6) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter a 6-Digit OTP"),
      ));
    } else if (otpCode == null) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("Please enter the OTP sent"),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    // code from pinput documentation, to beautify the verify otp screen
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: TextStyle(
          fontSize: 25,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(91, 0, 0, 0)),
        borderRadius: BorderRadius.circular(8),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.black),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Color.fromRGBO(255, 255, 255, 1),
      ),
    );

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "AgriPharm",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            hexStringToColor("FF671F"),
            hexStringToColor("FFFFFF"),
            hexStringToColor("046A38")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.2, 20, 0),
            child: Column(
              children: <Widget>[
                Image(
                  image: AssetImage("assets/images/login_page_image.png"),
                  height: 250,
                  width: 250,
                ),
                const SizedBox(height: 10),
                Text(
                  "Please enter the 6-Digit OTP",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                const SizedBox(height: 40),
                Pinput(
                  onCompleted: (value) {
                    setState(() {
                      otpCode = value;
                    });
                  },
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  length: 6,
                  animationCurve: Curves.ease,
                  showCursor: true,
                ),
                const SizedBox(height: 35),
                generalButton(context, () {
                  _login();
                }, "VERIFY OTP"),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Edit phone number? ",
                      style: TextStyle(color: Colors.white70, fontSize: 17),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignInScreen(),
                            ));
                      },
                      child: const Text(
                        "Go Back",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
