// import 'dart:html';
//popup container 800+
//this widget is add student 1200+
// import 'package:date_range_form_field/date_range_form_field.dart';
// import 'package:favorite_button/favorite_button.dart';
import 'dart:async';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:money_management/Custom_icons.dart';

import 'package:money_management/db_functions/db_functions.dart';

import 'package:money_management/screens/Sign%20Up_Screen.dart';

import 'package:money_management/db_functions/group_model.dart';

import '../ListView_option_Category.dart';
import '../home_widget_all.dart';
import '../main.dart';
import '../Add_or_Update_widget.dart';

class HomeScreen extends StatefulWidget {
  List<String> _year = [
    '2022',
    '2021',
    '2020',
  ];



  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  Map<String, double> dataMap = {};
var DataMap;
  getPieChartValue(_category) async {
    dataMap={};
    print(DataMap);
     print("in Pie chart $_category");
    final entireData = await PieChartValue(_category);
    for (var item in entireData) {
   String SingleItem= item['category'] as String;
   int SingleAmount= item['tot_amount'] as int;
   double Total = SingleAmount.toDouble();
   print("iteemmmmsss $SingleItem");
   print("iteemmmmsss $Total");
   dataMap[SingleItem]=Total;

  //  Map<String, double>
      
    }

// monthsofYear.add(); 
// monthsofYear [i]=;
// monthsofYear ;
   
      
      // monthsofYear[i]['1']=2;
      // print(monthsofYears);
      // print(entireData[i]['data']);
      // monthsofYears.add(DateFormat('MMMM')
      //     .format(DateTime(0, int.parse(entireData[i]['data']))));
      //     print("Month of years $monthsofYears");
    
    
    setState(() {
      DataMap =dataMap;
      
      // monthsofYears;
      // // print("Month Outside $monthsofYears");
      // monthsofYears.isNotEmpty?
      // dropdownvalue = monthsofYears[0].toString():Text(""); 
    });
  }

  
    String _isSelectedyear = '2022';
  var values;
  var allItem;
  int _incomeTot = 0;
  int _expenseTot = 0;
  int _lendTot = 0;
  int _borrowTot = 0;
  int _savingsTot = 0;
  String? dropdownvalue;
 List<String> monthsofYears = [];
// List<Map<String, String>> monthsofYear=[];
//   getCurrentYear() async {
//     final entireData = await CurrentYear(_isSelectedyear);
//     for (var i = 0; i < entireData.length; i++) {
//       print("entitedata $entireData");
// // monthsofYear.add(); 
// // monthsofYear [i]=;
// // monthsofYear ;
   
      
//       // monthsofYear[i]['1']=2;
//       // print(monthsofYears);
//       print(entireData[i]['data']);
//       monthsofYears.add(DateFormat('MMMM')
//           .format(DateTime(0, int.parse(entireData[i]['data']))));
//           print("Month of years $monthsofYears");
//     }
//     setState(() {
//       monthsofYears;
//       // print("Month Outside $monthsofYears");
//       monthsofYears!=''?
//       dropdownvalue = monthsofYears[0].toString():Text(""); 
//     });
//   }


  getMonths() async {
    final entireData = await ListForMonth();
    for (var i = 0; i < entireData.length; i++) {
      print("entitedata $entireData");
// monthsofYear.add(); 
// monthsofYear [i]=;
// monthsofYear ;
   
      
      // monthsofYear[i]['1']=2;
      // print(monthsofYears);
      print(entireData[i]['data']);
      monthsofYears.add(DateFormat('MMMM')
          .format(DateTime(0, int.parse(entireData[i]['data']))));
          print("Month of years $monthsofYears");
    }
    setState(() {
      monthsofYears;
      // print("Month Outside $monthsofYears");
      monthsofYears.isNotEmpty?
      dropdownvalue = monthsofYears[0].toString():Text(""); 
    });
  }

  getAllitem() async {
//  await getAllItems();
    int _incomeTotal = 0;
    int _expenseTotal = 0;
    int _lendTotal = 0;
    int _borrowTotal = 0;
    int _savingsTotal = 0;
    final entireData = await GroupByCategory();
    //  entireData
    // print("entire data ${entireData[1]}");

// print("hei                             this ${entireData[0]['category']}");
    for (var i = 0; i < entireData.length; i++) {
      String item = entireData[i]['category'];
      if (item == '1') {
        _incomeTotal = entireData[i]['tot_amount']!;
      }
      if (item == '2') {
        _expenseTotal = entireData[i]['tot_amount']!;
      }
      if (item == '3') {
        _lendTotal = entireData[i]['tot_amount']!;
      }
      if (item == '4') {
        _borrowTotal = entireData[i]['tot_amount']!;
      }
    }

    setState(() {
      // getAllItems();
      _incomeTot = _incomeTotal;
      _expenseTot = _expenseTotal;
      _lendTot = _lendTotal;
      _borrowTot = _borrowTotal;
      _savingsTot =
          (_incomeTotal + _borrowTotal) - (_expenseTotal + _lendTotal);
    });
    print("Income tota $_savingsTot");
  }

