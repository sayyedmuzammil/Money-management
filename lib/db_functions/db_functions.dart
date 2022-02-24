import 'package:flutter/cupertino.dart';
import 'package:money_management/db_functions/List_model.dart';
// import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'data_model.dart';
import 'group_model.dart';

ValueNotifier<List<MoneyModel>> MoneyListNotifier = ValueNotifier([]);

ValueNotifier<List<listModel>> SimpleListNotifier = ValueNotifier([]);
late Database _db1;
// late Database _db2;

Future<void> openDB() async {
  _db1 = await openDatabase('money6.db', version: 1,
      onCreate: (Database db, int version) async {
    await db.execute(
        'CREATE TABLE MoneyManage (id INTEGER PRIMARY KEY, category TEXT, item TEXT, date DATE, amount INTEGER, remark TEXT, favourite TEXT)');
  });
}

Future<void> addMoney(MoneyModel value) async {
value.id==null?
  await _db1.rawInsert(
      'INSERT INTO MoneyManage(category,item,date,amount,remark,favourite) VALUES (?,?,?,?,?,?)',
      [
        value.category,
        value.item,
        value.date,
        value.amount,
        value.remark,
        value.favourite
      ]):
      await _db1.rawUpdate(
      'UPDATE MoneyManage SET item= "${value.item}", date="${value.date}",amount="${value.amount}", remark="${value.remark}" WHERE id="${value.id}"');
  print("Money added successfully");
}

Future<void> SearchMoney(SearchedItem) async {
  MoneyListNotifier.value.clear();
  final searched_item = await _db1.query('MoneyManage',
      where: "item LIKE ?", whereArgs: ['%$SearchedItem%']);

  searched_item.forEach((map) {
    final Single_student = MoneyModel.fromMap(map);
    MoneyListNotifier.value.add(Single_student);
    MoneyListNotifier.notifyListeners();
  });
}

Future<List<Map<String, Object?>>> getAllItems( {starDate,endDate, categoryList}) async {
  MoneyListNotifier.value.clear();
  print("555 $categoryList");
  final _values =categoryList==null? starDate== null && endDate==null?
      await _db1.rawQuery('SELECT * FROM MoneyManage ORDER BY date desc'):await _db1.rawQuery("SELECT * FROM MoneyManage WHERE date BETWEEN '$starDate' AND '$endDate' ORDER BY date desc")
  :starDate== null && endDate==null?await _db1.rawQuery("SELECT * FROM MoneyManage WHERE category='$categoryList' ORDER BY date desc"):await _db1.rawQuery("SELECT * FROM MoneyManage WHERE (date BETWEEN '$starDate' AND '$endDate') AND category='$categoryList' ORDER BY date desc");
  // print("this is all values in db $_values");
  if (_values.isNotEmpty) {
    _values.forEach((map) {
      final Single_item = MoneyModel.fromMap(map);
      MoneyListNotifier.value.add(Single_item);
      MoneyListNotifier.notifyListeners();
    });
  } else {
    var alert = "no values in db";
  }
  print("values in db $_values");
  return _values;
}

Future<dynamic> GroupByCategory({SelectedMonth}) async {
 
  final values = 
   SelectedMonth!=null?
  await _db1.rawQuery(
      "SELECT  category, SUM(amount) tot_amount FROM MoneyManage WHERE (strftime('%m', date)='$SelectedMonth') GROUP BY category"):
  await _db1.rawQuery(
      "SELECT  category, SUM(amount) tot_amount FROM MoneyManage GROUP BY category");
print("5555 $values");
  // var grouped;
  values.forEach((map) {
   var grouped = groupModel.fromMap(map);
  });
  print("Inthe Database Grouped month $values");

  return values;
}

Future<List<Map<String, Object?>>> PieChartValue({category ,SelectedMonth,overall}) async {
  final values = 
  overall!=true?
  await _db1.rawQuery(
      "SELECT  DISTINCT(item) AS category, SUM(amount) tot_amount FROM MoneyManage WHERE category='$category' AND (strftime('%m', date)='$SelectedMonth') GROUP BY item ")
  :await _db1.rawQuery(
      "SELECT  DISTINCT(item) AS category, SUM(amount) tot_amount FROM MoneyManage WHERE category='$category' GROUP BY item ");
  print("Inthe Database in main card group and wher $values");
  return values;
}

Future<dynamic> ListForTextForm(_category) async {
  SimpleListNotifier.value.clear();
String currentMonth = DateTime.now().month.toString();
String currentYear = DateTime.now().year.toString();
print(DateTime.now().month);
print(DateTime.now().year);

  final values = await _db1.rawQuery(
      "SELECT DISTINCT(item) AS data FROM MoneyManage WHERE category = '$_category' AND ((strftime('%m', date)='0$currentMonth') OR (strftime('%m', date)='$currentMonth')) ");
  if (values.isNotEmpty) {
    values.forEach((map) {
      final Single_item = listModel.fromMap(map);
      SimpleListNotifier.value.add(Single_item);
      SimpleListNotifier.notifyListeners();
    });
  } else {
    var alert = "no values in db";
    print("error alert $alert");
  }
  return values;
}


Future<dynamic> ListForMonth() async {
  SimpleListNotifier.value.clear();
String currentMonth = DateTime.now().month.toString();
String currentYear = DateTime.now().year.toString();
  final values = await _db1.rawQuery(
      "SELECT DISTINCT(strftime('%m', date)) AS data FROM MoneyManage ORDER BY date desc");
      print(values);
  if (values.isNotEmpty) {
    values.forEach((map) {
      final Single_item = listModel.fromMap(map);
      SimpleListNotifier.value.add(Single_item);
      SimpleListNotifier.notifyListeners();
    });
  } else {
    var alert = "no values in db";
    print("error alert $alert");
  }
  return values;
}

Future<void> deleteMoney(int id) async {
  // print(id);
  await _db1.rawDelete('DELETE FROM MoneyManage WHERE id=$id');

  await getAllItems(); 
}

Future<void> AddtoFavorite(int id) async {
  // print(id);
  final favorite = await _db1.rawQuery(
      "SELECT favourite FROM MoneyManage WHERE id=$id");
  String fav= favorite[0]['favourite'].toString();
  print("55555 $favorite");
  fav!='true'?
 await _db1.rawUpdate(
      'UPDATE MoneyManage SET favourite="true" WHERE id=$id')
: fav=='true'?
 await _db1.rawUpdate(
      'UPDATE MoneyManage SET favourite="false" WHERE id=$id'):print("5555 $favorite");
  

  await getAllItems(); 
}
