import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teletip_project_app/components/custom_suffix_icon.dart';
import 'package:teletip_project_app/components/default_button.dart';
import 'package:teletip_project_app/models/patient.dart';
import 'package:teletip_project_app/services/patient_service.dart';


class PatientProfile extends StatefulWidget {
  final Patient patient;
  const PatientProfile({super.key, required this.patient});

  @override
  State<PatientProfile> createState() => _PatientProfileState();
}

class _PatientProfileState extends State<PatientProfile> {
  final _formKey = GlobalKey<FormState>();
  String? newEmail;
  String? newFirstName;
  String? newLastName;
  String? newPhone;
  String? newPassword;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
         body: body(context));
  }

  SingleChildScrollView body(BuildContext context) {
    return SingleChildScrollView(
        //physics: ClampingScrollPhysics(),
        child: Column(
          children: [
           formImage(context),
            formProfile(context),
            const SizedBox(
              height: 100,
            ),
            
          ],
        ),
      );
  }

  ClipOval formImage(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return ClipOval(
            child: SvgPicture.asset(
              widget.patient.gender
                  ? "assets/images/woman1.svg"
                  : "assets/images/man1.svg",
              width: _width / 2,
              height: _width / 2,
          
            ),
          );
  }

  Form formProfile(BuildContext context) {
    return Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    const SizedBox(height: 12,),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        decoration:  const InputDecoration(
                        labelText: "Email Adresiniz",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: 
                          CustomSuffixIcon(svgIcon: "assets/icons/Mail.svg"),
                        
                        ),
                         initialValue: widget.patient.email,
                        onChanged: (value) {},
                      
                        onSaved: (value) {
                          newEmail = value.toString();
                          widget.patient.email = newEmail.toString();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          decoration:  InputDecoration(
                        labelText: "Adınız",
                         floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon:  Padding(
                              padding: const EdgeInsets.fromLTRB(
                              0,
                              20,
                              20,
                              20,
                            ),
                              child: Icon(Icons.account_circle,color: Colors.blue.shade900,),
                            )
                        ),
                         initialValue: widget.patient.firstName,
                        onChanged: (value) {},
                     
                        onSaved: (value) {
                          newFirstName = value.toString();
                          widget.patient.firstName = newFirstName.toString();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        decoration:  InputDecoration(
                        labelText: "Soyadınız",
                         floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon: Padding(
                              padding: const EdgeInsets.fromLTRB(
                              0,
                              20,
                              20,
                              20,
                            ),
                              child: Icon(Icons.account_circle,color: Colors.blue.shade900,),
                            )
                        ),
                         initialValue: widget.patient.lastName,
                        onChanged: (value) {},
                      
                        onSaved: (value) {
                          newLastName = value.toString();
                          widget.patient.lastName = newLastName.toString();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                          decoration:  InputDecoration(
                            
                             floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon:  Padding(
                              padding: const EdgeInsets.fromLTRB(
                              0,
                              20,
                              20,
                              20,
                            ),
                              child: Icon(Icons.phone,color: Colors.blue.shade900,),
                            ),
                              labelText: "Telefon numaranız",),
                      initialValue: widget.patient.phoneNumber,
            
                        onChanged: (value) {},
                    
                        onSaved: (value) {
                          newPhone = value.toString();
                          widget.patient.phoneNumber = newPhone.toString();
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                          decoration:  const InputDecoration(
                            
                             floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon:   CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
                              labelText: "Şifreniz",),
                      initialValue: widget.patient.password,
            
                        onChanged: (value) {},
                    
                        onSaved: (value) {
                          newPassword = value.toString();
                          widget.patient.password = newPassword.toString();
                        },
                      ),
                    ),
                    const SizedBox(height: 30,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal:32.0),
                      child: DefaultButton(
                        // style: ElevatedButton.styleFrom(backgroundColor: Colors.blue.shade900),
                        text:"Profilimi güncelle",
                       
                        press: () {
                          if (_formKey.currentState!.validate()) {
                            _formKey.currentState!.save();
                            
                            Patient updatedPatient = createPatientModel();
                            
                             if(!EmailValidator.validate(updatedPatient.email)){
                                customShowAlert(context, "Hata", "Lütfen geçerli bir email adresi girin!");
                                return;
                              }
                             if(updatedPatient.firstName.length < 3){
                                customShowAlert(context, "Hata", "İsim 3 karakterden az olamaz!");
                                return;
                              }
                              if(updatedPatient.lastName.length < 3){
                                customShowAlert(context, "Hata", "Soyad 3 karakterden az olamaz!");
                                return;
                              }
                              if(updatedPatient.phoneNumber.length < 10){
                                customShowAlert(context, "Hata", "Telefon numarası 10 karakterden az olamaz!");
                                return;
                              }
                              if(newPassword!.length < 4){
                              customShowAlert(context, "Hata", "Şifre 4 karakterden az olamaz!");
                              return;
                            }
                            PatientService.update(updatedPatient);
                          }
                        },
                      ),
                    ),
                  ],
                ),
              ),
            );
  }

  Patient createPatientModel() {
    return Patient(
                              widget.patient.patientId,
                              newFirstName!,
                              newLastName!,
                              newEmail!,
                              newPassword!,                       
                              newPhone!,
                              widget.patient.gender,
                              true,
                              "");
  }

  void customShowAlert(BuildContext context, String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (BuildContext context) => alertDialog);
  }
}
