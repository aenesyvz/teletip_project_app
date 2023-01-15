import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingContent extends StatelessWidget {
  const OnBoardingContent({super.key,required this.image,required this.title,required this.description});

  final String image,title,description;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(),
        // Image.asset(image,height: 250,),
        SvgPicture.asset(image,height: 200,),
        const Spacer(),
        Text(title,textAlign: TextAlign.center,style: Theme.of(context).textTheme.headline5!.copyWith(fontWeight: FontWeight.w500),),
        const SizedBox(height: 10,),
        Text(description,textAlign: TextAlign.center,),
        const Spacer(),
      ],
    );
  }
}