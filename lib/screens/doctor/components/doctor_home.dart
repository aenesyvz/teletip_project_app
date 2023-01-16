

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teletip_project_app/models/doctor.dart';

class DoctorHome extends StatefulWidget {
  final Doctor doctor;
  const DoctorHome({super.key,required this.doctor});

  @override
  State<DoctorHome> createState() => _DoctorHomeState();
}

class _DoctorHomeState extends State<DoctorHome> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
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
          header(),
          const SizedBox(
            height: 40,
          ),
          const Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.all(24.0),
              child: Text(
                "Herhangi bir notunuz bulunmamaktadır\nYeni bir not ekleyin",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black,fontSize: 24, ),
              ),
            ),
          ),
          const SizedBox(height: 40,),
          Padding(
            padding: const EdgeInsets.only(right:16.0),
            child: Align(alignment: Alignment.bottomRight,child: ElevatedButton(
              onPressed: (){}, child: const Icon(Icons.note_add,),
              style:ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade900),
            ),
              ),
          )
        ],
      ),
    );
  }
  
   Padding header() {
    var _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: SizedBox(
        width: double.infinity,
        height: 150,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: _width / 7,
              backgroundColor: Colors.transparent,
              child: ClipOval(
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
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "Hoş geldiniz\n${widget.doctor.firstName} ${widget.doctor.gender ? 'Hanım' : 'Bey'}",
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
  
  

}