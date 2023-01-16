import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:teletip_project_app/components/default_button.dart';
import 'package:teletip_project_app/constants.dart';
import 'package:teletip_project_app/models/comment.dart';
import 'package:teletip_project_app/models/doctor.dart';
import 'package:teletip_project_app/models/patient.dart';
import 'package:teletip_project_app/screens/patient/doctor_profile_view.dart';
import 'package:teletip_project_app/services/comment_service.dart';




class PatientComment extends StatefulWidget {
  final Doctor doctor;
  final Patient patient;
  const PatientComment({super.key,required this.doctor,required this.patient});

  @override
  State<PatientComment> createState() => _PatientCommentState();
}

class _PatientCommentState extends State<PatientComment> {
  final _formKey = GlobalKey<FormState>();
  Comment comment = Comment(-1, -1,-1,"",  "","");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  Center body() {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                   mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                      TextFormField(
                        decoration:  InputDecoration(
                          labelText: "Kullanıcı Adı",
                          labelStyle: TextStyle(color: kPrimaryColor),
                          hintText: "Yorumda görünmesi istediğiniz isim",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right:16.0),
                            child: Icon(Icons.emoji_people_sharp,color: kPrimaryColor,),
                          )
                        ),

                        onChanged: (value) {},
                       
                        onSaved: (value) {
                          comment.userName = value.toString();
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
                        decoration:  InputDecoration(
                          labelText: "Başlık",
                          labelStyle: TextStyle(color: kPrimaryColor),
                          hintText: "Yorum başlığı giriniz",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right:16.0),
                            child: Icon(Icons.filter_tilt_shift_sharp,color:kPrimaryColor),
                          )
                        ),
                        onChanged: (value) {},
                     
                        onSaved: (value) {
                          comment.title = value.toString();
                        },
                      ),
                      const SizedBox(
                        height:  10,
                      ),
                      TextFormField(
                        decoration:  InputDecoration(
                          labelText: "Açıklama",
                          labelStyle: TextStyle(color: kPrimaryColor),
                          hintText: "Açıklamanızı giriniz",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right:16.0),
                            child: Icon(Icons.message_outlined,color: kPrimaryColor,),
                          )
                        ),
                        onChanged: (value) {},
                        //validator: validateEmail,
                        onSaved: (value) {
                          comment.explation = value.toString();
                        },
                      ),
                     const SizedBox(
                      height: 20,
                     ),
                    DefaultButton(
                        text: "Yorumu kaydet",
                        press: () {
                          createComment();
                        },
                      ),
                  ],
                ),
              ))
          ],
        ),
      ),
    );
  }
  AppBar appBar() {
      return AppBar(
        leading: GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Icon(Icons.arrow_back_ios_new, color: Colors.blue.shade900)),
        title: Text(
          "Yorum Yaz",
          style: TextStyle(color: Colors.blue.shade900),
        ),
     
      );
    }

   void showAlert(BuildContext context, String title, String message) {
    var alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  void createComment(){
    if(_formKey.currentState!.validate()){
      _formKey.currentState!.save();
      comment.doctorId = widget.doctor.doctorId;
      comment.patientId = widget.patient.patientId;
       CommentService.add(comment).then((res) {
      var body = json.decode(res.body);
      if (body["success"]) {
        comment.id = body["data"]["insertId"];
        AlertDialog alert = const AlertDialog(
          title: Text("Başarılı"),
          content: Text("Yorumunuz başarıyla kaydedildi"),
        );
        showDialog(context: context, builder: (BuildContext context) => alert)
            .then((value) {
              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  DoctorProfileView(doctor: widget.doctor,patient: widget.patient,)));
            //Navigator.pop(context);
        });
      }
    });
    }
  }
}