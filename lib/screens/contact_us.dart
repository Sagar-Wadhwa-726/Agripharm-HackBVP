// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, must_be_immutable, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/colors_utils.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Contact Us"),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            hexStringToColor("FF671F"),
            hexStringToColor("FFFFFF"),
            hexStringToColor("046A38")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Text(
                  textAlign: TextAlign.justify,
                  textScaleFactor: 1.5,
                  style: TextStyle(fontWeight: FontWeight.bold),
                  "Got any query? Feel free to contact us on the phone number given below or write an email to us.\n\nकोई सवाल है? नीचे दिए गए फ़ोन नंबर पर हमसे बेझिझक संपर्क करें या हमें एक ईमेल लिखें।\n\n"),
              ListTile(
                onTap: () {
                  launchDialer('+91-9831012390');
                },
                leading: Icon(
                  Icons.phone,
                  color: Colors.black,
                ),
                title: Text(
                  "+91-9831012390",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  launcEmailService("support@agripharm.com");
                },
                leading: Icon(
                  Icons.email,
                  color: Colors.black,
                ),
                title: Text(
                  "support@agripharm.com",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// function to open dialer on pressing the contact phone
void launchDialer(String phoneNumber) async {
  final url = 'tel:$phoneNumber';
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    ScaffoldMessenger(
        child: SnackBar(content: Text("Error opening calling application")));
  }
}

// function to open the email service application on pressing the contact email
void launcEmailService(String email) async {
  String email = Uri.encodeComponent("support@agripharm.com");
  Uri mailer = Uri.parse("mailto:$email");
  if (await launchUrl(mailer)) {
  } else {
    ScaffoldMessenger(
        child: SnackBar(content: Text("Error opening email application")));
  }
}
