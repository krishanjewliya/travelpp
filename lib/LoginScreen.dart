import 'dart:async';
import 'package:flutter/material.dart';
import 'package:travelbillapp/DashboardAdminScreen.dart';
import 'package:travelbillapp/DashboardScreen.dart';
import 'package:travelbillapp/HomeScreen.dart';
import 'package:travelbillapp/TripDetailsScreen..dart';
import 'package:travelbillapp/Utils/shared_preferences.dart';
import 'package:travelbillapp/api/apiProvider.dart';
import 'package:travelbillapp/api/model/LoginModel.dart';
import 'package:travelbillapp/common_widget/custom_textfield.dart';
import 'package:travelbillapp/common_widget/progress_dialog.dart';
import 'package:travelbillapp/common_widget/submit_button.dart';
import 'package:travelbillapp/constant/app_colors.dart';
import 'package:travelbillapp/constant/app_text_style.dart';
import 'package:travelbillapp/constant/constWidgets.dart';
import 'package:travelbillapp/main.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LogoinScreenState createState() => _LogoinScreenState();
}

class _LogoinScreenState extends State<LoginScreen> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  bool _passwordVisible = false;
  static List<LoginModel> loginDataList = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.transparent,
      body:
      SingleChildScrollView(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.symmetric(horizontal: 16),
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/login.png'),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 250),

              CustomRoundTextField(
                icon: Icon(Icons.email_outlined),
                fillColor: Colors.white70,
                hintText: "Enter email",
                controller: _emailController,
                onChanged:
                    (text) {},
              ),
              const SizedBox(
                height: 8,
              ),
              CustomRoundTextField(
                fillColor: Colors.white70,
                hintText: "Enter password".trim(),
                icon: Icon(Icons.key, color: Colors.black38),
                isPassword: !_passwordVisible,

                suffixIcon: IconButton(
                  icon: Icon(
                      _passwordVisible ? Icons.visibility : Icons.visibility_off,
                      color: AppColors.greenColor),
                  onPressed: () {
                    setState(() => _passwordVisible = !_passwordVisible);
                  },
                ),

                controller: _passwordController,
                onChanged: (text) {},
              ),
              SizedBox(height: 15),
              Container(
                child: GestureDetector(
                  onTap: () {
                   // loginvalidation();
                    _showBottomSheet(context);

                  },
                  child: SubmitButton(
                    height: 60,
                    value: "login".trim().toUpperCase(),
                    color: Colors.white70,
                    textStyle: AppTextStyles.mediumStyle(
                        AppFontSize.font_18, AppColors.blackColor),
                  ),
                ),
              ),

            ],
          )
        ),
      ),


      /*child: Image(
            image: AssetImage('assets/applogo.jpg'),
            width: 100,
            height: 100,
          )),*/
    );
  }

  void loginvalidation() {

    if (_emailController.text == "") {
      showToastMessage("Please enter email");

    }
    else if (_passwordController.text == "") {
      showToastMessage("Please enter password");
    }

    else {

      // showInSnackBar("Thanks");
      Login(_emailController.text.trim(), _passwordController.text.trim());
    }
  }


  Login(String userEmail, String password) {
    final body = {
      "email": userEmail,
      "password": password,
     // "token": "abc",
      // "firebase_token": sp.getString(SpUtil.USER_FCM_TOKEN),
      //  "device_type ": Platform.isAndroid ? "android" : "ios"
    };
    print(body);
    showLoder(context);
    apiProvider.login(body, this).then((response) {
      Navigator.pop(context);
      FocusScope.of(context).unfocus();
      var statusCode = response.status;
      print("statusCode------------>>>>>" + statusCode.toString());
      var convertDataToJson = response;
      if (convertDataToJson.status == "success") {
        sp?.clear();
        var data = convertDataToJson.data;
        sp?.putString(SpUtil.EMAIL, data!.email.toString());
        sp?.putString(SpUtil.USER_ID, data!.id.toString());
        sp?.putString(SpUtil.USER_FNAME, data!.name.toString());
        sp?.putString(SpUtil.USER_MOBILE, data!.mobile.toString());
        sp?.putString(SpUtil.ROLENAME, data!.rolename.toString());
        sp?.putString(SpUtil.TOKEN, data!.remember_token.toString());
        sp?.putString(SpUtil.ISLogin, "user");
        String user = sp?.getString(SpUtil.ISLogin);
        showToastMessage(response.message.toString());
        print("NAME is ------------>>>>>" + data!.name.toString());
        if (data!.rolename.toString() == "User Admin") {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) =>
              const DashboardAdminScreen()));

        }
        else {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) =>
              const TripDetailScreen()));
        }
      }
      else
      {
        showToastMessage(response.message.toString());
            Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) =>
              const LoginScreen()));
      }

    });
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return SingleChildScrollView(
              child:
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery
                          .of(context)
                          .viewInsets
                          .bottom),
                  child:
                  Column(
                    children: [
                      SizedBox(height: 10),
                      Row(

                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [

                          Container(
                              padding: EdgeInsets.all(10),
                              child: Column(children: [
                                GestureDetector(
                                    onTap: () {
                                      setState(() {

                                      });
                                    },

                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              100),
                                          border: Border.all(width: 1,
                                              color: AppColors.blackColor)
                                      ),
                                      child: Icon(Icons.add),
                                    )),
                                SizedBox(height: 10),

                                GestureDetector(
                                    onTap: () {
                                      setState(() {

                                      });
                                    },

                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              100),
                                          border: Border.all(width: 1,
                                              color: AppColors.blackColor)
                                      ),
                                      child: Icon(Icons.remove),
                                    )
                                )
                              ])),
                          Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Text("Person"),
                                  SizedBox(height: 5),
                                  Text("rr", style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),),
                                  SizedBox(height: 5),
                                  Text("Per expense"),
                                  SizedBox(height: 5),
                                  Text('\u{20B9}${'0.50'}', style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16)),

                                ],)),
                          Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text("Spand Expense"),
                                  SizedBox(height: 10),
                                  Text("Today- 5/4/2023", style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16)),
                                  SizedBox(height: 10),
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              10),
                                          color: AppColors.bgColor
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 8),
                                      child: Text("SAVE", style: TextStyle(
                                          color: AppColors.whiteColor),)),

                                ],))
                        ],),
                      SizedBox(height: 10)
                    ],

                  )));
        });
      },
    );
  }

}
