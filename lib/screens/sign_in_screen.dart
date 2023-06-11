// ignore_for_file: prefer_final_fields, must_be_immutable, prefer_const_literals_to_create_immutables, prefer_const_constructors, nullable_type_in_catch_clause, unnecessary_new, use_key_in_widget_constructors, library_private_types_in_public_api, avoid_print, unused_catch_clause, empty_catches
import 'package:agripharm/screens/otp_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../reusable_widgets/reusable_widgets.dart';
import '../utils/colors_utils.dart';

class SignInScreen extends StatefulWidget {
  @override
  _SignInScreenState createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _phoneNumberTextController =
      TextEditingController();

  var otpSent = false;

  Future<void> signInWithPhoneNumber(String phoneNumber) async {
    FirebaseAuth auth = FirebaseAuth.instance;

    try {
      await auth.verifyPhoneNumber(
        //phoneNumber where OTP has to be sent
        phoneNumber: phoneNumber,

        // Function which does something when the code is sent to the phone number
        codeSent: (String verificationId, int? resendToken) async {
          setState(() {
            otpSent = true;
          });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("OTP sent successfully"),
          ));
          String smsCode = '';
          PhoneAuthCredential credential = PhoneAuthProvider.credential(
            verificationId: verificationId,
            smsCode: smsCode,
          );
          setState(() {
            otpSent = false;
          });
          Get.to(OtpScreen(), arguments: [verificationId]);
          try {
            await auth.signInWithCredential(credential);
          } on FirebaseAuthException catch (error) {
            print("error-1 ${error.code}");
          }
        },

        // function which executes when the verification of phone number is completed
        verificationCompleted: (PhoneAuthCredential credential) async {
          setState(() {
            otpSent = true;
          });
          await auth.signInWithCredential(credential);
        },

        // functions which informs user if the verification has failed
        verificationFailed: (FirebaseAuthException error) {
          setState(() {
            otpSent = false;
          });
          {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              content: Text(error.message.toString()),
            ));
          }
        },

        // timeout specified
        codeAutoRetrievalTimeout: (String verificationId) {},
        timeout: Duration(seconds: 10),
      );
    } on FirebaseAuthException catch (error) {
      setState(() {
        otpSent = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(error.message.toString()),
      ));
    }
  }

  void _userLogin() async {
    String mobile = _phoneNumberTextController.text;
    if (mobile.length != 10) {
      setState(() {
        otpSent = false;
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text("Please enter a valid 10 digit mobile number")));
    } else {
      signInWithPhoneNumber("+91$mobile");
    }
  }

  @override
  @override
  void dispose() {
    _phoneNumberTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
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
                20, MediaQuery.of(context).size.height * 0.12, 20, 0),
            child: Column(
              children: <Widget>[
                Image(
                  image: AssetImage("assets/images/login_page_image.png"),
                  height: 250,
                  width: 250,
                ),
                const SizedBox(height: 10),
                Text(
                  "Enter your phone number to begin",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                ),
                const SizedBox(height: 40),
                reusableTextField("Enter Phone number", Icons.phone, false,
                    _phoneNumberTextController),
                const SizedBox(height: 35),
                otpSent == false
                    ? generalButton(context, () {
                        setState(() {
                          otpSent = true;
                        });
                        _userLogin();
                      }, "RECEIVE OTP")
                    : CircularProgressIndicator(
                        color: Colors.black,
                      ),
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Standard carrier charges may apply to receive OTP",
                      style: TextStyle(color: Colors.white, fontSize: 17),
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
