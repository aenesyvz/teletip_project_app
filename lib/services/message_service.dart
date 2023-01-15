//https://www.udemy.com/course/sifirdan-flutter-ile-android-ve-ios-apps-development/ 
//https://www.youtube.com/playlist?list=PL_Wj0DgxTlJeLFYfRBfpFveEd9cQfIpDx
//https://www.youtube.com/watch?v=ynVj0G2W28k
import 'dart:convert';


import 'package:http/http.dart' as http;

import 'package:teletip_project_app/enviroment.dart';
import 'package:teletip_project_app/models/message.dart';

const newPath = Environment.PATH + "message";

class MessageService {

  static Future patientSendMessage(Message message)  async{
    return await http.post(Uri.parse(newPath + "/patientSendMessage"),headers: Environment.HEADERS, body: json.encode(message));
  }

  static Future doctorReplyMessage(Message message) async{
    return await http.post(Uri.parse(newPath + "/doctorReplyMessage"),headers: Environment.HEADERS, body: json.encode(message));
  }
  
  static Future getAllByPatientId(int patientId)async{
    return await http.get(Uri.parse(newPath + "/getallbypatientId/$patientId"),headers: Environment.HEADERS);
  }

  static Future getAllByDoctorId(int doctorId)async {
    return await http.get(Uri.parse(newPath + "/getallbydoctorId/$doctorId"),headers: Environment.HEADERS);
  }

  static Future delete(Message message)async {
    return await http.post(Uri.parse(newPath + "/delete"),headers: Environment.HEADERS, body: json.encode(message));
  }

  static Future getById(int id) async{
    return  await http.get(Uri.parse(newPath + "/getbyid/$id"),headers: Environment.HEADERS);
  }
  
  static Future getAll() async{
    return await http.get(Uri.parse(newPath + "/getall"),headers: Environment.HEADERS);
  }

  

}
