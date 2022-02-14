// import 'dart:html';
//popup container 800+
import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:money_management/Custom_icons.dart';
import 'package:money_management/income_list_widget.dart';
import 'package:money_management/screens/Sign%20Up_Screen.dart';
// import 'Splash_Screen.dart';
// import 'package:money_management/my_flutter_app_icons.dart';

import '../home_widget_all.dart';
import '../main.dart';

class HomeScreen extends StatefulWidget {
  List<String> _year = [
    '2022',
    '2021',
    '2020',
  ];

  String _isSelectedyear = '2022';

  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  bool _isUpdateClicked = false; 
  bool _isAddorUpdate = false;
  int _card = 0;
  bool _overall = false;
  bool _addButton = false; //clicking add button
  bool _percentInd=false;
  int? currentIndex;
  // Initial Selected Value
  String dropdownvalue = 'March';
  int _cardList = 0;
  // bool _addButton=false;

  // List of items in our dropdown menu
  var items = [
    'March',
    'February',
    'January',
  ];

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
    });
  }

  final _category = TextEditingController();

  final _date = TextEditingController();
  final _amount = TextEditingController();

  final _remark = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  // final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    print("is update clicked $_isUpdateClicked");

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Styles.primary_color,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              //this coloumn stack 1
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Column(
                      children: [
                        Positioned(
                          top: 0,
                          right: size.width * 0.1,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _overall = true;
                                _card = 0;
                                _cardList = 0;
                                bool _isUpdateClicked = false;
                                bool _isAddorUpdate = false;
                              });
                              print("this is main gesture");
                            },
                            child: Container(
                              width: size.width * 0.8,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                    bottom: Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Styles.primary_black
                                        .withOpacity(0.3), //color of shadow
                                    spreadRadius: 1, //spread radius
                                    blurRadius: 6,
                                    // blur radius
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                    //first paramerter of offset is left-right
                                    //second parameter is top to down
                                  ),
                                  //you can set more BoxShadow() here
                                ],
                              ),
                              child: Column(
                                children: [
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Icon(
                                        Custom_icons.savings,
                                        color: Styles.primary_black,
                                        size: 27,
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        'Total Savings',
                                        style: TextStyle(
                                            fontFamily: 'nunito',
                                            fontSize: 20,
                                            fontWeight: FontWeight.w700,
                                            color: Styles.primary_black),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '₹1,54,500',
                                    style: TextStyle(
                                        fontFamily: 'nunito',
                                        fontSize: 30,
                                        fontWeight: FontWeight.w800,
                                        color: Styles.primary_black),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: size.width,
                      height: 200,
                      color: Colors.white,
                    ),
                  ],
                ),
              ],
            ),
            Column(
              //this coloumn stack 2
              children: [
                Container(
                  //top icons
                  margin: EdgeInsets.symmetric(
                    vertical: 20,
                    horizontal: 50,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        // width: 60,
                        // height: 60,
                        // color: Colors.red,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Styles.primary_black,
                            borderRadius: BorderRadius.all(Radius.circular(25)),
                          ),
                          alignment: Alignment.topLeft,
                          width: 35,
                          height: 35,
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                // _addButton=false;
                                //  _overall=false;
                                // _isAddorUpdate=false;
                                // _isUpdateClicked=false;
                                // _card=0;
                                // print(_card);
                                // currentIndex=null;
                                // _cardList=0;
                                // _overall=false;
                                // // _overall==false;
                                Navigator.of(context).pushAndRemoveUntil(
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()),
                                    (Route<dynamic> route) => false);
                              });
                              print("this is home icon");
                            },
                            icon: Icon(
                              Icons.home_outlined,
                              size: 20,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      Container(
                          child: Container(
                        decoration: BoxDecoration(
                          color: Styles.primary_black,
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                        alignment: Alignment.topLeft,
                        width: 35,
                        height: 35,
                        child: Center(
                          child: PopupMenuButton(
                            color: Styles.primary_black,
                            icon: Icon(
                              Icons.more_vert_outlined,
                              color: Colors.white,
                              size: 20,
                            ),
                            itemBuilder: (context) => [
                              PopupMenuItem<int>(
                                value: 0,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Favourites",
                                      style: Styles.boldwhite,
                                    ),
                                    Icon(
                                      Icons.favorite_outlined,
                                      size: 20,
                                      color: Colors.redAccent,
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem<int>(
                                value: 0,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Selected Year",
                                      style: Styles.normal17red,
                                    ),
                                    Icon(
                                      Icons.event_available_outlined,
                                      size: 20,
                                      color: Colors.redAccent,
                                    ),
                                  ],
                                ),
                              ),
                              for (var i in widget._year)
                                PopupMenuItem<int>(
                                  onTap: () {
                                    setState(() {
                                      widget._isSelectedyear = i.toString();
                                      print(widget._isSelectedyear);
                                    });
                                  },
                                  value: 1,
                                  child: i.toString() == widget._isSelectedyear
                                      ? Text(
                                          i.toString(),
                                          style: Styles.normal17red,
                                        )
                                      : Text(
                                          i.toString(),
                                          style: Styles.boldwhite,
                                        ),
                                ),
                              PopupMenuItem<int>(
                                onTap: () {
                                  print("on share app");
                                },
                                value: 3,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Share App",
                                      style: Styles.boldwhite,
                                    ),
                                    Icon(
                                      Icons.share_outlined,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem<int>(
                                onTap: () {
                                  print("Settings button");
                                },
                                value: 4,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Settings",
                                      style: Styles.boldwhite,
                                    ),
                                    Icon(
                                      Icons.settings_outlined,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                              PopupMenuItem<int>(
                                onTap: () {
                                  print("logout button");
                                  Log_out();
                                  //                                FocusScopeNode currentFocus = FocusScope.of(context);
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (ctx) {
                                    return SignUp_Screen();
                                  }));
                                  // Navigator.popUntil(context, ModalRoute.withName('/Splash_Screen'));
                                  // Navigator.pop(context);
                                },
                                value: 5,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Log Out",
                                      style: Styles.boldwhite,
                                    ),
                                    Icon(
                                      Icons.logout_outlined,
                                      size: 20,
                                      color: Colors.white,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                            onSelected: (item) => {print(item)},
                          ),
                        ),
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  // color: Colors.red,
                  height: 50,
                  margin: EdgeInsets.only(left: 30, top: 10),
                  child: _overall == false
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // SizedBox(width: size,)
                            Column(
                              children: [
                                DropdownButton(
                                  // Initial Value
                                  value: dropdownvalue,

                                  // Down Arrow Icon
                                  icon: const Icon(Icons.arrow_drop_down),

                                  // Array list of items
                                  items: items.map((String items) {
                                    return DropdownMenuItem(
                                      value: items, //march  selected
                                      child: Text(
                                        items,
                                        style: Styles.normal20,
                                      ),
                                    );
                                  }).toList(),
                                  // After selecting the desired option,it will
                                  // change button value to selected value
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      dropdownvalue = newValue!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ],
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              "Overall",
                              style: Styles.normal20
                                  .copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                ),
                // SizedBox(height: 10,),

                Container(
                  height: 140,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      SizedBox(
                        width: 30,
                      ),
                      InkWell(
                          onTap: (){
                            setState(() {
                              _cardList=5;
                            _percentInd=true;
                            });
                            
                          },
                        child: Stack(children: [
                          Container(
                            height: 140,
                            width: 140,
                            decoration: BoxDecoration(
                              color: Styles.custom_savings_blue,
                              borderRadius: BorderRadius.all(Radius.circular(30)),
                              boxShadow: [
                                BoxShadow(
                                  color: Styles.primary_black
                                      .withOpacity(0.3), //color of shadow
                                  spreadRadius: 0.5, //spread radius
                                  blurRadius: 5,
                                  // blur radius
                                  offset:
                                      Offset(0, 3), // changes position of shadow
                                  //first paramerter of offset is left-right
                                  //second parameter is top to down
                                ),
                                //you can set more BoxShadow() here
                              ],
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 10,
                            ),
                            width: 140,
                            height: 140,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Icon(
                                  Custom_icons.savings,
                                  size: 36,
                                  color: Styles.primary_black,
                                ),
                                Text(
                                  "Savings",
                                  style: Styles.normal17,
                                ),
                                _overall == false
                                    ? Text(
                                        "₹55,500",
                                        style: Styles.bold25,
                                      )
                                    : Text(
                                        "₹1,54,500",
                                        style: Styles.bold25,
                                      ),
                              ],
                            ),
                          ),
                        ]),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      InkWell(
                          onTap: (){
                            setState(() {
                              _cardList=1; 
                            _percentInd=true;
                            });
                            
                          },
                        child: Stack(
                          children: [
                            Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                color: Styles.custom_income_green,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Styles.primary_black
                                        .withOpacity(0.3), //color of shadow
                                    spreadRadius: 0.5, //spread radius
                                    blurRadius: 5,
                                    // blur radius
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                    //first paramerter of offset is left-right
                                    //second parameter is top to down
                                  ),
                                  //you can set more BoxShadow() here
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              width: 140,
                              height: 140,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Custom_icons.income,
                                    size: 36,
                                    color: Styles.primary_black,
                                  ),
                                  Text(
                                    "Income",
                                    style: Styles.normal17,
                                  ),
                                  _overall == false
                                      ? Text(
                                          "₹30,000",
                                          style: Styles.bold25,
                                        )
                                      : Text(
                                          "₹1,74,500",
                                          style: Styles.bold25,
                                        ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      InkWell(
                         onTap: (){
                            setState(() {
                              _cardList=2;
                            _percentInd=true;
                            });
                            
                          },
                        child: Stack(
                          children: [
                            Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                color: Styles.custom_expense_red,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Styles.primary_black
                                        .withOpacity(0.3), //color of shadow
                                    spreadRadius: 0.5, //spread radius
                                    blurRadius: 5,
                                    // blur radius
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                    //first paramerter of offset is left-right
                                    //second parameter is top to down
                                  ),
                                  //you can set more BoxShadow() here
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              width: 140, height: 140,
                              // color: Colors.blue,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Custom_icons.expense,
                                    size: 36,
                                    color: Styles.primary_black,
                                  ),
                                  Text(
                                    "Expense",
                                    style: Styles.normal17,
                                  ),
                                  _overall == false
                                      ? Text(
                                          "₹14,500",
                                          style: Styles.bold25,
                                        )
                                      : Text(
                                          "₹80,000",
                                          style: Styles.bold25,
                                        ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      InkWell( 
                         onTap: (){
                            setState(() {
                              _cardList=3;
                            _percentInd=true;
                            });
                            
                          },
                        child: Stack(
                          children: [
                            Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                color: Styles.custom_lend_yellow,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Styles.primary_black
                                        .withOpacity(0.3), //color of shadow
                                    spreadRadius: 0.5, //spread radius
                                    blurRadius: 5,
                                    // blur radius
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                    //first paramerter of offset is left-right
                                    //second parameter is top to down
                                  ),
                                  //you can set more BoxShadow() here
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              width: 140,
                              height: 140,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Custom_icons.lend,
                                    size: 30,
                                    color: Styles.primary_black,
                                  ),
                                  Text(
                                    "Lend",
                                    style: Styles.normal17,
                                  ),
                                  _overall == false
                                      ? Text(
                                          "₹10,000",
                                          style: Styles.bold25,
                                        )
                                      : Text(
                                          "₹10,000",
                                          style: Styles.bold25,
                                        ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      InkWell(
                         onTap: (){
                            setState(() {
                              _cardList=4;
                            _percentInd=true;
                            }); 
                            
                          },
                        child: Stack(
                          children: [
                            Container(
                              height: 140,
                              width: 140,
                              decoration: BoxDecoration(
                                color: Styles.custom_borrow_pink,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(30)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Styles.primary_black
                                        .withOpacity(0.3), //color of shadow
                                    spreadRadius: 0.5, //spread radius
                                    blurRadius: 5,
                                    // blur radius
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                    //first paramerter of offset is left-right
                                    //second parameter is top to down
                                  ),
                                  //you can set more BoxShadow() here
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                vertical: 10,
                              ),
                              width: 140,
                              height: 140,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                children: [
                                  Icon(
                                    Custom_icons.borrow,
                                    size: 32,
                                    color: Styles.primary_black,
                                  ),
                                  Text(
                                    "Borrow",
                                    style: Styles.normal17,
                                  ),
                                  _overall == false
                                      ? Text(
                                          "₹50,000",
                                          style: Styles.bold25,
                                        )
                                      : Text(
                                          "₹70,000",
                                          style: Styles.bold25,
                                        ),
                                ],
                              ),
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                    ],
                  ),
                ),

                SizedBox(
                  height: 20,
                ),

                _cardList >= 1
                    ? list_widget(
                        size: size,
                        toggleisUpdateClicked: toggleisUpdateClicked,
                        card: _cardList,
                        percentIndicator: _percentInd,
                      )
                    :

                   _isUpdateClicked?category_cards(size: size, card: _card, globalKey: _globalKey, category: _category, date: _date, amount: _amount, remark: _remark, add : _isAddorUpdate) :
                    // home_content_all_widget(size: size, toggleisUpdateClicked: toggleisUpdateClicked, overall: _overall,)
                    _card >= 1
                        ? category_cards(
                            size: size,
                            card: _card,
                            globalKey: _globalKey,
                            category: _category,
                            date: _date,
                            amount: _amount,
                            remark: _remark,
                            add: _isAddorUpdate)
                        : home_content_all_widget(
                            size: size,
                            toggleisUpdateClicked: toggleisUpdateClicked,
                            overall: _overall,
                          ),  
              ],
            ),
            _addButton == true //popup container
                ? //IF CLICKED ADD BUTTON POPUP A CONTAINER
                Positioned(
                    bottom: 90,
                    left: 47,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        Container(
                          // alignment: Alignment.bottomCenter,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ImageIcon(
                                AssetImage("assets/export/Union 1.png"),
                                size: 300,
                              ),
                            ],
                          ),
                          //add Button clicked
                          height: 150,
                          width: 300, /* color: Styles.primary_black */
                        ),
                        Container(
                          width: 280, height: 120,
                          /* color: Colors.red,  */
                          alignment: Alignment.topLeft,
                          // margin: EdgeInsets.all(10),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              SizedBox(
                                height: 5,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        
                                        _isAddorUpdate = true;
                                        _card = 1;
                                        _addButton = false;
                                        _cardList = 0;
                                          _isUpdateClicked=false;
                                      });
                                    },
                                    child: Container(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(
                                              Custom_icons.income,
                                              size: 24,
                                              color: Styles.primary_black,
                                            ),
                                            Text(
                                              "Income",
                                              style: Styles.normal17,
                                            )
                                          ],
                                        ),
                                      ),
                                      height: 40,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        color: Styles.custom_income_green,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        //
                                      ),
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _cardList = 0;
                                        _isAddorUpdate = true;
                                        _card = 2;
                                        _addButton = false;
                                           _isUpdateClicked=false;
                                      });
                                    },
                                    child: Container(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(
                                              Custom_icons.expense,
                                              size: 24,
                                              color: Styles.primary_black,
                                            ),
                                            Text(
                                              "Expense",
                                              style: Styles.normal17,
                                            )
                                          ],
                                        ),
                                      ),
                                      height: 40,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        color: Styles.custom_expense_red,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        _cardList = 0;
                                        _isAddorUpdate = true;
                                        _card = 3;
                                        _addButton = false;
                                           _isUpdateClicked=false;
                                      });
                                    },
                                    child: Container(
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(
                                              Custom_icons.lend,
                                              size: 24,
                                              color: Styles.primary_black,
                                            ),
                                            Text(
                                              "Lend",
                                              style: Styles.normal17,
                                            )
                                          ],
                                        ),
                                      ),
                                      height: 40,
                                      width: 130,
                                      decoration: BoxDecoration(
                                        color: Styles.custom_lend_yellow,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                    ),
                                  ),
                                  Container(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _cardList = 0;
                                          _isAddorUpdate = true;
                                          _card = 4;
                                          _addButton = false;
                                             _isUpdateClicked=false;
                                        });
                                      },
                                      child: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: [
                                            Icon(
                                              Custom_icons.borrow,
                                              size: 24,
                                              color: Styles.primary_black,
                                            ),
                                            Text(
                                              "Borrow",
                                              style: Styles.normal17,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                    height: 40,
                                    width: 130,
                                    decoration: BoxDecoration(
                                      color: Styles.custom_borrow_pink,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
                : Text(""),
            Positioned(
              //bottom navigation bar

              bottom: 0,
              left: 0,
              child: Container(
                width: size.width,
                height: 60,
                child: Stack(
                  overflow: Overflow.visible,
                  children: [
                    CustomPaint(
                      size: Size(size.width, 80),
                      painter: BNBCustomPainter(),
                    ),
                    Center(
                      heightFactor: 0.2,
                      child: FloatingActionButton(
                          backgroundColor: Styles.primary_black,
                          child: Icon(
                            Icons.add,
                            size: 40,
                          ),
                          elevation: 0.1,
                          onPressed: () {
                            setState(() {
                              _addButton == false
                                  ? _addButton = true
                                  : _addButton = false;
                               
                              // _cardList=0;
                              // _card=0;
                            });
                          }),
                    ),
                    Container(
                      width: size.width,
                      height: 60,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            icon: Icon(
                              Custom_icons.income,
                              color: currentIndex == 0
                                  ? Styles.primary_black
                                  : Colors.grey.shade400,
                            ),
                            onPressed: () {
                              setState(() {
                                _isUpdateClicked=false; 
                                _percentInd=false;
                                _cardList = 1;
                                _addButton = false;
                                setBottomBarIndex(0);
                                // print("_isadd $_isAddorUpdate");
                              });
                            },
                            splashColor: Colors.white,
                          ),
                          IconButton(
                              icon: Icon(
                                Custom_icons.expense,
                                color: currentIndex == 1
                                    ? Styles.primary_black
                                    : Colors.grey.shade400,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isUpdateClicked=false; 
                                   _percentInd=false;
                                  _addButton = false;
                                  _cardList = 2;
                                  setBottomBarIndex(1);
                                });
                              }),
                          Container(
                            width: size.width * 0.20,
                          ),
                          IconButton(
                              icon: Icon(
                                Custom_icons.lend,
                                color: currentIndex == 2
                                    ? Styles.primary_black
                                    : Colors.grey.shade400,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isUpdateClicked=false; 
                                   _percentInd=false;
                                  _addButton = false;
                                  _cardList = 3;

                                  setBottomBarIndex(2);
                                });
                              }),
                          IconButton(
                              icon: Icon(
                                Custom_icons.borrow,
                                color: currentIndex == 3
                                    ? Styles.primary_black
                                    : Colors.grey.shade400,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isUpdateClicked=false; 
                                   _percentInd=false;
                                  _addButton = false;
                                  _cardList = 4;

                                  setBottomBarIndex(3);
                                });
                              }),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> Log_out() async {
    await Future.delayed(const Duration(milliseconds: 1), () {});
    print("in function of logout");
    await Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) {
      return SignUp_Screen();
    }));
  }

  void toggleisUpdateClicked() {
    setState(() {
   _cardList=0; 
      _addButton=false;
      print("before $_isUpdateClicked");
      _isUpdateClicked ? _isUpdateClicked = false : _isUpdateClicked = true;
      print("it worked $_isUpdateClicked");
         
    });
  }
}

