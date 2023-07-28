// ignore_for_file: prefer_const_constructors

import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:vendor/screens/basicScreen/check_login_page.dart';
import 'package:vendor/screens/homeScreens/Home_Page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnimatedSplashScreen(
        splashIconSize: 200,
        duration: 3000,
        nextScreen: Home_Page(),
        splash: Column(
          children: [
            Image.asset(
              "images/logo.png",
              height: 150,
              width: 250,
            ),
            // ignore: prefer_const_constructors
            Text(
              'Welcome Partner',
              style: TextStyle(
                  letterSpacing: 1,
                  color: Colors.green,
                  fontSize: 25,
                  fontWeight: FontWeight.w500),
            ),
          ],
        ),
        splashTransition: SplashTransition.fadeTransition,
      ),
    );
  }
}
