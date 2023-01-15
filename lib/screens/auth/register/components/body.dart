import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:teletip_project_app/components/default_button.dart';
import 'package:teletip_project_app/screens/auth/register/components/registerForDoctor.dart';
import 'package:teletip_project_app/screens/auth/register/components/registerForPatient.dart';


class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;

     return Scaffold(
      appBar: appBar(),
      body: body(context, _height),
    );
  }

  Padding body(BuildContext context, double _height) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
           SizedBox(height: MediaQuery.of(context).size.height * 0.03),
              const Text(
                "Hoş Geldiniz !",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Text(
                "Kullanıcı tipinizi seçerek \n kaydolabilirsiniz!",
                textAlign: TextAlign.center,
              ),
             SizedBox(height: MediaQuery.of(context).size.height * 0.04),

          const SizedBox(height: 20,),
          DefaultButton(
            text: "Doktor olarak kaydol",
            press: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const DoctorForRegister()));
          }),
          SizedBox(height: _height * 0.06,),
          DefaultButton(
            text: "Hasta olarak kaydol",
            press: () {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const PatientForRegister()));
          })
        ],
      ),
    );
  }


  AppBar appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      leading:  GestureDetector(onTap: () => Navigator.pop(context),child: const Icon(Icons.arrow_back_ios_new,color:Colors.black)),
      title:  const Text("Kaydol",style: TextStyle(color: Colors.black),),
    );
  }

}