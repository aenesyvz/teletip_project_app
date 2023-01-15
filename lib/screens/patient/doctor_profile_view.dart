
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teletip_project_app/constants.dart';
import 'package:teletip_project_app/models/comment.dart';
import 'package:teletip_project_app/models/doctor.dart';
import 'package:teletip_project_app/models/doctor_specialty.dart';
import 'package:teletip_project_app/models/main_science_branch.dart';
import 'package:teletip_project_app/models/patient.dart';
import 'package:teletip_project_app/models/profession.dart';
import 'package:teletip_project_app/screens/patient/patient_comment.dart';
import 'package:teletip_project_app/services/comment_service.dart';
import 'package:teletip_project_app/services/doctor_specialty_service.dart';
import 'package:teletip_project_app/services/main_science_branch_service.dart';
import 'package:teletip_project_app/services/profession_servcie.dart';


class DoctorProfileView extends StatefulWidget {
  final Doctor doctor;
  final Patient patient;
  const DoctorProfileView({super.key,required this.doctor,required this.patient});

  @override
  State<DoctorProfileView> createState() => _DoctorProfileViewState();
}

class _DoctorProfileViewState extends State<DoctorProfileView> {
  List<Comment> commnets = <Comment>[];
  List<MainScienceBranch> mainScienceBranchs = [];
  List<DoctorSpecialty> doctorspecialtys = <DoctorSpecialty>[];
  List<Profession> professions = <Profession>[];
  List<Profession> dp = [];
  String? mainScienceBranchName;

  @override void initState() {
    getByMainScienceBranchId(widget.doctor.mainScienceBranchId);
    getAllCommentByDoctorId();
    getAllDoctorSpecialtyByDoctorId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Profession> professions = <Profession>[];
    return Scaffold(
      appBar: appBar(context),
      body: body(context),
    );
  }

