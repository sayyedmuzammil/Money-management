// import 'package:flutter/cupertino.dart';
// ignore_for_file: sized_box_for_whitespace, non_constant_identifier_names, deprecated_member_use, must_be_immutable, camel_case_types

import 'package:flutter/material.dart';
import 'package:money_management/db_functions/List_model.dart';
import 'package:money_management/db_functions/data_model.dart';
import 'package:money_management/db_functions/db_functions.dart';
import 'package:intl/intl.dart';
import 'main.dart';

class category_cards extends StatefulWidget {
  category_cards({
    Key? key,
    required this.size,
    required int card,
    required bool add,
    required this.selectedcontent,
    this.toggleAddorUpdateClicked,
  })  : _card = card,
        _isAddorUpdate = add,
        super(key: key);

  final Size size;
  final int _card;
  final bool _isAddorUpdate;
  final Map<String, Object?> selectedcontent;
  void Function(String category)? toggleAddorUpdateClicked;

  @override
  State<category_cards> createState() => _category_cardsState();
}

class _category_cardsState extends State<category_cards> {
  final snackBarAdd = SnackBar(
      content: Text(' Item Added Successfully.',
          style: Styles.normal17.copyWith(
            color: Colors.white,
          )));
  final snackBarUpdate = SnackBar(
      content: Text(' Item Updated Successfully.',
          style: Styles.normal17.copyWith(
            color: Colors.white,
          )));
  final _categoryController = TextEditingController();
  final _dateController = TextEditingController();
  final _amountController = TextEditingController();
  final _remarkController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();

  late DateTime _selectedDate;
  bool _isClicked = false;
  @override
  void initState() {
    setState(() {
      ListForTextForm(widget._card);
      widget.selectedcontent.isNotEmpty
          ? {
              _categoryController.text =
                  widget.selectedcontent['item'].toString(),
              _selectedDate = DateTime.parse(
                widget.selectedcontent['date'].toString(),
              ),
              _amountController.text =
                  widget.selectedcontent['amount'].toString(),
              _remarkController.text =
                  widget.selectedcontent['remark'].toString(),
            }
          :_selectedDate = DateTime.now();
    });

    super.initState();
  }

