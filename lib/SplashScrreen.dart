import 'dart:async';
import 'package:flutter/material.dart';
import 'package:travelbillapp/HomeScreen.dart';
import 'package:travelbillapp/IntroductionSlider.dart';
class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = "/splash";
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {

    Timer(
        const Duration(seconds: 5),
            () =>
            Navigator?.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (BuildContext context) => IntroductionSliderScreen())));

    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/splash.png'),
              fit: BoxFit.cover),
        ),
      ),


      /*child: Image(
            image: AssetImage('assets/applogo.jpg'),
            width: 100,
            height: 100,
          )),*/
    );
  }
}
