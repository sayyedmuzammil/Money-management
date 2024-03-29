// ignore_for_file: unnecessary_null_comparison, unrelated_type_equality_checks, non_constant_identifier_names

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/material.dart';
import 'db_functions/db_functions.dart';
import 'package:intl/intl.dart';
import 'main.dart';
import 'package:money_management/screens/homeScreen.dart';
// import 'screens/homeScreen.dart';

class home_content_all_widget extends StatefulWidget {
  home_content_all_widget(
    this.size,
    this.toggleisUpdateClicked,
    this.isOverall,
    this.favoriteVisible,
    this.startDate,
    this.endDate,
  );
  final Size size;
  void Function(Map<String, Object?> _selectedcontent, {bool fav})
      toggleisUpdateClicked;
  final isOverall;
  var favoriteVisible;
  final startDate;
  final endDate;

  @override
  State<home_content_all_widget> createState() =>
      _home_content_all_widgetState();
}

class _home_content_all_widgetState extends State<home_content_all_widget> {
  var val;
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
    _selectedStartDate = widget.startDate;
    _selectedEndDate = widget.endDate;

    String previousDate = '';
    return FutureBuilder<List<Map<String, Object?>>>(
        future: widget.favoriteVisible == false
            ? getAllItems(
                starDate: _selectedStartDate,
                endDate: _selectedEndDate,
                overall: widget.isOverall)
            : getAllItems(
                favoriteVisible: widget.favoriteVisible,
                starDate: _selectedStartDate,
                endDate: _selectedEndDate,
              ),
        builder: (context, listItem) {
        
          int pointer = -1;
          int counter = -1;
          dateSets = [];
          // dateSets=[];
          if (listItem == null) {
            return const CircularProgressIndicator();
          }

          if (listItem.data == null || listItem.data!.isEmpty) {
            return Tooltip(
              message: "Alert",
              child: InkWell(
                onTap: () {},
                child: Column(
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
                    )
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(20)),
                        boxShadow: [
                          BoxShadow(
                            color: Styles.primary_black
                                .withOpacity(0.3), //color of shadow
                            spreadRadius: 0.5, //spread radius
                            blurRadius: 5,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      width: widget.size.width,
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
                        child: Column(children: [
                          Tooltip(
                            message: " ",
                            enableFeedback: true,
                            child: InkWell(
                              onTap: () {},
                              child: Text(
                                widget.favoriteVisible == true
                                    ? "Favourites"
                                    : "All Transactions",
                                style: Styles.normal17.copyWith(
                                    fontSize: 16,
                                    color: Colors.deepOrange,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                          for (var i in AllRows)
                            Container(
                                child: Column(
                              // mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // final this_is;

                              children: [
                                dateSets[++counter] != null
                                    ? const SizedBox(
                                        height: 15,
                                      )
                                    : Container(),
                                dateSets[++pointer] != null
                                    ? Tooltip(
                                        message: " ",
                                        child: InkWell(
                                          onTap: () {},
                                          child: Text(
                                            DateFormat('MMM dd').format(
                                                DateTime.parse(
                                                    i['date'].toString())),
                                            style: Styles.normal17.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                          ),
                                        ),
                                      )
                                    : Container(),
                                InkWell(
                                  onTap: () {
                                    // print(i.toString());
                                    bottomSheet_edit(context, i);
                                  },
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        i['item'].toString(),
                                        style: Styles.normal20,
                                      ),
                                      i['category'] == '1'
                                          ? Text(
                                              i['amount'].toString(),
                                              style: Styles.normal17.copyWith(
                                                  color: /*  Styles.custom_income_green  */ Colors
                                                      .green[200]),
                                            )
                                          : i['category'] == '2'
                                              ? Text(
                                                  i['amount'].toString(),
                                                  style: Styles.normal17.copyWith(
                                                      color: Styles
                                                          .custom_expense_red),
                                                )
                                              : i['category'] == '3'
                                                  ? Text(
                                                      i['amount'].toString(),
                                                      style: Styles.normal17
                                                          .copyWith(
                                                              color: Styles
                                                                  .custom_lend_yellow),
                                                    )
                                                  : Text(
                                                      i['amount'].toString(),
                                                      style: Styles.normal17
                                                          .copyWith(
                                                              color: Styles
                                                                  .custom_borrow_pink),
                                                    ),
                                    ],
                                  ),
                                ),
                              ],
                            )),
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

    return showModalBottomSheet<void>(
      backgroundColor: Styles.primary_color.withOpacity(0),
      context: context,
      builder: (BuildContext context) {
        return Container(
          decoration: BoxDecoration(
            color: Styles.primary_black,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
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
                                widget.toggleisUpdateClicked(_selectedcontent,
                                    fav: false);
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
