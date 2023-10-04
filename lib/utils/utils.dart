import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Utils {

  void showsnackbar(Color color, String content){
    Get.rawSnackbar(message: content, backgroundColor: color,duration:const Duration(seconds: 3));
  }

  void closesnackbar(){
    Get.closeCurrentSnackbar();
  }
  
}