  @override //this widget is add student
  Widget build(BuildContext context) {
    _dateController.text = DateFormat("MMM dd").format(_selectedDate);
    _categoryController.text.length > 1
        ? _isClicked = false
        : _isClicked = true;

    return Stack(
      children: [
        Container(
          width: widget.size.width,
          height: (widget.size.height * .5) + 20,
          margin: const EdgeInsets.symmetric(horizontal: 10),

          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              // scrollDirection: Axis.vertical,

              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:const BorderRadius.all(Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Styles.primary_black
                            .withOpacity(0.3), //color of shadow
                        spreadRadius: 0.5, //spread radius
                        blurRadius: 5,
 
                        offset: const Offset(0, 3), // changes position of shadow
                 
                      ),
                      //you can set more BoxShadow() here
                    ],
                  ),
                  margin:const EdgeInsets.all(10),
                  width: widget.size.width,
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 10,
                        ),
                        Tooltip(
                          message: " ",
                          child: InkWell(
                            onTap: () {},
                            child: Container(
                              child: widget._card == 1
                                  ? Text(
                                      "Income",
                                      style: Styles.normal20.copyWith(
                                        color: Colors.green[300],
                                      ),
                                    )
                                  : widget._card == 2
                                      ? Text(
                                          "Expense",
                                          style: Styles.normal20.copyWith(
                                            color: Styles.custom_expense_red,
                                          ),
                                        )
                                      : widget._card == 3
                                          ? Text(
                                              "Lend",
                                              style: Styles.normal20.copyWith(
                                                color:
                                                    Styles.custom_lend_yellow,
                                              ),
                                            )
                                          : widget._card == 4
                                              ? Text(
                                                  "Borrow",
                                                  style:
                                                      Styles.normal20.copyWith(
                                                    color: Styles
                                                        .custom_borrow_pink,
                                                  ),
                                                )
                                              : widget._card == 5
                                                  ? Text(
                                                      "Savings",
                                                      style: Styles.normal20
                                                          .copyWith(
                                                        color: Styles
                                                            .custom_savings_blue,
                                                      ),
                                                    )
                                                  : Container(),
                            ),
                          ),
                        ),
                        Stack(
                          children: [
                            Column(
                              children: [
                                Form(
                                  key: _globalKey,
                                  child: Container(
                                    margin:
                                        const EdgeInsets.symmetric(horizontal: 30),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Card(
                                          elevation: 0,
                                          // width: 400, height: 50,
                                          child: TextFormField(
                                            onTap: () => setState(() {
                                              _isClicked = true;
                                            }),
                                            enableSuggestions: true,
                                            controller: _categoryController,
                                            decoration: InputDecoration(
                                              icon: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15),
                                                child: Icon(
                                                  Icons.category_outlined,
                                                  size: 20,
                                                  color: Styles.primary_black
                                                      .withOpacity(.8),
                                                ),
                                              ),
                                              contentPadding:const  EdgeInsets.only(
                                                top: 20,
                                              ),
                                              // errorStyle: TextStyle(fontSize: 9, height: 0.3),
                                              // border: OutlineInputBorder(),

                                              hintText: 'Enter the Item',
                                              hintStyle: Styles.normal17.copyWith(
                                                  color: Colors.grey,
                                                  fontSize:
                                                      15), /*  hintStyle: Styles.Normal15 */
                                            ),
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'Item is required';
                                              } else if (value
                                                  .startsWith(" ")) {
                                                return "Item should not contain whitespace";
                                              }
                                            },
                                          ),
                                        ),
                                        Stack(
                                          children: [
                                            Card(
                                              elevation: 0,
                                              // width: 400, height: 50,
                                              child: TextFormField(
                                                onTap: () async {
                                                  final _selectedDateTemp =
                                                      await showDatePicker(
                                                    context: context,
                                                    initialDate: DateTime.now(),
                                                    firstDate: DateTime.now()
                                                        .subtract(
                                                            const Duration(
                                                                days: 90)),
                                                    lastDate: DateTime.now(),
                                                  );

                                                  //  print(_selected_date);
                                                  if (_selectedDateTemp ==
                                                      null) {
                                                    return;
                                                  } else {
                                                    _selectedDate =
                                                        _selectedDateTemp;
                                                    setState(() {});
                                                    // print(_selected_date.toString());
                                                    // setState(() {
                                                    //   _dateController.text =
                                                    //        DateFormat('MMM dd')
                                                    //         .format(
                                                    //             _selectedDate);
                                                    // });
                                                  }
                                                },
                                                readOnly: true,
                                                controller: _dateController,
                                                decoration: InputDecoration(
                                                  icon: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            top: 15),
                                                    child: Icon(
                                                      Icons
                                                          .calendar_today_outlined,
                                                      size: 20,
                                                      color: Styles
                                                          .primary_black
                                                          .withOpacity(.8),
                                                    ),
                                                  ),
                                                  // enabled: false,
                                                  contentPadding:
                                                      const EdgeInsets.only(
                                                    top: 20,
                                                  ),
                                                ),
                                                validator: (value) {
                                                  if (value == null ||
                                                      value.isEmpty) {
                                                    return 'Date is required';
                                                  } else if (value
                                                      .startsWith(" ")) {
                                                    return " should not contain whitespace";
                                                  }
                                                },
                                              ),
                                            ),
                                          ],
                                        ),

//                                     sfDaterangepicker
//                                      SfDateRangePicker(
//                                        monthFormat: 'MMM',
                                        // minDate: DateTime(2010),
//                                        maxDate: DateTime.now(),
//                                       //  enableMultiView: true,
//                                         selectionMode: DateRangePickerSelectionMode.single,
//                                             view: DateRangePickerView.month,
//                                              onViewChanged: (DateRangePickerViewChangedArgs args) {
//                                          final PickerDateRange visibleDates = args.visibleDateRange;
//                                          final DateRangePickerView view = args.view;
//                                        },
//                                             // monthViewSettings: DateRangePickerMonthViewSettings(showTrailingAndLeadingDates: true,
//                                             // ),
//                                             onSelectionChanged: (DateRangePickerSelectionChangedArgs args) {
//     // var _startDate =
//     //     DateFormat('yyyy-MM-dd').format(args.value).toString();
//         //   var  _endDate =
//         // DateFormat('yyyy-MM-dd').format(args.value.endDate ?? args.value.startDate).toString();
// // DateTime start=new DateTime(2020, 02, 04);
// // DateTime end=new DateTime(2020,03,04);
// // var diff=end.difference(start);
// // print("difference $diff");
//         // print("start $_startDate end date $_endDate");
//         // var diff= DateTime.now().difference(DateFormat('yyyy-MM-dd').format(args.value.startDate).toString()).inDays
//         // print("{$_endDate - $_startDate}");
//                                          final dynamic value = args.value;
//                                          print("value      $value");
//                                         //  now=value;
//                                        },
//                                             monthCellStyle: DateRangePickerMonthCellStyle(
//                                                todayTextStyle: TextStyle(color: Styles.primary_black),
//                                               /*   cellDecoration: BoxDecoration(color:Colors.teal), */
//                                               ),
//                                           ),

                                        Card(
                                          elevation: 0,
                                          // width: 400, height: 50,
                                          child: TextFormField(
                                            keyboardType: TextInputType.number,
                                            controller: _amountController,
                                            // obscureText: true,
                                            validator: (value) {
                                              if (value == null ||
                                                  value.isEmpty) {
                                                return 'please enter the amount';
                                              } /* else if (value
                                                  .startsWith("0")) {
                                                return "should not start zero";
                                              } */
                                              else if (value.contains(" ")) {
                                                return "white space is not acceptable";
                                              } else if (value.contains(".")) {
                                                return "decimal number is not acceptable";
                                              } else if (value.contains(",") ||
                                                  value.contains("-") ||
                                                  value.contains(",") ||
                                                  value.startsWith("0")) {
                                                return "Enter a Valid Amount";
                                              }
                                            },
                                            decoration: InputDecoration(
                                              icon: Padding(
                                                padding: const EdgeInsets.only(
                                                  top: 15,
                                                ),
                                                child: Icon(
                                                  Icons.payments_outlined,
                                                  size: 24,
                                                  color: Styles.primary_black
                                                      .withOpacity(.8),
                                                ),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                top: 20,
                                              ),
                                              // border: OutlineInputBorder(),
                                              hintText: 'Enter the amount',
                                              hintStyle: Styles.normal17
                                                  .copyWith(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                            ),
                                          ),
                                        ),
                                        Card(
                                          elevation: 0,
                                          // width: 400, height: 50,
                                          child: TextFormField(
                                            controller: _remarkController,
                                            decoration: InputDecoration(
                                              icon: Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 15),
                                                child: Icon(
                                                  Icons.note,
                                                  size: 24,
                                                  color: Styles.primary_black
                                                      .withOpacity(.8),
                                                ),
                                              ),
                                              contentPadding:
                                                  const EdgeInsets.only(
                                                top: 20,
                                                // bottom: 5,
                                                // left: 30,
                                              ),
                                              hintText: 'Remark',
                                              hintStyle: Styles.normal17
                                                  .copyWith(
                                                      color: Colors.grey,
                                                      fontSize: 15),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    textStyle: const TextStyle(
                                      fontSize: 25,
                                      color: Styles.primary_black,
                                    ),
                                    primary: Styles.primary_black,
                                    shape: const StadiumBorder(),
                                  ),
                                  onPressed: widget._isAddorUpdate == true
                                      ? () {
                                          // print("card value ${widget._card}");
                                          if (_globalKey.currentState!
                                              .validate()) {
                                            onAddorUpdateButton(
                                                category: widget._card);
                                            widget.toggleAddorUpdateClicked!(
                                                widget._card.toString());
                                            Scaffold.of(context)
                                                .showSnackBar(snackBarAdd);
                                          }
                                        }
                                      : () {
                                          if (_globalKey.currentState!
                                              .validate()) {
                                            // checkLogin(context);
                                            onAddorUpdateButton(
                                                id: widget
                                                    .selectedcontent['id']);
                                            widget.toggleAddorUpdateClicked!(
                                                widget.selectedcontent[
                                                    'category'] as String);
                                            Scaffold.of(context)
                                                .showSnackBar(snackBarUpdate);
                                          }
                                          
                                        },
                                  child: widget._isAddorUpdate == true
                                      ? const Text(
                                          'ADD',
                                          style: Styles.boldwhite,
                                        )
                                      : const Text(
                                          'UPDATE',
                                          style: Styles.boldwhite,
                                        ),
                                )

                              ],
                            ),
                            _isClicked == true //its for listing previus items
                                ? items_list_after_click()
                                : Container(),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 260,
                ),
              ],
            ),
          ),

          // }
        ),
      ],
    );
  }

  Container items_list_after_click() {
    return Container(
      color: Colors.white.withOpacity(.8),
      padding: const EdgeInsets.only(left: 20),
      margin: const EdgeInsets.fromLTRB(35, 50, 30, 0),
      child: Container(
        height: 230,
        width: 350,
        child: ValueListenableBuilder(
            valueListenable: simpleListNotifier,
            builder:
                (BuildContext ctx, List<ListModel> itemList, Widget? child) {
              return ListView.builder(
                  itemCount: itemList.length,
                  itemBuilder: (ctx, index) {
                    MainAxisSize.min;
                    final singleItem = itemList[index];
                    return ListTile(
                      isThreeLine: false,
                      title: Text(
                        '${singleItem.item}',
                        style: Styles.normal17,
                      ),
                      selected: true,
                      onTap: () => setState(() {
                        _categoryController.text = singleItem.item.toString();
                        _isClicked = false;
                      }),
                    );
                  });
            }),
      ),
    );
  }

  Future<void> onAddorUpdateButton({category, id}) async {
    final _item = _categoryController.text.trim().toLowerCase();
    final _date = DateFormat('yyyy-MM-dd').format(_selectedDate);
    final _amount = int.parse(_amountController.text.trim());
    final _remark = _remarkController.text.trim();
    // _categoryController.text = "";
    // _amountController.text = "";
    // _remarkController.text = "";
    // MoneyListNotifier.notifyListeners();

    final _singleItem = id != null
        ? MoneyModel(
            id: int.parse('$id'),
            category: category.toString(),
            item: _item,
            date: _date,
            amount: _amount,
            remark: _remark,
            favourite: "false",
          )
        : MoneyModel(
            category: category.toString(),
            item: _item,
            date: _date,
            amount: _amount,
            remark: _remark,
            favourite: "false",
          );
    addMoney(_singleItem);
  }
}
