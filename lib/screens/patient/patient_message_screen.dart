import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teletip_project_app/components/default_button.dart';
import 'package:teletip_project_app/constants.dart';
import 'package:teletip_project_app/models/doctor.dart';
import 'package:teletip_project_app/models/message.dart';
import 'package:teletip_project_app/models/patient.dart';
import 'package:teletip_project_app/screens/patient/doctor_profile_view.dart';
import 'package:teletip_project_app/services/message_service.dart';



class PatientMessageScreen extends StatefulWidget {
  final Patient patient;
  final Doctor doctor;
  Message message;
  PatientMessageScreen({super.key,required this.patient,required this.doctor,required this.message});

  @override
  State<PatientMessageScreen> createState() => _PatientMessageScreenState();
}

class _PatientMessageScreenState extends State<PatientMessageScreen> {
  String messageTxt = "";
  bool isDeleted = false;
  // late Message newMessage;
  //  @override void initState() {
  //   // TODO: implement initState
  //   newMessage = createdNewMessage();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
      return Scaffold(
          //resizeToAvoidBottomInset: false,      
        backgroundColor: Colors.white,
        appBar: appBar(context),
        body: body(),
    );
  }

  Column body() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 10,),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              children: [
                //Silme işlemi henüz yapılamadı
                if(isDeleted  == false)
                    customShowMessage(
                        widget.message.patientMessage,
                        true,
                       ),
                 const SizedBox(height: 12.0,),
                 if(isDeleted  == false)
                    customShowMessage(
                        widget.message.doctorResponse,
                        false,
                      ),
              ],
            ),
          ),
        ),
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal:16.0),
              child: TextField(
                // maxLines: 6, 
                onChanged: (value) {
                  setState(() {
                    messageTxt = value;
                  });
                },
                style:  TextStyle(color: kPrimaryColor),
                decoration: const InputDecoration(
                  labelText:"Mesaj" ,
                  hintText: "Yazınız",
                  hintStyle: TextStyle(color: Colors.black),
                  border: InputBorder.none,
                ),
              ),
            ),
                const SizedBox(
                  width: 10,
                ),
           Padding(
             padding: const EdgeInsets.symmetric(horizontal:16.0,vertical: 8),
             child: DefaultButton(
              text: "Mesaj Gönder",
              press: (){
                    if (messageTxt.isNotEmpty) {
                        Message newMessage = createNewMessageModel();
                        MessageService.patientSendMessage(newMessage).then((res) {
                          //Eğer mesaj gönderimi başarılıysa ekranda görütülenmesi için veri tabanına eklenen mesajın bilgisi alınır
                            MessageService.getById( json.decode(res.body)["data"]["insertId"]).then((getRes) {
                                  setState(
                                    () {
                                      widget.message = Message.fromJson(json.decode(getRes.body)["data"][0]);
                                    },
                                  );
                              },
                            );
                        });
                      }
              },
             ),
           )
          ],
        ),
  
      ],
    );
  }

  AppBar appBar(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: kPrimaryColor,
      title: Row(
        children: [
          ClipOval(
                  child: SvgPicture.asset(widget.doctor.gender
                      ? "assets/images/woman1.svg"
                      : "assets/images/man1.svg",
                      width: _width/10,
                      height: _width/10,
                      fit: BoxFit.cover,
                    ),
                ),
          const SizedBox(width: 12.0,),
          Expanded(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: (() {
                         Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => DoctorProfileView(doctor: widget.doctor,patient: widget.patient,)));
                    }),
                    child:Text("${widget.doctor.firstName} ${widget.doctor.lastName}",overflow: TextOverflow.ellipsis,)),
                  const SizedBox(width: 30,),
                  Row(
                    children: [
                      Container(
                        height: 10,
                        width: 10,
                        decoration: BoxDecoration(
                          color: widget.doctor.activityStatus == true ? Colors.green:Colors.red,
                          borderRadius: BorderRadius.circular(50),
                        ),
                      ),

                      const SizedBox(width: 10,),
                      Text(widget.doctor.activityStatus == true ?"Online":"Offline",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w500),),
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Message createdNewMessage() => Message(-1, -1, -1, "", "", "", DateTime.now(), null);

  Message createNewMessageModel() {
    return Message(
                        1,
                        widget.patient.patientId,
                        widget.doctor.doctorId,
                        messageTxt,
                        "",
                        "",
                        DateTime.now(),
                        null);
  }

 
    //https://codewithandrea.com/articles/chat-messaging-ui-flutter/
    Widget customShowMessage(String? message, bool status) {
    if (message == "" ||message == null ) {
      return const Text("");
    }
    return Padding(
      // asymmetric padding
      padding: EdgeInsets.fromLTRB(
        status ? 64.0 : 16.0,
        4,
        status ? 16.0 : 64.0,
        4,
      ),
      child: Align(
        // align the child within the container
        alignment: status ? Alignment.centerRight : Alignment.centerLeft,
        child: DecoratedBox(
          // chat bubble decoration
          decoration: BoxDecoration(
            color: status ? Colors.green.shade600 : Colors.grey.shade600,
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Text(
              message,
              style: Theme.of(context).textTheme.bodyText1!.copyWith(
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }

}