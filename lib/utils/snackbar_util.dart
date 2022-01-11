import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarUtil {
  static void showErrorSnackbar({title, message}) {
    Get.snackbar(
      title, 
      message,
      colorText: Colors.redAccent, backgroundColor: Colors.red[50]);
  }

  static void showInforSnackbar({title, message}) {
    Get.snackbar(
      title, 
      message,
      colorText: Colors.blueAccent, backgroundColor: Colors.blue[50]);
  }

  static void showSuccessSnackbar({title, message}) {
    Get.snackbar(
      title, 
      message,
      colorText: Colors.greenAccent, backgroundColor: Colors.green[50]);
  }
}