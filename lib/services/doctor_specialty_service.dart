//https://www.udemy.com/course/sifirdan-flutter-ile-android-ve-ios-apps-development/ 
////https://www.youtube.com/playlist?list=PL_Wj0DgxTlJeLFYfRBfpFveEd9cQfIpDx
/////https://www.youtube.com/watch?v=ynVj0G2W28k
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:teletip_project_app/enviroment.dart';
import 'package:teletip_project_app/models/doctor_specialty.dart';
const newPath = Environment.PATH + "doctorSpecialty";

class DoctorSpecialtyService {
  
  static Future add(DoctorSpecialty doctorSpecialty) async {
    return await http.post(Uri.parse(newPath + "/add"),headers: Environment.HEADERS,body: json.encode(doctorSpecialty));
  }

  static Future update(DoctorSpecialty doctorSpecialty) async{
    return await  http.post(Uri.parse(newPath + "/update"),headers: Environment.HEADERS,body: json.encode(doctorSpecialty));
  }

  static Future delete(DoctorSpecialty doctorSpecialty) async{
    return await http.post(Uri.parse(newPath + "/delete"),headers: Environment.HEADERS,body: json.encode(doctorSpecialty));
  }

  static Future getAllByProfessionId(int professionId )async{
    return  await http.get(Uri.parse(newPath + "/getAllByProfessionId/$professionId"),headers: Environment.HEADERS);
  }
  
  static Future getAllByDoctorId(int doctorId)async {
    return await http.get(Uri.parse(newPath + "/getbydoctorId/$doctorId"),headers: Environment.HEADERS);
  }
  
  static Future getAll() async{
    return  await http.get(Uri.parse(newPath + "/getall"),headers: Environment.HEADERS);
  }

  static Future getById(int id)async {
    return  await http.get(Uri.parse(newPath + "/getbyid/$id"),headers: Environment.HEADERS);
  }

 

  

}