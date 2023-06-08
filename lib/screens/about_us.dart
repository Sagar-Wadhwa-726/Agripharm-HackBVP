// ignore_for_file: prefer_const_constructors, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
import '../utils/colors_utils.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("About AgriPharm"),
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
        child: SingleChildScrollView(
          child: Column(children: [
            Image(
              image: AssetImage("assets/images/login_page_image.png"),
              height: 250,
              width: 250,
            ),
            Padding(
              padding: EdgeInsets.all(20),
              child: Text(
                "Welcome to AgriPharm! We are an application for farmers, providing the best practices for crop cultivation, disease detection, and farm management. With our advanced features and real-time recommendations, we empower farmers to optimize yields and practice sustainable farming. Join us today and revolutionize your agricultural journey with AgriPharm.\n\nएग्रीफार्म में आपका स्वागत है! हम किसानों के लिए एक आवेदन हैं, जो फसल की खेती, रोग का पता लगाने और कृषि प्रबंधन के लिए सर्वोत्तम अभ्यास प्रदान करते हैं। हमारी उन्नत सुविधाओं और वास्तविक समय की सिफारिशों के साथ, हम किसानों को उपज का अनुकूलन करने और टिकाऊ खेती का अभ्यास करने के लिए सशक्त बनाते हैं। आज ही हमसे जुड़ें और एग्रीफार्म के साथ अपनी कृषि यात्रा में क्रांति लाएं।",
                textAlign: TextAlign.justify,
                style: TextStyle(fontSize: 19, height: 1.4),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}
