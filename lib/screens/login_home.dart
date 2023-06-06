// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers

import 'package:agripharm/screens/about_us.dart';
import 'package:agripharm/screens/check_plant_health.dart';
import 'package:agripharm/screens/contact_us.dart';
import 'package:agripharm/screens/crop_recommendation.dart';
import 'package:agripharm/screens/farming_practices.dart';
import 'package:agripharm/screens/sign_in_screen.dart';
import 'package:agripharm/utils/colors_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Agripharm"),
      ),
      drawer: Drawer(
        child: Container(
          color: Colors.lightBlue,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                padding: EdgeInsets.zero,
                child: UserAccountsDrawerHeader(
                  decoration:
                      BoxDecoration(color: Color.fromARGB(255, 0, 139, 203)),
                  currentAccountPictureSize: const Size.fromRadius(30.0),
                  accountName: Text("Agripharm User"),
                  accountEmail: Text("user@agripharm.com"),
                  margin: EdgeInsets.zero,
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: AssetImage("assets/images/user.png"),
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomeScreen()));
                },
                leading: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                title: Text(
                  "Home\nमुख्य मेन्यू",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AboutPage()));
                },
                leading: Icon(
                  Icons.person_3_rounded,
                  color: Colors.white,
                ),
                title: Text(
                  "About Agripharm\nहमारे बारे में",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => ContactPage()));
                },
                leading: Icon(
                  Icons.phone_android,
                  color: Colors.white,
                ),
                title: Text(
                  "Contact Us\nसंपरक करें",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => CropRecommenderScreen()));
                },
                leading: Icon(
                  Icons.recommend,
                  color: Colors.white,
                ),
                title: Text(
                  "Crop Recommendation\nसर्वोत्तम फसल पद्धतियाँ",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => PlantHealthCheckScreen()));
                },
                leading: Icon(
                  Icons.health_and_safety,
                  color: Colors.white,
                ),
                title: Text(
                  "Check Plant Health\nपौधे के स्वास्थ्य की जाँच करें",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => FarmingPractices()));
                },
                leading: Icon(
                  Icons.question_mark_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  "How to farm\nकैसे खेती करें",
                  textScaleFactor: 1.2,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                width: 50,
                height: 40,
                child: ElevatedButton(
                  child: const Text(
                    "LOGOUT",
                  ),
                  onPressed: () {
                    FirebaseAuth.instance.signOut().then((value) {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SignInScreen(),
                          ),
                          (route) => false);
                    });
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("User Logged Out successfully"),
                    ));
                  },
                ),
              ),
            ],
          ),
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
