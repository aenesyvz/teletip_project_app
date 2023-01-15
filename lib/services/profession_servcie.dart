//https://www.udemy.com/course/sifirdan-flutter-ile-android-ve-ios-apps-development/ 
//https://www.youtube.com/playlist?list=PL_Wj0DgxTlJeLFYfRBfpFveEd9cQfIpDx
//https://www.youtube.com/watch?v=ynVj0G2W28k
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:teletip_project_app/enviroment.dart';
import 'package:teletip_project_app/models/profession.dart';

const newPath = Environment.PATH + "profession";

class ProfesionService {
  
  static Future add(Profession profession)async {
    return await http.post(Uri.parse(newPath + "/add"),headers: Environment.HEADERS, body: json.encode(profession));
  }

 static Future getById(int id)async {
    return await http.get(Uri.parse(newPath + "/getbyid/$id"),headers: Environment.HEADERS);
  }

  static Future getAllByProfessionName(String professionName) async{
    return await http.get(Uri.parse(newPath + "/getbyname/$professionName"),headers: Environment.HEADERS);
  }
  
  static Future getAll() async{
    return await http.get(Uri.parse(newPath + "/getall"),headers: Environment.HEADERS);
  }

  

}