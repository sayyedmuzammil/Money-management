import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_toggle_tab/flutter_toggle_tab.dart';
import 'package:money_management/main.dart';
import 'package:money_management/screens/Login_widget.dart';
import 'package:money_management/screens/forgot_pass.dart';
import 'package:money_management/screens/homeScreen.dart';
// import 'package:toggle_switch/toggle_switch.dart';

abstract class ThemeText {}

class SignUp_Screen extends StatefulWidget {
  const SignUp_Screen({Key? key}) : super(key: key);

  // Login_screen({this.currentSelected = 0, this.id});
  // int? id;
  // int currentSelected;

  @override
  State<SignUp_Screen> createState() => _SignUp_Screen();
}

class _SignUp_Screen extends State<SignUp_Screen> {
  var _selectedIndex = 1;
  final _username = TextEditingController();

  final _password = TextEditingController();

  final _globalKey = GlobalKey<FormState>();
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    //  final double height= MediaQuery.of(context).size.height;
    // final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    // TextDecoration.none;
    return Center(
      child: Stack(
        children: [
          widget_screen(),
          Container(
            margin: EdgeInsets.all(60),
            child: Center(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 80,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Row(
                          children: [
                            Stack(
                                //  direction: Axis.horizontal,
                                children: [
                                  Container(
                                    // decoration: BoxDecoration(border:Border.all(width: 2),),
                                    child: FlutterToggleTab(
                                      selectedBackgroundColors: [
                                        Styles.primary_black,
                                      ],
                                      unSelectedBackgroundColors: [
                                        Styles.primary_black.withOpacity(.2)
                                      ],

                                      width: 69,

                                      borderRadius: 25,

                                      selectedIndex: _selectedIndex,
                                      selectedTextStyle: TextStyle(
                                          color: Colors.white,
                                          fontSize: 17,
                                          fontFamily: 'nunito',
                                          fontWeight: FontWeight.w500),
                                      unSelectedTextStyle: TextStyle(
                                          color: Styles.primary_black,
                                          fontSize: 17,
                                          fontFamily: 'nunito',
                                          fontWeight: FontWeight.w500),
                                      labels: ["Sign In", "Sign Up"],
                                      // icons: [Icons.person,Icons.pregnant_woman],
                                      selectedLabelIndex: (index) {
                                        print("Selected Index $index");
                                        setState(() {
                                          _selectedIndex = index;
                                        });
                                      },
                                    ),
                                  ),

                                  // OutlinedButton(
                                  //   style: ElevatedButton.styleFrom(
                                  //       side: BorderSide(
                                  //           width: 1.5, color: Styles.primary_black),
                                  //       textStyle: TextStyle(
                                  //         fontSize: 17,
                                  //         color: Colors
                                  //             .black, /*  backgroundColor: Colors.red, */ /* Styles.primary_black, */
                                  //       ),
                                  //       // primary:Colors.white,
                                  //       shape: const StadiumBorder(),
                                  //       padding: EdgeInsets.symmetric(
                                  //         horizontal: 48,
                                  //         vertical: 10,
                                  //       )),
                                  //   onPressed: () {},
                                  //   child: Text(
                                  //     'Sign In',
                                  //     style: TextStyle(
                                  //       color: Styles.primary_black,
                                  //     ),
                                  //   ),
                                  // ),
                                ]),
                          ],
                        ),
                        SizedBox(
                          height: 50,
                        ),
                        _selectedIndex == 1
                            ? Container(
                                //this container is signup form
                                child: Form(
                                  key: _globalKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                            if (value == null ||
                                                value.isEmpty) {
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
                                            if (value == null ||
                                                value.isEmpty) {
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
                                            if (value == null ||
                                                value.isEmpty) {
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
                              )
                            : Container(
                                //this container from sign in form
                                child: Form(
                                  key: _globalKey,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                            if (value == null ||
                                                value.isEmpty) {
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
                                            if (value == null ||
                                                value.isEmpty) {
                                              return 'Password is Required';
                                            }
                                            if (value != 'muzammil@123') {
                                              return 'Please Enter valid Password';
                                            }
                                          },
                                          decoration: InputDecoration(
                                            // border: OutlineInputBorder(),
                                            hintText: 'Password',
                                            // hintStyle: ,
                                          ),
                                        ),
                                      ),
                                      Container(
                                        alignment: Alignment.centerRight,
                                        // margin: EdgeInsets,
                                        child: TextButton(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      const Forgot_password()),
                                            );
                                          },
                                          child: Text(
                                            'Forgot Password?',
                                            style: TextStyle(
                                                color: Styles.primary_black,
                                                fontSize: 12),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                      ],
                    ),

                    // Container(height: 1, color: Styles.primary_black.withOpacity(.3)),
                    Row(
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
                          onPressed: () {
                              Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                            HomeScreen()), (Route<dynamic> route) => false);
                          },
                          icon: ImageIcon(
                            AssetImage("assets/export/simple_logo.png"),
                            // color: Colors.pink,
                            size: 50,
                          ),
                          label: Text(
                            _selectedIndex == 1 ? 'Sign Up' : 'Sign In',
                            style: Styles.LoginHeader,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
