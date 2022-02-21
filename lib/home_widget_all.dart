import 'package:favorite_button/favorite_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:money_management/db_functions/db_functions.dart';
// import 'package:flutter_slidable/flutter_slidable.dart';
import 'db_functions/data_model.dart';
import 'main.dart';

class home_content_all_widget extends StatefulWidget {
  home_content_all_widget({
    Key? key,
    required this.size,
    required this.toggleisUpdateClicked,
  }) : super(key: key);

  final Size size;
  VoidCallback toggleisUpdateClicked;



  @override
  State<home_content_all_widget> createState() =>
      _home_content_all_widgetState();
}

class _home_content_all_widgetState extends State<home_content_all_widget> {
  
  
  

  // List<Widget> allWidget = [];
//  int j=1;
  //  @override
  // void initState() {
  //   setState(() {
      
  //   });
  //   // TODO: implement initState
  //   super.initState();
  // }
       
  @override
  Widget build(BuildContext context) {

    // getPieChartValue();
      int pointer=0;
      int counter=0;
   List dateSets=[];
    String _selectedcontent = '';
    // int count=0;

  
    String previousDate='';
    // var previousCategory;

    return FutureBuilder<List<Map<String,Object?>>>(
      future: getAllItems(),
      
      builder: (context, listItem ){
        if(listItem==null)
        return CircularProgressIndicator(); 

     if(listItem.data==null||listItem.data!.isEmpty) {
       return Text("Nothing foud");
     } 

      List<Map<String,Object?>> AllRows=listItem.data!;
      // List<Map<String,Object?>> UpdatedRow=AllRows;
      
      // print(UpdatedRow);
      print("666 ${AllRows[0]}");
      previousDate=AllRows[0]['date'].toString();
      dateSets.add(previousDate);
      // print(previousDate); 
      for (var i = 1; i < AllRows.length; i++) {
             print("Previus date $previousDate");
      print("new value ${AllRows[i]['date']}"); 
      print("i value $i");
       if(previousDate==AllRows[i]['date']){  dateSets.add(null);}
       else{
         previousDate=AllRows[i]['date'].toString();
         dateSets.add(AllRows[i]['date']);}
          
 
      //  count=0;
      
      }
      dateSets.add(null);
      // dateSets.add(null);
      // dateSets.add(count);
      print("New datee sets $dateSets");  
      // print(++counter);
      return Expanded(
      //second container in list view
      // color: Colors.white,
      // width: widget.size.width,
      // height: (widget.size.height * .58)+5,
      // margin: EdgeInsets.only(top:10, ), 
      // height: _content.length*30,
      // color: Colors.red,

      //  for (var i = 0; i < _content.length; i++) {
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
                      color:
                          Styles.primary_black.withOpacity(0.3), //color of shadow
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
                margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                width: widget.size.width,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // SizedBox(
                        //   height: 20,
                        // ),

                        // allWidget.isEmpty
                        //     ? Text("yes this is empty")
                        //     : Text("Not empty"),
                        // ...allWidget,
                        for (var i in AllRows)
                        
                        Container(child: Column(
                          // mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start, 
                          // final this_is;
                          children: [
                            
 dateSets[++counter]!=null?SizedBox(height: 15,):Container(),
                              dateSets[++pointer]!=null?
                             
                                Text(i['date'].toString(),style: Styles.normal17.copyWith(fontWeight: FontWeight.bold, color: Colors.red), ):Container(), 


                                
                                 
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(i['item'].toString(),style: Styles.normal20,),
                                
                            
                                i['category']=='1'?
                                 Text(i['amount'].toString(),style: Styles.normal17.copyWith(color: Styles.custom_income_green),)
                                 :i['category']=='2'?
                                 Text(i['amount'].toString(),style: Styles.normal17.copyWith(color: Styles.custom_expense_red),)
                                 :i['category']=='3'?
                                 Text(i['amount'].toString(),style: Styles.normal17.copyWith(color: Styles.custom_lend_yellow),)
                                 :
                                 Text(i['amount'].toString(),style: Styles.normal17.copyWith(color: Styles.custom_borrow_pink),),
                              ],
                            ),
                          ],
                        )
                        
                        ), 

                      ]
                      //                       ValueListenableBuilder(
                      //                          valueListenable: MoneyListNotifier,
                      //         builder:
                      //               (BuildContext ctx, List<MoneyModel> MoneyList, Widget? child) {
                      //                         return ListView.builder(
                      //                           itemCount: MoneyList.length,
                      //                           itemBuilder: (ctx, index) {

                      //                     //  final previous;
                      //                     //  final previousCategory;
                      //                               final data = MoneyList[index];
                      //                              final previousCategory = index>0? MoneyList[index-1]:MoneyList[index];

                      //                              print('${previousCategory.category}   and is ${data.category}');
                      //                               // index>0?()

                      //                               // final previous=previousCategory.category;
                      //                               // var set;
                      //                               // index!=0?
                      //                               // ( previousCategory = MoneyList[index-1]

                      //                               //  previous=previousCategory;)

                      //                               //  :Text("");

                      // //                                  for(var item in data as List){
                      // //   // If a map with the same name exists don't add the item.
                      // //   if (set.any((e) => e['name'] == item['name'])) {
                      // //     continue;
                      // //   }
                      // //   set.add(item);
                      // // }
                      //                               //  final UniqueCate= MoneyList.toSet().toList();

                      //                                         // print("UniqueCate $UniqueCate");

                      //                               // print("from home listview ${data.content}");

                      //                           return Column(
                      //                               crossAxisAlignment: CrossAxisAlignment.start,
                      //                             children: [
                      //                               index>0?
                      //                              previousCategory.category!=data.category?
                      //                              data.category=='4'?  Column(
                      //                                children: [
                      //                                   SizedBox(height: 20,),
                      //                                  Text('Borrow',style: Styles.normal20,),
                      //                                 //  SizedBox(height: 20,)
                      //                                ],
                      //                              )
                      //                              :data.category=='2'?  Column(
                      //                                children: [
                      //                                   SizedBox(height: 20,),
                      //                                  Text('Expense',style: Styles.normal20,),
                      //                                ],
                      //                              )
                      //                              : data.category=='3'?  Column(
                      //                                children: [
                      //                                   SizedBox(height: 20,),
                      //                                  Text('Lend',style: Styles.normal20,),
                      //                                ],
                      //                              )
                      //                              : Text('Income',style: Styles.normal20,)
                      //                             :Text(""):  data.category=='4'?  Text('Borrow',style: Styles.normal20,)
                      //                              :data.category=='2'?  Text('Expense',style: Styles.normal20,)
                      //                              : data.category=='3'?  Text('Lend',style: Styles.normal20,)
                      //                 : Text('Income',style: Styles.normal20,),
                      //                             //  print(data.category),

                      //                               singleRow(data: data),
                      //                                   // SizedBox(height: 30,),
                      //                             ],
                      //                           );

                      //                           }
                      //                         );
                      //               },
                      //                       ),
                      //                     ),
                      //                   //       SizedBox(
                      //                   //   height: 10,
                      //                   // ),
                      //                 ],
                      //               ),
                      // //             ),
                      // //           ),

                      //         // SingleChildScrollView(
                      //         //   scrollDirection: Axis.vertical,
                      //         //   child: Column(
                      //         //     // scrollDirection: Axis.vertical,

                      //         //     children: [
                      //         //       Container(
                      //         //         decoration: BoxDecoration(
                      //         //           color: Colors.white,
                      //         //           borderRadius:
                      //         //               BorderRadius.all(Radius.circular(20)),
                      //         //           boxShadow: [
                      //         //             BoxShadow(
                      //         //               color: Styles.primary_black
                      //         //                   .withOpacity(0.3), //color of shadow
                      //         //               spreadRadius: 0.5, //spread radius
                      //         //               blurRadius: 5,
                      //         //               // blur radius
                      //         //               offset: Offset(
                      //         //                   0, 3), // changes position of shadow
                      //         //               //first paramerter of offset is left-right
                      //         //               //second parameter is top to down
                      //         //             ),
                      //         //             //you can set more BoxShadow() here
                      //         //           ],
                      //         //         ),
                      //         //         margin: EdgeInsets.all(10),
                      //         //         width: size.width,
                      //         //         child: Container(
                      //         //           margin: EdgeInsets.all(10),
                      //         //           child: Column(
                      //         //             // mainAxisAlignment: MainAxisAlignment.start,
                      //         //             crossAxisAlignment:
                      //         //                 CrossAxisAlignment.start,
                      //         //             children: [
                      //         //               SizedBox(
                      //         //                 height: 10,
                      //         //               ),
                      //         //               // SizedBox(width: 10,),
                      //         //               // for (var i in _content)
                      //         //               //   Text(
                      //         //               //     i.toString(),
                      //         //               //     style: Styles.normal17,
                      //         //               //   ),
                      //         //               SizedBox(
                      //         //                 height: 10,
                      //         //               ),
                      //         //             ],
                      //         //           ),
                      //         //         ),
                      //         //       )
                      //         //     ],
                      //         //   ),
                      //         // ),
                      //         // SizedBox(
                      //         //   height: 60,
                      //         // ),

                      //                  SizedBox(
                      //                   height: 70,
                      //                 ),
                      //       ],

                      ),

