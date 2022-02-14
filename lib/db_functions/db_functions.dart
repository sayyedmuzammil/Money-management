import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'data_model.dart';

ValueNotifier<List<MoneyModel>> MoneyListNotifier = ValueNotifier([]);
late Database _db;

Future<void> openDB() async {
  _db = await openDatabase('student.db', version: 1,
      onCreate: (Database db, int version) async {
    await db.execute(
        'CREATE TABLE MoneyManage (id INTEGER PRIMARY KEY, category TEXT, item TEXT, date TEXT, amount INTEGER, remark TEXT, favourite TEXT)');
  });
}

Future<void> addStudent(MoneyModel value) async {
  await _db.rawInsert(
      'INSERT INTO MoneyMange( category, item, date, amount, remark, favourite) VALUES (?,?,?,?,?,?)',
      [value.category,value.item, value.date, value.amount, value.remark, value.favourite]);
  print("student added successfully");
}

Future<void> SearchStudent(SearchedCategory) async {
  MoneyListNotifier.value.clear();
 

  final searched_student = await _db
      .query('MoneyManage', where: "item LIKE ?", whereArgs: ['%$SearchedCategory%']);


  // if
  searched_student.forEach((map) {
    final Single_student = MoneyModel.fromMap(map);
    MoneyListNotifier.value.add(Single_student);
    MoneyListNotifier.notifyListeners();
  });
}

Future<void> getAllStudents() async {
  MoneyListNotifier.value.clear();
  final _values = await _db.rawQuery('SELECT * FROM student');
  print("this is all values in db $_values");
  if (_values.isNotEmpty) {
    _values.forEach((map) {
      final Single_student = MoneyModel.fromMap(map);
      MoneyListNotifier.value.add(Single_student);
      MoneyListNotifier.notifyListeners();
     
    });
  } else {
    print("error alert");
    var alert = "no values in db";
  }
}

_displayDialog(BuildContext context) {}
Future<void> 
deleteStudent(int id) async {
  print(id);
  await _db.rawDelete('DELETE FROM student WHERE id=$id');

  getAllStudents();
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

  await _db.rawUpdate(
      'UPDATE student SET name= "$_name", age="$_age",standard="$_std", address="$_add", profile="$_profile" WHERE id="$_id"');
}

Future<dynamic> FetchData(id) async {
  final values = await _db.rawQuery('SELECT * FROM student WHERE id=$id');

  var Single_student;
  values.forEach((map) {
    Single_student = MoneyModel.fromMap(map);
  });

  return Single_student;
}
