// ignore_for_file: camel_case_types, prefer_const_constructors, use_build_context_synchronously

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../homeScreens/Home_Page.dart';
import 'LoginPage.dart';

class check_login extends StatefulWidget {
  const check_login({Key? key}) : super(key: key);

  @override
  State<check_login> createState() => _check_loginState();
}

class _check_loginState extends State<check_login> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 0), () async {
      SharedPreferences pref3 = await SharedPreferences.getInstance();
      String? mobile = pref3.getString('mobile');
      if (mobile != null) {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => Home_Page()));
      } else {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => LoginScreen()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
