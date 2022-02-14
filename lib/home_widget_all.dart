import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'main.dart';

class home_content_all_widget extends StatelessWidget {
   home_content_all_widget({
    Key? key,
    required this.size,
    required this.toggleisUpdateClicked,
    required this.overall,
  }) : super(key: key);

  final Size size;
  final bool overall;
VoidCallback toggleisUpdateClicked;

  @override
  Widget build(BuildContext context) {
     List<String> _content = [
    'Bread',
    'jam',
    'egg',
    'Bread',
    'Bread',
    'jam',
    'egg',
    'Bread',
    'Bread',
    'Bread',
    'jam',
    'egg',
    'Bread',
    'Bread',
    'jam',
    'egg',
    'Bread',
    'Bread',
    'jam',
    'egg',
    'Bread',
    'Bread',
    'jam',
    'egg',
    'Bread',
    'Bread',
    'jam',
    'egg',
    'Bread',
  ];
   List<String> _overall_list = [
    'Test overall',
    'jam',
    'egg',
    'Bread',
    'Bread',
    'jam',];
     List<String> _income_list = [
    'Test income',
    'jam',
    'egg',
    'Bread',
    'Bread',
    'jam',];
   String _selectedcontent = '';
    return Container(//second container in list view
      // color: Colors.white,
      width: size.width,
      height: (size.height * .52),    
      margin: EdgeInsets.all(10),
      // height: _content.length*30,
      // color: Colors.white,

      //  for (var i = 0; i < _content.length; i++) {
        
      child: 
      SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          // scrollDirection: Axis.vertical,

          children: [
              overall==false?
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
              child: Container(
                margin: EdgeInsets.all(10),
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    SizedBox(width: 10,),
                    for (var i in _content)
                      GestureDetector(
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
                          child: Text(
                            i.toString(),
                            style: Styles.normal17,
                          ),
                          ),
                    SizedBox(
                      height: 10,
                    ),
                  ],
                ),
              ),
            ):
          
            // SingleChildScrollView(
            //   scrollDirection: Axis.vertical,
            //   child: Column(
            //     // scrollDirection: Axis.vertical,

