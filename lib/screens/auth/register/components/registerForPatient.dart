import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:teletip_project_app/components/custom_suffix_icon.dart';
import 'package:teletip_project_app/components/default_button.dart';
import 'package:teletip_project_app/constants.dart';
import 'package:teletip_project_app/models/patient.dart';

import 'package:teletip_project_app/screens/auth/login/login_screen.dart';
import 'package:teletip_project_app/services/patient_service.dart';


class PatientForRegister extends StatefulWidget {
  const PatientForRegister({super.key});

  @override
  State<PatientForRegister> createState() => _PatientForRegisterState();
}

class _PatientForRegisterState extends State<PatientForRegister> {
  final _formKey = GlobalKey<FormState>();
  Patient patient = Patient(-1, "", "", "", "", "", false, false, "");
   List<String> genders = [
    "Cinsiyetiniz",
    "Erkek",
    "Kadın"
  ];
  String? selectedGender = "Cinsiyetiniz";
  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: appBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: _height * 0.03,),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      decoration:  InputDecoration(
                        labelText: "İsim",
                        labelStyle: TextStyle(color: kPrimaryColor),
                        hintText: "İsminizi giriniz",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon:
                            const CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
                      ),

                      onChanged: (value) {},
                     
                      onSaved: (value) {
                        patient.firstName = value.toString();
                      },
                    ),
                    SizedBox(
                      height: _height * 0.03,
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                        labelText: "Soyad",
                        labelStyle: TextStyle(color: kPrimaryColor),
                        hintText: "Soyadınızı giriniz",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon:
                            const CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
                      ),
                      onChanged: (value) {},
                  
                      onSaved: (value) {
                        patient.lastName = value.toString();
                      },
                    ),
                    SizedBox(
                      height: _height * 0.03,
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: kPrimaryColor),
                        hintText: "Email adresinizi giriniz",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon:
                            const CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
                      ),
                      onChanged: (value) {},
                    
                      onSaved: (value) {
                        patient.email = value.toString();
                      },
                    ),
                    SizedBox(
                      height: _height * 0.03,
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                        labelText: "Şifre",
                        labelStyle: TextStyle(color: kPrimaryColor),
                        hintText: "Şifrenizi giriniz",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon:
                            const CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
                      ),
                      onChanged: (value) {},
                     
                      onSaved: (value) {
                        patient.password = value.toString();
                      },
                    ),
                    SizedBox(
                      height: _height * 0.03,
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                        labelText: "Telefon Numarası",
                        labelStyle: TextStyle(color: kPrimaryColor),
                        hintText: "Telefon numaranızı giriniz",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon:
                            const CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
                      ),

                      onChanged: (value) {},
                   
                      onSaved: (value) {
                        patient.phoneNumber = value.toString();
                      },
                    ),
                    SizedBox(
                      height: _height * 0.03,
                    ),
                     DropdownButtonFormField<String>(
                    decoration:  InputDecoration(
                        labelText: "Cinsiyet",
                      labelStyle: TextStyle(color: kPrimaryColor),
                      floatingLabelBehavior: FloatingLabelBehavior.always,
                    
                    ),
                    items: genders.map((item) => DropdownMenuItem<String>(
                      value: item,
                      child: Text(item,),
                    ) ).toList(),
                    value: selectedGender, 
                    onChanged: ((value) => setState(() {
                      selectedGender = value;
                    })),
                   ),
                   
                    const SizedBox(
                      height: 20,
                    ),
                    DefaultButton(
                      text: "Hasta kaydını oluştur",
                      press: () {
                        createPatient();
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      leading: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Icon(Icons.arrow_back_ios_new, color: Colors.grey.shade700)),
      title: Text(
        "Hasta Kaydı",
        style: TextStyle(color: Colors.grey.shade700),
      ),
    );
  }

  void customShowAlert(BuildContext context, String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (BuildContext context) => alertDialog);
  }

  Future customRouteShowAlert(BuildContext context, String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    return showDialog(context: context, builder: (BuildContext context) => alertDialog);
  }

  void createPatient() {
    if (_formKey.currentState!.validate()) {
      bool isWoman = selectedGender != "Erkek";
      patient.activityStatus = false;
      patient.gender = isWoman;
      _formKey.currentState!.save();
       if (selectedGender == "Cinsiyetiniz") {
        customShowAlert(context, "Hata", "Lütfen cinsiyetinizi seçiniz");
        return;
      }
       if(!EmailValidator.validate(patient.email)){
         customShowAlert(context, "Hata", "Lütfen geçerli bir email adresi giriniz!");
        return;
      }
        if(patient.firstName.length < 3){
        customShowAlert(context, "Hata", "İsim 3 karakterden az olamaz!");
        return;
      }
      if(patient.lastName.length < 3){
        customShowAlert(context, "Hata", "Soyad 3 karakterden az olamaz!");
        return;
      }
      if(patient.phoneNumber.length < 10){
        customShowAlert(context, "Hata", "Telefon numarası 10 karakterden az olamaz!");
        return;
      }
        if(patient.password.length < 4){
        customShowAlert(context, "Hata", "Şifre 5 karakterden az olamaz!");
        return;
      }
     
    }
    else{
       customShowAlert(context,"Hata","Lütfen formu düzgün bir şekilde doldurun!");
      return;
    }

    PatientService.add(patient).then((res) {
        customRouteShowAlert(context,"Başarılı" ,"Hasta kaydınız başarıyla oluşturuldu hasta giriş ekranına basıp giriş yapınız").then((value) => 
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => const LoginScreen()))
        );
    });
  }
}