  bool _isUpdateClicked = false;
  bool _isAddorUpdate = false;
  int _card = 0;
  bool _overall = false;
  bool _addButton = false; //clicking add button
  bool _percentInd = false;
  int? currentIndex;
  // Initial Selected Value

  int _cardList = 0;
  // bool _addButton=false;

  // List of items in our dropdown menu
  // var monthsofYears = [
  //   'March',
  //   'February',
  //   'January',
  // ];

  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
      super.setState(() {});
    });
  }

  // final _income_controleer= TextEditingController();

  // final formKey = GlobalKey<FormState>();

  String? _dateCount;
  String? _range;
  var MonthData;

  @override
  void initState() {
    getMonths();
    getAllitem();
    _dateCount = '';
    _range = '';
    super.initState();
   
    //  var months= ListForMonth().then((value) =>   print("months $value"),  );
//  print("Months outside $months");
  }

  @override
  Widget build(BuildContext context) {
    //  var values;
    // GroupByCategory();
// dropdownvalue='no data';
    print("is update clicked $_isUpdateClicked");
    // print(allItem);

    // print("after fetching ${values.toString()}");

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Styles.primary_color,
      body: SafeArea(
        child: Stack(
          // mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        Container(
                          //main total savings container
                          alignment: Alignment.center,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                print("this is main gesture");
                                // _overall = true;
                                // _card = 0;
                                // _cardList = 0;
                                // bool _isUpdateClicked = false;
                                // bool _isAddorUpdate = false;
                              });
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
                                    "₹$_savingsTot",
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
                        Container(
                          //top icons home and more
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
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(25)),
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
                                        Navigator.of(context)
                                            .pushAndRemoveUntil(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        HomeScreen()),
                                                (Route<dynamic> route) =>
                                                    false);
                                      });
                                      // allItem==null?
                                      // print("item has null"):
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
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(25)),
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
                                              _isSelectedyear =
                                                  i.toString();
                                              print(_isSelectedyear);
                                            });
                                          },
                                          value: 1,
                                          child: i.toString() ==
                                                  _isSelectedyear
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
                      ],
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Stack(
                      children: [
                        Container(
                          width: size.width,
                          height: 200,
                          color: Colors.white,
                        ),
                        Column(
                          // main horizontal scroll view
                          children: [
                            Container(
                              // color: Colors.red,
                              // height: 50,
                              margin: EdgeInsets.only(left: 30),
                              child: _overall == false
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        // SizedBox(width: size,)
                                        Column(
                                          children: [
                                            dropdownvalue==null?SizedBox(height: 30,):
                                            DropdownButtonHideUnderline(
                                              child: DropdownButton(
                                                // elevation: 0,
                                                // Initial Value
                                                
                                                value: dropdownvalue,

                                                // Down Arrow Icon
                                                icon: const Icon(
                                                    Icons.arrow_drop_down),

                                                // Array list of items
                                                items: monthsofYears
                                                    .map((String items) {
                                                  return DropdownMenuItem(
                                                    value:
                                                        items, //march  selected
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
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Overall",
                                          style: Styles.normal20.copyWith(
                                              fontWeight: FontWeight.bold),
                                        ),
                                      ],
                                    ),
                            ),
                            Container(
                              //scroll view main

                              height: 140,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  SizedBox(
                                    width: 30,
                                  ),
                                  InkWell(
                                    onTap: () {
                                      setState(() {
                                        // currentIndex = null;
                                        // _cardList = 5;
                                        // _percentInd = true;
                                        // PieChartValue(_cardList);
                                      });
                                    },
                                    child: Stack(children: [
                                      Container(
                                        height: 140,
                                        width: 140,
                                        decoration: BoxDecoration(
                                          color: Styles.custom_savings_blue,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(30)),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Styles.primary_black
                                                  .withOpacity(
                                                      0.3), //color of shadow
                                              spreadRadius: 0.5, //spread radius
                                              blurRadius: 5,
                                              // blur radius
                                              offset: Offset(0,
                                                  3), // changes position of shadow
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
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
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
                                                    "₹$_savingsTot",
                                                    style: Styles.bold25,
                                                  )
                                                : Text(
                                                    "₹",
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
                                    onTap: () {
                                      setState(() {
                                           _percentInd = false;
                                          getPieChartValue(1);
                                        _cardList = 1;
                                        _percentInd = true;
                                        currentIndex = null;
                                        //  PieChartValue(_cardList);
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 140,
                                          width: 140,
                                          decoration: BoxDecoration(
                                            color: Styles.custom_income_green,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Styles.primary_black
                                                    .withOpacity(
                                                        0.3), //color of shadow
                                                spreadRadius:
                                                    0.5, //spread radius
                                                blurRadius: 5,
                                                // blur radius
                                                offset: Offset(0,
                                                    3), // changes position of shadow
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
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
                                                      "₹$_incomeTot",
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
                                    onTap: () {
                                      setState(() {
                                        _percentInd = false;
                                          getPieChartValue(2);
                                        _cardList = 2;
                                        _percentInd = true;
                                        currentIndex = null;
                                       
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 140,
                                          width: 140,
                                          decoration: BoxDecoration(
                                            color: Styles.custom_expense_red,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Styles.primary_black
                                                    .withOpacity(
                                                        0.3), //color of shadow
                                                spreadRadius:
                                                    0.5, //spread radius
                                                blurRadius: 5,
                                                // blur radius
                                                offset: Offset(0,
                                                    3), // changes position of shadow
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
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
                                                      "₹$_expenseTot",
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
                                    onTap: () {
                                      setState(() {
                                         _percentInd = false;
                                          getPieChartValue(3);
                                        _cardList = 3;
                                        _percentInd = true;
                                        currentIndex = null;
                                       
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 140,
                                          width: 140,
                                          decoration: BoxDecoration(
                                            color: Styles.custom_lend_yellow,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Styles.primary_black
                                                    .withOpacity(
                                                        0.3), //color of shadow
                                                spreadRadius:
                                                    0.5, //spread radius
                                                blurRadius: 5,
                                                // blur radius
                                                offset: Offset(0,
                                                    3), // changes position of shadow
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
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
                                                      "₹$_lendTot",
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
                                    onTap: () {
                                      setState(() {
                                         getPieChartValue(4);
                                        _cardList = 4;
                                        _percentInd = true;
                                        currentIndex = null;
                                        
                                      });
                                    },
                                    child: Stack(
                                      children: [
                                        Container(
                                          height: 140,
                                          width: 140,
                                          decoration: BoxDecoration(
                                            color: Styles.custom_borrow_pink,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(30)),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Styles.primary_black
                                                    .withOpacity(
                                                        0.3), //color of shadow
                                                spreadRadius:
                                                    0.5, //spread radius
                                                blurRadius: 5,
                                                // blur radius
                                                offset: Offset(0,
                                                    3), // changes position of shadow
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
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
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
                                                      "₹$_borrowTot",
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
                            SizedBox(height: 20,) 
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                _cardList >= 1
                    ? list_widget(
                      dataMap: DataMap,
                        size: size,
                        toggleisUpdateClicked: toggleisUpdateClicked,
                        card: _cardList,
                        percentIndicator: _percentInd,
                      )
                    : _isUpdateClicked
                        ? category_cards(
                            size: size, card: _card, add: _isAddorUpdate)
                        :
                        // home_content_all_widget(size: size, toggleisUpdateClicked: toggleisUpdateClicked, overall: _overall,)
                        _card >= 1
                            ? category_cards(
                                size: size, card: _card, add: _isAddorUpdate)
                            : home_content_all_widget(
                                size: size,
                                toggleisUpdateClicked: toggleisUpdateClicked,
                                // overall: _overall,
                              ),
              ],
            ),
            _addButton == true //popup container
                ? //IF CLICKED
                Positioned(
                    // ADD BUTTON POPUP A CONTAINER

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
                                        _isUpdateClicked = false;
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
                                        _isUpdateClicked = false;
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
                                        _isUpdateClicked = false;
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
                                          _isUpdateClicked = false;
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
                      child: Transform.rotate(
                        angle: 90 * pi / 180,
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
                                _card = 0;
                              });
                            }),
                      ),
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
                                _isUpdateClicked = false;
                                _percentInd = false;
                                _cardList = 1;
                                // _addButton
                                // _card=0;
                                _addButton = false;
                                _isAddorUpdate = false;
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
                                  _isUpdateClicked = false;
                                  _percentInd = false;
                                  _addButton = false;
                                  _isAddorUpdate = false;
                                  // _card=0;
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
                                  _isUpdateClicked = false;
                                  _percentInd = false;
                                  _addButton = false;
                                  _cardList = 3;
                                  _isAddorUpdate = false;

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
                                  _isUpdateClicked = false;
                                  _percentInd = false;
                                  _addButton = false;
                                  _cardList = 4;
                                  _isAddorUpdate = false; 

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
      _cardList = 0;
      _addButton = false;
      print("before $_isUpdateClicked");
      _isUpdateClicked ? _isUpdateClicked = false : _isUpdateClicked = true;
      print("it worked $_isUpdateClicked");
    });
  }
}

Future<dynamic> fetchingData() async {
  final values = await GroupByCategory();
  print("this is test value $values");
  await Future.delayed(const Duration(seconds: 2), () {});
  return await values;
  // print(grouped);
  var grouped;
  // print("${grouped.amount}");
  print("after fetching ${values}");
  await values.forEach((map) {
    grouped = groupModel.fromMap(map);
    print("this is category ${grouped.category}");
    print("this is amount ${grouped.totalAmount}");
  });
  // return grouped;
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
