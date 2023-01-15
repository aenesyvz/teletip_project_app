class Message {
  int messageId;
  int patientId;
  int doctorId;
  String patientMessage;
  String? doctorResponse;
  String? patientAdditionPath;
  DateTime sendDate;
  DateTime? responseDate;

  Message(
      this.messageId,
      this.patientId,
      this.doctorId,
      this.patientMessage,
      this.doctorResponse,
      this.patientAdditionPath,
      this.sendDate,
      this.responseDate);

  Message.fromJson(Map json)
      : messageId = int.tryParse(json["messageId"].toString())!,
        patientId = int.tryParse(json["patientId"].toString())!,
        doctorId = int.tryParse(json["doctorId"].toString())!,
        patientMessage = json["patientMessage"],
        doctorResponse = json["doctorResponse"],
        patientAdditionPath = json["patientAdditionPath"],
        sendDate = DateTime.parse(json["sendDate"]),
        responseDate = json["responseDate"] == null ? null : DateTime.parse(json["responseDate"]);

  Map toJson() {
    return {
      "messageId": messageId,
      "patientId": patientId,
      "doctorId": doctorId,
      "patientMessage": patientMessage,
      "doctorResponse": doctorResponse,
      "patientAdditionPath": patientAdditionPath,
      "sendDate": sendDate.toString(),
      "responseDate": responseDate.toString()
    };
  }
}
