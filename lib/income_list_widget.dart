// import 'dart:html';

import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

import 'main.dart';

class list_widget extends StatelessWidget {
   list_widget({
    Key? key,
    required this.size,
    required this.card,
    required this.percentIndicator,
    required this.toggleisUpdateClicked,
    
  }) : super(key: key);

  final Size size;
  final int card;
  final bool percentIndicator;
VoidCallback toggleisUpdateClicked;

  @override
  Widget build(BuildContext context) {
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
    'Travel', 'Food', 'Credit card Bill', 'food ',  'Train ticket',
    'Food',
    'Travel', 'Food', 'Credit card Bill', 'food ',  'Train ticket',
    'Food',
    'Travel', 'Food', 'Credit card Bill', 'food ',  'Train ticket',
  ];
   String _selectedcontent = '';
    return Container(//second container in list view
      // color: Colors.white,
      width: size.width,
      height: (size.height * .52),  
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
                    offset:
                        Offset(0, 3), // changes position of shadow
                    //first paramerter of offset is left-right
                    //second parameter is top to down
                  ),
                  //you can set more BoxShadow() here
                ],
              ),
              margin: EdgeInsets.all(10),
              width: size.width,
              child: 
              Container(
                margin: EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10,),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    card==1?
                    Text("Income",style: Styles.normal20.copyWith(color: Styles.custom_income_green,),): card==2?
                    Text("Expense",style: Styles.normal20.copyWith(color: Styles.custom_expense_red,),): card==3?
                    Text("Lend",style: Styles.normal20.copyWith(color: Styles.custom_lend_yellow,),): card==4?
                    Text("Borrow",style: Styles.normal20.copyWith(color: Styles.custom_borrow_pink,),): card==5?
                    Text("Savings",style: Styles.normal20.copyWith(color: Styles.custom_savings_blue,),): Text(""), 
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(width: 10,),
                    
                    
                    percentIndicator==true? 
                   
                    Container(
         height: 250,   
              
              margin: EdgeInsets.only(top:10), 
              width: size.width,
            
              child:
             
              Container(
                
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center, 
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround, 
                      children: [
                        Container(
                          alignment: Alignment.centerLeft, 
                          child: CircularPercentIndicator(
                            backgroundColor: Styles.primary_black,
                            radius: 45,  lineWidth: 10, animation: true, percent: 0.7, center: new Text("70.0%", style: Styles.normal20,), footer: new Text("Sales", style: Styles.normal20,),circularStrokeCap: CircularStrokeCap.round, progressColor: Styles.custom_expense_red, 
                          ),
                        ),
                         Container(
                          alignment: Alignment.centerLeft, 
                          child: CircularPercentIndicator(
                            backgroundColor: Styles.primary_black, 
                            radius: 45,  lineWidth: 10, animation: true, percent: 0.5, center: new Text("50.0%", style: Styles.normal20,), footer: new Text("front", style: Styles.normal20,),circularStrokeCap: CircularStrokeCap.round, progressColor: Styles.custom_savings_blue, 
                          ),
                        ),
                         
                      ],
                    ),
                    SizedBox(height: 10,),  
                    Container(
                          alignment: Alignment.center, 
                          child: CircularPercentIndicator(
                            backgroundColor: Styles.primary_black, 
                            radius: 45,  lineWidth: 10, animation: true, percent: 0.3, center: new Text("30.0%", style: Styles.normal20,), footer: new Text("brother", style: Styles.normal20,),circularStrokeCap: CircularStrokeCap.round, progressColor: Styles.custom_income_green,  
                          ),
                        ),  
                  ],
                ),
              )): 
                Container(
                margin: EdgeInsets.symmetric(horizontal:10), 
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // card==1?
                    // Text("Income",style: Styles.normal20.copyWith(color: Styles.custom_income_green,),): card==2?
                    // Text("Expense",style: Styles.normal20.copyWith(color: Styles.custom_expense_red,),): card==3?
                    // Text("Lend",style: Styles.normal20.copyWith(color: Styles.custom_lend_yellow,),): card==4?
                    // Text("Borrow",style: Styles.normal20.copyWith(color: Styles.custom_borrow_pink,),): 
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(width: 10,),
              
                    for (var i in card==1?_incomeList:card==2?_expenseList:card==3?_lendList:_borrowList )
                      Container(
                        margin: EdgeInsets.only(left: 10, ),
                        child: GestureDetector(
                            onTap: () {
                              print(i.toString());
                              _selectedcontent = i.toString();
                              showModalBottomSheet<void>(
                                backgroundColor: Styles.primary_color
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
                                          color: Styles.primary_black
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
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 30),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceEvenly,
                                          children: <Widget>[
                                            Text(
                                              _selectedcontent,
                                              style: Styles.boldwhite,
                                            ),
                                            Container(
                                                height: 2,
                                                color: Colors.white),
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
                                              onTap: (){
                                                
                                               toggleisUpdateClicked();
                                              Navigator.of(context).pop();  
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
                                                    Icons.edit_outlined,
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
                            },
                            child: 
                            card==1?
                            Text(
                              i.toString(),
                              style: Styles.normal17,
                            ):card==2?
                            Text(
                              i.toString(),
                              style: Styles.normal17,
                            ):card==3?
                            Text(
                              i.toString(),
                              style: Styles.normal17,
                            ):card==4?
                            Text(
                              i.toString(),
                              style: Styles.normal17,
                            ):Text(""),
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
      )
            ),],),),)
      ;
  }
}
