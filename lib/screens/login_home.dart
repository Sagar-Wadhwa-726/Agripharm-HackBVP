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
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              hexStringToColor("FF671F"),
              hexStringToColor("FFFFFF"),
              hexStringToColor("046A38")
            ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
          ),
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
                padding: EdgeInsets.all(20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
