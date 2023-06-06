// ignore: file_names
// ignore_for_file: public_member_api_docs, sort_constructors_first, file_names, duplicate_ignore
// ignore_for_file: camel_case_types

class farmingPracticesModel {
  String? season;
  String? cropName;
  String? description;
  String? farmingTechniqueOne;
  String? farmingTechniqueTwo;
  String? imageURL;

  farmingPracticesModel(
      {this.season,
      this.cropName,
      this.description,
      this.farmingTechniqueOne,
      this.farmingTechniqueTwo,
      this.imageURL});

  farmingPracticesModel.fromJSON(Map<String, dynamic> json) {
    season = json["season"];
    cropName = json["crop name"];
    description = json["description"];
    farmingTechniqueOne = json['farming-techniques'][0];
    farmingTechniqueTwo = json['farming-techniques'][1];
    imageURL = json["imageUrl"];
  }
}
