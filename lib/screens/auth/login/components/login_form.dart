//Flutter Way
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:teletip_project_app/components/custom_suffix_icon.dart';
import 'package:teletip_project_app/components/default_button.dart';
import 'package:teletip_project_app/constants.dart';
import 'package:teletip_project_app/helpers/keyboard_util.dart';
import 'package:teletip_project_app/models/doctor.dart';
import 'package:teletip_project_app/models/patient.dart';
import 'package:teletip_project_app/screens/doctor/doctor_screen.dart';
import 'package:teletip_project_app/screens/patient/patient_screen.dart';
import 'package:teletip_project_app/services/doctor_service.dart';
import 'package:teletip_project_app/services/patient_service.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key});

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  bool status = true;
  String? email;
  String? password;
  bool? remember = false;

  final List<String?> errors = [];

  void addError({String? error}){
    if(!errors.contains(error)){
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}){
    if(errors.contains(error)){
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
   return Form(
      key: _formKey,
      child: Column(
        children: [
          buildEmailFormField(),
          const SizedBox(height: 30,),
          buildPasswordFormField(),
          const SizedBox(height: 30,),
          Row(
            children: [
              Checkbox(
                value: remember,
                activeColor: kPrimaryColor,
                onChanged: (value) {
                  setState(() {
                    remember = value;
                  });
                },
              ),
              const Text("Beni hatırla"),
              const Spacer(),
              GestureDetector(
                // onTap: () =>  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const RegisterScreen())),
                child: const Text(
                  "Şifremi unuttum",
                  style:TextStyle(decoration: TextDecoration.underline),
                ),
              )
            ],
          ),
          GestureDetector(
            onTap: () =>setState(() {
               status = !status;
                _formKey.currentState!.reset();
            }),
            child: Text(status ? "Doktor Girişi İçin Tıklayınız":"Hasta Girişi İçin Tıklayınız",style:  TextStyle(color: kPrimaryColor,fontSize: 16)),
            ),
         // FormError(errors:errors),
          const SizedBox(height: 20,),
          DefaultButton(
            text: "Giriş Yap",
            press: () {
              if(_formKey.currentState!.validate()){
                _formKey.currentState!.save();
                KeyboardUtil.hideKeyboard(context);
                login();
              }
            },
          )
        ],
      ),
    );
  }

   TextFormField buildPasswordFormField() {
    return TextFormField(
      obscureText: true,
      onSaved: (newValue) => password = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kPassNullError);
        } else if (value.length >= 8) {
          removeError(error: kShortPassError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kPassNullError);
          return "";
        } else if (value.length < 3) {
          addError(error: kShortPassError);
          return "";
        }
        return null;
      },
      decoration:  InputDecoration(
        labelText: "Şifre",
         labelStyle: TextStyle(color: kPrimaryColor),
        hintText: "Şifrenizi giriniz",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
      ),
    );
  }

  TextFormField buildEmailFormField() {
    return TextFormField(
      keyboardType: TextInputType.emailAddress,
      onSaved: (newValue) => email = newValue,
      onChanged: (value) {
        if (value.isNotEmpty) {
          removeError(error: kEmailNullError);
        } else if (emailValidatorRegExp.hasMatch(value)) {
          removeError(error: kInvalidEmailError);
        }
        return null;
      },
      validator: (value) {
        if (value!.isEmpty) {
          addError(error: kEmailNullError);
          return "";
        } else if (!emailValidatorRegExp.hasMatch(value)) {
          addError(error: kInvalidEmailError);
          return "";
        }
        return null;
      },
      decoration:  InputDecoration(
        labelText: "Email",
        labelStyle: TextStyle(color: kPrimaryColor),
        hintText: "Email adresinizi giriniz",
        floatingLabelBehavior: FloatingLabelBehavior.always,
        suffixIcon: const CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
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

  
  void login() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (status) {
        PatientService.login(email.toString(),password.toString()).then((res) {
           var data =json.decode(res.body)["data"];
           print(data);
            if (data.isNotEmpty) {
                Patient patient = Patient.fromJson(data[0]);
                  patient.activityStatus = true;
                  PatientService.update(patient).then((updateRes) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  PatientScreen(patient: patient,)));
                  });
                } else {
                  customShowAlert(context, "Hata","E-posta adresiniz veya şifreniz hatalıdır!");
                }
        });
      } else {
        DoctorService.login(email.toString(),password.toString()).then((res) {
           var data =json.decode(res.body)["data"];
            if (data.isNotEmpty) {
                Doctor doctor = Doctor.fromJson(data[0]);
                  doctor.activityStatus = true;
                  DoctorService.update(doctor).then((updateRes) {
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) =>  DoctorScreen(doctor: doctor,)));
                  });
               
            } else {
              customShowAlert(context, "Hata", "E-posta adresiniz veya şifreniz hatalı");
            }
        });
      }
    }
  }
}