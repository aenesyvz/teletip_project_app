//https://www.udemy.com/course/sifirdan-flutter-ile-android-ve-ios-apps-development/ 
//https://www.youtube.com/playlist?list=PL_Wj0DgxTlJeLFYfRBfpFveEd9cQfIpDx
//https://www.youtube.com/watch?v=ynVj0G2W28k
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:teletip_project_app/enviroment.dart';
import 'package:teletip_project_app/models/patient.dart';
const newPath = Environment.PATH + "patient";

class PatientService {
   static Future login(String email,String password) async {
     return await http.get(Uri.parse(newPath + "/login/email/$email/password/$password"),headers: Environment.HEADERS);
  }
  static Future add(Patient patient) async {
    return await http.post(Uri.parse(newPath + "/add"),
        headers: Environment.HEADERS, body: json.encode(patient));
  }

  static Future update(Patient patient) async {
    return await http.post(Uri.parse(newPath + "/update"),
        headers: Environment.HEADERS, body: json.encode(patient));
  }

  static Future getAll() async {
    return await http.get(Uri.parse(newPath + "/getall"),headers: Environment.HEADERS);
  }

  static Future getByPatientId(int patientId) async {
    return  await http.get(Uri.parse(newPath + "/getBypatientId/$patientId"),headers: Environment.HEADERS);
  }

 


}