class category_cards extends StatelessWidget {
  const category_cards({
    Key? key,
    required this.size,
    required int card,
    required bool add,
    required GlobalKey<FormState> globalKey,
    required TextEditingController category,
    required TextEditingController date,
    required TextEditingController amount,
    required TextEditingController remark,
  })  : _card = card,
        _isAddorUpdate = add,
        _globalKey = globalKey,
        _category = category,
        _date = date,
        _amount = amount,
        _remark = remark,
        super(key: key);

  final Size size;
  final int _card;
  final bool _isAddorUpdate;
  final GlobalKey<FormState> _globalKey;
  final TextEditingController _category;
  final TextEditingController _date;
  final TextEditingController _amount;
  final TextEditingController _remark;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          //second container in list view
          // color: Colors.white,
          width: size.width,
          height: (size.height * .5) + 20,
          margin: EdgeInsets.all(10),
          // height: _content.length*30,
          // color: Colors.white,

          //  for (var i = 0; i < _content.length; i++) {
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              // scrollDirection: Axis.vertical,

              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Styles.primary_black
                            .withOpacity(0.3), //color of shadow
                        spreadRadius: 0.5, //spread radius
                        blurRadius: 5,
                        // blur radius
                        offset: Offset(0, 3), // changes position of shadow
                        //first paramerter of offset is left-right
                        //second parameter is top to down
                      ),
                      //you can set more BoxShadow() here
                    ],
                  ),
                  margin: EdgeInsets.all(10),
                  width: size.width,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        _card==1?
                        Text(
                          "Income",
                          style: Styles.normal17.copyWith(
                              color:
                                  Styles.custom_income_green),
                        ):_card==2?  Text(
                          "Expense",
                          style: Styles.normal17.copyWith(
                              color:
                                  Styles.custom_expense_red),
                        ):_card==3?
                        Text(
                          "Lend",
                          style: Styles.normal17.copyWith(
                              color:
                                  Styles.custom_lend_yellow),
                        ):_card==4?
                        Text(
                          "Borrow",
                          style: Styles.normal17.copyWith(
                              color:
                                  Styles.custom_borrow_pink),
                        ):Text(""),

                        Column(
                          children: [
                            Form(
                              key: _globalKey,
                              child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Card(
                                      elevation: 0,
                                      // width: 400, height: 50,
                                      child: TextFormField(
                                        enableSuggestions: true,
                                        controller: _category,
                                        decoration: InputDecoration(
                                            contentPadding: EdgeInsets.only(
                                              top: 15,
                                              bottom: 5,
                                              left: 30,
                                            ),
                                            // errorStyle: TextStyle(fontSize: 9, height: 0.3),
                                            // border: OutlineInputBorder(),
                                            hintText: 'Enter the Category',
                                            hintStyle: Styles.normal17.copyWith(
                                                fontSize: 15,
                                                color: Styles.primary_black
                                                    .withOpacity(
                                                        .8)) /*  hintStyle: Styles.Normal15 */
                                            ),
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'Category is required';
                                          } else if (value.startsWith(" ")) {
                                            return "category should not contain whitespace";
                                          }
                                        },
                                      ),
                                    ),
                                    Card(
                                      elevation: 0,
                                      // width: 400, height: 50,
                                      child: TextFormField(
                                        enableSuggestions: true,
                                        controller: _date,
                                        obscureText: true,
                                        // validator: (value) {

                                        // },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                            top: 15,
                                            bottom: 5,
                                            left: 30,
                                          ),
                                          // border: OutlineInputBorder(),
                                          hintText: 'Today',

                                          // hintStyle: ,
                                        ),
                                      ),
                                    ),
                                    Card(
                                      elevation: 0,
                                      // width: 400, height: 50,
                                      child: TextFormField(
                                        controller: _amount,
                                        obscureText: true,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'please enter the amount';
                                          } else if (value.startsWith(" ")) {
                                            return "amount should not contain whitespace";
                                          }
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                              top: 15, bottom: 5, left: 30),
                                          // border: OutlineInputBorder(),
                                          hintText: 'Enter the amount',
                                        ),
                                      ),
                                    ),
                                    Card(
                                      elevation: 0,
                                      // width: 400, height: 50,
                                      child: TextFormField(
                                        controller: _remark,
                                        obscureText: true,
                                        validator: (value) {
                                          if (value == null || value.isEmpty) {
                                            return 'remark is required';
                                          }
                                        },
                                        decoration: InputDecoration(
                                          contentPadding: EdgeInsets.only(
                                            top: 15,
                                            bottom: 5,
                                            left: 30,
                                          ),
                                          // border: OutlineInputBorder(),
                                          hintText: 'Remark',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            _isAddorUpdate == true
                                ? ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      fixedSize: const Size(90, 40),
                                      textStyle: TextStyle(
                                        fontSize: 25,
                                        color: Styles.primary_black,
                                      ),
                                      primary: Styles.primary_black,
                                      shape: const StadiumBorder(),
                                    ),
                                    onPressed: () {
                                      print("card value $_card");
                                      Navigator.of(context).pushAndRemoveUntil(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeScreen()),
                                          (Route<dynamic> route) => false);
                                    },
                                    child: Text(
                                      'ADD',
                                      style: Styles.boldwhite,
                                    ),
                                  )
                                : _isAddorUpdate == false
                                    ? ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(120, 40),
                                          textStyle: TextStyle(
                                            fontSize: 25,
                                            color: Styles.primary_black,
                                          ),
                                          primary: Styles.primary_black,
                                          shape: const StadiumBorder(),
                                        ),
                                        onPressed: () {
                                          //  _isAddorUpdate=false;
                                          print("card value $_card");
                                          Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                              HomeScreen()),
                                                  (Route<dynamic> route) =>
                                                      false);
                                        },
                                        child: Text(
                                          'UPDATE',
                                          style: Styles.boldwhite,
                                        ),
                                      )
                                    : Text(""),
                          ],
                        ),
                        // SizedBox(width: 10,),
                        // for (var i in _content)
                        //   GestureDetector(
                        //       child: Text(
                        //         i.toString(),
                        //         style: Styles.normal17,
                        //       ),
                        //       ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 60,
                ),
              ],
            ),
          ),

          // }
        ),
        Container(
            margin: EdgeInsets.all(60),
            child: Container(
              margin: EdgeInsets.symmetric(
                horizontal: 22,
                vertical: 8,
              ),
              child: Column(
                children: [
                  Icon(
                    Icons.category_outlined,
                    size: 24,
                    color: Styles.primary_black.withOpacity(.8),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Icon(
                    Icons.calendar_today_outlined,
                    size: 24,
                    color: Styles.primary_black.withOpacity(.8),
                  ),
                  SizedBox(
                    height: 34,
                  ),
                  Icon(
                    Icons.payments_outlined,
                    size: 24,
                    color: Styles.primary_black.withOpacity(.8),
                  ),
                  SizedBox(
                    height: 34,
                  ),
                  Icon(
                    Icons.note,
                    size: 24,
                    color: Styles.primary_black.withOpacity(.8),
                  ),
                  //  SizedBox(height: 32,),
                ],
              ),
            )),
      ],
    );
  }
}

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 10); // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 10);
    path.arcToPoint(Offset(size.width * 0.60, 10),
        radius: Radius.circular(40.0), clockwise: false);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0);
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 10);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
