// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, unused_local_variable, non_constant_identifier_names, unnecessary_null_comparison, sized_box_for_whitespace, prefer_typing_uninitialized_variables
import 'package:flutter/material.dart';
import '../utils/colors_utils.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class PlantHealthCheckScreen extends StatefulWidget {
  const PlantHealthCheckScreen({super.key});

  @override
  State<PlantHealthCheckScreen> createState() => _PlantHealthCheckScreenState();
}

class _PlantHealthCheckScreenState extends State<PlantHealthCheckScreen> {
  File? selectedImage;
  String base64Image = "";

  Future<void> chooseImage(type) async {
    var image;
    if (type == "camera") {
      image = await ImagePicker()
          .pickImage(source: ImageSource.camera, imageQuality: 10);
    } else {
      image = await ImagePicker()
          .pickImage(source: ImageSource.gallery, imageQuality: 25);
    }
    if (image != null) {
      setState(() {
        selectedImage = File(image.path);
        base64Image = base64Encode(selectedImage!.readAsBytesSync());
      });
    }
  }

  // Object of ImagePicker class
  ImagePicker image = ImagePicker();

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
            SizedBox(height: 20),
            Container(
              height: 350,
              width: 380,
              child: selectedImage == null
                  ? Icon(Icons.image, size: 80)
                  : Image.file(
                      selectedImage!,
                      fit: BoxFit.cover,
                    ),
            ),
            SizedBox(height: 5),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 30, 10, 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      chooseImage("Gallery");
                    },
                    style: ElevatedButton.styleFrom(fixedSize: Size(145, 50)),
                    child: Text(
                      "Upload Image\n(अपलोड तस्विर)",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      chooseImage("camera");
                    },
                    style: ElevatedButton.styleFrom(fixedSize: Size(145, 50)),
                    child: Text(
                      "Click Photo\n(एक तस्वीर ले)",
                      style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.none,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20),
            selectedImage == null
                ? SizedBox(height: 0)
                : ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(fixedSize: Size(190, 50)),
                    child: Text(
                      "Analyze Image\n(छवि का विश्लेषण करें)",
                      style: TextStyle(
                        fontSize: 18,
                        decoration: TextDecoration.none,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
