import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teletip_project_app/components/custom_suffix_icon.dart';
import 'package:teletip_project_app/components/default_button.dart';
import 'package:teletip_project_app/models/doctor.dart';
import 'package:teletip_project_app/models/doctor_specialty.dart';
import 'package:teletip_project_app/models/main_science_branch.dart';
import 'package:teletip_project_app/models/profession.dart';
import 'package:teletip_project_app/services/doctor_service.dart';
import 'package:teletip_project_app/services/doctor_specialty_service.dart';
import 'package:teletip_project_app/services/main_science_branch_service.dart';
import 'package:teletip_project_app/services/profession_servcie.dart';

class DoctorProfile extends StatefulWidget {
  final Doctor doctor;
  const DoctorProfile({super.key,required this.doctor});

  @override
  State<DoctorProfile> createState() => _DoctorProfileState();
}

class _DoctorProfileState extends State<DoctorProfile> {
  Map<Profession, bool> professions = <Profession, bool>{};
  List<MainScienceBranch> mainScienceBranchs = <MainScienceBranch>[];
  MainScienceBranch? selectedMainScienceBranch;
 
  final _formKey = GlobalKey<FormState>();
  
  String? newFirstName;
  String? newLastName;
  String? newPhone;
  String? newEmail;
  String? newPassword;
  String? newHospital;
  String? newFaculty;


  @override
  void initState() {
    getListMainScienceBranch();
     getByMainScienceBranchId(widget.doctor.mainScienceBranchId);
    professions.clear();
    getListProfession();
   
  
  
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    var _width = MediaQuery.of(context).size.width;
    return Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
               Container(
                  height: 12,
                ),
              changeImage(context),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    children: [
                       Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            decoration:  InputDecoration(
                          labelText: "Adınız",
                           floatingLabelBehavior: FloatingLabelBehavior.always,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right:8.0),
                            child: Icon(Icons.person,color: Colors.blue.shade900,),
                          ),
                          ),
                           initialValue: widget.doctor.firstName,
                          onChanged: (value) {},
                       
