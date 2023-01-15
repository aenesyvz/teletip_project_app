class DoctorSpecialty {
  int id;
  int doctorId;
  int professionId;

  DoctorSpecialty(this.id, this.doctorId, this.professionId);

  DoctorSpecialty.fromJson(Map json)
      : id = int.tryParse(json["id"].toString())!,
        doctorId = int.tryParse(json["doctorId"].toString())!,
        professionId = int.tryParse(json["professionId"].toString())!;

  Map toJson() {
    return {
      "id": id,
      "doctorId": doctorId,
      "professionId": professionId
    };
  }
}
