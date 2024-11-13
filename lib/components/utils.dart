import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Utils {
  //Toast Message
  static toastMessage(String message, Color backColor) {
    Fluttertoast.showToast(
      msg: message,
      backgroundColor: backColor,
      textColor: Colors.white,
      fontSize: 20,
      toastLength: Toast.LENGTH_SHORT, 
    );
  }
}
