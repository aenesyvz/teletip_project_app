
import 'package:flutter/material.dart';
import 'package:teletip_project_app/screens/auth/login/login_screen.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3)).then((value) => {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()))
    });
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
             Text("TeleTip",style: TextStyle(fontSize: 54,color: Colors.white,fontWeight: FontWeight.bold),),
            //  Padding(
            //   padding: EdgeInsets.symmetric(horizontal: 20.0,vertical: 8),
            //   child: Divider(color: Colors.white,),
            // ),
            //  Text("Software",style: TextStyle(fontSize: 36,color: Colors.white)),
            // // Image.asset("",fit: BoxFit.cover,)
          ],
        ),
      ),
    );
  }
}