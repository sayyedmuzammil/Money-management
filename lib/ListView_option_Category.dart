import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'db_functions/db_functions.dart';
import 'package:intl/intl.dart';
import 'main.dart';
import 'screens/homeScreen.dart';

class list_widget extends StatefulWidget {
  list_widget({
     this.dataMap,
  required  this.size,
    required this.card,
 required this.percentIndicator,
   required this.toggleisUpdateClicked,
   required this.isSelectedYear,
    required this.startDate,
    required this.endDate,
    required this.favoriteVisible,
  }
  );
  
final dataMap;
  final Size size;
  final int card;
  final bool percentIndicator;
  void Function(Map<String, Object?> _selectedcontent) toggleisUpdateClicked;
  final isSelectedYear;
  final startDate;
    final endDate;
    final favoriteVisible;

  @override
  State<list_widget> createState() =>
      _list_widget();
}

class _list_widget extends State<list_widget> {
  var dateRange;
  var _selectedStartDate;
  var _selectedEndDate;
  String DisplayDate = 'Select Date Range';
  List dateSets = [];

  @override
  void initState() {
    setState(() {
      dateSets = [];
    });
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print("111 ${widget.startDate} ${widget.endDate}");
    Map<String, Object?> _selectedcontent;
              _selectedStartDate=widget.startDate;
_selectedEndDate=widget.endDate;
    var j;
    String previousDate = '';
    print("date range $dateRange");
    return FutureBuilder<List<Map<String, Object?>>>(
        // future: dateRange != null
        //     ? getAllItems(
        //         starDate: _selectedStartDate, endDate: _selectedEndDate, categoryList: widget.card, /* selectedYear: widget.isSelectedYear */)
        //     : getAllItems(categoryList: widget.card, /* selectedYear: widget.isSelectedYear */),
       future: 
        widget.favoriteVisible==false?
       getAllItems(
                starDate: _selectedStartDate, endDate: _selectedEndDate,categoryList: widget.card /* selectedYear: widget.isSelectedYear */):getAllItems(favoriteVisible: widget.favoriteVisible, starDate: _selectedStartDate, endDate: _selectedEndDate,),
        builder: (context, listItem) {
          int pointer = -1;
          int counter = -1;
          dateSets = [];
          // dateSets=[];
          if (listItem == null) return CircularProgressIndicator();

          if (listItem.data == null || listItem.data!.isEmpty) {
            return Text("Nothing found");
          }
          List<Map<String, Object?>> AllRows = listItem.data!;
          previousDate = AllRows[0]['date'].toString();
          dateSets.add(previousDate);
          for (var i = 1; i < AllRows.length; i++) {
            if (previousDate == AllRows[i]['date']) {
              dateSets.add(null);
            } else {
              previousDate = AllRows[i]['date'].toString();
              dateSets.add(AllRows[i]['date']);
            }
          }
          dateSets.add(null); //dummy data in the end of dateset list
          return Expanded(
            child: ListView(
              // scrollDirection: Axis.vertical,

              children: [
                Column(
                  children: [
                    // SizedBox(height: 30,),
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
                            offset: Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      margin:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      width: widget.size.width,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.percentIndicator!=true?
                              Column(
                                children: [
                                /*  Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  InkWell(
                                      onTap: () {
                                        pickDateRange(context);
                                      },
                                      child: Text(
                                        DisplayDate,
                                        style: Styles.normal17.copyWith(
                                            fontSize: 16,
                                            color: Colors.deepOrange,
                                            fontWeight: FontWeight.bold),
                                      )),
                                      dateRange!=null?
                                      InkWell(
                                        onTap: (){setState(() {
                                           DisplayDate = 'Select Date Range';
                                          dateRange=null;
                                        });},
                                        child: Icon(Icons.close,color: Colors.red, size: 22,)) : Container(),
                                ],
                              ),
                                       SizedBox(
                                height: 5,
                              ),
                              Divider(
                                height: 2,
                              ), */
                                     SizedBox(
                                height: 5,
                              ),
                                ],
                              ):Container(),
                      widget.favoriteVisible==true?
                              Container(
                                alignment: Alignment.center, 
                                child: Text(
                                      "Favourites",
                                        style: Styles.normal17.copyWith(
                                            fontSize: 16,
                                            color: Colors.deepOrange,
                                            fontWeight: FontWeight.bold),
                                      ),):    
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
                            widget.percentIndicator==true && widget.dataMap!={}?
                              Container(
                              height: 260,  
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
                                                  dataMap: widget.dataMap,
                                                  animationDuration: Duration(milliseconds: 800),
                                                  chartLegendSpacing: 35,
                                                  chartRadius: MediaQuery.of(context).size.width / 3,
                                                  chartType: ChartType.disc,
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
                         
                          :    Column(
                                children: [
                              for (var i in AllRows)
                            
                                  Container( // Text("Income", style: Styles.normal17.copyWith(color: Styles.custom_income_green)),
                                        child: Column(
                                      // mainAxisAlignment: MainAxisAlignment.start,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      // final this_is;

                                      children: [
                                        dateSets[++counter] != null
                                            ? SizedBox(
                                                height: 15,
                                              )
                                            : Container(),
                                        dateSets[++pointer] != null
                                            ? Text(
                                                DateFormat('MMM dd').format(
                                                    DateTime.parse(
                                                        i['date'].toString())),
                                                style: Styles.normal17.copyWith(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.red),
                                              )
                                            : Container(),
                                        InkWell(
                                          onTap: () {
                                            print(i.toString());
                                            _selectedcontent = i;
                                            print(_selectedcontent);
                                            bottomSheet_edit(
                                                context, _selectedcontent);
                                          },
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                i['item'].toString(),
                                                style: Styles.normal20,
                                              ),
                                              Text(
                                                      i['amount'].toString(),
                                                      style: Styles.normal17,
                                                    )
                                                  
                                            ],
                                          ),
                                        ),
                                      ],
                                    )),
                                ],
                              ),
                            ]
                   
                            ),

                        // }
                      ),
                   
                    ),
                    SizedBox(
                      height: 85,
                    ),
                  ],
                ),
              ],
            ),
          );
        });
  }

  Future<void> bottomSheet_edit(
      BuildContext context, Map<String, Object?> _selectedcontent) {
    String val = '${_selectedcontent['favourite']}'.toString();

    bool fav = val == false
        ? val.toLowerCase() == 'false'
        : val.toLowerCase() == 'true';

    final x = _selectedcontent['id'].toString();
    print(x);
    return showModalBottomSheet<void>(
      backgroundColor: Styles.primary_color.withOpacity(0),
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
            borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Styles.primary_black.withOpacity(0.3), //color of shadow
                spreadRadius: 0.5, //spread radius
                blurRadius: 5,
                // blur radius
                offset: Offset(0, -3), // changes position of shadow
                //first paramerter of offset is left-right
                //second parameter is top to down
              ),
              //you can set more BoxShadow() here
            ],
          ),
          height: 250,
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            _selectedcontent['item'].toString(),
                            style: Styles.boldwhite,
                          ),
                          Text(
                            _selectedcontent['amount'].toString(),
                            style: Styles.boldwhite,
                          ),
                        ],
                      ),
                      // SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Remark :  ${_selectedcontent['remark'].toString()}",
                            style: Styles.boldwhite,
                          ),
                          Text(
                            DateFormat('MMM dd').format(DateTime.parse(
                                _selectedcontent['date'].toString())),
                            style: Styles.boldwhite,
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(height: 2, color: Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Add to Favourite",
                        style: Styles.boldwhite,
                      ),
                      FavoriteButton(
                        isFavorite: fav,
                        iconSize: 28,
                        valueChanged: (_isFavorite) {
                          AddtoFavorite(int.parse('${_selectedcontent['id']}'));
                          print('Is Favorite $_isFavorite');
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Edit Entry",
                        style: Styles.boldwhite,
                      ),
                      Container(
                        height: 40, width: 33,
                        alignment: Alignment.center,
                        //  color: Colors.red,
                        child: IconButton(
                            onPressed: () {
                              widget.toggleisUpdateClicked(_selectedcontent);
                              Navigator.of(context).pop();
                            },
                            icon: Icon(
                              Icons.edit_outlined,
                              size: 24,
                              color: Styles.custom_income_green,
                            )),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delete Entry",
                        style: Styles.boldwhite,
                      ),
                      InkWell(
                        onTap: () {
                          deleteMoney(int.parse('${_selectedcontent['id']}'));

                          Navigator.of(context).pop();
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()),
                              (Route<dynamic> route) => false);
                        },
                        child: Icon(
                          Icons.delete_outline,
                          size: 24,
                          color: Styles.custom_expense_red,
                        ),
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
      setState(() {
        DisplayDate = "$_selectedFirst - $_selectedEnd";
      });
    }
  }
}
