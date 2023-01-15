class Profession {
  int professionId;
  String professionName;

  Profession(this.professionId, this.professionName);

  Profession.fromJson(Map json)
      : professionId = int.tryParse(json["professionId"].toString())!,
        professionName = json["professionName"];

  Map toJson() {
    return {
      "professionId": professionId,
      "professionName": professionName
    };
  }
}
