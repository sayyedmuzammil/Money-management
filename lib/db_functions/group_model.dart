// import 'package:flutter/foundation.dart';

class groupModel {
  int? totalAmount;

  String? category;

  groupModel({
    required this.category,
    required this.totalAmount,
  });

  static groupModel fromMap(Map<String, Object?> map) {
    // final id = map['id'] as int;
    final Category = map['category'] as String;
    final totalAmount = map['tot_amount'] as int;

    return groupModel(
      // id: id,
      category: Category,
      totalAmount: totalAmount,
    );
  }
}
