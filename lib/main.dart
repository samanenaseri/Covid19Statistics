//import 'package:covid19/screens/details_each_country.dart';
import 'package:covid19/screens/splash_screen.dart';
import 'package:flutter/material.dart';
//import 'package:covid19/component/box_report.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home:SplashScreen(),
    );
  }
}


