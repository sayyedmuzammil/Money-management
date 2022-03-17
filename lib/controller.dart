// ignore_for_file: non_constant_identifier_names

import 'package:get/get.dart';

class FetchController extends GetxController{
    var imageTemporary="".obs;
     Future<void> DataInsetion1(studentid) async {
    //  int counter=0;

    if (studentid == null || studentid == 0) {
    imageTemporary.value="" ;
     return;
    }
    // final student = await control.FetchData(studentid);
    // imageTemporary.value = await student.profile;
  //  update(); 
   }
}
