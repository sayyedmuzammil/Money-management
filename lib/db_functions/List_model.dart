class listModel {
  String? item;

  listModel({
     this.item,
  
  });

  static listModel fromMap(Map<String, Object?> map) {
    // final id = map['id'] as int;
    final Items = map['data'] as String;

    return listModel(
      // id: id,
      item: Items,
   
    );
  }
}