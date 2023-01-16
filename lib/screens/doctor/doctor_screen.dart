import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:teletip_project_app/models/doctor.dart';
import 'package:teletip_project_app/screens/doctor/components/doctor_home.dart';
import 'package:teletip_project_app/screens/doctor/components/doctor_message.dart';
import 'package:teletip_project_app/screens/doctor/components/doctor_profile.dart';
import 'package:teletip_project_app/services/doctor_service.dart';



import '../auth/login/login_screen.dart';

class DoctorScreen extends StatefulWidget {
  final Doctor doctor;
  const DoctorScreen({super.key,required this.doctor});

  @override
  State<DoctorScreen> createState() => _DoctorScreenState();
}

class _DoctorScreenState extends State<DoctorScreen> with WidgetsBindingObserver {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;

  @override void initState() {
    // TODO: implement initState
    WidgetsBinding.instance!.addObserver(this);
    super.initState();
  }
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){
      setState(() {
        widget.doctor.activityStatus = true;
      DoctorService.update(widget.doctor);
      });
      
    }else{
      setState(() {
        widget.doctor.activityStatus = false;
      DoctorService.update(widget.doctor);
      });
      
    }
    super.didChangeAppLifecycleState(state);
  }
   @override
  void dispose() {
    WidgetsBinding.instance!.removeObserver(this);
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final screens = [
      DoctorHome(doctor: widget.doctor),
      DoctorMessage(doctor: widget.doctor),
      DoctorProfile(doctor: widget.doctor)
    ];
    
  final items = <Widget>[
     const Icon(Icons.home,size:30),
     const Icon(Icons.message,size:30),
     const Icon(Icons.favorite,size: 30,),
  ];
  final titles = [
    "Ana sayfa",
    "Mesajlar",
    "Profilim"
  ];

    return SafeArea(child: Scaffold(
          extendBody: true,
          backgroundColor: Colors.white,
          appBar: AppBar(
            leading:  Icon(Icons.arrow_forward_ios_outlined,color:Colors.blue.shade900),
            title:  Text(titles[index],style: TextStyle(color: Colors.blue.shade900),),
            elevation: 0,
            centerTitle: false,
            actions: [
              Padding(
                padding: const EdgeInsets.only(right:32.0),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      widget.doctor.activityStatus = false;
                       DoctorService.update(widget.doctor);
                    });
                 
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                  },
                 
                  child: Icon(Icons.logout_rounded,color: Colors.blue.shade900,size: 30,)),
              )
            ],
          ),
          body:screens[index],
          bottomNavigationBar:Theme(
        data: Theme.of(context).copyWith(iconTheme: const IconThemeData(color:Colors.white)), 
        child: CurvedNavigationBar(
          key: navigationKey,
          backgroundColor: Colors.transparent,
          color: Colors.blue.shade900,
          buttonBackgroundColor: Colors.blue.shade900,
          height: 60,
          items: items,
          index: index,
          animationCurve: Curves.easeInOut,
          animationDuration: const Duration(milliseconds: 300),
          onTap: (index) => setState(() {
            this.index = index;
          }),)
        )
        ));
  }
}