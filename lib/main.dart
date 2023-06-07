// ignore_for_file: prefer_const_constructors
import 'package:agripharm/screens/login_home.dart';
import 'package:agripharm/screens/sign_in_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  //Flutter needs to call native code before calling runApp, makes sure that you have an instance of the WidgetsBinding, which is required to use platform channels to call the native code. Basically this ensures that firebase is initialised before we run our application
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var auth = FirebaseAuth.instance;
  var isLogin = false;

  //method to check whether the user is already logged in or not
  checkIfLogin() {
    // on auth state change, a listener listens to the event
    auth.authStateChanges().listen((User? user) {
      if (user != null && mounted) {
        setState(() {
          isLogin = true;
        });
      }
    });
  }

  // before running the application call the init state method which will call the checkIfLogin method
  @override
  void initState() {
    checkIfLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Agripharm",
        theme: ThemeData(
          primarySwatch: Colors.green,
        ),
        home: isLogin ? const HomeScreen() : const SignInScreen());
  }
}
