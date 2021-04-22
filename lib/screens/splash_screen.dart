import 'package:covid19/screens/show_coutries.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:animator/animator.dart';
import 'dart:math';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    _handleScreen();
  }
  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Color(0xff003d64),
      body:Padding(
        padding: EdgeInsets.symmetric(horizontal: 65,vertical:height/3 ),
        child: Column(
          children: [
            Container(
              alignment: Alignment.topLeft,
              child: Animator(
                tween: Tween<double>(begin: 0, end: 2* pi),
                duration: Duration(seconds: 4),
                repeats: 0,
                builder: (_,AnimatorState,__)=>Transform.rotate(
                  angle:AnimatorState.value,
                  child: Image.asset('assets/coronapic/virus2.png',height: 100,width: 100,),
                ),

              ),
            ),
            SizedBox(height: 20,),
            Container(
              alignment: Alignment.center,
              child: ColorizeAnimatedTextKit(
                  repeatForever: true,
                  onTap: () {
                    print("Tap Event");
                  },
                  text: [
                    "Covid19 Information",

                  ],
                  textStyle: TextStyle(
                      fontSize: 30.0,
                      fontFamily: "Horizon",
                      fontWeight: FontWeight.bold
                  ),
                  colors: [
                    Color(0xffeb5955),
                    Color(0xfff58f8a),
                    Color(0xfff07872),
                    Color(0xffe5c3c1),
                  ],
                  textAlign: TextAlign.start,
                  alignment: AlignmentDirectional.topStart // or Alignment.topLeft
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _handleScreen() async{
    await Future.delayed(Duration(seconds: 4));
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context){
      return ShowCountries();
    }));
  }
}
