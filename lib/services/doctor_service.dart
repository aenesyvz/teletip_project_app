//https://www.udemy.com/course/sifirdan-flutter-ile-android-ve-ios-apps-development/ 
//https://www.youtube.com/playlist?list=PL_Wj0DgxTlJeLFYfRBfpFveEd9cQfIpDx
//https://www.youtube.com/watch?v=ynVj0G2W28k
import 'dart:convert'; 

import 'package:http/http.dart' as http;

import 'package:teletip_project_app/enviroment.dart';
import 'package:teletip_project_app/models/doctor.dart';
const newPath = Environment.PATH + "doctor";

class DoctorService {
  static Future login(String email,String password) async {
    //return http.get(Uri.parse(newPath + "/login/email/$email/password/$password"),headers: Environment.HEADERS )
    //.then((data) => {
    //   if(data.statusCode == 200){
    //     var data =json.decode(data.body)["data"];
    //     Doctor doctor =  Doctor.fromJson(data[0]);
    //     return doctor;
    //   }
    // }).catchError((_) => APIResponse<Doctor>(error:true,errorMessage:"An error occured");
    
    return await http.get(Uri.parse(newPath + "/login/email/$email/password/$password"),headers: Environment.HEADERS );
  }

   static Future getAllByEmail(String email)async {
    return await http.get(Uri.parse(newPath + "/getbyemail/$email"),headers: Environment.HEADERS);
  }

  static Future getAllByFirstName(String firstName)async {
    return await http.get(Uri.parse(newPath + "/getbyfirstname/$firstName"),headers: Environment.HEADERS);
  }
   static Future getByDoctorId(int doctorId) async {
    return await http.get(Uri.parse(newPath + "/getbydoctorId/$doctorId"),headers: Environment.HEADERS);
  }

  static Future getAllByMainScienceBranchId(int mainScienceBranchId)async {
    return await http.get(Uri.parse(newPath + "/getbymainsciencebranch/$mainScienceBranchId"),headers: Environment.HEADERS);
  }

  static Future getAll()async {
    return await http.get(Uri.parse(newPath + "/getall"),headers: Environment.HEADERS);
  }

  static Future add(Doctor doctor) async{
    return await http.post(Uri.parse(newPath + "/add"),headers: Environment.HEADERS, body: json.encode(doctor));
  }

  static Future update(Doctor doctor) async{
    return await http.post(Uri.parse(newPath + "/update"),headers: Environment.HEADERS, body: json.encode(doctor));
  }

}