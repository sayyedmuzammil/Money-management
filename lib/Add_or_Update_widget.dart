import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:money_management/db_functions/List_model.dart';
import 'package:money_management/db_functions/data_model.dart';
import 'package:money_management/db_functions/db_functions.dart';
import 'package:intl/intl.dart';
import 'main.dart';
import 'screens/homeScreen.dart';

class category_cards extends StatefulWidget {
  category_cards({
    Key? key,
    required this.size,
    required int card,
    required bool add,
    required Map<String, Object?> this.selectedcontent,
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
  final snackBar = SnackBar(content: Text(' Item Added Successfully.', style: Styles.normal17.copyWith(color: Colors.white,)));   
  final _categoryController = TextEditingController();

  final _dateController = TextEditingController();
  final _amountController = TextEditingController();

  final _remarkController = TextEditingController();
  final _globalKey = GlobalKey<FormState>();
  late DateTime _selectedDate;

  bool _isClicked = false;
  // String now = DateFormat("yyyy-MM-dd").format(DateTime.now());
  @override
  void initState() {
    // TODO: implement initState
    setState(() {
      ListForTextForm(widget._card);
      widget.selectedcontent.isNotEmpty
          ? {
              
              _categoryController.text =
                  widget.selectedcontent['item'].toString(),
              _selectedDate= DateTime.parse(widget.selectedcontent['date'].toString(),) , 
              _amountController.text =
                  widget.selectedcontent['amount'].toString(),
              _remarkController.text =
                  widget.selectedcontent['remark'].toString(),
            }
          : 

// print("its list data $LISTS");

      _selectedDate = DateTime.now();
    });

    super.initState();
  }

  @override //this widget is add student
  Widget build(BuildContext context) {
    _dateController.text=DateFormat("MMM dd").format(_selectedDate);
    // print("7777 ${widget.selectedcontent}   and ${widget.hello}");
print("555 ${widget.selectedcontent}");
    _categoryController.text.length > 1
        ? _isClicked = false
        : _isClicked = true;
  
    String _dateChange = 0.toString();

    return Stack(
      children: [
        Container(
          width: widget.size.width,
          height: (widget.size.height * .5) + 20,
          margin: EdgeInsets.symmetric(horizontal: 10),

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
                  width: widget.size.width,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 30),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        
                        Tooltip(
                message: " " ,
                child: InkWell(
                  onTap: (){},
                  child: Container(child:
                  widget._card == 1
                              ? 
                  Text(
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
                                            color: Styles.custom_lend_yellow,
                                          ),
                                        )
                                      : widget._card == 4
                                          ? Text(
                                              "Borrow",
                                              style: Styles.normal20.copyWith(
                                                color: Styles.custom_borrow_pink,
                                              ),
                                            )
                                          : widget._card == 5
                                              ? Text(
                                                  "Savings",
                                                  style: Styles.normal20.copyWith(
                                                    color:
                                                        Styles.custom_savings_blue,
                                                  ),
                                                )
                                              : Text(""),),
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
                                        EdgeInsets.symmetric(horizontal: 30),
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
                                              contentPadding: EdgeInsets.only(
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
                                                     _selectedDate = _selectedDateTemp;
                                                     setState(() {
                                                       
                                                     });
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
                                                      EdgeInsets.only(
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
                                              } */else if (value
                                                  .contains(" ")) {
                                                return "white space is not acceptable";
                                              }
                                              else if (value
                                                  .contains(".")) {
                                                return "decimal number is not acceptable";
                                              }
                                               else if (value
                                                  .contains(",") || 
                                                  value.contains("-") ||
                                                  value.contains(",") || 
                                                  value.startsWith("0")
                                                  ) {
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
                                            // obscureText: true,
                                            // validator: (value) {
                                            //   if (value == null ||
                                            //       value.isEmpty) {
                                            //     return 'remark is required';
                                            //   }
                                            // },
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
                                widget._isAddorUpdate == true
                                    ? ElevatedButton(
                                        style: ElevatedButton.styleFrom(
                                          fixedSize: const Size(90, 40),
                                          textStyle: const TextStyle(
                                            fontSize: 25,
                                            color: Styles.primary_black,
                                          ),
                                          primary: Styles.primary_black,
                                          shape: const StadiumBorder(),
                                        ),
                                        onPressed: () {
                                          print("card value ${widget._card}");
                                           if (_globalKey.currentState!.validate()) {
                                          onAddItemButton(
                                              category: widget._card);
                                                widget.toggleAddorUpdateClicked!(widget._card.toString());
                          Scaffold.of(context).showSnackBar(snackBar);  
                          
                                         /*  Navigator.of(context)
                                              .pushAndRemoveUntil(
                                                  MaterialPageRoute(
                                                      builder:
                                                          (context) =>
                                                              HomeScreen()),
                                                  (Route<dynamic> route) =>
                                                      false); */
                                           }
                                        },
                                        child: const Text(
                                          'ADD',
                                          style: Styles.boldwhite,
                                        ),
                                      )
                                    : widget._isAddorUpdate == false
                                        ? ElevatedButton(
                                            style: ElevatedButton.styleFrom(
                                              fixedSize: const Size(120, 40),
                                              textStyle: const TextStyle(
                                                fontSize: 25,
                                                color: Styles.primary_black,
                                              ),
                                              primary: Styles.primary_black,
                                              shape: const StadiumBorder(),
                                            ),
                                            onPressed: () {
                                               if (_globalKey.currentState!.validate()) {
                            // checkLogin(context);
                               onAddItemButton(
                                                  id: widget
                                                      .selectedcontent['id']);
                                                      widget.toggleAddorUpdateClicked!(widget.selectedcontent['category'] as String);
                                              // Navigator.of(context)
                                              //     .pushAndRemoveUntil(
                                              //         MaterialPageRoute(
                                              //             builder: (context) =>
                                              //                 HomeScreen()),
                                              //         (Route<dynamic> route) =>
                                              //             false);

                                                        // Scaffold.of(context).showSnackBar(snackBar); 
                          }
                                              // print(
                                              //     "card value ${widget.selectedcontent['id']}");
                                           
                                            },
                                            child: const Text(
                                              'UPDATE',
                                              style: Styles.boldwhite,
                                            ),
                                          )
                                        : Text(""),
                              ],
                            ),
                            _isClicked == true //its for listing previus items
                                ? Container(
                                    color: Colors.white.withOpacity(.8),
                                    padding: const EdgeInsets.only(left: 20),
                                    margin: const EdgeInsets.fromLTRB(
                                        35, 50, 30, 0),
                                    child: Container(
                                      height: 230,
                                      width: 350,
                                      child: ValueListenableBuilder(
                                          valueListenable: SimpleListNotifier,
                                          builder: (BuildContext ctx,
                                              List<listModel> itemList,
                                              Widget? child) {
                                            return ListView.builder(
                                                itemCount: itemList.length,
                                                itemBuilder: (ctx, index) {
                                                  MainAxisSize.min;
                                                  final singleItem =
                                                      itemList[index];
                                                  return ListTile(
                                                    isThreeLine: false,
                                                    title: Text(
                                                      '${singleItem.item}',
                                                      style: Styles.normal17,
                                                    ),
                                                    selected: true,
                                                    onTap: () => setState(() {
                                                      _categoryController.text =
                                                          singleItem.item
                                                              .toString();
                                                      _isClicked = false;
                                                    }),
                                                  );
                                                });
                                          }),
                                    ),
                                  )
                                : Text(""),
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

  Future<void> onAddItemButton({category, id}) async {
  //  print("")
    final _item = _categoryController.text.trim().toLowerCase();
    final _date = DateFormat('yyyy-MM-dd').format(_selectedDate);
                                                  
    
    final _amount = int.parse(_amountController.text.trim());
    final _remark = _remarkController.text.trim();
    _categoryController.text = "";
    // _dateController.text = ""; 
    _amountController.text = "";
    _remarkController.text = "";
    MoneyListNotifier.notifyListeners();

    // if (_item.isEmpty || _amount.tonul || _date.isEmpty) {
    //   return;
    // }
    print('$_item  and $_amount or $_date  $id');

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
    //  print("now its bottom");
    addMoney(_singleItem);
  }
}
