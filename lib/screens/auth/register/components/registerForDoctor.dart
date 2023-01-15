import 'dart:convert';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:teletip_project_app/components/custom_suffix_icon.dart';
import 'package:teletip_project_app/components/default_button.dart';
import 'package:teletip_project_app/constants.dart';
import 'package:teletip_project_app/models/doctor.dart';
import 'package:teletip_project_app/models/doctor_specialty.dart';
import 'package:teletip_project_app/models/main_science_branch.dart';
import 'package:teletip_project_app/models/profession.dart';
import 'package:teletip_project_app/screens/auth/login/login_screen.dart';
import 'package:teletip_project_app/services/doctor_service.dart';
import 'package:teletip_project_app/services/doctor_specialty_service.dart';
import 'package:teletip_project_app/services/main_science_branch_service.dart';
import 'package:teletip_project_app/services/profession_servcie.dart';



class DoctorForRegister extends StatefulWidget {
  const DoctorForRegister({super.key});

  @override
  State<DoctorForRegister> createState() => _DoctorForRegisterState();
}

class _DoctorForRegisterState extends State<DoctorForRegister> {
  final _formKey = GlobalKey<FormState>();
  Doctor doctor = Doctor(-1,  "", "", "", "", "", false,-1,false, "", "", "");
  List<MainScienceBranch> mainScienceBranchs = <MainScienceBranch>[];
  MainScienceBranch? selectedMainScienceBranch;
  List<String> genders = ["Cinsiyetiniz", "Erkek", "Kadın"];
  String selectedGender ="Cinsiyetiniz";
  Map<Profession, bool> professions = <Profession, bool>{};

