import 'package:flutter/material.dart';

import 'package:teletip_project_app/constants.dart';
import 'package:teletip_project_app/models/onboard.dart';
import 'package:teletip_project_app/screens/auth/register/register_screen.dart';
import 'package:teletip_project_app/screens/onboarding/components/dot_indicator.dart';
import 'package:teletip_project_app/screens/onboarding/components/on_boarding_content.dart';

class Body extends StatefulWidget {
  const Body({super.key});

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  late PageController _pageController;

  int _pageIndex = 0;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                onPageChanged: (value) => setState(() {
                  _pageIndex = value;
                }),  
                itemCount: demoData.length,
                controller: _pageController,
                itemBuilder: (context, index) => OnBoardingContent(
                  image: demoData[index].image,
                  title: demoData[index].title, 
                  description: demoData[index].description),
              ),
            ),
            Row(
              children: [
                ...List.generate(
                  demoData.length, 
                  (index) =>  Padding(
                    padding: const EdgeInsets.only(right: 4),
                    child: DotIndicator(isActive: index == _pageIndex),
                  )
                ),
                const Spacer(),
                SizedBox(
                  height: 60,
                  width: 60,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(shape: const  CircleBorder(),backgroundColor:kPrimaryColor),
                    onPressed: () {
                      _pageIndex++;
                      print(_pageIndex);
                      if(_pageIndex >= 3){
                        Navigator.push(context,  MaterialPageRoute(builder: (context) => const RegisterScreen()));
                      }
                      _pageController.nextPage(duration: const Duration(milliseconds: 300),
                      curve: Curves.ease,
                      
                      ); },
                    child: const Icon(Icons.arrow_forward_ios_rounded,color: Colors.white,),
                  ),
                )
              ],
            ),
            const SizedBox(height: 24,),
          ],
        ),
      ),
    );
  }
}