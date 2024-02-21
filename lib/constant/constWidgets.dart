/*
* ©️  2021 Inventcolabs Pvt. Ltd. ,  All rights reserved.
*/
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../main.dart';

void showToastMessage(String message) {
  Fluttertoast.showToast(
      msg: message,
      //message to show toast
      toastLength: Toast.LENGTH_LONG,
      //duration for message to show
      gravity: ToastGravity.CENTER,
      //where you want to show, top, bottom
      timeInSecForIosWeb: 1,
      //for iOS only
      backgroundColor: Colors.black45, //background Color for message
      textColor: Colors.white,
      //message text color
      fontSize: 16.0 //message font size
      );
}