  @override
  void initState() {
    getAllMainScienceBranch();
    getAllProfession();
    super.initState();
  }

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
              SizedBox(
                height: _height * 0.05,
              ),
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
                          // suffixIcon:
                          //     CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
                          suffixIcon: Padding(
                            padding: const EdgeInsets.fromLTRB(
                              0,
                              20,
                              20,
                              20,
                            ),
                            child: Icon(
                              Icons.account_circle,
                              color: kPrimaryColor,
                            ),
                          )),

                      onChanged: (value) {},
                   
                      onSaved: (value) {
                        doctor.firstName = value.toString();
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
                        doctor.lastName = value.toString();
                      },
                    ),
                     SizedBox(
                      height: _height * 0.03,
                    ),
                      TextFormField(
                      decoration:  InputDecoration(
                        labelText: "Email",
                        labelStyle: TextStyle(color: kPrimaryColor),
                        hintText: "Email adresini giriniz",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon:
                            const CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
                      ),
                      onChanged: (value) {},
                    
                      onSaved: (value) {
                        doctor.email = value.toString();
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
                        doctor.password = value.toString();
                      },
                    ),
                    SizedBox(
                      height: _height * 0.03,
                    ), 
                    TextFormField(
                      decoration:  InputDecoration(
                        labelText: "Telefon Numarası",
                        labelStyle: TextStyle(color: kPrimaryColor),
                        hintText: "Telefon Numaranızı giriniz",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon:
                            const CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
                      ),

                      onChanged: (value) {},
                   
                      onSaved: (value) {
                        doctor.phoneNumber = value.toString();
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
                        // icon: Icon(Icons.wc_sharp,color: kPrimaryColor,)
                      ),
                      value: selectedGender,
                      items: genders
                          .map((item) => DropdownMenuItem<String>(
                                value: item,
                                child: Text(
                                  item,
                                ),
                              ))
                          .toList(),
                      onChanged: ((value) => setState(() {
                            selectedGender = value!;
                          })),
                    ),
                    SizedBox(
                      height: _height * 0.03,
                    ),
                  
                   
                    TextFormField(
                      decoration:  InputDecoration(
                        labelText: "Hastane ya da Klinik Adresi",
                        labelStyle: TextStyle(color: kPrimaryColor),
                        hintText: "Hastane ya da klinik Adresinizi giriniz",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon:
                            const CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
                      ),

                      onChanged: (value) {},
                  
                      onSaved: (value) {
                        doctor.hospital = value.toString();
                      },
                    ),
                    SizedBox(
                      height: _height * 0.03,
                    ),
                    TextFormField(
                      decoration:  InputDecoration(
                        labelText: "Fakülte",
                        labelStyle: TextStyle(color: kPrimaryColor),
                        hintText: "Mezun olduğunuz fakülteyi giriniz",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        suffixIcon:
                            const CustomSuffixIcon(svgIcon: "assets/icons/Lock.svg"),
                      ),

                      onChanged: (value) {},
                     
                      onSaved: (value) {
                        doctor.faculty = value.toString();
                      },
                    ),
                    SizedBox(
                      height: _height * 0.03,
                    ),

                 
                    DropdownButtonFormField<MainScienceBranch>(
                      isExpanded: true,
                      decoration:  InputDecoration(
                        labelText: "Ana bilim dalı",
                        labelStyle: TextStyle(color: kPrimaryColor),
                        hintText: "Ana bilim dalı seçiniz",
                        floatingLabelBehavior: FloatingLabelBehavior.always,                      
                      ),
                      onChanged: (value) {
                        setState(() {
                          selectedMainScienceBranch = value!;
                        });
                      },
                      items: mainScienceBranchs
                          .map((a) => DropdownMenuItem(
                                child: Text(a.mainScienceBranchName),
                                value: a,
                              ))
                          .toList(),
                      value: selectedMainScienceBranch,
                    ),
                  
                    SizedBox(height: _height * 0.03,),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const SizedBox(
                          height: 12,
                        ),
                         Text(
                          "Uzmanlık alanlarınızı seçiniz",
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.blue.shade900),
                        ),
                        const SizedBox(
                          height: 12,
                        ),
                        Flexible(
                          child: ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            scrollDirection: Axis.vertical,
                            itemCount: professions.length,
                            itemBuilder: (context, index) {
                              //https://stackoverflow.com/questions/72575035/how-to-loop-map-value-by-key
                              //https://stackoverflow.com/questions/45153204/how-can-i-handle-a-list-of-checkboxes-dynamically-created-in-flutter
                              Profession professionKey = professions.keys.toList()[index];
                              bool professionValue = professions.values.toList()[index];
                             
                              return CheckboxListTile(
                                activeColor: Colors.black,
                                title: Text(professionKey.professionName,style: const TextStyle(color: Colors.black),),
                                value: professionValue,
                                selected: professionValue,
                                onChanged: (value) {
                                  setState(
                                    () {
                                      professions[professionKey] = value!;
                                    },
                                  );
                                },
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              DefaultButton(
                text: "Doktor olarak kaydol",
                press: () {
                  createDoctor();
                },
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
          onTap: (() {
            Navigator.pop(context);
          }),
          child: Icon(Icons.arrow_back_ios_new, color: Colors.grey.shade700)),
      title: Text(
        "Doktor",
        style: TextStyle(color: Colors.grey.shade700),
      ),

    );
  }

  void showAlert(BuildContext context, String title, String message) {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (BuildContext context) => alert);
  }

  Future customRouteShowAlert(BuildContext context, String title, String message) {
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    return showDialog(context: context, builder: (BuildContext context) => alert);
  }


  void createDoctor() {
     if (_formKey.currentState!.validate()) {
      bool isWoman = selectedGender != "Erkek";
      doctor.activityStatus = false;
      doctor.gender = isWoman;
      _formKey.currentState!.save();
       if (selectedGender == "Cinsiyetiniz") {
        showAlert(
            context, "Hata", "Cinsiyet alanı boş geçilemez!");
        return;
      }
       if(doctor.password.isEmpty || doctor.password.length < 5){
        showAlert(context, "Hata", "Şifre 5 karakterden az olamaz!");
        return;
      }
      if(!EmailValidator.validate(doctor.email)){
         showAlert(context, "Hata", "Lütfen geçerli bir email adresi giriniz!");
        return;
      }
      if(doctor.lastName.isEmpty || doctor.lastName.length<3){
        showAlert(context, "Hata", "Soyad 3 karakterden az olamaz!");
        return;
      }
      if(doctor.firstName.isEmpty || doctor.firstName.length < 3){
        showAlert(context, "Hata", "İsim 3 karakterden az olamaz!");
        return;
      }
      if ( selectedMainScienceBranch == null) {
        showAlert(context, "Hata","Anabilim dalı boş geçilemez!");
        return;
      }
      if (!professions.values.toList().any((x) => x)) {
        showAlert(context, "Hata","Uzmanlık alanı boş geçilemez!");
        return;
      }
     
      if(doctor.phoneNumber.isEmpty || doctor.phoneNumber.length < 10){
        showAlert(context, "Hata", "Telefon numarası 10 karakterden az olamaz!");
        return;
      }
      doctor.mainScienceBranchId = selectedMainScienceBranch!.mainScienceBranchId;
    }else{
       showAlert(context, "Hata","Formu lütfen düzgün bir şekilde doldurun!");
        return;
    }

    DoctorService.add(doctor).then((res) {
      //Doktorun uzmanlık alanlarını veri tabanına kaydetmek için backendden gelen insertId değerini almalıyız ki uzmanlık alanlarını doktorId e göre ekleyebilelim
        doctor.doctorId = json.decode(res.body)["data"]["insertId"];
        for (var profession in professions.entries) {
          Profession itemProfession = profession.key;
          if (professions[itemProfession]!) {
            DoctorSpecialty addedDoctorSpecialty = DoctorSpecialty(1, doctor.doctorId, itemProfession.professionId);
            DoctorSpecialtyService.add(addedDoctorSpecialty);
          }
        }
        customRouteShowAlert(context, "Başarılı", "Doktor kaydınız başarıyla oluşturuldu doktor giriş ekranına basıp giriş yapınız").then((value) => {
           Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const LoginScreen()))
        
        });
    });
  }

  

  getAllProfession() {
    ProfesionService.getAll().then((res) {
        var dataProfession = json.decode(res.body)["data"];
        for (var profession in dataProfession) {
          Profession professionItem = Profession.fromJson(profession);
          setState(() {
            professions[professionItem] = false;
          });
        }
    });
  }

  getAllMainScienceBranch() {
    MainScienceBranchService.getAll().then((res) {
      var data = json.decode(res.body)["data"];
        setState(() {
          mainScienceBranchs = (data as List).map((e) => MainScienceBranch.fromJson(e)).toList();
        });
    });
  }

 
}
