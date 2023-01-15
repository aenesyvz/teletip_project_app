import 'package:flutter/material.dart';
import 'package:teletip_project_app/screens/auth/register/register_screen.dart';
import 'package:teletip_project_app/screens/onboarding/components/body.dart';


class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: (() => Navigator.of(context).pop()),
          child: const Icon(Icons.arrow_back_ios,color: Colors.black,)),
          
        actions: [
          GestureDetector(
              onTap: (() => Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const RegisterScreen()))),
              child: const Padding(
                padding: EdgeInsets.only(right:30.0),
                child: Center(child: Text("Atla",style: TextStyle(color: Colors.black,fontSize: 20,fontWeight: FontWeight.bold),)),
              ))
        ],
      ),
      body: const Body(),
    );
  }
}
