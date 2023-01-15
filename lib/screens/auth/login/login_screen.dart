import 'package:flutter/material.dart';
import 'package:teletip_project_app/screens/auth/login/components/body.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: const Body(),
    );
  }

  AppBar appBar() {
    return AppBar(
        leading:  Icon(Icons.arrow_back_ios_new,color:Colors.grey.shade700),
        title:  Text("Giriş Yap",style: TextStyle(color: Colors.grey.shade700),),
      );
  }
}
