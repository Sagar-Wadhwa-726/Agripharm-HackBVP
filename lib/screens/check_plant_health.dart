// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, unused_local_variable, non_constant_identifier_names, unnecessary_null_comparison
import 'package:flutter/material.dart';
import '../utils/colors_utils.dart';

class PlantHealthCheckScreen extends StatefulWidget {
  const PlantHealthCheckScreen({super.key});

  @override
  State<PlantHealthCheckScreen> createState() => _PlantHealthCheckScreenState();
}

class _PlantHealthCheckScreenState extends State<PlantHealthCheckScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Check Plant Health"),
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
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.fromLTRB(10, 60, 10, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () async {},
                    style: ElevatedButton.styleFrom(fixedSize: Size(170, 70)),
                    child: Text(
                      "Upload Image\n\nतस्विर अपलोड करें",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(fixedSize: Size(170, 70)),
                    child: Text(
                      "Click Photo\n\nएक तस्वीर ले",
                      style: TextStyle(
                        fontSize: 20,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
