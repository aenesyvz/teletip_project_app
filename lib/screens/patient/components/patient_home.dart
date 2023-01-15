import 'dart:convert';


import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:teletip_project_app/components/default_button.dart';
import 'package:teletip_project_app/constants.dart';
import 'package:teletip_project_app/models/doctor.dart';
import 'package:teletip_project_app/models/doctor_specialty.dart';
import 'package:teletip_project_app/models/main_science_branch.dart';
import 'package:teletip_project_app/models/message.dart';
import 'package:teletip_project_app/models/patient.dart';
import 'package:teletip_project_app/models/profession.dart';
import 'package:teletip_project_app/screens/patient/patient_message_screen.dart';
import 'package:teletip_project_app/services/doctor_service.dart';
import 'package:teletip_project_app/services/doctor_specialty_service.dart';
import 'package:teletip_project_app/services/main_science_branch_service.dart';
import 'package:teletip_project_app/services/profession_servcie.dart';


class PatientHome extends StatefulWidget {
  final Patient patient;
  const PatientHome({super.key, required this.patient});

  @override
  State<PatientHome> createState() => _PatientHomeState();
}

class _PatientHomeState extends State<PatientHome> with SingleTickerProviderStateMixin  {
  List<Doctor> doctors = <Doctor>[];
  List<MainScienceBranch> mainScienceBranchs = <MainScienceBranch>[];
  List<Profession> professions = <Profession>[];
  String? doctorFirstName;
  MainScienceBranch? selectedMainScienceBranch;
  Profession? selectedprofession;
  int current = 0;
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 3, vsync: this);
    getListMainScienceBranch();
    getListProfession();
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _width = MediaQuery.of(context).size.width;
    List pageItems = [
      mainScienceBranchSearch(context),
      proffessionSearch(context),
      doctorSearch(context)
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      dragStartBehavior: DragStartBehavior.start,
      physics: const ScrollPhysics(),
    //  padding: const EdgeInsets.all(2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          header(),
          defaultTabController(context),
          doctorList(),
        ],
      ),
    );
  }
  //https://www.youtube.com/watch?v=W7S0GwYwayM - Örnek alınarak yapılmıştır
  ListView doctorList() {
    return ListView.separated(
           separatorBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal:32.0),
            child: Container(
                    height: 1,
                    color: Colors.grey.shade300, // Custom style
                  ),
          );
        }, 
          //https://stackoverflow.com/questions/50477809/flutter-listview-disable-scrolling-with-touchscreen  
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),             
          itemCount: doctors.length,
          itemBuilder: (context, int index) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal:8.0),
              child: ListTile( 
                //isThreeLine: true,
                leading: ClipOval(
                        child: SvgPicture.asset(
                          doctors[index].gender
                              ? "assets/images/woman1.svg"
                              : "assets/images/man1.svg", 
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                        ),
                      ),
                title: Text("${doctors[index].firstName} ${doctors[index].lastName}",overflow: TextOverflow.ellipsis),
                subtitle: Row(
                  children: [
                    Container(  
                       height: 10,
                       width: 10,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: doctors[index].activityStatus == true ? Colors.green :Colors.red,
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Flexible(child: Text(doctors[index].gender ? 'KADIN' : 'ERKEK',overflow: TextOverflow.ellipsis)),
                  ],
                ),
                 onTap: () {
                  Message newMessage = createdNewMessage();
                   Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PatientMessageScreen(
                            patient: widget.patient,
                            doctor: doctors[index],
                            message: newMessage,
                          ),
                        ),
                      );
              
                },
              ),
            );
          },
        );
  }

  Message createdNewMessage() => Message(-1, -1, -1, "", "", "", DateTime.now(), null);

  //https://divyanshu.dev/building-custom-tabbar-indicator-in-flutter-37a93c0fceff adresinden faydalanılmıştır
  DefaultTabController defaultTabController(BuildContext context) {
    var _height = MediaQuery.of(context).size.height;
    return DefaultTabController(
      animationDuration: const Duration(milliseconds: 700),
      initialIndex: 0,
      length: 3,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [   
          TabBar(
           // controller: _tabController,
            indicatorColor: Colors.blue.shade900,
            indicator: DotIndicator(color: Colors.blue.shade900,radius: 4),
            isScrollable: true,
            unselectedLabelStyle: const TextStyle(color: Colors.black),
            unselectedLabelColor: Colors.black54,     
            labelColor: Colors.blue.shade900,
            tabs: const [
              Tab(
                text: "Ana Bilim Dalı",
              ),
              Tab(
                text: "Uzmanlık Alanı",
              ),
              Tab(text: "Doktor Adı"),
            ],
            onTap: (value) {
              setState(() {
                doctors.clear();
              });
            },
          ),
          //https://stackoverflow.com/questions/52023610/getting-horizontal-viewport-was-given-unbounded-height-with-tabbarview-in-flu
          SizedBox(
            height: _height / 3.5,
            child: TabBarView(
              children: [
                mainScienceBranchSearch(context),
                proffessionSearch(context),
                doctorSearch(context),
            ]),
          ),
        ],
      ),
    );
  }

  Column doctorSearch(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: TextFormField(
              decoration: const InputDecoration(
                labelText: "Doktor Adı",
                hintText: "Doktorun adını giriniz",
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
              onChanged: (value) {
                doctorFirstName = value;
              }),
        ),
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: DefaultButton(
              text: "Doktor ismine göre ara",
              press: () {
                if (doctorFirstName != null && doctorFirstName.toString().isNotEmpty) {
                  doctors.clear();
                  getListDoctorByFirstName(doctorFirstName!);
                } else {
                  customShowAlert(context, "Hata", "Lütfen bir doktor ismi giriniz");
                }
              }),
        ),
      ],
    );
  }

  Column proffessionSearch(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(
          height: 20,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: DropdownButtonFormField<Profession>(
            isExpanded: true,
            decoration: InputDecoration(
            labelText: "Uzmanlık Alanı",
            labelStyle: TextStyle(color: kPrimaryColor),
            floatingLabelBehavior: FloatingLabelBehavior.always,
            
            ),  
            items: professions
                .map((x) => DropdownMenuItem(
                      child: Text(x.professionName),
                      value: x,
                    )).toList(),
            onChanged: (value) {
              setState(() {
                selectedprofession = value!;
              });
            },
            value: selectedprofession,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: DefaultButton(
              text: "Uzmanlık alanına göre doktor ara",
              press: () {
                if (selectedprofession != null) {
                  doctors.clear();
                  getListDoctorByProfessionId(selectedprofession!.professionId);
                } else {
                  customShowAlert(context, "Hata", "Lütfen bir uzmanlık alanı seçiniz!");
                }
              }),
        ),
      ],
    );
  }

  Column mainScienceBranchSearch(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20,),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: DropdownButtonFormField<MainScienceBranch>(
            isExpanded: true,
            decoration: InputDecoration(
              labelText: "Ana Bilim Dalı",
              labelStyle: TextStyle(color: kPrimaryColor),
              floatingLabelBehavior: FloatingLabelBehavior.always,
            ),
            items: mainScienceBranchs.map((x) => DropdownMenuItem(
                      child: Text(x.mainScienceBranchName),
                      value: x,
                    )).toList(),
            onChanged: (value) {
              setState(() {
                selectedMainScienceBranch = value!;
              });
            },
            value: selectedMainScienceBranch,
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: DefaultButton(
              text: "Anabilim Dalına Göre Doktor Ara",
              press: () {
                if (selectedMainScienceBranch != null) {
                  doctors.clear();
                  getListDoctorByMainScienceBranchId(selectedMainScienceBranch!.mainScienceBranchId);
                } else {
                  customShowAlert(context, "Hata", "Anabilim dalı seçmelisiniz!");
                }
              }),
        ),
      ],
    );
  }

  Padding header() {
    var _width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        width: double.infinity,
        height: 150,    
        decoration: BoxDecoration(
            color: Colors.blue.shade900,
            borderRadius: BorderRadius.circular(32),
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius:_width  / 7,
              backgroundColor: Colors.transparent,
              child: ClipOval(
                  child: SvgPicture.asset(
                    widget.patient.gender
                        ? "assets/images/woman1.svg"
                        : "assets/images/man1.svg",
                    width: 75,  
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                ),
            ),
            Flexible(
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Hoş geldiniz\n${widget.patient.firstName} ${widget.patient.gender ? 'Hanım' : 'Bey'}",
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(   
                    color: Colors.white,  
                    fontSize: 24.0,       
                    fontWeight: FontWeight.bold, 
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

//Internetten
 void customShowAlert(BuildContext context, String title, String message) {
    AlertDialog alertDialog = AlertDialog(
      title: Text(title),
      content: Text(message),
    );
    showDialog(context: context, builder: (BuildContext context) => alertDialog);
  }

  getListDoctorByFirstName(String firstName) {
    DoctorService.getAllByFirstName(firstName).then((res) {
      var data = json.decode(res.body)["data"];
        setState(() {
          doctors = (data as List).map((e) => Doctor.fromJson(e)).toList();
        });
    });
  }

  getListMainScienceBranch() {
    MainScienceBranchService.getAll().then((res) {
       var data = json.decode(res.body)["data"];
        setState(() {       
          mainScienceBranchs = (data as List).map((e) => MainScienceBranch.fromJson(e)).toList();
        });
    });
  }

 getListProfession() {
    ProfesionService.getAll().then((res) {
      var data = json.decode(res.body)["data"];
        setState(() {
           professions =  (data as List).map((e) => Profession.fromJson(e)).toList();
        });
    });
  }

  //Seçilen ana bilim dalına göre doktor getirir
  getListDoctorByMainScienceBranchId(int mainScienceBranchId) {
    DoctorService.getAllByMainScienceBranchId(mainScienceBranchId).then((res) {
        var data = json.decode(res.body)["data"];
        setState(() {
          doctors = (data as List).map((e) => Doctor.fromJson(e)).toList();
        });
    });
  }

   
  //Seçilen uzmanlık alanına göre doktor getirilir
  getListDoctorByProfessionId(int professionId) {
    DoctorSpecialtyService.getAllByProfessionId(professionId).then((res) {
        var dataDoctorSpecialty = json.decode(res.body)["data"];
        //Eğer seçilen uzmanlık alanına sahip  doktor varsa doktor listesine eklenir.
        for (var item in dataDoctorSpecialty) {
          //Uzmanlık alanları farklı bir tabloda tutulduğu için gelen verideki doktorId e göre doktor getirilir ve listeye eklenir.
          DoctorSpecialty doctorSpecialty = DoctorSpecialty.fromJson(item);
          DoctorService.getByDoctorId(doctorSpecialty.doctorId).then((res2) {
              setState(() {
                doctors.add(Doctor.fromJson(json.decode(res2.body)["data"][0]));
              });
          });
        }
    });
  }

 
}
//https://divyanshu.dev/building-custom-tabbar-indicator-in-flutter-37a93c0fceff
class DotIndicator extends Decoration {
  const DotIndicator({
    this.color = Colors.white,
    this.radius = 4.0,
  });

  final Color color;
  final double radius;

  @override
  BoxPainter createBoxPainter([VoidCallback? onChanged]) {
    return _DotPainter(
      color: color,
      radius: radius,
      onChange: onChanged,
    );
  }
}

class _DotPainter extends BoxPainter {
  _DotPainter({
    required this.color,
    required this.radius,
    VoidCallback? onChange,
  })  : _paint = Paint()
          ..color = color
          ..style = PaintingStyle.fill,
        super(onChange);

  final Paint _paint;
  final Color color;
  final double radius;

  @override
  void paint(Canvas canvas, Offset offset, ImageConfiguration configuration) {
    assert(configuration.size != null);
    final Rect rect = offset & configuration.size!;
    canvas.drawCircle(
      Offset(rect.bottomCenter.dx, rect.bottomCenter.dy - radius),
      radius,
      _paint,
    );
  }
}