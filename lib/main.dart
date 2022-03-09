import 'package:flutter/material.dart';
import 'package:money_management/screens/Settings.dart';
import 'package:money_management/screens/homeScreen.dart';
// import 'package:money_management/screens/homeScreen.dart';
import 'db_functions/db_functions.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await openDB();
  runApp(MyApp());
}

class Styles {
  static const Color primary_color = Color(0xFF73BDC5);
  static const Color primary_black = Color(0xFF464E57);
  static const Color custom_savings_blue = Color(0xFF9BC6E9);
  static const Color custom_income_green = Color(0xFFC8DD8E);
  static const Color custom_expense_red = Color(0xFFF57C61);
  static const Color custom_lend_yellow = Color(0xFFF7D644);
  //  Color.fromRGBO(247, 214, 68, 0.8),
  static const Color custom_borrow_pink = Color(0xFFDD99C3);
static const paragraphStructStyle=StrutStyle( 
    // fontSize: 14,
    height: 1.2,
    leading: 1.2, 
  );
  static const BodyStylePara= TextStyle(
                              fontSize: 15,
                              color: Colors.grey,
                              wordSpacing: 2);
  static const dropHeadStyle=TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ); 
  static const LoginHeader = TextStyle(
    fontSize: 24.0,
    color: Colors.white,
    fontFamily: 'nunito',
    fontWeight: FontWeight.w500,
  );

  static const bold25 = TextStyle(
    fontSize: 25.0,
    color: Styles.primary_black,
    fontFamily: 'nunito',
    fontWeight: FontWeight.bold,
  );
  static const boldwhite = TextStyle(
    fontSize: 17.0,
    color: Colors.white,
    fontFamily: 'nunito',
  );
  static const normal17red = TextStyle(
    fontSize: 17.0,
    color: Colors.redAccent,
    fontFamily: 'nunito',
  );
  static const normal17 = TextStyle(
    fontSize: 17.0,
    color: Styles.primary_black,
    fontFamily: 'nunito',
    // fontWeight: FontWeight.w700,
  );
  static const normal20 = TextStyle(
    fontSize: 20.0,
    color: Styles.primary_black,
    fontFamily: 'nunito',
  );
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Money X',
      theme: ThemeData(
        primarySwatch: Colors.blueGrey,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
  //      initialRoute: '/',
  // routes: {
  //   // When navigating to the "/" route, build the FirstScreen widget.
  //   '/': (context) =>  HomeScreen(),
  //   // When navigating to the "/second" route, build the SecondScreen widget.
  //   '/second': (context) => SettingsScreen(),
  // },
      home: HomeScreen(),
    );
  }
}
