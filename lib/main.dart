import 'package:flutter/material.dart';
import 'package:money_management/screens/Splash_Screen.dart';

void main() {
  runApp(MyApp());
}
class Styles{
 static const Color primary_color = Color(0xFF73BDC5);
 static const Color primary_black= Color(0xFF464E57);
 static const LoginHeader= TextStyle(
  fontSize: 24.0,
  color: Colors.white,
  fontFamily: 'nunito',
  fontWeight: FontWeight.w500,

);
static const boldwhite= TextStyle(
  fontSize: 17.0,
  color: Colors.white,
  fontFamily: 'nunito',
);

 }


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Bottom Nav Bar V2',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Splash_Screen(),
    );
  }
}
