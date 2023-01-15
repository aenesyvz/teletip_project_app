import 'dart:convert';

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:teletip_project_app/models/patient.dart';
import 'package:teletip_project_app/screens/patient/components/patient_home.dart';
import 'package:teletip_project_app/screens/patient/components/patient_message.dart';
import 'package:teletip_project_app/screens/patient/components/patient_profile.dart';
import 'package:teletip_project_app/services/patient_service.dart';

import '../auth/login/login_screen.dart';

class PatientScreen extends StatefulWidget {
  final Patient patient;
  const PatientScreen({super.key, required this.patient});

  @override
  State<PatientScreen> createState() => _PatientScreenState();
}

class _PatientScreenState extends State<PatientScreen> {
  final navigationKey = GlobalKey<CurvedNavigationBarState>();
  int index = 0;
  @override
  Widget build(BuildContext context) {
    final screens = [
      PatientHome(patient: widget.patient),
      PatientMessage(patient: widget.patient),
      PatientProfile(patient: widget.patient)
    ];

    final items = <Widget>[
      const Icon(Icons.home, size: 30),
      const Icon(Icons.search, size: 30),
      const Icon(
        Icons.favorite,
        size: 30,
      ),
    ];
    final titles = ["Ana sayfa", "Mesajlar", "Profilim"];
    return SafeArea(
        child: Scaffold(
            extendBody: true,
            backgroundColor: Colors.white,
            appBar: AppBar(
              backgroundColor: Colors.white,
              leading: Icon(Icons.arrow_forward_ios_outlined,
                  color: Colors.blue.shade900),
              title: Text(
                titles[index],
                style: TextStyle(color: Colors.blue.shade900),
              ),
              elevation: 0,
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 16.0),
                  child: GestureDetector(
                      onTap: () {
                        setState(() {
                          widget.patient.activityStatus = false;
                          PatientService.update(widget.patient);
                        });
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
                      },
                      child: Icon(Icons.logout_outlined,
                          color: Colors.blue.shade900)),
                )
              ],
            ),
            body: screens[index],
            bottomNavigationBar: Theme(
                data: Theme.of(context).copyWith(
                    iconTheme: const IconThemeData(color: Colors.white)),
                child: CurvedNavigationBar(
                  key: navigationKey,
                  backgroundColor: Colors.transparent,
                  color: Colors.blue.shade900,
                  buttonBackgroundColor: Colors.red,
                  height: 60,
                  items: items,
                  index: index,
                  animationCurve: Curves.easeInOut,
                  animationDuration: const Duration(milliseconds: 300),
                  onTap: (index) => setState(() {
                    this.index = index;
                  }),
                ))));
  }
}
