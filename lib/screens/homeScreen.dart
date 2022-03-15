import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:money_management/Custom_icons.dart';
import 'package:money_management/db_functions/db_functions.dart';
import 'package:money_management/screens/Settings.dart';
import 'package:sqflite/sqflite.dart';
import '../ListView_option_Category.dart';
import '../home_widget_all.dart';
import '../main.dart';
import '../Add_or_Update_widget.dart';
import 'Sign Up_Screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
  // List<String> _About = [/* 'Developer : Muzammil', */ 'version : 1.0'];
  //  var year=getYearDB();
  var dateRange;
  var _selectedStartDate;
  var _selectedEndDate;
  Map<String, double> dataMap = {};
  var DataMap;
  getPieChartValue(_category) async {
    dataMap = {};
    final entireData = await PieChartValue(
        category: _category,
        startDate: _selectedStartDate,
        endDate: _selectedEndDate,
        overall: _overall);
    entireData.isNotEmpty ? setPie(entireData) : null;
  }

  void setPie(entireData) {
    for (var item in entireData) {
      String SingleItem = item['category'] as String;
      int SingleAmount = item['tot_amount'] as int;
      double Total = SingleAmount.toDouble();
      dataMap[SingleItem] = Total;
    }
    setState(() {
      DataMap = dataMap;
    });
  }
  bool _favoriteVisible = false;
  String? dropdownvalue;
  Map<int, String> monthsofYearsMap = {};

  int _incomeTot = 0;
  int _expenseTot = 0;
  int _lendTot = 0;
  int _borrowTot = 0;
  int _savingsTot = 0;
  int _savingsOverall = 0;
  bool _isAbout=false;

  var currentMonth = DateTime.now().month;
  // ignore: prefer_typing_uninitialized_variables
  var currentMonthText;
  // ignore: non_constant_identifier_names
  String DisplayDate = '';

  late Database _db2;
  // ignore: prefer_typing_uninitialized_variables
  late var monthLastDate;
  // ignore: prefer_typing_uninitialized_variables
  late var monthFirstDate;
  // ignore: prefer_typing_uninitialized_variables
  var startText;
  // ignore: prefer_typing_uninitialized_variables
  var endText;
  Future<void> getTotalSavings() async {
    _db2 = await openDatabase('money.db', version: 1, 
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE MoneyManage (id INTEGER PRIMARY KEY, category TEXT, item TEXT, date DATE, amount INTEGER, remark TEXT, favourite TEXT)');
    });

    monthFirstDate = _overall == false
        ? await _db2.rawQuery(
            "SELECT date FROM MoneyManage WHERE (strftime('%m', date)='0$currentMonth') OR (strftime('%m', date)='$currentMonth') ORDER BY date ASC LIMIT 1 ")
        : await _db2.rawQuery(
            "SELECT date FROM MoneyManage ORDER BY date ASC LIMIT 1 ");
    monthLastDate = await _db2
        .rawQuery("SELECT date FROM MoneyManage ORDER BY date DESC LIMIT 1");
    final List ls = monthFirstDate;
