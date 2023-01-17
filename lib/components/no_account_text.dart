
import 'package:flutter/material.dart';
import 'package:teletip_project_app/constants.dart';
import 'package:teletip_project_app/screens/onboarding/onboarding_screen.dart';

class NoAccountText extends StatelessWidget {
  const NoAccountText({super.key});

  @override
  Widget build(BuildContext context) {
   return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          "Hesabınız yok mu? ",
          style: TextStyle(fontSize: 16),
        ),
        GestureDetector(
          onTap: () => Navigator.push(context,  MaterialPageRoute(builder: (context) => const OnboardingScreen())),
          child:  Text(
            "Hesap Aç",
            style: TextStyle(
                fontSize: 16,
                color: kPrimaryColor),
          ),
        ),
      ],
    );
  }
}