import 'package:flutter/cupertino.dart';
import 'package:money_management/db_functions/List_model.dart';
// import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'data_model.dart';
import 'group_model.dart';

ValueNotifier<List<MoneyModel>> MoneyListNotifier = ValueNotifier([]);
ValueNotifier<List<listModel>> SimpleListNotifier = ValueNotifier([]);
late Database _db1;

Future<void> openDB() async {
  _db1 = await openDatabase('money.db', version: 1,
      onCreate: (Database db, int version) async {
    await db.execute(
        'CREATE TABLE MoneyManage (id INTEGER PRIMARY KEY, category TEXT, item TEXT, date DATE, amount INTEGER, remark TEXT, favourite TEXT)');
  });
}

Future<void> addMoney(MoneyModel value) async {
  print(value.toString());
  print(value.category);
  print(value.item);
  print(value.amount);
  print(value.date);
  print(value.remark);

  await _db1.rawInsert(
      'INSERT INTO MoneyManage(category,item,date,amount,remark,favourite) VALUES (?,?,?,?,?,?)',
      [
        value.category,
        value.item,
        value.date,
        value.amount,
        value.remark,
        value.favourite
      ]);
  print("student added successfully");
}

Future<void> SearchMoney(SearchedItem) async {
  MoneyListNotifier.value.clear();

  final searched_item = await _db1.query('MoneyManage',
      where: "item LIKE ?", whereArgs: ['%$SearchedItem%']);

  // if
  searched_item.forEach((map) {
    final Single_student = MoneyModel.fromMap(map);
    MoneyListNotifier.value.add(Single_student);
    MoneyListNotifier.notifyListeners();
  });
}

Future<List<Map<String, Object?>>> getAllItems() async {
  MoneyListNotifier.value.clear();
  final _values =
      await _db1.rawQuery('SELECT * FROM MoneyManage ORDER BY date desc');
  // print("this is all values in db $_values");
  if (_values.isNotEmpty) {
    _values.forEach((map) {
      final Single_item = MoneyModel.fromMap(map);
      MoneyListNotifier.value.add(Single_item);
      MoneyListNotifier.notifyListeners();
      print("this is getall $Single_item");
    });
  } else {
    // _values.add({'null':'null'});
    var alert = "no values in db";
    print("error alert $alert");
  }

  return _values;
}

Future<dynamic> GroupByCategory() async {
  // MoneyListNotifier.value.clear();
  // print('in displayStudent ');

  final values = await _db1.rawQuery(
      "SELECT  category, SUM(amount) tot_amount FROM MoneyManage GROUP BY category");
  var grouped;
  values.forEach((map) {
    grouped = groupModel.fromMap(map);
  });
  print("Inthe Database Grouped $values");

  return values;
}
Future<List<Map<String, Object?>>> PieChartValue(_category) async {
  // MoneyListNotifier.value.clear();
  // print('in displayStudent ');
print("category from db $_category");
  final values = await _db1.rawQuery(
      "SELECT  DISTINCT(item) AS category, SUM(amount) tot_amount FROM MoneyManage WHERE category='$_category' GROUP BY item ");
  // var grouped;
  // values.forEach((map) {
  //   grouped = groupModel.fromMap(map);
  // });
  print("Inthe Database in main card group and wher $values");

  return values;
}

Future<dynamic> ListForTextForm(_category) async {
  SimpleListNotifier.value.clear();
//  var month=_db1.rawQuery;
//  print("Current Month $month");
// await _db1.query('TRUNCATE MoneyManage');
// _db1.execute("delete from MoneyManage");//delete all data
String currentMonth = DateTime.now().month.toString();
String currentYear = DateTime.now().year.toString();
print(DateTime.now().month);
print(DateTime.now().year);

  final values = await _db1.rawQuery(
      "SELECT DISTINCT(item) AS data FROM MoneyManage WHERE category = '$_category' AND ((strftime('%m', date)='0$currentMonth') OR (strftime('%m', date)='$currentMonth')) ");
      print(values);
  if (values.isNotEmpty) {
    values.forEach((map) {
      final Single_item = listModel.fromMap(map);
      SimpleListNotifier.value.add(Single_item);
      SimpleListNotifier.notifyListeners();
      print("this is lists $Single_item");
    });
  } else {
    var alert = "no values in db";
    print("error alert $alert");
  }
  
  return values;
  // r;
}


Future<dynamic> ListForMonth() async {
  SimpleListNotifier.value.clear();
//  var month=_db1.rawQuery;
//  print("Current Month $month");
// await _db1.query('TRUNCATE MoneyManage');
// _db1.execute("delete from MoneyManage");//delete all data
String currentMonth = DateTime.now().month.toString();
String currentYear = DateTime.now().year.toString();
print(DateTime.now().month);
print(DateTime.now().year);

  final values = await _db1.rawQuery(
      "SELECT DISTINCT(strftime('%m', date)) AS data FROM MoneyManage ORDER BY date desc");
      print(values);
  if (values.isNotEmpty) {
    values.forEach((map) {
      final Single_item = listModel.fromMap(map);
      SimpleListNotifier.value.add(Single_item);
      SimpleListNotifier.notifyListeners();
      print("this is lists for months $Single_item");
    });
  } else {
    var alert = "no values in db";
    print("error alert $alert");
  }
  
  return values;
  // r;
}
/* 
Future<void> deleteStudent(int id) async {
  print(id);
  await _db1.rawDelete('DELETE FROM student WHERE id=$id');

  getAllItems();
}

Future<void> UpdateStudent(editedStudent) async {
  MoneyListNotifier.value.clear();
  print('in displayStudent $editedStudent');
  int _id = editedStudent.id;
  String _name = editedStudent.name;
  int _age = editedStudent.age;
  String _std = editedStudent.standard;
  String _add = editedStudent.address;
  String _profile = editedStudent.profile;

  await _db1.rawUpdate(
      'UPDATE student SET name= "$_name", age="$_age",standard="$_std", address="$_add", profile="$_profile" WHERE id="$_id"');
}

Future<dynamic> FetchData(id) async {
  final values = await _db1.rawQuery('SELECT * FROM student WHERE id=$id');

  var Single_student;
  values.forEach((map) {
    Single_student = MoneyModel.fromMap(map);
  });

  return Single_student;
}
 */