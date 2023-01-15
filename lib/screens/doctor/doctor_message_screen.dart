import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teletip_project_app/components/default_button.dart';
import 'package:teletip_project_app/constants.dart';
import 'package:teletip_project_app/models/doctor.dart';
import 'package:teletip_project_app/models/message.dart';
import 'package:teletip_project_app/models/patient.dart';
import 'package:teletip_project_app/screens/doctor/doctor_screen.dart';
import 'package:teletip_project_app/services/message_service.dart';


class DoctorMessageScreen extends StatefulWidget {
  final Doctor doctor;
  final Patient patient;
  Message message;
  DoctorMessageScreen({super.key,required this.patient ,required this.doctor,required this.message});

  @override
  State<DoctorMessageScreen> createState() => _DoctorMessageScreenState();
}

class _DoctorMessageScreenState extends State<DoctorMessageScreen> {
  String messageTxt = "";
  bool isDeleted = false;

  @override
  Widget build(BuildContext context) {
      return Scaffold(
       // resizeToAvoidBottomInset: false,
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
            padding: const EdgeInsets.symmetric(horizontal:16.0),
            child: Column(
              children: [
                //Silme işlemi henüz yapılamadı
                if(!isDeleted)
                  customShowMessage( widget.message.patientMessage,false),
                 Container(
                  height: 15.0,
                ),
                if(!isDeleted)
                  customShowMessage(widget.message.doctorResponse,true)
                
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
                        Message sendMessage = createdNewMessageModel();
                        MessageService.doctorReplyMessage(sendMessage).then((res) {
                          var body = json.decode(res.body);
                          if (body["success"]) {
                            MessageService.getById(widget.message.messageId).then((getRes) {
                                  Message getMessage = Message.fromJson(json.decode(getRes.body)["data"][0]);
                                  setState(
                                    () {
                                      widget.message = getMessage; 
                                    },
                                  );
                              },
                            );
                          }
                        });
                      }
                },
              ),
            )
          ],
        ),
       // messageTextField(),
      ],
    );
  }

  AppBar appBar(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return AppBar(
      backgroundColor: Colors.blue.shade900,
      leading: GestureDetector(
        onTap:(){
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => DoctorScreen(
                 
                  doctor: widget.doctor,
                  
                ),
              ),
            );
          //Navigator.pop(context);
      } ,
      child: const Icon(Icons.arrow_back_ios,color: Colors.white,)),
      title: Row(
        children: [
          ClipOval(
              child: SvgPicture.asset(
                widget.patient.gender
                    ? "assets/images/woman1.svg"
                    : "assets/images/man1.svg",
                     width: _width/10,
                     height: _width/10,
                     fit: BoxFit.cover,
              ),
            ),
          Container(
            width: 8.0,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("${widget.patient.firstName} ${widget.patient.lastName}",overflow: TextOverflow.ellipsis,),
                Row(
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: widget.patient.activityStatus == true ? Colors.green:Colors.red,
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Text(widget.patient.activityStatus == true ? "Online":"Offline",style: const TextStyle(fontSize: 16,fontWeight: FontWeight.w300),)
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  


  //https://codewithandrea.com/articles/chat-messaging-ui-flutter/
   Widget customShowMessage(String? message,bool status) {
    if ( message == "" ||message == null ) {
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


Message createdNewMessageModel() {
  return Message(
                        widget.message.messageId,
                        widget.message.patientId,
                        widget.message.doctorId,
                        widget.message.patientMessage,
                        messageTxt,
                        widget.message.patientAdditionPath,
                        widget.message.sendDate,
                        DateTime.now());
}

}
