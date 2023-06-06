// This page shows the farmer the farming best practices

// ignore_for_file: non_constant_identifier_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, unnecessary_null_comparison, library_prefixes, sized_box_for_whitespace

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' as rootBundle;
import '../models/farmingPracticesModel.dart';
import '../utils/colors_utils.dart';

class FarmingPractices extends StatefulWidget {
  const FarmingPractices({super.key});

  @override
  State<FarmingPractices> createState() => _FarmingPracticesState();
}

class _FarmingPracticesState extends State<FarmingPractices> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Farming Best Practices"),
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
        child: FutureBuilder(
            future: ReadJsonData(),
            // Builds the list from the context and the data that has been read
            builder: (context, data) {
              if (data.hasError) {
                return Center(child: Text("${data.hasError}"));
              } else if (data.hasData) {
                var items = data.data as List<farmingPracticesModel>;
                return ListView.builder(
                    itemCount: items == null ? 0 : items.length,
                    itemBuilder: (context, index) {
                      return Card(
                        color: Color.fromARGB(126, 233, 247, 226),
                        elevation: 5,
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        child: Container(
                          padding: EdgeInsets.all(8),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                width: 150,
                                height: 110,
                                child: Image(
                                  image: NetworkImage(
                                      items[index].imageURL.toString()),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              Expanded(
                                  child: Container(
                                padding: EdgeInsets.only(bottom: 8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        "Season : ${items[index].season}",
                                        style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                      width: 10,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        "Suggested item to be grown : ${items[index].cropName}",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                      width: 10,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        "More Information : ${items[index].description}",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                      width: 10,
                                    ),
                                    Padding(
                                      padding:
                                          EdgeInsets.only(left: 8, right: 8),
                                      child: Text(
                                        "Farming Technique(s) advised : ${items[index].farmingTechniqueOne}, ${items[index].farmingTechniqueTwo}",
                                        style: TextStyle(fontSize: 16),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 5,
                                      width: 10,
                                    ),
                                  ],
                                ),
                              ))
                            ],
                          ),
                        ),
                      );
                    });
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  // Reading of the JSON FILE
  Future<List<farmingPracticesModel>> ReadJsonData() async {
    // read the data from the json file
    final jsonData =
        await rootBundle.rootBundle.loadString("assets/farming.json");

    // convert the data to a list
    final list = json.decode(jsonData) as List<dynamic>;

    return list.map((e) => farmingPracticesModel.fromJSON(e)).toList();
  }
}
