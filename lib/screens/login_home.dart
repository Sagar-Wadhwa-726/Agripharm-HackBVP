// ignore_for_file: prefer_const_constructors, unused_field, unused_local_variable, non_constant_identifier_names, no_leading_underscores_for_local_identifiers, unused_element, prefer_final_fields, avoid_unnecessary_containers
import 'package:agripharm/reusable_widgets/reusable_widgets.dart';
import 'package:agripharm/screens/about_us.dart';
import 'package:agripharm/screens/check_plant_health.dart';
import 'package:agripharm/screens/contact_us.dart';
import 'package:agripharm/screens/crop_recommendation.dart';
import 'package:agripharm/screens/farming_practices.dart';
import 'package:agripharm/screens/sign_in_screen.dart';
import 'package:agripharm/screens/tutorial.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/chats_provider.dart';
import '../utils/colors_utils.dart';
import '../widgets/chat_item.dart';
import '../widgets/text_and_voice_field.dart';

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
        title: Text("Agripharm Chatbot"),
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
              drawerTiles(
                  context, Icons.accessibility_outlined, "Tutorial\nट्यूटोरियल",
                  () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => TutorialScreen()));
              }),
              SizedBox(
                height: 10,
              ),
              drawerTiles(context, Icons.home, "Home\nमुख्य मेन्यू", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => HomeScreen()));
              }),
              SizedBox(
                height: 10,
              ),
              drawerTiles(context, Icons.person_3_rounded,
                  "About Agripharm\nहमारे बारे में", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => AboutPage()));
              }),
              SizedBox(
                height: 10,
              ),
              drawerTiles(
                  context, Icons.phone_android, "Contact Us\nसंपरक करें", () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ContactPage()));
              }),
              SizedBox(
                height: 10,
              ),
              drawerTiles(context, Icons.recommend,
                  "Crop Recommendation\nसर्वोत्तम फसल पद्धतियाँ", () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CropRecommenderScreen()));
              }),
              SizedBox(
                height: 10,
              ),
              drawerTiles(context, Icons.health_and_safety,
                  "Check Plant Health\nपौधे के स्वास्थ्य की जाँच करें", () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => PlantHealthCheckScreen()));
              }),
              SizedBox(
                height: 10,
              ),
              drawerTiles(context, Icons.question_mark_outlined,
                  "How to farm\nकैसे खेती करें", () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => FarmingPractices()));
              }),
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
        decoration: BoxDecoration(
          gradient: LinearGradient(colors: [
            hexStringToColor("FF671F"),
            hexStringToColor("FFFFFF"),
            hexStringToColor("046A38")
          ], begin: Alignment.topCenter, end: Alignment.bottomCenter),
        ),
        child: Column(
          children: [
            Expanded(
              child: Consumer(builder: (context, ref, child) {
                final chats = ref.watch(chatsProvider).reversed.toList();
                return ListView.builder(
                  reverse: true,
                  itemCount: chats.length,
                  itemBuilder: (context, index) => ChatItem(
                    text: chats[index].message,
                    isMe: chats[index].isMe,
                  ),
                );
              }),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: TextAndVoiceField(),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
      // wrap with safe area so that it does not cover the bottom screen
    );
  }
}
