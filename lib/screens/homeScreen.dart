// import 'dart:async';
import 'dart:math';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:money_management/Custom_icons.dart';
import 'package:money_management/db_functions/db_functions.dart';
// import 'package:money_management/screens/Sign%20Up_Screen.dart';
import 'package:money_management/db_functions/group_model.dart';
import 'package:sqflite/sqflite.dart';
// import '../ListView_option_Category copy.dart';
import '../ListView_option_Category.dart';
import '../home_widget_all.dart';
import '../main.dart';
import '../Add_or_Update_widget.dart';
import 'Sign Up_Screen.dart';
// import 'package:money_management/db_functions/db_functions.dart';




class HomeScreen extends StatefulWidget {
  

  


  @override
  _HomeScreen createState() => _HomeScreen();
}

class _HomeScreen extends State<HomeScreen> {
List<String> _About = [ 'Developer : Muzammil', 'version : 1.0'];
  //  var year=getYearDB();
 var dateRange;
  var _selectedStartDate;
  var _selectedEndDate;
  Map<String, double> dataMap = {};
  var DataMap;
  // bool _isclosed=false;
  
  getPieChartValue(_category) async {
    
    dataMap = {};
    print("888 $DataMap");
    print("in Pie chart $dropdownvalue  and $_category $_selectedStartDate");
print("55555 $_overall");
    final entireData = /* dropdownvalue != null
        ? */ await PieChartValue(category: _category, startDate: _selectedStartDate,endDate: _selectedEndDate, overall: _overall /* selectedYear: _isSelectedyear */);
        // : await PieChartValue(category: _category, overall: _overall,/*  selectedYear: _isSelectedyear */);
    print("55 $entireData");
  entireData.isNotEmpty?
  setPie(entireData):print("55 Nullll");
  
  }
void setPie(entireData){
    for (var item in entireData) {
      String SingleItem = item['category'] as String;
      int SingleAmount = item['tot_amount'] as int;
      double Total = SingleAmount.toDouble();
      print("iteemmmmsss $SingleItem");
      print("iteemmmmsss $Total");
      dataMap[SingleItem] = Total;
    }
    setState(() {
      DataMap = dataMap;
    });
}
 bool _favoriteVisible=false;
  String? _isSelectedyear;
  var values;
  var allItem;

  String? dropdownvalue;
  Map<int, String> monthsofYearsMap = {};

  // List<String> monthsofYears = [];

  /* getMonths() async {
    print("99 $_selectedStartDate - $_selectedEndDate" );
    // final entireData = await ListForMonth(startDate: _selectedStartDate, endDate: _selectedEndDate);
    // for (var item in entireData) {
    //   String TextMonth = item['data'];
    //   print(TextMonth);
    //   // int numberMonth = int.parse(item['data']);
    //   // monthsofYears.add(TextMonth);
    //   // monthsofYearsMap[numberMonth] = '$TextMonth';
      
    // }
    final year=await getYearDB();
      //  print("4444 ${year[0]['Year']}");
for (var item in year) {
_year.add(item['Year'].toString()); 
  
}
// print()
    setState(() {
      // year[0]['Year'].toString()!=null?
      _isSelectedyear=(/* year[0]['Year']).toString() */'2022');
      // monthsofYearsMap;
      // monthsofYearsMap.isNotEmpty
      //     ? dropdownvalue = monthsofYears[0].toString()
      //     : Text("");

         
      getAllitemWidget();
    });
  } */

  int _incomeTot = 0;
  int _expenseTot = 0;
  int _lendTot = 0;
  int _borrowTot = 0;
  int _savingsTot = 0;
  int _incomeOverall = 0;
  int _expenseOverall = 0;
  int _lendOverall = 0;
  int _borrowOverall = 0;
  int _savingsOverall = 0;

// DateTime findLastDateOfTheWeek(DateTime dateTime) {
//   return dateTime.add(Duration(days: DateTime.daysPerWeek-4));
// }
// var currentMonth;
// var currentMonthText;
 var currentMonth =  DateTime.now().month;
