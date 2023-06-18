// ignore_for_file: prefer_const_constructors, depend_on_referenced_packages, unused_local_variable, non_constant_identifier_names, unnecessary_null_comparison, sized_box_for_whitespace, prefer_typing_uninitialized_variables, unused_field, unused_element, prefer_final_fields, prefer_interpolation_to_compose_strings, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers
import 'package:flutter/material.dart';
import '../utils/colors_utils.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:image/image.dart' as img;
import 'classifier/classifier.dart';

const _labelsFileName = 'assets/labels.txt';
const _modelFileName = 'diseases.tflite';

class PlantHealthCheckScreen extends StatefulWidget {
  const PlantHealthCheckScreen({super.key});

  @override
  State<PlantHealthCheckScreen> createState() => _PlantHealthCheckScreenState();
}

enum _ResultStatus {
  notStarted,
  notFound,
  found,
}

class _PlantHealthCheckScreenState extends State<PlantHealthCheckScreen> {
  _ResultStatus _resultStatus = _ResultStatus.notStarted;
  String _plantLabel = '';
  double _accuracy = 0.0;
  bool _isAnalyzing = false;
  final picker = ImagePicker();
  File? _selectedImageFile;
  late Classifier? _classifier;

  Future<void> _loadClassifier() async {
    final classifier = await Classifier.loadWith(
      labelsFileName: _labelsFileName,
      modelFileName: _modelFileName,
    );
    _classifier = classifier;
  }

  void _setAnalyzing(bool flag) {
    setState(() {
      _isAnalyzing = flag;
    });
  }

  void _onPickPhoto(ImageSource source) async {
    setState(() {
      _loadClassifier();
    });
    final pickedFile = await picker.pickImage(source: source);

    if (pickedFile == null) {
      return;
    }

    final imageFile = File(pickedFile.path);
    setState(() {
      _selectedImageFile = imageFile;
    });

    _analyzeImage(imageFile);
  }

  void _analyzeImage(File image) {
    _setAnalyzing(true);
    final imageInput = img.decodeImage(image.readAsBytesSync())!;
    final resultCategory = _classifier!.predict(imageInput);
    final result = resultCategory.score >= 0.8
        ? _ResultStatus.found
        : _ResultStatus.notFound;
    final plantLabel = resultCategory.label;
    final accuracy = resultCategory.score;
    setState(() {
      _resultStatus = result;
      _plantLabel = plantLabel;
      _accuracy = accuracy;
    });
    _setAnalyzing(false);
  }

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
              child: _selectedImageFile == null
                  ? Icon(Icons.image, size: 80)
                  : Image.file(
                      _selectedImageFile!,
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
                      setState(() {
                        _isAnalyzing = true;
                      });
                      _onPickPhoto(ImageSource.gallery);
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
                      setState(() {
                        _isAnalyzing = true;
                      });
                      _onPickPhoto(ImageSource.camera);
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
            _isAnalyzing == true
                ? const SizedBox(height: 0)
                : Container(
                    color: _resultStatus == _ResultStatus.found
                        ? Colors.red
                        : Colors.green,
                    width: MediaQuery.of(context).size.width,
                    child: Column(
                      children: [
                        _resultStatus == _ResultStatus.found &&
                                _isAnalyzing == false
                            ? Text(
                                "Predicted disease/अनुमानित बीमारी: $_plantLabel",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  height: 1.8,
                                ),
                              )
                            : Text(
                                "No predicted disease\nकोई अनुमानित बीमारी नहीं",
                                style: TextStyle(fontSize: 20, height: 1.8)),
                        SizedBox(height: 10),
                        _resultStatus == _ResultStatus.found &&
                                _isAnalyzing == false
                            ? Text(
                                "Accuracy/पूर्णता स्तर: ${(_accuracy * 100).toStringAsFixed(2)}",
                                textAlign: TextAlign.center,
                                style: TextStyle(fontSize: 20, height: 1.8))
                            : SizedBox(height: 0)
                      ],
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
