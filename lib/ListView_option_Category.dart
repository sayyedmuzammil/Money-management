// ignore_for_file: prefer_typing_uninitialized_variables, must_be_immutable, camel_case_types, use_key_in_widget_constructors, non_constant_identifier_names, unrelated_type_equality_checks, unnecessary_null_comparison

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'db_functions/db_functions.dart';
import 'package:intl/intl.dart';
import 'main.dart';

class list_widget extends StatefulWidget {
  list_widget({
    this.dataMap,
    required this.size,
    required this.card,
    required this.percentIndicator,
    required this.toggleisUpdateClicked,
    required this.isOverall,
    required this.startDate,
    required this.endDate,
    required this.favoriteVisible,
  });

  final dataMap;
  final Size size;
  final int card;
  final bool percentIndicator;
  void Function(Map<String, Object?> _selectedcontent, {bool fav})
      toggleisUpdateClicked;
  final isOverall;
  final startDate;
  final endDate;
  final favoriteVisible;

  @override
  State<list_widget> createState() => _list_widget();
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
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _selectedStartDate = widget.startDate;
    _selectedEndDate = widget.endDate;
    String previousDate = '';
    return FutureBuilder<List<Map<String, Object?>>>(
        future: widget.favoriteVisible == false
            ? getAllItems(
                overall: widget.isOverall,
                starDate: _selectedStartDate,
                endDate: _selectedEndDate,
                categoryList:
                    widget.card /* selectedYear: widget.isSelectedYear */)
            : getAllItems(
                favoriteVisible: widget.favoriteVisible,
                starDate: _selectedStartDate,
                endDate: _selectedEndDate,
              ),
        builder: (context, listItem) {
          int pointer = -1;
          int counter = -1;
          dateSets = [];
          if (listItem == null) return const CircularProgressIndicator();

          if (listItem.data == null || listItem.data!.isEmpty) {
            return Tooltip(
              message: "Alert! ",
              child: InkWell(
                onTap: () {},
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 50,
                    ),
                    Image.asset(
                      "assets/export/clipboard.png",
                      height: widget.size.height * .13,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      "No Record",
                      style: Styles.normal20,
                    ),
                    Text(
                      "Tap the + button to add a record",
                      style: Styles.normal17.copyWith(
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                  ],
                ),
              ),
            );
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
              children: [
                Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Styles.primary_black
                                .withOpacity(0.3), //color of shadow
                            spreadRadius: 0.5, //spread radius
                            blurRadius: 5,
                            offset:const  Offset(0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      margin:
                         const  EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      width: widget.size.width,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                        child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              widget.percentIndicator != true
                                  ? const SizedBox(
                                      height: 5,
                                    )
                                  : Container(),
                              Tooltip(
                                message: " ",
                                child: InkWell(
                                  onTap: () {},
                                  child: Container(
                                    child: widget.card == 1
                                        ? Text(
                                            "Income",
                                            style: Styles.normal20.copyWith(
                                              color: Colors.green[300],
                                            ),
                                          )
                                        : widget.card == 2
                                            ? Text(
                                                "Expense",
                                                style: Styles.normal20.copyWith(
                                                  color:
                                                      Styles.custom_expense_red,
                                                ),
                                              )
                                            : widget.card == 3
                                                ? Text(
                                                    "Lend",
                                                    style: Styles.normal20
                                                        .copyWith(
                                                      color: Styles
                                                          .custom_lend_yellow,
                                                    ),
                                                  )
                                                : widget.card == 4
                                                    ? Text(
                                                        "Borrow",
                                                        style: Styles.normal20
                                                            .copyWith(
                                                          color: Styles
                                                              .custom_borrow_pink,
                                                        ),
                                                      )
                                                    : widget.card == 5
                                                        ? Text(
                                                            "Savings",
                                                            style: Styles
                                                                .normal20
                                                                .copyWith(
                                                              color: Styles
                                                                  .custom_savings_blue,
                                                            ),
                                                          )
                                                        : Container(),
                                  ),
                                ),
                              ),
                              widget.percentIndicator == true &&
                                      widget.dataMap != {}
                                  ? Container(
                                      // height: 260,
                                      margin: const EdgeInsets.only(top: 10),
                                      width: widget.size.width,
                                      child: Container(
                                          alignment: Alignment.centerLeft,
                                          child: widget.dataMap != null
                                              ? Tooltip(
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: PieChart(
                                                      dataMap: widget.dataMap,
                                                      animationDuration:
                                                          const Duration(
                                                              milliseconds:
                                                                  800),
                                                      ringStrokeWidth: 25,
                                                      chartLegendSpacing: 35,
                                                      chartRadius:
                                                          MediaQuery.of(
                                                                      context)
                                                                  .size
                                                                  .width /
                                                              3,
                                                      chartType:
                                                          ChartType.ring,
                                                      legendOptions:
                                                          const LegendOptions(
                                                        showLegendsInRow:
                                                            true,
                                                        legendPosition:
                                                            LegendPosition
                                                                .bottom,
                                                        showLegends: true,
                                                        legendShape:
                                                            BoxShape.circle,
                                                        legendTextStyle:
                                                            Styles.normal17,
                                                      ),

                                                      chartValuesOptions:
                                                          const ChartValuesOptions(
                                                              showChartValueBackground:
                                                                  false,
                                                              // chartValueBackgroundColor: Colors.gree,
                                                              showChartValues:
                                                                  true,
                                                              showChartValuesInPercentage:
                                                                  true,
                                                              showChartValuesOutside:
                                                                  true,
                                                              decimalPlaces:
                                                                  1,
                                                              chartValueStyle:
                                                                  TextStyle(
                                                                      color: Colors
                                                                          .black)),
                                                      // gradientList: ---To add gradient colors---
                                                      // emptyColorGradient: ---Empty Color gradient---
                                                    ),
                                                  ),
                                                  message:
                                                      "${widget.dataMap}",
                                                )
                                              : const Text("No datas")))
                                  : Column(
                                      children: [
                                        for (var i in AllRows)
                                          Column(
                                            // mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                            // final this_is;

                                            children: [
                                          dateSets[++counter] != null
                                              ?const  SizedBox(
                                                  height: 15,
                                                )
                                              : Container(),
                                          dateSets[++pointer] != null
                                              ? Tooltip(
                                                  message: " ",
                                                  child: InkWell(
                                                    onTap: () {},
                                                    child: Text(
                                                      DateFormat('MMM dd')
                                                          .format(DateTime
                                                              .parse(i[
                                                                      'date']
                                                                  .toString())),
                                                      style: Styles.normal17
                                                          .copyWith(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color: Colors
                                                                  .red),
                                                    ),
                                                  ),
                                                )
                                              : Container(),
                                          InkWell(
                                            onTap: () {
                                              bottomSheet_edit(context, i);
                                            },
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
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
                                          ),
                                      ],
                                    ),
                            ]),

                        // }
                      ),
                    ),
                    const SizedBox(
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

    // print(x);
    return showModalBottomSheet<void>(
      backgroundColor: Styles.primary_color.withOpacity(0),
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Styles.primary_black,
            borderRadius:const  BorderRadius.vertical(top: Radius.circular(30)),
            boxShadow: [
              BoxShadow(
                color: Styles.primary_black.withOpacity(0.3), //color of shadow
                spreadRadius: 0.5, //spread radius
                blurRadius: 5,
                offset: const Offset(0, -3), // changes position of shadow
              ),
            ],
          ),
          height: 250,
          child: Center(
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Tooltip(
                    message: " ",
                    child: InkWell(
                      onTap: () {},
                      child: Column(
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
                    ),
                  ),
                  Container(height: 2, color: Colors.white),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Add to Favourite",
                        style: Styles.boldwhite,
                      ),
                      Tooltip(
                        message:
                            "favourite is $fav on ${_selectedcontent['item']}! tap to switch",
                        child: FavoriteButton(
                          isFavorite: fav,
                          iconSize: 28,
                          valueChanged: (_isFavorite) {
                            // Scaffold.of(context).activate;
                            AddtoFavorite(
                                int.parse('${_selectedcontent['id']}'));
                            widget.toggleisUpdateClicked(_selectedcontent,
                                fav: true);
                            Navigator.of(context).pop();
                          },
                        ),
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
                        child: Tooltip(
                          message: "Edit ${_selectedcontent['item']} item",
                          child: IconButton(
                              onPressed: () {
                                widget.toggleisUpdateClicked(_selectedcontent);
                                Navigator.of(context).pop();
                              },
                              icon: const Icon(
                                Icons.edit_outlined,
                                size: 24,
                                color: Styles.custom_income_green,
                              )),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Delete Entry",
                        style: Styles.boldwhite,
                      ),
                      Container(
                        height: 40,
                        width: 33,
                        alignment: Alignment.center,
                        child: Tooltip(
                          message: "delete ${_selectedcontent['item']} item",
                          child: IconButton(
                            onPressed: () {
                              deleteMoney(
                                  int.parse('${_selectedcontent['id']}'));
                              _selectedcontent = {};
                              widget.toggleisUpdateClicked(_selectedcontent);
                              Navigator.of(context).pop();
                            },
                            icon: const Icon(
                              Icons.delete_outline,
                              size: 24,
                              color: Styles.custom_expense_red,
                            ),
                          ),
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
}
