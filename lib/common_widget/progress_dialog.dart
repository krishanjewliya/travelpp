
import 'package:flutter/material.dart';
import 'package:travelbillapp/constant/app_colors.dart';

  Future<void> showLoder(BuildContext context) {
    return
  showDialog(
    barrierDismissible: false,
    context: context,
    builder: (BuildContext  context) {
      return WillPopScope(
        onWillPop: () async=>false,
        child: Container(
          height: 50,
          width: 50,
          child: const Center(
            child:
            CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(
                  AppColors.blueColor),
            ),
          ),
        ),
      );
    },
  );
}