            //     children: [
            //       Container(
            //         decoration: BoxDecoration(
            //           color: Colors.white,
            //           borderRadius:
            //               BorderRadius.all(Radius.circular(20)),
            //           boxShadow: [
            //             BoxShadow(
            //               color: Styles.primary_black
            //                   .withOpacity(0.3), //color of shadow
            //               spreadRadius: 0.5, //spread radius
            //               blurRadius: 5,
            //               // blur radius
            //               offset: Offset(
            //                   0, 3), // changes position of shadow
            //               //first paramerter of offset is left-right
            //               //second parameter is top to down
            //             ),
            //             //you can set more BoxShadow() here
            //           ],
            //         ),
            //         margin: EdgeInsets.all(10),
            //         width: size.width,
            //         child: Container(
            //           margin: EdgeInsets.all(10),
            //           child: Column(
            //             // mainAxisAlignment: MainAxisAlignment.start,
            //             crossAxisAlignment:
            //                 CrossAxisAlignment.start,
            //             children: [
            //               SizedBox(
            //                 height: 10,
            //               ),
            //               // SizedBox(width: 10,),
            //               for (var i in _content)
            //                 Text(
            //                   i.toString(),
            //                   style: Styles.normal17,
            //                 ),
            //               SizedBox(
            //                 height: 10,
            //               ),
            //             ],
            //           ),
            //         ),
            //       )
            //     ],
            //   ),
            // ),
             Column(
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
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(width: 10,),
                        for (var i in _overall_list)
                          GestureDetector(
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
                              child: Text(
                                i.toString(),
                                style: Styles.normal17,
                              ),
                              ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
            ),



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
                  child: Container(
                    margin: EdgeInsets.all(10),
                    child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 10,
                        ),
                        SizedBox(width: 10,),
                        for (var i in _income_list )
                          GestureDetector(
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
                              child: Text(
                                i.toString(),
                                style: Styles.normal17,
                              ),
                              ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
            ),

            // testing(_overall_list, _selectedcontent, context),
               ],
             ),
            SizedBox(
              height: 60,
            ),
          ],
        ),
      ),

      // }
    );
  }
  // Widget testing(List _overall_list, String _selectedcontent , BuildContext context,){
    
  //   for (var j = 0; j < 4; j++) {
  //     print("value of i $j");
  //    return  Container(
         
  //                 decoration: BoxDecoration(
  //                   color: Colors.white,
  //                   borderRadius: BorderRadius.all(Radius.circular(20)),
  //                   boxShadow: [
  //                     BoxShadow(
  //                       color: Styles.primary_black
  //                           .withOpacity(0.3), //color of shadow
  //                       spreadRadius: 0.5, //spread radius
  //                       blurRadius: 5,
  //                       // blur radius
  //                       offset:
  //                           Offset(0, 3), // changes position of shadow
  //                       //first paramerter of offset is left-right
  //                       //second parameter is top to down
  //                     ),
  //                     //you can set more BoxShadow() here
  //                   ],
  //                 ),
  //                 margin: EdgeInsets.all(10),
  //                 width: size.width,
  //                 child: Container(
  //                   margin: EdgeInsets.all(10),
  //                   child: Column(
  //                     // mainAxisAlignment: MainAxisAlignment.start,
  //                     crossAxisAlignment: CrossAxisAlignment.start,
  //                     children: [
  //                       SizedBox(
  //                         height: 10,
  //                       ),
                        
  //                       SizedBox(width: 10,),
  //                       for (var i in _overall_list)
  //                         GestureDetector(
  //                             onTap: () {
  //                               print(i.toString());
  //                               _selectedcontent = i.toString();
  //                               showModalBottomSheet<void>(
  //                                 backgroundColor: Styles.primary_color
  //                                     .withOpacity(0),
  //                                 // context and builder are
  //                                 // required properties in this widget
  //                                 context: context,
  //                                 builder: (BuildContext context) {
  //                                   // we set up a container inside which
  //                                   // we create center column and display text
  //                                   return Container(
  //                                     // color: Styles.primary_black,
  //                                     decoration: BoxDecoration(
  //                                       color: Styles.primary_black,
  //                                       borderRadius:
  //                                           BorderRadius.vertical(
  //                                               top: Radius.circular(
  //                                                   30)),
  //                                       boxShadow: [
  //                                         BoxShadow(
  //                                           color: Styles.primary_black
  //                                               .withOpacity(
  //                                                   0.3), //color of shadow
  //                                           spreadRadius:
  //                                               0.5, //spread radius
  //                                           blurRadius: 5,
  //                                           // blur radius
  //                                           offset: Offset(0,
  //                                               -3), // changes position of shadow
  //                                           //first paramerter of offset is left-right
  //                                           //second parameter is top to down
  //                                         ),
  //                                         //you can set more BoxShadow() here
  //                                       ],
  //                                     ),
  //                                     height: 200,
  //                                     child: Center(
  //                                       child: Container(
  //                                         margin: EdgeInsets.symmetric(
  //                                             horizontal: 30),
  //                                         child: Column(
  //                                           mainAxisAlignment:
  //                                               MainAxisAlignment
  //                                                   .spaceEvenly,
  //                                           children: <Widget>[
  //                                             Text(
  //                                               _selectedcontent,
  //                                               style: Styles.boldwhite,
  //                                             ),
  //                                             Container(
  //                                                 height: 2,
  //                                                 color: Colors.white),
  //                                             Row(
  //                                               mainAxisAlignment:
  //                                                   MainAxisAlignment
  //                                                       .spaceBetween,
  //                                               children: [
  //                                                 Text(
  //                                                   "Add to Favourite",
  //                                                   style: Styles
  //                                                       .boldwhite,
  //                                                 ),
  //                                                 FavoriteButton(
  //                                                   iconSize: 24,
  //                                                   valueChanged:
  //                                                       (_isFavorite) {
  //                                                     print(
  //                                                         'Is Favorite $_isFavorite)');
  //                                                   },
  //                                                 ),
  //                                               ],
  //                                             ),
  //                                             InkWell(
  //                                               onTap: (){
  //                                                 toggleisUpdateClicked();
  //                                                 Navigator.of(context).pop(); 
  //                                               },
  //                                               child: Row(
  //                                                 mainAxisAlignment:
  //                                                     MainAxisAlignment
  //                                                         .spaceBetween,
  //                                                 children: [
  //                                                   const Text(
  //                                                     "Edit Entry",
  //                                                     style: Styles
  //                                                         .boldwhite,
  //                                                   ),
  //                                                   const Icon(
  //                                                     Icons.edit_outlined,
  //                                                     size: 24,
  //                                                     color: Styles
  //                                                         .custom_income_green,
                                                          
  //                                                   ),
  //                                                 ],
  //                                               ),
  //                                             ),
  //                                             Row(
  //                                               mainAxisAlignment:
  //                                                   MainAxisAlignment
  //                                                       .spaceBetween,
  //                                               children: [
  //                                                 Text(
  //                                                   "Delete Entry",
  //                                                   style: Styles
  //                                                       .boldwhite,
  //                                                 ),
  //                                                 Icon(
  //                                                   Icons
  //                                                       .delete_outline,
  //                                                   size: 24,
  //                                                   color: Styles
  //                                                       .custom_expense_red,
  //                                                 )
  //                                               ],
  //                                             ),
  //                                           ],
  //                                         ),
  //                                       ),
  //                                     ),
  //                                   );
  //                                 },
  //                               );
  //                             },
  //                             child: Text(
  //                               i.toString(),
  //                               style: Styles.normal17,
  //                             ),
  //                             ),
  //                       SizedBox(
  //                         height: 10,
  //                       ),
  //                     ],
  //                   ),
  //                 ),
  //           );
  //   }
  //  return Container();
  // }

}
