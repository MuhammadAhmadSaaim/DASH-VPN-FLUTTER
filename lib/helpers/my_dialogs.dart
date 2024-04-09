import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:vpn_basic_project/helpers/pref.dart';

class MyDialogs{

  static error({required String msg}){
    Get.snackbar('Error', msg, colorText: Colors.white, backgroundColor: Colors.red.withOpacity(.9));
  }
  static info({required String msg}){
    Get.snackbar('Info', msg, colorText: Pref.isDarkMode? Colors.white: Colors.black54);
  }

}