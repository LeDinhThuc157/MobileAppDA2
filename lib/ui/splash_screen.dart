import 'dart:async';
import 'package:appda2/ui/soft_button.dart';
import 'package:flutter/material.dart';
import 'home.dart';
import 'homePage.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 5000), () {
      Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => HomePage(),));
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF1F2F6),
      body: Center(
        child: CircularSoftButton(
            radius: 60,
            icon: Center(
              child: Image.asset('assets/splash.png', height: 75, width: 75,scale: 1,),
            )
        ),
      ),
    );
  }
}