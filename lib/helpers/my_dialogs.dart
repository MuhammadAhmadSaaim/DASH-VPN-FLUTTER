import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class MyDialogs{

  static error({required String msg}){
    Get.snackbar('Error', msg, colorText: Colors.white, backgroundColor: Colors.red.withOpacity(.9));
  }
  static info({required String msg}){
    Get.snackbar('Info', msg, colorText: Colors.white);
  }

}