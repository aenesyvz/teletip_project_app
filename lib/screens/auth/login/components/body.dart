import 'package:flutter/material.dart';
import 'package:teletip_project_app/components/no_account_text.dart';
import 'package:teletip_project_app/components/social_card.dart';
import 'package:teletip_project_app/screens/auth/login/components/login_form.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
      return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: SingleChildScrollView(
            child: Column(
              children: [
                 SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                const Text(
                  "Hoş Geldiniz!",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.03,),
                const Text(
                  "Kendinize ait mail adresi ve şifre ile giriş yapabilirsiniz ya da\nSosyal medya hesaplarıyla giriş yapabilirsiniz",
                  textAlign: TextAlign.center,
                ),
               SizedBox(height: MediaQuery.of(context).size.height * 0.04),

                const LoginForm(),
                
                SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SocialCard(
                      icon: "assets/icons/google-icon.svg",
                      press: () {},
                    ),
                    SocialCard(
                      icon: "assets/icons/facebook-2.svg",
                      press: () {},
                    ),
                    SocialCard(
                      icon: "assets/icons/twitter.svg",
                      press: () {},
                    ),
                  ],
                ),
                const SizedBox(height: 20,),
                const NoAccountText(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}