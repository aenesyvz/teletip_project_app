//https://www.udemy.com/course/sifirdan-flutter-ile-android-ve-ios-apps-development/ 
//https://www.youtube.com/playlist?list=PL_Wj0DgxTlJeLFYfRBfpFveEd9cQfIpDx
//https://www.youtube.com/watch?v=ynVj0G2W28k
import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:teletip_project_app/enviroment.dart';

const newPath = Environment.PATH + "mainsciencebranch";

class MainScienceBranchService {

   static Future getAllByMainScienceBranchId(int mainScienceBranchId) async{
    return await http.get(Uri.parse(newPath + "/getbyMainScienceBranchId/$mainScienceBranchId"),headers: Environment.HEADERS);
  }
  static Future getAll() async{
    return await http.get(Uri.parse(newPath + "/getall"),headers: Environment.HEADERS);
  }

 

}