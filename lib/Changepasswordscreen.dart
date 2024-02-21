import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:travelbillapp/DashboardScreen.dart';
import 'package:travelbillapp/LoginScreen.dart';
import 'package:travelbillapp/Utils/shared_preferences.dart';
import 'package:travelbillapp/common_widget/custom_textfield.dart';
import 'package:travelbillapp/constant/app_colors.dart';
import 'package:travelbillapp/constant/constWidgets.dart';
import 'package:travelbillapp/main.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  _ChangePasswordScreenState createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  TextEditingController _oldpasswordController = TextEditingController();
  TextEditingController _newpasswordController = TextEditingController();
  TextEditingController _confirmpasswordController = TextEditingController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return  WillPopScope(
        onWillPop: () => Future.value(false),
        child: Scaffold(
      //  backgroundColor: Colors.transparent,
      appBar: AppBar(
        titleSpacing: -10,
        title: Container(
            padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
            child: Text("Change Password", style: TextStyle(color: Colors.white))),
        backgroundColor: Colors.blueAccent,
        elevation: 0.0,
        actions: [],
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>  DashboardScreen("0")));
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(left: 16, right: 16, top: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                SizedBox(height: 20),
              CustomRoundTextField(
                fillColor: AppColors
                    .whiteColor,
                hintText: "Enter old password",
                controller: _oldpasswordController,
                onChanged:
                    (text) {},
              ),
              const SizedBox(
                height: 5,
              ),

              CustomRoundTextField(
                fillColor: AppColors
                    .whiteColor,
                hintText: "Enter new password",
                controller: _newpasswordController,
                onChanged:
                    (text) {},
              ),
              const SizedBox(
                height: 5,
              ),

              CustomRoundTextField(
                fillColor: AppColors
                    .whiteColor,
                hintText: "Enter confirm password",
                controller: _confirmpasswordController,
                onChanged:
                    (text) {},
              ),
              const SizedBox(
                height: 5,
              ),

              Container(
                  width: MediaQuery.of(context).size.width,
                  height: 65,
                  padding: const EdgeInsets.only(top: 16.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: Colors.blue, // background
                      onPrimary: Colors.white, // foreground
                    ),
                    onPressed: () {
                      changevalidation();
                    },
                    child: Text('Change Password'),
                  )),

            ],
          ),
        ),
      ),
    ));
  }
  void changevalidation() {
  if (_oldpasswordController.text == "") {
    showToastMessage("Please enter old password");
    }
    else   if (_newpasswordController.text == "") {
    showToastMessage("Please enter new password");
    }
else if(_newpasswordController.text!=_confirmpasswordController.text)
   {
     showToastMessage("Please password not matched");
  }
else
    {
      changepassword(_oldpasswordController.text,_newpasswordController.text);
      /*Navigator.of(context).pushReplacement(MaterialPageRoute(
          builder: (BuildContext context) =>
          const DashboardScreen()));*/
    }
  }


  changepassword(String oldpassword, String newpassword) {
    final body = {
      "id":sp?.getString(SpUtil.USER_ID.toString()),
      "old_password": oldpassword,
      "new_password": newpassword,
    };
    print(
        "resetpassword=======>     $body");
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return WillPopScope(
          onWillPop: () async=>false,
          child: Container(
            height: 50,
            width: 50,
            child: Center(
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.blueColor),
              ),
            ),
          ),
        );
      },
    );
    apiProvider.resetPassword(body, this).then((response) {
      Navigator.pop(context);
      var convertDataToJson = json.decode(response.body);
      print("reset password===================>     $body");
      if (convertDataToJson['status'] == "success") {
        showToastMessage(convertDataToJson["message"].toString());
        sp?.clear();
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen()));
        //showAlertDialog(context);
      } else  {
        showToastMessage(convertDataToJson["message"].toString());
      }
    });
  }
}
