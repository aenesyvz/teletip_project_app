class Doctor {
  int doctorId; 
  String firstName;
  String lastName;
  String phoneNumber;
  String email;
  String password;
  int mainScienceBranchId;
  bool gender;
  bool activityStatus;
  String? imagePath;
  String? hospital;
  String? faculty;

  Doctor(this.doctorId,this.firstName,this.lastName,this.email, this.password,this.phoneNumber, this.gender,this.mainScienceBranchId, this.activityStatus, this.imagePath,this.hospital,this.faculty);

  Doctor.fromJson(Map json)
      : doctorId = int.tryParse(json["doctorId"].toString())!,
        firstName = json["firstName"],
        lastName = json["lastName"],
        email = json["email"],
        password = json["doctorPassword"],
        phoneNumber = json["phoneNumber"],
        gender = json["gender"] == 0 ? false : true,
        mainScienceBranchId = int.tryParse(json["mainScienceBranchId"].toString())!,
        activityStatus = json["activityStatus"] == 0 ? false : true,
        imagePath = json["imagePath"] == "null" ? null : json["imagePath"],
        hospital = json["hospital"] == "null" ? null:json["hospital"],
        faculty = json["faculty"] == "null" ? null:json["faculty"];

  Map toJson() {
    return {
      "doctorId": doctorId,
      "firstName": firstName,
      "lastName": lastName,
      "email": email,
      "doctorPassword": password,
      "phoneNumber": phoneNumber,
      "gender": gender ? 1 : 0,
      "mainScienceBranchId": mainScienceBranchId,
      "activityStatus": activityStatus ? 1 : 0,
      "imagePath": imagePath ?? "",
      "hospital":hospital ?? "",
      "faculty":faculty ?? "",
    };
  }
}