print("88 before $monthFirstDate, $monthLastDate, $currentMonth"); 
    if (ls.isNotEmpty) {
      _selectedStartDate = await monthFirstDate[0]['date'].toString();
      _selectedEndDate = await monthLastDate[0]['date'].toString();
  
    }

    currentMonthText = (DateFormat('MMM')
        .format(DateTime(0, int.parse('$currentMonth'.toString()))));
    final entireData = await GroupByCategory(Tsavings: true);
    final List la=entireData;
    if( la.isEmpty)
    {
      setState(() {
     
        _savingsOverall=0;
      });
    }
    else{
    for (var i = 0; i < entireData.length; i++) {
      String item = entireData[i]['category'];
      if (item == '1') {
        _incomeTot = entireData[i]['tot_amount']!;
      }
      if (item == '2') {
        _expenseTot = entireData[i]['tot_amount']!;
      }
      if (item == '3') {
        _lendTot = entireData[i]['tot_amount']!;
      }
      if (item == '4') {
        _borrowTot = entireData[i]['tot_amount']!;
      }
    }




      _savingsOverall = (_incomeTot + _borrowTot) - (_expenseTot + _lendTot); 
    print("88 $_savingsOverall , $_incomeTot, $_expenseTot, $_lendTot, $_borrowTot, $_selectedStartDate, $_selectedEndDate");
    }
    setState(() {
      _savingsOverall;
    });
    getPieChartValue(_cardList);
    getAllitemWidget();
   
  }

  int _incomeTotal = 0;
  int _expenseTotal = 0;
  int _lendTotal = 0;
  int _borrowTotal = 0;
  getAllitemWidget() async {
    _incomeTotal = 0;
    _expenseTotal = 0;
    _lendTotal = 0;
    _borrowTotal = 0;
    final entireData = _selectedStartDate != null
        ? await GroupByCategory(
            startDate: _selectedStartDate,
            endDate: _selectedEndDate,
          )
        : await GroupByCategory(overall: _overall);

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
      _incomeTot = _incomeTotal;
      _expenseTot = _expenseTotal;
      _lendTot = _lendTotal;
      _borrowTot = _borrowTotal;
      _savingsTot = (_incomeTot + _borrowTot) - (_expenseTot + _lendTot);
      
    print("888 $_savingsTot , $_incomeTot, $_expenseTot, $_lendTot, $_borrowTot, $_selectedStartDate, $_selectedEndDate");
    });
  }

  Map<String, Object?> __selectedcontent = {};
  String _selectedCategory='';

  bool _isUpdateClicked = false;
  bool _isAddorUpdate = false;
  int _card = 0;
  bool _overall = false;
  bool _addButton = false; //clicking add button
  bool _percentInd = false;
  int? currentIndex;
  int _cardList = 0;
  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
      super.setState(() {});
    });
  }

  @override
  void initState() {
    getTotalSavings();
    setState(() {});
    _card = 0;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
          startText =  _selectedStartDate!=null?
          DateFormat('MMM dd').format(DateTime.parse(_selectedStartDate)):null;
       endText = _selectedStartDate!=null?DateFormat('MMM dd').format(DateTime.parse(_selectedEndDate)):null;

   _selectedStartDate == null
            ? _savingsOverall == 0 
        ? DisplayDate = "There is No Data"
        : DisplayDate = "No Data in Current Month"
            :  DisplayDate ='''$startText - $endText''';

    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Styles.primary_color,
      body: SafeArea(
        child: Stack(
          children: [
            Column(
              children: [
                Column(
                  children: [
                    Overall_inkwell_main(size, context),
                    const SizedBox(
                      height: 20,
                    ),
                    scrollView_container(size, context),
                  ],
                ),
                _cardList >= 1
                    ? list_widget(
                        dataMap: DataMap,
                        size: size,
                        toggleisUpdateClicked: toggleisUpdateClicked,
                        card: _cardList,
                        percentIndicator: _percentInd,
                        isOverall: _overall,
                        startDate: _selectedStartDate,
                        endDate: _selectedEndDate,
                        favoriteVisible: _favoriteVisible,
                      )
                    /* : _isUpdateClicked && _favoriteVisible == false
                        ? category_cards(
                            selectedcontent: __selectedcontent,
                            size: size,
                            card: _card,
                            add: _isAddorUpdate) */
                        : (_card >= 1 || _isUpdateClicked )&& _favoriteVisible == false
                            ? category_cards(
                                selectedcontent: __selectedcontent,
                                size: size,
                                card: _card,
                                add: _isAddorUpdate,
                                toggleAddorUpdateClicked: toggleAddorUpdateClicked,
                               )
                            : home_content_all_widget(
                                size,
                                toggleisUpdateClicked,
                                _overall,
                                _favoriteVisible,
                                _selectedStartDate,
                                _selectedEndDate),
              ],
            ),
            _addButton == true //popup container
                ? addButton_container()
                : Container(),
            bottomNavigation_buttons(size),
          ],
        ),
      ),
    );
  }

  Stack Overall_inkwell_main(Size size, BuildContext context) {
    return Stack(
                    children: [
                      Container(
                        //main total savings container
                        alignment: Alignment.center,
                        child: Tooltip(
                          message: "Tap here Switch to Overall", 
                          child: InkWell(
                            onTap: () {
                              setState(() {
                                // print("this is main gesture");
                                currentIndex=null;
                                currentMonth = 0;
                                _overall = true;
                                _card = 0;
                                _cardList = 0;
                                _isUpdateClicked = false;
                                _isAddorUpdate = false;
                                _selectedStartDate = null;
                                getTotalSavings();
                              });
                            },
                            child: Container(
                              width: size.width * 0.8,
                              height: 100,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: const BorderRadius.vertical(
                                    bottom: Radius.circular(50)),
                                boxShadow: [
                                  BoxShadow(
                                    color: Styles.primary_black
                                        .withOpacity(0.3), //color of shadow
                                    spreadRadius: 1, //spread radius
                                    blurRadius: 6,
                                    // blur radius
                                    offset:  const Offset(
                                        0, 3), // changes position of shadow
                                    //first paramerter of offset is left-right
                                    //second parameter is top to down
                                  ),
                                  //you can set more BoxShadow() here
                                ],
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
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
                                    "₹$_savingsOverall",
                                    style: const TextStyle(
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
                      ),
                      Container(
                        //top icons home and more
                        margin: const EdgeInsets.symmetric(
                          vertical: 20,
                          horizontal: 50,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              decoration: const BoxDecoration(
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
                                    _addButton=false;
                                     _overall=false;
                                    _isAddorUpdate=true;
                                    _isUpdateClicked=false;
                                    _card=0;
                                    print(_card);
                                    currentIndex=null;
                                    _cardList=0;
                                    _overall=false;
                                     _favoriteVisible=false;
                                        // _addButton=false;
                                        _percentInd = false;
                                        _cardList = 0;
                                        // _percentInd = true;
                                        currentIndex = null;
                                        __selectedcontent={};
                                        currentMonth =DateTime.now().month;
                                                            // DisplayDate = 'Choose Date Range';
                                                            DisplayDate =
                                                                '''$startText - $endText''';
                                                            dateRange = null;
                                                            _selectedStartDate =
                                                                null;
                                    getTotalSavings(); 
                                    // // _overall==false;
                                    /* Navigator.of(context).pushAndRemoveUntil(
                                        MaterialPageRoute(
                                            builder: (ctx) =>
                                                HomeScreen()),
                                        (Route<dynamic> route) => false); */
                                  });
                                },
                                icon: const Icon(
                                  Icons.home_outlined,
                                  semanticLabel: "Home",
                                  size: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            Container(
                              decoration: const BoxDecoration(
                                color: Styles.primary_black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(25)),
                              ),
                              alignment: Alignment.topLeft,
                              width: 35,
                              height: 35,
                              child: Center(
                                child: popup_menu_button_main(context),
                              ),
                            ),
                          ],
                        ),
                      ),
                    
                    ],
                  );
  }

 PopupMenuButton<int> popup_menu_button_main(BuildContext context) {
    return PopupMenuButton(
                                  
                                  color: Styles.primary_black,
                                  icon: const Icon(
                                    Icons.more_vert_outlined,
                                    // semanticLabel: "Menu Button", 
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  itemBuilder: (context) => [
                                    PopupMenuItem<int>(
                                      value: 0,
                                      onTap: () {
                                        setState(() {
                                          // _cardList=0;
                                          currentIndex=null;
                                          _card=0;
                                          _cardList=0;
                                          //  _percentInd = false;
                                          _favoriteVisible == true
                                              ? _favoriteVisible = false
                                              : _favoriteVisible = true;
                                        });
                                      },
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Favourites",
                                            style: _favoriteVisible == false
                                                ? Styles.boldwhite
                                                : Styles.normal17red,
                                          ),
                                          const Icon(
                                            Icons.favorite_outlined,
                                            size: 20,
                                            color: Colors.redAccent,
                                          ),
                                        ],
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
                                        children: const [
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

                                      value: 4,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
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
                                      value: 5,
                                      onTap:(){
                                   
                                      },
                                       
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
                                          Text(
                                            "About",
                                            style: Styles.boldwhite, 
                                             ),
                                          Icon(
                                            Icons.info_outline,
                                            size: 20,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                   
                               /*      PopupMenuItem<int>(
                                      onTap: () {
                                        print("logout button");
                                        Log_out();
                                      
                                      },
                                      value: 5,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: const [
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
                                */  
                                  ],
                                  // onSelected: (item) => {print(item)},
                                  onSelected: (result) {
                                    if(result==5){
                                      _showAbout();
                                    }
  if (result == 4) {
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => SettingsScreen()),
      );
  }
},
  );
  }

  Stack scrollView_container(Size size, BuildContext context) {
    return Stack(
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
                            margin: const EdgeInsets.only(left: 30),
                            child: _overall == false
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    children: [
                                      Column(
                                        children: [
                                         const SizedBox(
                                            height: 15,
                                          ),
                                          Row(
                                            children: [
                                              Tooltip(
                                                message: "tap to Select a new date range! current date range is ",  
                                                child: InkWell(
                                                    onTap: () {
                                                      currentMonth = 0;
                                                      pickDateRange(context);
                                                    },
                                                    child: Row(
                                                      children: [
                                                      const Icon(
                                                          Icons
                                                              .calendar_today_sharp,
                                                          size: 20,
                                                          color: Styles
                                                              .primary_black,
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Text(
                                                          DisplayDate,
                                                          style: Styles.normal17
                                                              .copyWith(
                                                                  // fontSize: 17,
                                                                  color: Colors
                                                                      .deepOrange,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold),
                                                        ),
                                                      ],
                                                    )),
                                              ),
                                             const SizedBox(
                                                width: 10,
                                              ),
                                              dateRange != null
                                                  ? Tooltip(
                                                    message: "tap to go default range! defaut date range is current month. ",
                                                    child: InkWell(
                                                        onTap: () {
                                                          setState(() {
                                                            currentMonth =
                                                                DateTime.now()
                                                                    .month;
                                                            // DisplayDate = 'Choose Date Range';
                                                            DisplayDate =
                                                                '''$startText - $endText''';
                                                            dateRange = null;
                                                            _selectedStartDate =
                                                                null;
                                                          });
                                                          getTotalSavings();
                                                        },
                                                        child: const Icon(
                                                          Icons.close,
                                                          color: Colors.red,
                                                          size: 22,
                                                        )),
                                                  )
                                                  : Container(),
                                            ],
                                          ),
                                         const SizedBox(
                                            height: 15,
                                          ),
                                        ],
                                      ),
                                    ],
                                  )
                                : Tooltip(
                                   message: "Viewing entire Data", 
                                  child: InkWell(
                                    onTap: (){},
                                    child: Column(
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
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
                                          const SizedBox(
                                            height: 10,
                                          )
                                        ],
                                      ),
                                  ),
                                ),
                          ),
                          main_Scrollview_container(),
                          const SizedBox(
                            height: 20,
                          )
                        ],
                      ),
                    ],
                  );
  }
 
  Container main_Scrollview_container() {
    return Container(
                            //scroll view main

                            height: 140,
                            child: ListView(
                              scrollDirection: Axis.horizontal,
                              children: [
                                _overall == false
                                    ?const SizedBox(
                                        width: 30,
                                      )
                                    : Container(),
                                _overall == false
                                    ? Tooltip(
                                       message: " ",      
                                      child: InkWell(
                                          onTap: (){},
                                          child: Stack(children: [
                                            Container(
                                              height: 140,
                                              width: 140,
                                              decoration: BoxDecoration(
                                                color:
                                                    Styles.custom_savings_blue,
                                                borderRadius:const BorderRadius.all(
                                                    Radius.circular(30)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Styles.primary_black
                                                        .withOpacity(
                                                            0.3), //color of shadow
                                                    spreadRadius:
                                                        0.5, //spread radius
                                                    blurRadius: 5,
                                                    offset: const Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                  //you can set more BoxShadow() here
                                                ],
                                              ),
                                            ),
                                            Container(
                                              margin: const EdgeInsets.symmetric(
                                                vertical: 10,
                                              ),
                                              width: 140,
                                              height: 140,
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceEvenly,
                                                children: [
                                                 const Icon(
                                                    Custom_icons.savings,
                                                    size: 36,
                                                    color: Styles.primary_black,
                                                  ),
                                                 const Text(
                                                    "Savings",
                                                    style: Styles.normal17,
                                                  ),
                                                  Text(
                                                    "₹$_savingsTot",
                                                    style: Styles.bold25,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ]),
                                        ),
                                    )
                                    : Container(),
                                const SizedBox(
                                  width: 30,
                                ),
                                Tooltip(
                                  message: "Income Chart Button",
                                  child: InkWell(
                                                         
                                    onTap: () {
                                      // getAllitemWidget();
                                      getPieChartValue(1);
                                      setState(() {
                                         _favoriteVisible=false;
                                        _addButton=false;
                                        _percentInd = false;
                                        _cardList = 1;
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
                                            color: Styles.custom_income_green,
                                            borderRadius: const BorderRadius.all(
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
                                                offset: const Offset(0,
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
                                              const Icon(
                                                Custom_icons.income,
                                                size: 36,
                                                color: Styles.primary_black,
                                              ),
                                              const Text(
                                                "Income",
                                                style: Styles.normal17,
                                              ),
                                              /*  _overall == false
                                                  ? */
                                              Text(
                                                "₹$_incomeTotal",
                                                style: Styles.bold25,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Tooltip(
                                   message: "Expense Chart Button",
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                        _favoriteVisible=false;
                                        _addButton=false;
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
                                            borderRadius:
                                                const BorderRadius.all(
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
                                                offset:  const Offset(0,
                                                    3), // changes position of shadow
                                              ),
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          width: 140, height: 140,
                                          // color: Colors.blue,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Icon(
                                                Custom_icons.expense,
                                                size: 36,
                                                color: Styles.primary_black,
                                              ),
                                              const Text(
                                                "Expense",
                                                style: Styles.normal17,
                                              ),
                                              Text(
                                                "₹$_expenseTotal",
                                                style: Styles.bold25,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Tooltip(
                                   message: "Lend Chart Button",
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                         _favoriteVisible=false;
                                        _addButton=false;
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
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                                //first paramerter of offset is left-right
                                                //second parameter is top to down
                                              ),
                                              //you can set more BoxShadow() here
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          width: 140,
                                          height: 140,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Icon(
                                                Custom_icons.lend,
                                                size: 30,
                                                color: Styles.primary_black,
                                              ),
                                              const Text(
                                                "Lend",
                                                style: Styles.normal17,
                                              ),
                                              /*    _overall == false
                                                  ? */
                                              Text(
                                                "₹$_lendTotal",
                                                style: Styles.bold25,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                Tooltip(
                                   message: "Borrow Chart Button",
                                  child: InkWell(
                                    onTap: () {
                                      setState(() {
                                         _favoriteVisible=false;
                                        _addButton=false;
                                        _percentInd = false;
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
                                                offset: const Offset(0,
                                                    3), // changes position of shadow
                                                //first paramerter of offset is left-right
                                                //second parameter is top to down
                                              ),
                                              //you can set more BoxShadow() here
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                            vertical: 10,
                                          ),
                                          width: 140,
                                          height: 140,
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: [
                                              const Icon(
                                                Custom_icons.borrow,
                                                size: 32,
                                                color: Styles.primary_black,
                                              ),
                                              const Text(
                                                "Borrow",
                                                style: Styles.normal17,
                                              ),
                                              /* _overall == false
                                                  ? */
                                              Text(
                                                "₹$_borrowTotal",
                                                style: Styles.bold25,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                              ],
                            ),
                          );
  }

  Container addButton_container() {
    return Container(
                alignment: Alignment.bottomCenter,
                  // ADD BUTTON POPUP A CONTAINER
                  margin: EdgeInsets.only(bottom: 90),
                  // bottom: 90,
                  // left: 47,
                  child: Stack(
                    alignment: Alignment.topCenter,
                    children: [
                      Container(
                        // alignment: Alignment.bottomCenter,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: const [
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
                                         __selectedcontent={};
                                    });
                                  },
                                  child: Tooltip(
                                     message: "Add your new ",   
                                    child: Container(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: const [
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
                                      decoration: const BoxDecoration(
                                        color: Styles.custom_income_green,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                        //
                                      ),
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
                                      __selectedcontent={};
                                    });
                                  },
                                  child: Tooltip(
                                    message: "Add your new ",   
                                    child: Container(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: const [
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
                                      decoration: const BoxDecoration(
                                        color: Styles.custom_expense_red,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
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
                                         __selectedcontent={};
                                    });
                                  },
                                  child: Tooltip(
                                    message: "Add your new ",   
                                    child: Container(
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: const [
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
                                      decoration: const BoxDecoration(
                                        color: Styles.custom_lend_yellow,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(30)),
                                      ),
                                    ),
                                  ),
                                ),
                                Tooltip(
                                  message: "Add your new ",    
                                  child: Container(
                                    child: InkWell(
                                      onTap: () {
                                        setState(() {
                                          _cardList = 0;
                                          _isAddorUpdate = true;
                                          _card = 4;
                                          _addButton = false;
                                          _isUpdateClicked = false;
                                             __selectedcontent={}; 
                                        });
                                      },
                                      child: Container(
                                        margin: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          children: const [
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
                                    decoration: const BoxDecoration(
                                      color: Styles.custom_borrow_pink,
                                      borderRadius:
                                          BorderRadius.all(Radius.circular(30)),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
  }

  Positioned bottomNavigation_buttons(Size size) {
    return Positioned(
            //bottom navigation bar
            bottom: 0,
            left: 0,
            child: Container(
              width: size.width,
              height: size.height*.075,         
              child: Stack(
                
                children: [
                  CustomPaint(
                    size: Size(size.width, size.height*.075),         
                    painter: BNBCustomPainter(),
                  ),
                  Center(
                    heightFactor: 0.2, 
                    child: FloatingActionButton(
                        backgroundColor: Styles.primary_black,
                        child: Tooltip(
                             message: "Add new item +",    
                          child: Icon(
                            Icons.add,
                            size: size.width*.1,    
                          ),
                        ),
                        elevation: 0.2, 
                        onPressed: () { 
                          setState(() {
                             _favoriteVisible=false;
                             __selectedcontent={};
                             _isAddorUpdate=true;
                            _addButton == false
                                ? _addButton = true
                                : _addButton = false;
                            // _cardList=0;
                            _card = 0;
                          });
                        }),
                  ),
                  Container(
                    width: size.width,
                    height: 60,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Tooltip(
                             message: "List your Income",    
                          child: IconButton(
                            icon: Icon(
                              Custom_icons.income,
                              color: currentIndex == 0
                                  ? Styles.primary_black
                                  : Colors.grey.shade400,
                            ),
                            onPressed: () {
                              setState(() {

                               _favoriteVisible=false; 
                                _isUpdateClicked = false;
                                _cardList = 1;
                                // _addButton
                                // _card=0;
                                _percentInd = false;
                                _addButton = false;
                                _isAddorUpdate = false;
                                setBottomBarIndex(0);
                               
                                // HomeScreen();
                              });
                            },
                            splashColor: Colors.white,
                          ),
                        ),
                        Tooltip(
                           message: "List your Expense",  
                          child: IconButton(
                              icon: Icon(
                                Custom_icons.expense,
                                color: currentIndex == 1
                                    ? Styles.primary_black
                                    : Colors.grey.shade400,
                              ),
                              onPressed: () {
                                setState(() {
                                   _favoriteVisible=false;
                                  _isUpdateClicked = false;
                                  _percentInd = false;
                                  _addButton = false;
                                  _isAddorUpdate = false;
                                  _cardList = 2;
                                  setBottomBarIndex(1);
                                });
                              }),
                        ),
                        Container(
                          width: size.width * 0.20,
                        ),
                        Tooltip(
                           message: "List your lend",  
                          child: IconButton(
                              icon: Icon(
                                Custom_icons.lend,
                                color: currentIndex == 2
                                    ? Styles.primary_black
                                    : Colors.grey.shade400,
                              ),
                              onPressed: () {
                                setState(() {
                                   _favoriteVisible=false;
                                  _isUpdateClicked = false;
                                  _percentInd = false;
                                  _addButton = false;
                                  _cardList = 3;
                                  _isAddorUpdate = false;

                                  setBottomBarIndex(2);
                                });
                              }),
                        ),
                        Tooltip(
                           message: "List your borrow",   
                          child: IconButton(
                              icon: Icon(
                                Custom_icons.borrow,
                                color: currentIndex == 3
                                    ? Styles.primary_black
                                    : Colors.grey.shade400,
                              ),
                              onPressed: () {
                                setState(() {
                                   _favoriteVisible=false;
                                  _isUpdateClicked = false;
                                  _percentInd = false;
                                  _addButton = false;
                                  _cardList = 4;
                                  _isAddorUpdate = false;
                                  setBottomBarIndex(3);
                                });
                              }),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
  }

// void Function(Map<String, Object?> _selectedcontent)   toggleisUpdateClicked;
 
  Future pickDateRange(BuildContext context) async {
    // final dateFormat = DateFormat("yyyy-MM-dd");
    final initialDateRange = DateTimeRange(
      start: DateTime.now().subtract(Duration(hours: 24 * 3)),
      end: DateTime.now(),
    );
    final newDateRange = await showDateRangePicker(
      initialEntryMode: DatePickerEntryMode.calendar,
      context: context,
      currentDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 5),
      lastDate: DateTime.now(),
      initialDateRange: dateRange ?? initialDateRange,
    );

    if (newDateRange == null) return;
    dateRange = newDateRange;

    _selectedStartDate = DateFormat('yyyy-MM-dd').format(dateRange!.start);
    _selectedEndDate = DateFormat('yyyy-MM-dd').format(dateRange!.end);
    var _selectedFirst = DateFormat('MMM dd').format(dateRange!.start);
    var _selectedEnd = DateFormat('MMM dd').format(dateRange!.end);
    print(dateRange);
    if (dateRange != null) {
      getAllitemWidget();
      _cardList == 1
          ? getPieChartValue(1)
          : _cardList == 2
              ? getPieChartValue(2)
              : _cardList == 3
                  ? getPieChartValue(3)
                  : getPieChartValue(4);
      setState(() {
        DisplayDate = "$_selectedFirst - $_selectedEnd";
      });
    }
  }

  Future<dynamic> _showAbout() {
      print("show about");
    return showDialog(
      context: context,
      builder: (context) {
        return AboutDialog(
          applicationName: "MoneyX",
          applicationVersion: "Version 1.0.0",
          applicationIcon: Image.asset(
            'assets/export/simple_logo.png', 
            width: 50.0,
            height: 50.0,
          ),
        );
      },
    );
  }

  Future<dynamic> Log_out() async {
    await Future.delayed(const Duration(milliseconds: 1), () {});
    await Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (ctx) {
      return const SignUp_Screen();
    }));
  }

  void toggleisUpdateClicked(Map<String, Object?> _selectedcontent,{bool? fav}) {
print("888 $_selectedcontent and $fav");
    if(fav==true){
      setState(() {
        _selectedcontent={};
        print("888 in fav");
        // _favoriteVisible=true;
        // _favoriteVisible=false
      });
    }
    
        // print("999 $_selectedcontent");
    if(_selectedcontent.isEmpty)
    {
       print("888 in delete");
      _incomeTot=0;
      _expenseTot=0;
      _lendTot=0;
      _borrowTot=0;
      getTotalSavings();
    }
  
      else{
      
        setState(() {
           print("888 in update");
          // print("999 in update");
          _card=int.parse(_selectedcontent['category'] as String);
        __selectedcontent = _selectedcontent;
      _cardList = 0;
      _addButton = false;
      _isAddorUpdate=false;
      _favoriteVisible=false; 
      _isUpdateClicked ? _isUpdateClicked = false : _isUpdateClicked = true;
    });
      }
  }

void toggleAddorUpdateClicked(String category) {
setState(() {
  _cardList=int.parse(category);
  currentIndex=int.parse(category)-1;
  _percentInd=false; 
_card=0;
getTotalSavings();
});

}
}

/* 
Future<dynamic> fetchingData() async {
  final values = await GroupByCategory();
  print("this is test value $values");
  await Future.delayed(const Duration(seconds: 2), () {});
  return await values;
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
 */

class BNBCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = new Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 10);   // Start
    path.quadraticBezierTo(size.width * 0.20, 0, size.width * 0.35, 0);
    path.quadraticBezierTo(size.width * 0.40, 0, size.width * 0.40, 10);
    path.arcToPoint( Offset(size.width * 0.60, size.width*.02),
        radius:  Radius.circular(size.width*.1005 ), clockwise: false,);
    path.quadraticBezierTo(size.width * 0.60, 0, size.width * 0.65, 0 );
    path.quadraticBezierTo(size.width * 0.80, 0, size.width, 10);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.lineTo(0, 20);
    canvas.drawShadow(path, Colors.black, 5 , true);
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return false;
  }
}
