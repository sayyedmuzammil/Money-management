// import 'package:charts_flutter/flutter.dart';
import 'package:favorite_button/favorite_button.dart';
// import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:percent_indicator/circular_percent_indicator.dart';
// import 'package:syncfusion_flutter_charts/charts.dart';

import 'package:money_management/main.dart';
import 'package:pie_chart/pie_chart.dart';

import 'db_functions/db_functions.dart';  



class list_widget extends StatefulWidget {
  list_widget({
    Key? key,
    this.dataMap,
    required this.size,
    required this.card,
    required this.percentIndicator,
    required this.toggleisUpdateClicked,
  }) : super(key: key);

final dataMap;
  final Size size;
  final int card;
  final bool percentIndicator;
  VoidCallback toggleisUpdateClicked;


  @override
  State<list_widget> createState() => _list_widgetState();
}

class _list_widgetState extends State<list_widget> {

  
  @override
  void initState() {
    setState(() {

        // getPieChartValue();
    });

    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
      print("after passing ${widget.dataMap}");

    List<String> _lendList = [
      'Debit to akshay',
      'Debit to suhail',
    ];
    List<String> _borrowList = [
      'credit from muneer',
      'crossroads',
      'brother',
    ];
    List<String> _incomeList = [
      'Salary',
      'Shop profit',
      'Salary',
      'incentive',
      'shop profit',
      'Salary',
    ];
    List<String> _expenseList = [
      'Food',
      'Travel',
      'Food',
      'Credit card Bill',
      'food ',
      'Train ticket',
      'Food',
      'Travel',
      'Food',
      'Credit card Bill',
      'food ',
      'Train ticket',
      'Food',
      'Travel',
      'Food',
      'Credit card Bill',
      'food ',
      'Train ticket',
    ];
    String _selectedcontent = '';
    var dataMap={'item' :73723.2};
    return Container(
      //second container in list view
      // color: Colors.white,
      width: widget.size.width,
      height: (widget.size.height * .52),
      margin: EdgeInsets.only(top: 10, left: 20, right: 20,),
      // height: _content.length*30,
      // color: Colors.white,

      //  for (var i = 0; i < _content.length; i++) {
      child: SingleChildScrollView(
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
                // margin: EdgeInsets.all(10),
                width: widget.size.width,
                child: Container(
                  margin: EdgeInsets.only(
                    left: 20,
                    right: 10,
                    top: 10, 
                    bottom: 10,
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      widget.card == 1
                          ? Text(
                              "Income",
                              style: Styles.normal20.copyWith(
                                color: Styles.custom_income_green,
                              ),
                            )
                          : widget.card == 2
                              ? Text(
                                  "Expense",
                                  style: Styles.normal20.copyWith(
                                    color: Styles.custom_expense_red,
                                  ),
                                )
                              : widget.card == 3
                                  ? Text(
                                      "Lend",
                                      style: Styles.normal20.copyWith(
                                        color: Styles.custom_lend_yellow,
                                      ),
                                    )
                                  : widget.card == 4
                                      ? Text(
                                          "Borrow",
                                          style: Styles.normal20.copyWith(
                                            color: Styles.custom_borrow_pink,
                                          ),
                                        )
                                      : widget.card == 5
                                          ? Text(
                                              "Savings",
                                              style: Styles.normal20.copyWith(
                                                color:
                                                    Styles.custom_savings_blue,
                                              ),
                                            )
                                          : Text(""),
                      // SizedBox(
                      //   height: 10,
                      // ),
               
                      widget.percentIndicator == true
                          ? Container(
                              height: 340,  
                              margin: EdgeInsets.only(top: 10),
                              width: widget.size.width,
                              child: Container(
                                // margin: EdgeInsets.only(top: 0),
                                // color: Colors.red,
                                child: Container(
                                 
                                  alignment: Alignment.centerLeft,
                                  child:
                                  widget.dataMap!=null?
                                   PieChart(
                                                  //emptyColor: Colors.white,
                                                  dataMap: widget.dataMap,
                                                  animationDuration: Duration(milliseconds: 800),
                                                  chartLegendSpacing: 35,
                                                  chartRadius: MediaQuery.of(context).size.width / 3,
                                                  //colorList: colorList,
                                                  // initialAngleInDegree: 0,
                                                  chartType: ChartType.disc,
                                                  // ringStrokeWidth: 55,
                                                   
                                                  
                                                  // centerText: 
                                                  // widget.card==1?
                                                  // 'Income'
                                                  // : widget.card==2?
                                                  // 'Expense'
                                                  // : widget.card==3?
                                                  // 'Lend'
                                                  // : 
                                                  // 'Borrow',
                                                  
                                
                                                  // centerTextStyle: 
                                                  // widget.card==1?
                                                  // Styles.normal20.copyWith(color: Styles.custom_income_green)
                                                  // : widget.card==2?
                                                  // Styles.normal20.copyWith(color: Styles.custom_expense_red)
                                                  // : widget.card==3?
                                                  // Styles.normal20.copyWith(color: Styles.custom_lend_yellow)
                                                  // : Styles.normal20.copyWith(color: Styles.custom_borrow_pink),
                                                  
                                                  legendOptions: const LegendOptions(
                                                    showLegendsInRow: true,
                                                    legendPosition: LegendPosition.bottom,
                                                    showLegends: true, 
                                                    legendShape: BoxShape.circle,
                                                    legendTextStyle:Styles.normal17, 
                                                  
                                                     
                                                  ),
                                                  chartValuesOptions: ChartValuesOptions(
                                                      showChartValueBackground: false,
                                                      // chartValueBackgroundColor: Colors.gree,
                                                      showChartValues: true, 
                                                      showChartValuesInPercentage: true,
                                                      showChartValuesOutside: true,
                                                      decimalPlaces: 1,
                                                      chartValueStyle: TextStyle(color: Colors.black)),
                                                  // gradientList: ---To add gradient colors---
                                                  // emptyColorGradient: ---Empty Color gradient---
                                                ):Text("No datas")
                                ),
                              ))
                          : Container(
                              margin: EdgeInsets.symmetric(horizontal: 10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  for (var i in widget.card == 1
                                      ? _incomeList
                                      : widget.card == 2
                                          ? _expenseList
                                          : widget.card == 3
                                              ? _lendList
                                              : _borrowList)
                                    Container(
                                      margin: EdgeInsets.only(
                                        left: 10,
                                      ),
                                      child: GestureDetector(
                                        onTap: () {
                                          
                                          print(i.toString());
                                          _selectedcontent = i.toString();
                                          PopUpBottomSheet(context, _selectedcontent);
                                        },
                                        child: widget.card == 1
                                            ? Text(
                                                i.toString(),
                                                style: Styles.normal17,
                                              )
                                            : widget.card == 2
                                                ? Text(
                                                    i.toString(),
                                                    style: Styles.normal17,
                                                  )
                                                : widget.card == 3
                                                    ? Text(
                                                        i.toString(),
                                                        style: Styles.normal17,
                                                      )
                                                    : widget.card == 4
                                                        ? Text(
                                                            i.toString(),
                                                            style:
                                                                Styles.normal17,
                                                          )
                                                        : Text(""),
                                      ),
                                    ),
                                  SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                    ],
                  ),
                )),
          ],
        ),
      ),
    );
  }

  Future<void> PopUpBottomSheet(BuildContext context, String _selectedcontent) {
    return showModalBottomSheet<void>(
                                          backgroundColor: Styles
                                              .primary_color
                                              .withOpacity(0),
                                          // context and builder are
                                          // required properties in this widget
                                          context: context,
                                          builder: (BuildContext context) {
                                            // we set up a container inside which
                                            // we create center column and display text
                                            return Container(
                                              // color: Styles.primary_black,
                                              decoration: BoxDecoration(
                                                color: Styles.primary_black,
                                                borderRadius:
                                                    BorderRadius.vertical(
                                                        top: Radius.circular(
                                                            30)),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Styles
                                                        .primary_black
                                                        .withOpacity(
                                                            0.3), //color of shadow
                                                    spreadRadius:
                                                        0.5, //spread radius
                                                    blurRadius: 5,
                                                    // blur radius
                                                    offset: Offset(0,
                                                        -3), // changes position of shadow
                                                    //first paramerter of offset is left-right
                                                    //second parameter is top to down
                                                  ),
                                                  //you can set more BoxShadow() here
                                                ],
                                              ),
                                              height: 200,
                                              child: Center(
                                                child: Container(
                                                  margin:
                                                      EdgeInsets.symmetric(
                                                          horizontal: 30),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceEvenly,
                                                    children: <Widget>[
                                                      Text(
                                                        _selectedcontent,
                                                        style:
                                                            Styles.boldwhite,
                                                      ),
                                                      Container(
                                                          height: 2,
                                                          color:
                                                              Colors.white),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Add to Favourite",
                                                            style: Styles
                                                                .boldwhite,
                                                          ),
                                                          FavoriteButton(
                                                            iconSize: 24,
                                                            valueChanged:
                                                                (_isFavorite) {
                                                              print(
                                                                  'Is Favorite $_isFavorite)');
                                                            },
                                                          ),
                                                        ],
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          widget.toggleisUpdateClicked();
                                                          Navigator.of(
                                                                  context)
                                                              .pop();
                                                        },
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            const Text(
                                                              "Edit Entry",
                                                              style: Styles
                                                                  .boldwhite,
                                                            ),
                                                            const Icon(
                                                              Icons
                                                                  .edit_outlined,
                                                              size: 24,
                                                              color: Styles
                                                                  .custom_income_green,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Text(
                                                            "Delete Entry",
                                                            style: Styles
                                                                .boldwhite,
                                                          ),
                                                          Icon(
                                                            Icons
                                                                .delete_outline,
                                                            size: 24,
                                                            color: Styles
                                                                .custom_expense_red,
                                                          )
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        );
  }
}
