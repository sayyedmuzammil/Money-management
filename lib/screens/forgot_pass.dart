import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_management/main.dart';
import 'package:money_management/screens/Login_widget.dart';

class Forgot_password extends StatelessWidget {
  const Forgot_password({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _username = TextEditingController();

    final _password = TextEditingController();

    final _globalKey = GlobalKey<FormState>();
    final formKey = GlobalKey<FormState>();
    return Stack(
      children: [
        login_widget(),
        Container(
          margin: EdgeInsets.all(60),
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 80,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    OutlinedButton(
                      style: OutlinedButton.styleFrom(
                        fixedSize: const Size(270, 40),
                        backgroundColor: Styles.primary_black,
                        // side: BorderSide(
                        //     width: 1.5, color: Styles.primary_black),
                        textStyle: TextStyle(
                          fontSize: 17,
                        ),
                        // primary:Colors.white,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {},
                      child: Text(
                        'Forgot Password',
                        style: Styles.boldwhite,
                      ),
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    Container(
                      //this container is signup form
                      child: Form(
                        key: _globalKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Card(
                              elevation: 0,
                              // width: 400, height: 50,
                              child: TextFormField(
                                controller: _username,
                                decoration: InputDecoration(
                                  // border: OutlineInputBorder(),
                                  hintText:
                                      'Enter Email or Username', /*  hintStyle: Styles.Normal15 */
                                ),
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'User Name is Required';
                                  } else if (value.startsWith(" ")) {
                                    return "User name should not contain whitespace";
                                  }
                                  if (value != 'muzammil') {
                                    return 'Please Enter valid User name';
                                  }
                                },
                              ),
                            ),
                            Card(
                              elevation: 0,
                              // width: 400, height: 50,
                              child: TextFormField(
                                controller: _password,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password is Required';
                                  }
                                  if (value != 'muzammil@123') {
                                    return 'Please Enter valid Password';
                                  }
                                },
                                decoration: InputDecoration(
                                  // border: OutlineInputBorder(),
                                  hintText: 'New Password',
                                  // hintStyle: ,
                                ),
                              ),
                            ),
                            Card(
                              elevation: 0,
                              // width: 400, height: 50,
                              child: TextFormField(
                                controller: _password,
                                obscureText: true,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Password is Required';
                                  }
                                  if (value != 'muzammil@123') {
                                    return 'Please Enter valid Password';
                                  }
                                },
                                decoration: InputDecoration(
                                  // border: OutlineInputBorder(),
                                  hintText: 'Confirm Password',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  // crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Text("in the login screen",style: Styles.LoginHeader, ),
                    ElevatedButton.icon(
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(272, 60),
                        textStyle: TextStyle(
                          fontSize: 25,
                          color: Styles.primary_black,
                        ),
                        primary: Styles.primary_black,
                        shape: const StadiumBorder(),
                      ),
                      onPressed: () {},
                      icon: ImageIcon(
                        AssetImage("assets/export/simple_logo.png"),
                        // color: Colors.pink,
                        size: 50,
                      ),
                      label: Text(
                        'Sign Up',
                        style: Styles.LoginHeader,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
