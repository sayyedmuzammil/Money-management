// ignore_for_file: file_names

class ListModel {
  String? item;

  ListModel({
     this.item,
  
  });

  static ListModel fromMap(Map<String, Object?> map) {
    // final id = map['id'] as int;
    final items = map['data'] as String;

    return ListModel(
      // id: id,
      item: items,
   
    );
  }
}