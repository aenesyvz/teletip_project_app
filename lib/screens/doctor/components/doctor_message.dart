import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teletip_project_app/models/doctor.dart';
import 'package:teletip_project_app/models/message.dart';
import 'package:teletip_project_app/models/patient.dart';
import 'package:teletip_project_app/screens/doctor/doctor_message_screen.dart';
import 'package:teletip_project_app/services/message_service.dart';
import 'package:teletip_project_app/services/patient_service.dart';

class DoctorMessage extends StatefulWidget {
  final Doctor doctor;
  const DoctorMessage({super.key,required this.doctor});

  @override
  State<DoctorMessage> createState() => _DoctorMessageState();
}

class _DoctorMessageState extends State<DoctorMessage> {
  List<Patient> patients = <Patient>[];
  List<Message> doctorMessages = <Message>[];
    bool isEmpty= false;
  bool isLoading = true;
   @override
  void initState() {
    patients.clear();
    doctorMessages.clear();
    getListMessage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
             Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: TextFormField(
                          onChanged: (value) {},
                            decoration:  InputDecoration( 
                              hintText: "Arama",
                              floatingLabelBehavior: FloatingLabelBehavior.always,
                               suffixIcon: Padding(
                              padding:  const EdgeInsets.only(right:8.0),
                              child: Icon(Icons.search_rounded,color:Colors.blue.shade900,),
                            ),
                              ),
                              
                          onSaved: (value) {
                           
                          },
                        ),),
            // messages(),
                        if(!isEmpty &&!isLoading)
                          messages()
                        else if(isEmpty && !isLoading)
                                                  const Expanded(
                                                    child: Center(
                                                                                    child: SizedBox(
                                                                                      child: Text("Henüz size mesaj gönderilmedi!",overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                                                                    ),
                                                                                  ),
                                                  )
                        else if(isLoading)
                          const Expanded(child: Center(child: Text("Mesajlar yükleniyor....",style: TextStyle(color: Colors.grey),),)),
             const SizedBox(height: 80,)
          ],
        ),
    );
  }

  //https://www.youtube.com/watch?v=W7S0GwYwayM  adresinden esinlenilmiştir
  Expanded messages() {
    return Expanded(
      child: ListView.separated(
        separatorBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal:16.0),
            child: Container(
                    height: 1,
                    color: Colors.grey.shade300, // Custom style
                  ),
          );
        },
        padding: const EdgeInsets.only(right: 2),
        shrinkWrap: true,
        scrollDirection: Axis.vertical,  
       // physics: const NeverScrollableScrollPhysics(),
        itemCount: doctorMessages.length,
        itemBuilder: (context, int index) {
          Patient patient= patients.where((x) => x.patientId == doctorMessages[index].patientId).take(1).first;
          return Padding(
              padding: const EdgeInsets.symmetric(horizontal:4.0,vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                ListTile( 
                  //isThreeLine: true,
                  leading: ClipOval(
                          child: SvgPicture.asset(patient.gender  ? "assets/images/woman1.svg" : "assets/images/man1.svg",fit: BoxFit.cover,width: 50,height: 50,),
                        ),
                  title: Text("${patient.firstName} ${patient.lastName}",style: const TextStyle(fontWeight: FontWeight.w400,fontSize: 16),overflow: TextOverflow.ellipsis,),
                  subtitle: Row(
                    children: [
                        Container(
                                height: 10,
                                width: 10,
                            
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: patient.activityStatus == true ? Colors.green :Colors.red,
                                ),
                              ),
                      const SizedBox(width: 8,),
                      Flexible(
                        child: Text(
                          doctorMessages[index].doctorResponse != null ? doctorMessages[index].doctorResponse! : doctorMessages[index].patientMessage,
                          style: const TextStyle(fontWeight: FontWeight.w400),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ), 
                  trailing: doctorMessages[index].doctorResponse != null ? const Icon(Icons.done_all_outlined, color: Colors.green,size: 30,):const Icon(Icons.dangerous_outlined,color: Colors.red,size:30),
                   onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DoctorMessageScreen(
                          patient: patient,
                          doctor: widget.doctor,
                          message: doctorMessages[index],
                        ),
                      ),
                    );
                  },
                ),
            //    const Padding(
            //  padding: EdgeInsets.symmetric(horizontal: 20.0),
            //    child: Divider(color: Colors.grey,),
            //   ),
              ],
            ),
          );
        },
      ),
    );
  }
  

  getListMessage() {
    //Refactoring
    MessageService.getAllByDoctorId(widget.doctor.doctorId).then((res) {
       var data = json.decode(res.body)["data"];
       if(data.isEmpty){
          setState(() {
            isEmpty = true;
            isLoading = false;
          });
        }
        for (var item in data) {
          Message getMessage = Message.fromJson(item);
          //Hastaya ait bilgilerin getirilmesi için yapılmıştır. (Resim,ad,soyad,aktiflik durumu)
            PatientService.getByPatientId(getMessage.patientId).then((res2) {
                Patient getPatient = Patient.fromJson(json.decode(res2.body)["data"][0]);
                setState(() {
                    patients.add(getPatient);
                    doctorMessages.add(getMessage);
                    //https://stackoverflow.com/questions/27897932/sorting-ascending-and-descending-in-dart
                    doctorMessages.sort((a, b) => b.sendDate.compareTo(a.sendDate));
                    isEmpty = false;
                    isLoading = false;
                });
            });
        }
    });
  }
}