var currentMonthText;
String DisplayDate='';

  late Database _db2;
 late var monthLastDate;
  late  var monthFirstDate;
  var StartText;
   var endText;
  getTotalSavings() async{
    
   _db2 = await openDatabase('money.db', version: 1,
      onCreate: (Database db, int version) async {
    await db.execute(
        'CREATE TABLE MoneyManage (id INTEGER PRIMARY KEY, category TEXT, item TEXT, date DATE, amount INTEGER, remark TEXT, favourite TEXT)');
  });

  
      monthFirstDate=
      _overall==false?
       await _db2.rawQuery("SELECT date FROM MoneyManage WHERE (strftime('%m', date)='0$currentMonth') ORDER BY date ASC LIMIT 1 "):
       await _db2.rawQuery("SELECT date FROM MoneyManage ORDER BY date ASC LIMIT 1 ");
      monthLastDate= await _db2.rawQuery("SELECT date FROM MoneyManage ORDER BY date DESC LIMIT 1");
final List ls=monthFirstDate;
final List la=monthLastDate;
// print("777 $ls");
if(ls.isNotEmpty){
_selectedStartDate=await monthFirstDate[0]['date'].toString();
_selectedEndDate=await monthLastDate[0]['date'].toString();
  StartText=  DateFormat('MMM dd').format(DateTime.parse(_selectedStartDate));
 endText=  DateFormat('MMM dd').format(DateTime.parse(_selectedEndDate));
  DisplayDate="$StartText - $endText"; 
}
else{
  DisplayDate="Add Some Data";
}
 
print("799 $_selectedStartDate $_selectedEndDate $StartText");
   currentMonthText=  (DateFormat('MMM').format(DateTime(0,int.parse('$currentMonth'.toString()))));

    //  var firstDay= findLastDateOfTheWeek(DateTime.now());
    final entireData=await GroupByCategory(Tsavings: true);
    print("699 $currentMonth");
    for (var i = 0; i < entireData.length; i++) {
      String item = entireData[i]['category'];
      if (item == '1') {
        _incomeTot = entireData[i]['tot_amount']!;
      }
      if (item == '2') {
        _expenseTot = entireData[i]['tot_amount']!;
      }
      if (item == '3') {
        _lendTot= entireData[i]['tot_amount']!;
      }
      if (item == '4') {
        _borrowTot = entireData[i]['tot_amount']!;
      }
    }

 
    // print("6999 $firstDay");
 
   setState(() {
     
    //  DisplayDate='''$currentMonthText 01 - $currentMonthText ${DateTime.now().day}''';
     _savingsOverall=(_incomeTot+_borrowTot)-(_expenseTot+_lendTot);
   });
  //  _isclosed==true?
   getPieChartValue(_cardList);
    getAllitemWidget();
    //  _incomeTot=0; _expenseTot=0; _lendTot=0; _borrowTot=0;
    print("7999 $_savingsOverall");

    
  }
    int _incomeTotal = 0;
    int _expenseTotal = 0;
    int _lendTotal = 0;
    int _borrowTotal = 0;
  getAllitemWidget() async {

    _incomeTotal=0;
    _expenseTotal=0;
    _lendTotal=0;
    _borrowTotal=0;
    print("199 $_selectedStartDate - $_selectedEndDate" );
    int keyMonth;
    String valueMonth;
    dropdownvalue == monthsofYearsMap;
  
    // int _savingsTotal = 0;

    // int _incomeTotalOv = 0;
    // int _expenseTotalOv = 0;
    // int _lendTotalOv = 0;
    // int _borrowTotalOv = 0;
    // int _savingsTotalOv = 0;
    // final lastDayOfMonth = DateTime.now().month+1,0};
print("999 $currentMonth");
  print("999 $_selectedStartDate- $_selectedEndDate  or $_overall  and $currentMonth" );
    final entireData = 
  /*   currentMonth!=0?
    await GroupByCategory(currentMonth: currentMonth)
    :  */
    _selectedStartDate!=null?
    await GroupByCategory(startDate: _selectedStartDate, endDate: _selectedEndDate, /*SelectedMonth:dropdownvalue   selectedYear: _isSelectedyear */)
: await GroupByCategory(overall: _overall/* selectedYear: _isSelectedyear */);

// final TotalSavings=GroupByCategory();
    
   /*  final entireDataForSavings =  */


    /* for (var i = 0; i < entireDataForSavings.length; i++) {
      String item = entireDataForSavings[i]['category'];
      if (item == '1') {
        _incomeTotalOv = entireDataForSavings[i]['tot_amount']!;
      }
      if (item == '2') {
        _expenseTotalOv = entireDataForSavings[i]['tot_amount']!;
      }
      if (item == '3') {
        _lendTotalOv = entireDataForSavings[i]['tot_amount']!;
      }
      if (item == '4') {
        _borrowTotalOv = entireDataForSavings[i]['tot_amount']!;
      }
    } */
print("99 entire $entireData"); 
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

      _savingsTot = (_incomeTot + _borrowTot) - (_expenseTot + _lendTot);

      // _incomeOverall = _incomeTotalOv;
      // _expenseOverall = _expenseTotalOv;
      // _lendOverall = _lendTotalOv;
      // _borrowOverall = _borrowTotalOv;

      // _savingsOverall =
      //     (_incomeOverall + _borrowOverall) - (_expenseOverall + _lendOverall);
  // var year=getYearDB();


      print("in get month $_incomeTot and $_savingsTot");
      // print("in get month $_incomeTotalOv and $_savingsOverall");
    });
    
    print("Income tota $_savingsTot");
  }
 Map<String, Object?> __selectedcontent={};

  bool _isUpdateClicked = false;
  bool _isAddorUpdate = false;
  int _card = 0;

  bool _overall = false;
  bool _addButton = false; //clicking add button
  bool _percentInd = false;
  int? currentIndex;
  // Initial Selected Value

  int _cardList = 0;
  
  setBottomBarIndex(index) {
    setState(() {
      currentIndex = index;
      super.setState(() {});
    });
  }
  String? _dateCount;
  String? _range;
  var MonthData;
  

  @override
  void initState() {
      dropdownvalue=_About[0].toString();
    // print("4444 $year");
 getTotalSavings();
    setState(() {
    
    });
      
    _card = 0;
      
    // getAllitemWidget();
      
    _dateCount = '';
    _range = '';
   
    // print("in init $dropdownvalue");
    super.initState();
  }

   

  

  @override
  Widget build(BuildContext context) {

 print("666 $_favoriteVisible $_selectedStartDate");

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
                                // print("this is main gesture");
                                  currentMonth=0;
                                _overall = true;
                                _card = 0;
                                _cardList = 0;
                                bool _isUpdateClicked = false;
                                bool _isAddorUpdate = false;
                                _selectedStartDate=null;
                                getTotalSavings();
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
                                    "₹$_savingsOverall",  
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
                                        onTap: (){
                                          setState(() {
                                            _favoriteVisible==true?_favoriteVisible=false:_favoriteVisible=true;
                                          });
                                        },
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              "Favourites",
                                              style:_favoriteVisible==false?
                                               Styles.boldwhite:Styles.normal17red,
                                            ),
                                            Icon(
                                              Icons.favorite_outlined,
                                              size: 20,
                                              color: Colors.redAccent,
                                            ),
                                          ],
                                        ),
                                      ),
                                     /*  PopupMenuItem<int>(
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
                                      ), */
                                      for (var i in _About)
                                        PopupMenuItem<int>(
                                          onTap: () {
                                            setState(() {
                                              // _isSelectedyear = i.toString();
                                              // print(_isSelectedyear);
                                            });
                                          },
                                          value: 1,
                                          child: i.toString() == _isSelectedyear
                                              ? Text(
                                                  i.toString(),
                                                  style: Styles.boldwhite,
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
                              margin: EdgeInsets.only(left: 30),
                              child: _overall == false
                                  ? Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Column(
                                          
                                          children: [
                                           /*  dropdownvalue == null
                                                ? SizedBox(
                                                    height: 30,
                                                  )
                                                : DropdownButtonHideUnderline(
                                                    child: DropdownButton(
                                                      value: dropdownvalue,
                                                      icon: const Icon(Icons
                                                          .arrow_drop_down),
                                                      items: monthsofYears
                                                          .map((String items) {
                                                        return DropdownMenuItem(
                                                          value:
                                                              items, //march  selected
                                                          child: Text(
                                                            items = (DateFormat(
                                                                    'MMMM')
                                                                .format(DateTime(
                                                                    0,
                                                                    int.parse(
                                                                        items)))),
                                                            style:
                                                                Styles.normal20,
                                                          ),
                                                        );
                                                      }).toList(),
                                                      onChanged:
                                                          (String? newValue) {
                                                        setState(() {
                                                          dropdownvalue =
                                                              newValue!;
                                                          getAllitem();
                                                        });
                                                      },
                                                    ),
                                                  ),
                                           */
                                           SizedBox(height: 15,),  
                                  Row(
                                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,  
                                    children: [
                                      InkWell(
                                          onTap: () {
                                            currentMonth=0;
                                            
                                            pickDateRange(context);
                                          },
                                          child: Row(
                                            children: [
                                              Icon(Icons.calendar_today_sharp , size: 20, color: Styles.primary_black,), 
                                              SizedBox(width: 10,),
                                              Text(
                                                DisplayDate,
                                                style: Styles.normal17.copyWith(
                                                    // fontSize: 17,
                                                    color: Colors.deepOrange,
                                                    fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          )),
                                          SizedBox(width: 10,),
                                           dateRange!=null?
                                      InkWell(
                                        onTap: (){
                                    
                                          setState(()
                                        
                                         {
                                          currentMonth = DateTime.now().month;
                                          // DisplayDate = 'Choose Date Range';
                                          DisplayDate='''$StartText - $endText''';
                                          dateRange=null;
                                        
                                        });
                                                 getTotalSavings();
                                           print("555 $_cardList");
                                          //  _isclosed=true;
                                          //  getPieChartValue(_cardList);
                                        },
                                        child: Icon(Icons.close,color: Colors.red, size: 22,)) : Container(),  
                                    ],
                                  ),
                               
                                      SizedBox(height: 15,),
                                          ],
                                        ),
                                      ],
                                    )
                                  : Column(
                                      children: [
                                        SizedBox(
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
                                        SizedBox(
                                          height: 10,
                                        )
                                      ],
                                    ),
                            ),
                            Container(
                              //scroll view main

                              height: 140,
                              child: ListView(
                                scrollDirection: Axis.horizontal,
                                children: [
                                  _overall==false?
                                  SizedBox(
                                    width: 30,
                                  ):Container(),
                                  _overall==false?
                                  InkWell(
                                    onTap: () {
                                      setState(() {
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
                                              offset: Offset(0,
                                                  3), // changes position of shadow
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
                                            // _overall == false
                                                Text(
                                                    "₹$_savingsTot",
                                                    style: Styles.bold25,
                                                  )
                                                /* : Text(
                                                    "₹$_savingsOverall",
                                                    style: Styles.bold25,
                                                  ), */
                                          ],
                                        ),
                                      ),
                                    ]),
                                  ):Container(),
                                  SizedBox(
                                    width: 30,
                                  ),
                                  InkWell(
                                    onTap: () {
                                       getAllitemWidget();
                                        getPieChartValue(1);
                                      setState(() {
                                        _percentInd = false;
                                       
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
                                             /*  _overall == false
                                                  ? */ Text(
                                                      "₹$_incomeTotal",
                                                      style: Styles.bold25,
                                                    )
                                                /*   : Text(
                                                      "₹$_incomeOverall",
                                                      style: Styles.bold25,
                                                    ), */
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
                                             /*  _overall == false
                                                  ? */ Text(
                                                      "₹$_expenseTotal",
                                                      style: Styles.bold25,
                                                    )
                                               /*    : Text(
                                                      "₹$_expenseOverall",
                                                      style: Styles.bold25,
                                                    ), */
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
                                           /*    _overall == false
                                                  ? */ Text(
                                                      "₹$_lendTotal",
                                                      style: Styles.bold25,
                                                    )
                                                 /*  : Text(
                                                      "₹$_lendOverall",
                                                      style: Styles.bold25,
                                                    ), */
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
                                        // getPieChartValue(4);
                                        // _cardList = 4;
                                        // _percentInd = true;
                                        // currentIndex = null;
                                        

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
                                              /* _overall == false
                                                  ? */ Text(
                                                      "₹$_borrowTotal",
                                                      style: Styles.bold25,
                                                    )
                                               /*    : Text(
                                                      "₹$_borrowOverall",
                                                      style: Styles.bold25,
                                                    ), */
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
                            )
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
                        isSelectedYear: _isSelectedyear,
                        startDate: _selectedStartDate,
                        endDate: _selectedEndDate,
                        favoriteVisible: _favoriteVisible,
                      )
                  
                    : _isUpdateClicked
                        ? category_cards(
                          selectedcontent: __selectedcontent,
                          hello: 0,
                            size: size, card: _card, add: _isAddorUpdate)
                        :
                        _card >= 1
                            ? category_cards(
                              selectedcontent: __selectedcontent,
                              hello: 1,
                                size: size, card: _card, add: _isAddorUpdate)
                            : home_content_all_widget(size,toggleisUpdateClicked,_isSelectedyear, _favoriteVisible,_selectedStartDate, _selectedEndDate
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
                               
                                _cardList = 1;
                                // _addButton
                                // _card=0;
                                _percentInd=false;
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
// void Function(Map<String, Object?> _selectedcontent)   toggleisUpdateClicked;
  void toggleisUpdateClicked(Map<String, Object?> _selectedcontent) {
    setState(() {
      __selectedcontent=_selectedcontent;
      _cardList = 0;
      _addButton = false;
      _isUpdateClicked ? _isUpdateClicked = false : _isUpdateClicked = true;
    });
  }

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
    //print(newDateRange.start);
    //print(dateRange);
    print(_selectedStartDate);
    print(_selectedEndDate);
    print(dateRange);

    if (dateRange != null) {
     getAllitemWidget();
     _cardList==1?
    getPieChartValue(1):_cardList==2? getPieChartValue(2):_cardList==3? getPieChartValue(3):getPieChartValue(4);
      setState(() {
        DisplayDate = "$_selectedFirst - $_selectedEnd";
      });
    }
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
