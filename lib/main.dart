import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:teletip_project_app/screens/splash/splash_screen.dart';
import 'package:teletip_project_app/theme.dart';


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) => runApp(const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      theme: theme(),
      debugShowCheckedModeBanner: false,
      home: const SplashScreen(),
    );
  }
}