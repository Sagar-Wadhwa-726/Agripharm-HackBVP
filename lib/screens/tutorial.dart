// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

import '../utils/colors_utils.dart';

class TutorialScreen extends StatelessWidget {
  const TutorialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Agripharm Tutorial")),
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
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.fromLTRB(10, 50, 10, 40),
                child: Text(
                  "Welcome to Agripharm",
                  style: TextStyle(fontSize: 30),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                margin: EdgeInsets.all(18),
                padding: EdgeInsets.all(10),
                child: Text(
                  "1. Click on the hamburger menu to open options present in the application\n\n2. Click on the home page to go back to the home page\n\n3. Click on the about agripharm button in the menu to know more about us\n\n4. Click on the crop recommendation button to get to know which are crops are recommended to be grown considering various factors such as weather, humidity, soil type etc.\n\n5. Click on the check plant health option to click an image of the plant and check whether it has been infected with a disease or not.\n\n6. Click on the How to farm option to get to know the best practices to grow crops in various seasons.\n\n\n१ . एप्लिकेशन में मौजूद विकल्पों को खोलने के लिए हैमबर्गर मेनू पर क्लिक करें\n\n२. होम पेज पर वापस जाने के लिए होम पेज पर क्लिक करें\n\n३ . हमारे बारे में अधिक जानने के लिए मेनू में अबाउट एग्रीफार्म बटन पर क्लिक करें\n\n४ . मौसम, नमी, मिट्टी के प्रकार आदि जैसे विभिन्न कारकों को ध्यान में रखते हुए कौन सी फसल उगाने की सिफारिश की जाती है, यह जानने के लिए फसल अनुशंसा बटन पर क्लिक करें।\n\n५ . पौधे की तस्वीर क्लिक करने के लिए चेक प्लांट हेल्थ विकल्प पर क्लिक करें और जांचें कि यह किसी बीमारी से संक्रमित है या नहीं।\n\n६ . विभिन्न मौसमों में फसल उगाने के सर्वोत्तम तरीकों को जानने के लिए हाउ टू फार्म विकल्प पर क्लिक करें।",
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                    fontSize: 17,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
