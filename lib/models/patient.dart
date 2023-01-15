class Patient {
  int patientId;
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String password;
  bool gender;
  bool activityStatus;
  String? imagePath;

  Patient(this.patientId, this.firstName, this.lastName , this.email, this.password,this.phoneNumber,
      this.gender, this.activityStatus, this.imagePath);

  Patient.fromJson(Map json)
      : patientId = int.tryParse(json["patientId"].toString())!,
        firstName = json["firstName"],
        lastName = json["lastName"],
        email = json["email"],
        password = json["patientPassword"],
        phoneNumber = json["phoneNumber"],
        gender = json["gender"] == 0 ? false : true,
        activityStatus = json["activityStatus"] == 0 ? false : true,
        imagePath = json["imagePath"] == "null" ? null : json["imagePath"];

  Map toJson() {
    return {
      "patientId": patientId,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "patientPassword": password,  
      "phoneNumber": phoneNumber,
      "gender": gender ? 1 : 0,
      "activityStatus": activityStatus ? 1 : 0,
      "imagePath": imagePath ?? "",
    };
  }
}