  SingleChildScrollView body(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
           Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            radius: MediaQuery.of(context).size.width / 5,
            backgroundColor: Colors.transparent,
            child: 
            
                ClipOval(
                    child: SvgPicture.asset(
                      widget.doctor.gender
                          ? "assets/images/woman1.svg"
                          : "assets/images/man1.svg",
                      width: 75,
                      height: 75,
                      fit: BoxFit.cover,
                    ),
                  )
               
          ),
          const SizedBox(width: 10,),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(widget.doctor.firstName,style: const TextStyle(color: Colors.black,fontSize: 36,fontWeight: FontWeight.w700),),
              Text(widget.doctor.lastName,style: const TextStyle(color: Colors.black,fontSize: 36,fontWeight: FontWeight.bold),),
            ],
          ),
        
        ],
      ),
       const SizedBox(height: 10,),
     Padding(
       padding: const EdgeInsets.symmetric(horizontal:20.0),
       child: Align(
        alignment: Alignment.centerLeft,
         child: Container(
          decoration: BoxDecoration(
             color: kPrimaryColor,
            borderRadius: BorderRadius.circular(20)
          ),
          height: 200,
          width: double.infinity,
         
           child: Padding(
             padding: const EdgeInsets.all(8.0),
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
               children: [
                 Text("Ana bilim dalı :" + mainScienceBranchName.toString(),style: const TextStyle(color: Colors.white,fontSize: 18),),
                 Text("Cinsiyeti : ${widget.doctor.gender == false ? "Erkek" : "Kadın"}",style: const TextStyle(color: Colors.white,fontSize: 18)),
                 Text("Adres : "+ widget.doctor.hospital.toString(),style: const TextStyle(color: Colors.white,fontSize: 18)),
                 Text("Mezun olduğu fakülte : "+ widget.doctor.faculty.toString(),style: const TextStyle(color: Colors.white,fontSize: 18))
               ],
             ),
           ),
         ),
       ),
     ),
     const SizedBox(height: 20,),
     Padding(
       padding: const EdgeInsets.only(left:16.0),
       child: Align(
        alignment: Alignment.centerLeft,
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Uzmanlık Alanları",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),),
            const SizedBox(height: 10,),
           ListView.builder(
              physics: const NeverScrollableScrollPhysics(),
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              itemCount: dp.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: const Icon(Icons.arrow_forward_ios,color:Colors.red),
                  title:Text(dp[index].professionName,style: const TextStyle(color: Colors.black),),
                );
              },
           )
           
          ],
         ),
       ),
     ),
     const SizedBox(height: 10,),
      Padding(
       padding: const EdgeInsets.symmetric(horizontal:16.0),
       child: Align(
        alignment: Alignment.centerLeft,
         child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Yorumlar ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 24),),
                 GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context) => PatientComment(doctor: widget.doctor, patient:widget.patient),)).then((value)  {
                      setState(() {
                          getAllCommentByDoctorId();
                      });
                    });
                  },
                  child: const Text("Sende Yaz ",style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 16),)),
              ],
            ),
            const SizedBox(height: 10,),
          ListView.builder(
             physics: const NeverScrollableScrollPhysics(),
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: commnets.length,
            itemBuilder: ((context, index) {
              var selectedComment = commnets[index];
              return ListTile(
              
                  isThreeLine: true,
                  title: Text(selectedComment.title,style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),),
                  subtitle: Text(selectedComment.explation,style: const TextStyle(color: Colors.black)),
                  trailing: const Icon(Icons.send_rounded,color: Colors.red,size: 30,),
              );
            }),
          ),
          ],
         ),
       ),
     ),
     const SizedBox(height: 20,),
        ],
      ),
    );
  }

  AppBar appBar(BuildContext context) {
    return AppBar(
      title: const Text("Doktor Profil Sayfası",style: TextStyle(color: Colors.black),),
      leading: GestureDetector(
        onTap: (() {
         
         Navigator.pop(context);
        })
        ,child: Icon(Icons.arrow_back_ios)),
    );
  }

  getAllCommentByDoctorId(){
     commnets.clear();
    print("hoop");
    CommentService.getAllByDoctorId(widget.doctor.doctorId).then((response) {
      print("buradayım 1");
      print(response.body);
      var body = json.decode(response.body);
           print("buradayım 2");
      if (body["success"]) {
        setState(() {
           print("buradayım 3");
          commnets = (body["data"] as List).map((e) => Comment.fromJson(e)).toList();
         
        });
      }
    });
  }

  getByMainScienceBranchId(int mainScienceBranchId){
    MainScienceBranchService.getAllByMainScienceBranchId(mainScienceBranchId).then((response) {
      var body = jsonDecode(response.body);
      if(body["success"]){
        setState(() {
             mainScienceBranchs = (body["data"] as List).map((e) => MainScienceBranch.fromJson(e)).toList();
              mainScienceBranchName= mainScienceBranchs[0].mainScienceBranchName.toString();
        });
        
      }
    } );
  }

  getAllDoctorSpecialtyByDoctorId(){
    DoctorSpecialtyService.getAllByDoctorId(widget.doctor.doctorId).then((response) {
      var body = jsonDecode(response.body);
      if(body["success"]){
       for(var item in body["data"]){
        DoctorSpecialty getDoctorSpecialty = DoctorSpecialty.fromJson(item);
        ProfesionService.getById(getDoctorSpecialty.professionId).then((res2) {
              var body2 = json.decode(res2.body);
              if (body2["success"]) {
                Profession getProfession = Profession.fromJson(body2["data"][0]);
                  setState(() {
                    dp.add(getProfession);
                  
                   
                });
              }
            });
       }
       print(dp.length);
      }
    });
  }

  Profession getNameProfessionById(int proffesionId)  {
     ProfesionService.getById(proffesionId).then((response) {
    var body = jsonDecode(response.body);
      if(body["success"]){
        setState(() {
             Profession profession = (body["data"] as List).map((e) => Profession.fromJson(e)).toList()[0];
          
        });
        print(" => " + professions[0].toJson().toString());
  
      }
    });
    return professions[0];
  }
}