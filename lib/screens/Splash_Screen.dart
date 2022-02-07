import 'dart:async';

import 'package:flutter/material.dart';
import 'package:money_management/screens/Sign%20Up_Screen.dart';
import 'package:money_management/screens/Login_widget.dart';

class Splash_Screen extends StatefulWidget {
  // Splash_Screen({this.currentSelected = 0, this.id});
  // int? id;
  // int currentSelected;

  @override
  State<Splash_Screen> createState() => _SplashScreen();
}

class _SplashScreen extends State<Splash_Screen> {
  @override
  void initState() {
    // TODO: implement initState
    splash_check_future();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        widget_screen(),
        Container(
          child: Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/export/logo final.png",
                    height: 50,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Image.asset(
                    "assets/export/logo heading.png",
                    height: 30,
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<dynamic> splash_check_future() async {
    await Future.delayed(const Duration(seconds: 3), () {});
    await Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) {
      return SignUp_Screen();
    }));
  }
}
