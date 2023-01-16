import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teletip_project_app/models/doctor.dart';
import 'package:teletip_project_app/models/message.dart';
import 'package:teletip_project_app/models/patient.dart';
import 'package:teletip_project_app/screens/patient/patient_message_screen.dart';
import 'package:teletip_project_app/services/doctor_service.dart';
import 'package:teletip_project_app/services/message_service.dart';


class PatientMessage extends StatefulWidget {
  final Patient patient;
  const PatientMessage({super.key, required this.patient});

  @override
  State<PatientMessage> createState() => _PatientMessageState();
}

class _PatientMessageState extends State<PatientMessage> {
  List<Doctor> doctors = <Doctor>[];
  List<Message> patientMessages = <Message>[];
  bool isEmpty= false;
  bool isLoading = true;
  @override
  void initState() {
    doctors.clear();
    patientMessages.clear();
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
                                                                                      child: Text("Henüz doktorlara mesaj göndermediniz!",overflow: TextOverflow.ellipsis,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),),
                                                                                    ),
                                                                                  ),
                                                  )
                        else if(isLoading)
                          const Expanded(child: Center(child: Text("Veriler geliyor",style: TextStyle(color: Colors.grey)),)),
                              
          const SizedBox(height: 50,)
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
        shrinkWrap: true,
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.only(right: 2),
        itemCount: patientMessages.length,
        itemBuilder: (context, int index) {
          Doctor doctor = doctors.where((x) => x.doctorId == patientMessages[index].doctorId).take(1).first;
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal:4.0,vertical: 4),
            child: Column(
               mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
              children: [
                ListTile(
                 // isThreeLine: true,

                  leading: ClipOval(child: SvgPicture.asset(doctor.gender ? "assets/images/woman1.svg": "assets/images/man1.svg",width: 50,height: 50,fit: BoxFit.cover,),),
                  title: Text("${doctor.firstName} ${doctor.lastName}",overflow: TextOverflow.ellipsis),
                  subtitle: Row(
                    children: [
                      Container(
                                width: 10,
                                height: 10,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: doctor.activityStatus == true ? Colors.green :Colors.red,
                                ),
                              ),
                      const SizedBox(width: 10,),
                      Flexible(
                        child: Text(
                          patientMessages[index].doctorResponse != null ? patientMessages[index].doctorResponse! : patientMessages[index].patientMessage,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  trailing: patientMessages[index].doctorResponse != null ? const Icon(Icons.done_all_outlined,color: Colors.green,size: 30,) : const Icon(Icons.dangerous_outlined,color:Colors.red,size: 30,),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PatientMessageScreen(
                          patient: widget.patient,
                          doctor: doctor,
                          message: patientMessages[index],
                        ),
                      ),
                    );
                  },
                ),
                
              ],
            ),
          );
        },
      ),
    );
  }


  getListMessage() {
    MessageService.getAllByPatientId(widget.patient.patientId).then((res) {
     var data = json.decode(res.body)["data"];
        if(data.isEmpty){
          setState(() {
            isEmpty = true;
            isLoading = false;
          });
        }
        for (var item in data) {
          Message getMessage = Message.fromJson(item);
          //Doktora ait bilgilerin getirilmesi için yapılmıştır. (Resim,ad,soyad,aktiflik durumu)
             DoctorService.getByDoctorId(getMessage.doctorId).then((res2) {
              print(json.decode(res2.body)["success"]== true);
                Doctor getDoctor = Doctor.fromJson(json.decode(res2.body)["data"][0]);
                setState(() {
                    doctors.add(getDoctor);
                    patientMessages.add(getMessage);
                    //https://stackoverflow.com/questions/27897932/sorting-ascending-and-descending-in-dart
                    patientMessages.sort((a, b) => b.sendDate.compareTo(a.sendDate),
                  );
                   isEmpty = false;
                   isLoading = false;
                });
            });
        }
    });
  }
}
