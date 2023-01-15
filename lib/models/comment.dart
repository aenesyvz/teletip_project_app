
class Comment {
    int id;
     int doctorId;
     int patientId;
     String userName;
     String title;
     String explation;
     
    Comment(
         this.id,
         this.doctorId,
         this.patientId,
         this.userName,
         this.title,
         this.explation,
    );

 

 
     Comment.fromJson(Map json)
        : id = int.tryParse(json["id"].toString())!,
        doctorId = int.tryParse(json["doctorId"].toString())!,
        patientId =  int.tryParse(json["patientId"].toString())!,
        userName =  json["userName"],
        title = json["title"],
        explation = json["explation"];

    Map toJson(){
      return{
        "id": id,
        "doctorId": doctorId,
        "patientId": patientId,
        "userName": userName,
        "title": title,
        "explation": explation,
    };
  }
}
