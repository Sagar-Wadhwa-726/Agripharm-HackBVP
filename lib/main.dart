// ignore_for_file: prefer_const_constructors
import 'package:agripharm/screens/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  //Flutter needs to call native code before calling runApp, makes sure that you have an instance of the WidgetsBinding, which is required to use platform channels to call the native code. Basically this ensures that firebase is initialised before we run our application
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Agripharm",
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: SignInScreen(),
    );
  }
}
