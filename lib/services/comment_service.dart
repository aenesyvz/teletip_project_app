//https://www.udemy.com/course/sifirdan-flutter-ile-android-ve-ios-apps-development/ 
//https://www.youtube.com/playlist?list=PL_Wj0DgxTlJeLFYfRBfpFveEd9cQfIpDx
//https://www.youtube.com/watch?v=ynVj0G2W28k
//https://www.youtube.com/playlist?list=PLXbYsh3rUPSzuLcZsIkpDmftSQbFmUq9x
import 'dart:convert';


import 'package:http/http.dart' as http;
import 'package:teletip_project_app/enviroment.dart';
import 'package:teletip_project_app/models/comment.dart';

const newPath = Environment.PATH + "comment";
class CommentService{
  
  static Future getAllByDoctorId(int doctorId) async {
    return await http.get(Uri.parse(newPath + "/doctorId/$doctorId"),headers: Environment.HEADERS);
  }

  
  static Future add(Comment comment) async {
    return await http.post(Uri.parse(newPath + "/add"),
        headers: Environment.HEADERS,
        body: json.encode(comment));
  }
}