                          onSaved: (value) {
                            newFirstName = value.toString();
                            widget.doctor.firstName = newFirstName.toString();
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
                            padding: const EdgeInsets.only(right:8.0),
                            child: Icon(Icons.person,color:Colors.blue.shade900,),
                          ),),
                           initialValue: widget.doctor.lastName,
                          onChanged: (value) {},
                     
                          onSaved: (value) {
                            newLastName= value.toString();
                            widget.doctor.lastName = newLastName.toString();
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.emailAddress,
                            decoration:  InputDecoration(
                            labelText: "Email Adresiniz",
                            floatingLabelBehavior: FloatingLabelBehavior.always,
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right:8.0),
                              child: Icon(Icons.email,color:Colors.blue.shade900,),
                            ),
                            ),
                             initialValue: widget.doctor.email,
                            onChanged: (value) {},
                         
                            onSaved: (value) {
                              newEmail = value.toString();
                              widget.doctor.email = newEmail.toString();
                            },
                          ),
                      ),
                      
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                          keyboardType: TextInputType.phone,
                            decoration:  InputDecoration(
                               floatingLabelBehavior: FloatingLabelBehavior.always,
                              suffixIcon: Padding(
                                padding: const EdgeInsets.only(right:8.0),
                                child: Icon(Icons.phone,color:Colors.blue.shade900,),
                              ),
                                labelText: "Telefon numaranız",),
                        initialValue: widget.doctor.phoneNumber,
            
                          onChanged: (value) {},
                      
                          onSaved: (value) {
                            newPhone = value.toString();
                            widget.doctor.phoneNumber = newPhone.toString();
                          },
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            decoration:  InputDecoration(
                              
                               floatingLabelBehavior: FloatingLabelBehavior.always,
                              suffixIcon: Padding(
                              padding: const EdgeInsets.fromLTRB(
                              0,
                              20,
                              20,
                              20,
                            ),
                              child: Icon(Icons.account_balance_outlined,color: Colors.blue.shade900,),
                            ),
                                labelText: "Hastane Ya da Klinik Adresi",),
                        initialValue: widget.doctor.hospital,
            
                          onChanged: (value) {},
                       
                          onSaved: (value) {
                            newHospital= value.toString();
                            widget.doctor.hospital = newHospital.toString();
                          },
                        ),
                      ),
                       Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextFormField(
                            decoration:  InputDecoration(
                               floatingLabelBehavior: FloatingLabelBehavior.always,
                              suffixIcon: Padding(
                              padding: const EdgeInsets.fromLTRB(
                              0,
                              20,
                              20,
                              20,
                            ),
                              child: Icon(Icons.account_balance_outlined,color: Colors.blue.shade900,),
                            ),
                                labelText: "Mezun Oldğunuz Fakülte",),
                        initialValue: widget.doctor.faculty,
            
                          onChanged: (value) {},
                      
                          onSaved: (value) {
                            newFaculty= value.toString();
                            widget.doctor.faculty = newFaculty.toString();
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
                        initialValue: widget.doctor.password,
            
                          onChanged: (value) {},
                      
                          onSaved: (value) {
                            newPassword = value.toString();
                            widget.doctor.password = newPassword.toString();
                          },
                        ),
                      ),
                    //   DropdownButtonFormField<MainScienceBranch>(
                    //   isExpanded: true,
                    //   decoration:  InputDecoration(
                    //     labelText: "Ana bilim dalı",
                    //     labelStyle: TextStyle(color: kPrimaryColor),
                    //     hintText: "Ana bilim dalı seçiniz",
                    //     floatingLabelBehavior: FloatingLabelBehavior.always,                      
                    //   ),
                    //   onChanged: (value) {
                    //     setState(() {
                    //       selectedMainScienceBranch = value!;
                    //     });
                    //   },
                    //   items: mainScienceBranchs
                    //       .map((a) => DropdownMenuItem(
                    //             child: Text(a.mainScienceBranchName),
                    //             value: a,
                    //           ))
                    //       .toList(),
                    //   value: selectedMainScienceBranch,
                    // ),
                  
                      const SizedBox(height: 30,),
                       Padding(
                        padding: const EdgeInsets.symmetric(horizontal:32.0),
                        child: DefaultButton(
                          text:"Profilimi güncelle",
                          press: () {
                            if (_formKey.currentState!.validate()) {
                              _formKey.currentState!.save();

                              Doctor updatedDoctor = createDoctorModelForProfile();
                              if(!EmailValidator.validate(updatedDoctor.email)){
                                customShowAlert(context, "Hata", "Lütfen geçerli bir email adresi girin!");
                                return;
                              }
                              if(updatedDoctor.lastName.isEmpty || updatedDoctor.lastName.length<3){
                                customShowAlert(context, "Hata", "Soyad 3 karakterden az olamaz!");
                                return;
                              }
                              if(updatedDoctor.firstName.isEmpty || updatedDoctor.firstName.length < 3){
                                customShowAlert(context, "Hata", "İsim 3 karakterden az olamaz!");
                                return;
                              }
                              if(updatedDoctor.phoneNumber.isEmpty || updatedDoctor.phoneNumber.length < 10){
                                customShowAlert(context, "Hata", "Telefon numarası 10 karakterden az olamaz!");
                                return;
                              }

                              DoctorService.update(updatedDoctor);
                            }
                          },
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                     
                      Column(
                         mainAxisSize: MainAxisSize.min,
                         mainAxisAlignment: MainAxisAlignment.center,
                         crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            height: 12,
                          ),
                          Text(
                            "Uzmanlık Alanları",
                            style: TextStyle(fontSize: 16,color: Colors.blue.shade900),
                          ),
                           Container(
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
                                  title: Text(professionKey.professionName,style: const TextStyle(color: Colors.black)),
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
                      const SizedBox(height: 12,),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal:16.0),
                        child: DefaultButton(
                          text: "Uzmanlık alanlarımı güncelle",
                          press: () {
                              DoctorSpecialtyService.getAllByDoctorId(widget.doctor.doctorId).then((res) {
                          
                                var data = json.decode(res.body)["data"];
                                List<DoctorSpecialty> DoctorSpecialties = (data as List).map((e) => DoctorSpecialty.fromJson(e)).toList();
                                //Uzmanlık alanları ile doktor uzmanlık alanları farklı tablolarda tutulduğu için eşleşme yapılması gerekmektedir
                                for (var profession in professions.entries) {
                                  Profession itemProfession = profession.key;
                                  bool status = profession.value;
                                  //https://stackoverflow.com/questions/45153204/how-can-i-handle-a-list-of-checkboxes-dynamically-created-in-flutter
                                  //Doktorun uzmanlık alanlarının içerisinde seçili gelen uzmanlık alanının var olup olmadığının kontrolu yapılır
                                  DoctorSpecialty? isDoctorSpecialty = DoctorSpecialties.firstWhereOrNull((y) => y.professionId == itemProfession.professionId);
                                    //Eğer uzmanlık alanı seçili ve daha önce eklenmemiş ise ekle
                                  if (status && isDoctorSpecialty == null) {
                                    DoctorSpecialty addedDoctorSpecialty = DoctorSpecialty(1,widget.doctor.doctorId,itemProfession.professionId);
                                    DoctorSpecialtyService.add(addedDoctorSpecialty);
                                  }
                                  
                                  //Eğer uzmanlık alanı seçili gelmediyse veya daha önce eklenmiş ise sil
                                  if (!status && isDoctorSpecialty != null ) {
                                    DoctorSpecialtyService.delete(isDoctorSpecialty);  
                                  }
                                 
                                }
                            });
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 12,
              ),
              const SizedBox(
                height: 80,
              ),
            ],
          ),
        ));
  }

  Doctor createDoctorModelForProfile() {
    return Doctor(
                                widget.doctor.doctorId,
                                newFirstName!,
                                newLastName!,                        
                              //  selectedMainScienceBranch.mainScienceBranchId,
                                newEmail!,
                                newPassword!,
                                newPhone!,
                                widget.doctor.gender,
                                widget.doctor.mainScienceBranchId,
                                true,
                                widget.doctor.imagePath,
                                newHospital!,
                                newFaculty!);
  }

  ClipOval changeImage(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    return ClipOval(
            child: SvgPicture.asset(
              widget.doctor.gender
                  ? "assets/images/woman1.svg"
                  : "assets/images/man1.svg",
              width: _width / 2,
              height: _width / 2,
            ),
          );
  }


  getListProfession() {
    ProfesionService.getAll().then((res) {
     var data = json.decode(res.body)["data"];
        DoctorSpecialtyService.getAllByDoctorId(widget.doctor.doctorId).then((res2) {
          var data2 =json.decode(res2.body)["data"];
            List<DoctorSpecialty> doctorSpecialties =  (data2 as List).map((e) => DoctorSpecialty.fromJson(e)).toList();
            for (var item in data) {
              Profession profession= Profession.fromJson(item);
              setState(() {
                //Doktorun sahip olduğu uzmanlık alanlarıyla karşılaştırma yapar. Varsa true yoksa false atar böylelikle arayüzde hangi uzmanlık alanının daha önceden seçildiği görülür
                professions[profession] = doctorSpecialties.any((y) => y.professionId == profession.professionId);
              });
            }
        });
    });
  }

  void customShowAlert(BuildContext context, String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (BuildContext context) => alertDialog);
  }

  getByMainScienceBranchId(int mainScienceBranchId){
    MainScienceBranchService.getAllByMainScienceBranchId(mainScienceBranchId).then((response) {
      var data = jsonDecode(response.body)["data"];
        setState(() {
           
              selectedMainScienceBranch = (data as List).map((e) => MainScienceBranch.fromJson(e)).toList()[0];
              print("csv");
              print( selectedMainScienceBranch!.mainScienceBranchName);
              print("object");
        });
    } );
  }

   getListMainScienceBranch() {
    MainScienceBranchService.getAll().then((res) {
     var data = json.decode(res.body)["data"];
        setState(() {
          mainScienceBranchs = (data as List).map((e) => MainScienceBranch.fromJson(e)).toList();
          print(mainScienceBranchs);
        });
    });
  }
}