                  // }
                ),
              ),
              SizedBox(height: 85,), 
            ],
          ),
        ],
      ),
    );

    }
    );
    
       }

  Future<void> bottomSheet_edit(BuildContext context, String _selectedcontent) {
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
          height: 200,
          child: Center(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 30),  
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(
                    _selectedcontent,
                    style: Styles.boldwhite,
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
                        iconSize: 24,
                        valueChanged: (_isFavorite) {
                          print('Is Favorite $_isFavorite)');
                        },
                      ),
                    ],
                  ),
                  InkWell(
                    onTap: () {
                      widget.toggleisUpdateClicked();
                      Navigator.of(context).pop();
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Edit Entry",
                          style: Styles.boldwhite,
                        ),
                        const Icon(
                          Icons.edit_outlined,
                          size: 24,
                          color: Styles.custom_income_green,
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Delete Entry",
                        style: Styles.boldwhite,
                      ),
                      Icon(
                        Icons.delete_outline,
                        size: 24,
                        color: Styles.custom_expense_red,
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

  UpdateState() {
   return;
  }
}

class singleRow extends StatelessWidget {
  singleRow({
    Key? key,
    required this.data,
  }) : super(key: key);

  MoneyModel data;

  @override
  Widget build(BuildContext context) {
    print("single row");
    print("2255 $data");
    return GestureDetector(
      onTap: () {
        // print(i.toString());
        // _selectedcontent = i.toString();
        // bottomSheet_edit(context, _selectedcontent);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            /* i.toString() */ '    ${data.category}',

            style: Styles.normal17,
            // style: Styles.normal17,
          ),
          data.category == '1'
              ? Text(
                  '${data.amount}',
                  style: Styles.normal17
                      .copyWith(color: Styles.custom_income_green),
                )
              : data.category == '2'
                  ? Text(
                      /* i.toString() */ '${data.amount}',
                      style: Styles.normal17
                          .copyWith(color: Styles.custom_expense_red),
                      // style: Styles.normal17,
                    )
                  : data.category == '3'
                      ? Text(
                          /* i.toString() */ '${data.amount}',
                          style: Styles.normal17
                              .copyWith(color: Styles.custom_lend_yellow),
                          // style: Styles.normal17,
                        )
                      : Text(
                          /* i.toString() */ '${data.amount}',
                          style: Styles.normal17
                              .copyWith(color: Styles.custom_borrow_pink),
                          // style: Styles.normal17,
                        ),
        ],
      ),
    );
  }
}
