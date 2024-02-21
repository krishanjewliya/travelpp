import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:travelbillapp/AddcategoriesScreen.dart';
import 'package:travelbillapp/DashboardScreen.dart';
import 'package:travelbillapp/LoginScreen.dart';
import 'package:travelbillapp/TripDetailsScreen..dart';
import 'package:travelbillapp/Utils/shared_preferences.dart';
import 'package:travelbillapp/common_widget/custom_textfield.dart';
import 'package:travelbillapp/common_widget/progress_dialog.dart';
import 'package:travelbillapp/common_widget/submit_button.dart';
import 'package:travelbillapp/constant/app_colors.dart';
import 'package:travelbillapp/constant/app_text_style.dart';
import 'package:travelbillapp/constant/constWidgets.dart';
import 'package:travelbillapp/main.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool _switchValue = false;
  bool _switchValue1 = false;
  bool _switchValue2 = false;
  var userid=sp?.getString(SpUtil.USER_ID.toString());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.cardColor,
      appBar: AppBar(
        backgroundColor: AppColors.cardnewColor,
        title: Text('Settings', textAlign: TextAlign.left),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>  DashboardScreen("0")));
          },
        ),
        elevation: 0,
        actions: [],
        automaticallyImplyLeading: false,
        centerTitle: false,
      ),

      body: SingleChildScrollView(
          child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height*1.2,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background.png'), fit: BoxFit.cover),
            ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: ()
              {
                Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (BuildContext context) => AddCategoriesScreen()));
              },

            child:Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,

                children: [
                Text("Manage Categories", style: TextStyle(fontSize: 18)),
                SizedBox(height: 5),
                Text(
                  "Create or update categories",
                  style: TextStyle(fontSize: 16),
                ),
              ],),
            )),


            SizedBox(height: 5),
            Divider(color: Colors.white),
            SizedBox(height: 5),
            Row(
              children: [
                Container(
                  width: 260,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                    Text("Location-based Currency", style: TextStyle(fontSize: 18)),
                    SizedBox(height: 5),
                    Text(
                      "Determine local currency for expenses \nautomatically",
                      style: TextStyle(fontSize: 14),
                    ),
                  ]),
                ),

                Container(
                  alignment: Alignment.centerRight,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                    Center(
                      child: Switch(
                        activeColor: AppColors.bgColor,
                        value: _switchValue,
                        onChanged: (value) {
                          setState(() {
                            _switchValue = value;
                          });
                        },
                      ),
                    ),
                  ]),
                )
              ],
            ),
            SizedBox(height: 5),
            Divider(color: Colors.white),
            SizedBox(height: 5),
            Row(
              children: [
                Container(
                  width: 200,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Reminder Notifications", style: TextStyle(fontSize: 18)),
                        SizedBox(height: 5),
                        Text(
                          "Remind me to add expenses when im on a trip",
                          style: TextStyle(fontSize: 16),
                        ),
                      ]),
                ),
                Spacer(),
                Container(
                  alignment: Alignment.centerRight,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Switch(
                            activeColor: AppColors.bgColor,
                            value: _switchValue1,
                            onChanged: (value) {
                              setState(() {
                                _switchValue1 = value;
                              });
                            },
                          ),
                        ),
                      ]),
                )
              ],
            ),
            SizedBox(height: 5),
            Divider(color: Colors.white),
            SizedBox(height: 5),
            Row(
              children: [
                Container(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Manage Categories", style: TextStyle(fontSize: 16)),
                        SizedBox(height: 5),
                        Text(
                          "Create or update categories",
                          style: TextStyle(fontSize: 16),
                        ),
                      ]),
                ),
                Spacer(),
                Container(
                  alignment: Alignment.centerRight,
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Center(
                          child: Switch(
                            activeColor: AppColors.bgColor,
                            value: _switchValue2,
                            onChanged: (value) {
                              setState(() {
                                _switchValue2 = value;
                              });
                            },
                          ),
                        ),
                      ]),
                )
              ],
            ),
            SizedBox(height: 5),
            Divider(color: Colors.white),
            SizedBox(height: 8),
            Text("Account", style: TextStyle(fontSize: 18,color: AppColors.bgColor)),
            SizedBox(height: 8),
            Text(
              "Enable premium features and remove ads",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 5),
            Text(
              "Upgrade to Premium ",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Divider(color: Colors.white),
            SizedBox(height: 5),
            Text(
              "Create User Account",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 5),
            Text(
              "Enable data sync and automatic backups",
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 5),
            Divider(color: Colors.white),
            SizedBox(height: 5),
            GestureDetector(
              onTap: ()
              {
                _dialoglogout();
              },

            child:Text(
              "Log Out",
              style: TextStyle(fontSize: 18, color: AppColors.bgColor),
            )),
            SizedBox(height: 5),
            Divider(color: Colors.white),
            SizedBox(height: 5),
            GestureDetector(
              onTap: ()
              {
                _dialogDelete();
              },

              child: Text(
              "Delete this account",
              style: TextStyle(fontSize: 18),
            )),
            SizedBox(height: 5),
            Divider(color: Colors.white),
            SizedBox(height: 5),
            Text(
              "Travel Spand",
              style: TextStyle(fontSize: 18, color: AppColors.bgColor),
            ),
            SizedBox(height: 5),
            Divider(color: Colors.white),
            SizedBox(height: 5),
            GestureDetector(
              onTap: ()
              {
                _showBottomSheet(context);
              },

            child:Text(
              "Enter coupon",
              style: TextStyle(fontSize: 18, ),
            )),
            SizedBox(height: 5),
            Divider(color: Colors.white),
            SizedBox(height: 5),
            Text(
              "Privacy Policy",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 5),
            Divider(color: Colors.white),
            SizedBox(height: 5),
            Text(
              "Terms and Conditions",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 5),
            Divider(color: Colors.white),
            SizedBox(height: 5),
            Text(
              "App Version",
              style: TextStyle(fontSize: 18),
            ),
            Text(
              "1.0.0",
              style: TextStyle(fontSize: 14),
            ),
            SizedBox(height: 5),

          ],
        ),
      )),
    );
  }
  Future<bool> _dialoglogout() async {
    return (await
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          "Confirm Logout !",
          style: AppTextStyles.boldStyle(
              AppFontSize.font_16, AppColors.blackColor),
        ),
        content: Text("Do you want to logout from travelbillapp",
            style: AppTextStyles.mediumStyle(
                AppFontSize.font_14, AppColors.blackColor)),
        actions: <Widget>[
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.center,
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  child: Text('Yes'),
                  onPressed: () {
                   LogoutAPI();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),)
              ),
              SizedBox(width: 10),
              ElevatedButton(
                  child: Text('No'),
                  onPressed: () => Navigator.of(context).pop(false),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black12),)
              ),
            ],)
        ],
      ),
    )) ??
        false;
  }
  Future<bool> _dialogDelete() async {
    return (await
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape:
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        title: Text(
          "Confirm Delete Account !",
          style: AppTextStyles.boldStyle(
              AppFontSize.font_16, AppColors.blackColor),
        ),
        content: Text("Do you want to deete this account",
            style: AppTextStyles.mediumStyle(
                AppFontSize.font_14, AppColors.blackColor)),
        actions: <Widget>[
          Row(
            crossAxisAlignment:
            CrossAxisAlignment.center,
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  child: Text('Yes'),
                  onPressed: () {
                    deleteAccount();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),)
              ),
              SizedBox(width: 10),
              ElevatedButton(
                  child: Text('No'),
                  onPressed: () => Navigator.of(context).pop(false),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black12),)
              ),
            ],)
        ],
      ),
    )) ??
        false;
  }


  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return SingleChildScrollView(
            child:
            Padding(
            padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom),
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 20),
          padding: EdgeInsets.only(left: 15,right: 15,top: 5, bottom: 5),

          // Content of the bottom sheet
          child: Row(
            children: [
              Expanded(
                  flex: 3,
                  child:Container(
              child:TextField(
                keyboardType: TextInputType.text,
                obscureText: false,
                decoration: InputDecoration(
                    hintText: 'Enter Coupon',
                ),
                //  controller: myController,
              ))),
              Expanded(
                  flex:1,
                  child: Container(
                padding: EdgeInsets.only(left: 10,right: 10, top: 10,bottom: 10),
                decoration: BoxDecoration(
                  color: AppColors.bgcardColor,
                  border: Border.all(width: 1,color: Colors.black12),
                  borderRadius: BorderRadius.circular(10)
                ),

                  child:Text("Redeem",style: TextStyle(color: Colors.pink, fontSize: 18))))
            ],
          ),
        )));
      },
    );
  }


  void LogoutAPI() {


    final body = {
      //"id": userid.toString(),
      "id": sp?.getString(SpUtil.USER_ID.toString()),
    };
    print(body);
    showLoder(context);
    apiProvider.logout(body, this).then((response) {
      Navigator.pop(context);
      FocusScope.of(context).unfocus();
      var convertDataToJson = json.decode(response.body);
      var success = convertDataToJson["status"];
      print("statusCode ===================>     $success");
      var message = convertDataToJson["message"];
      print("message------------>>>>>" + message);

      if (success == "success") {
        sp?.clear();
        // print("message ========message========>"+response.message.toString());
        showToastMessage(message);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>
                LoginScreen()));
      }
      else
      {
        showToastMessage(message);
      }

    });
  }
  void deleteAccount() {

    print("print user id=================>"+userid.toString());

    final body = {
        "id": userid.toString(),
    };
    print(body);
    showLoder(context);
    apiProvider.deleteAccount(body, this).then((response) {
      Navigator.pop(context);
      FocusScope.of(context).unfocus();
      var convertDataToJson = json.decode(response.body);
      var success = convertDataToJson["status"];
      print("statusCode ===================>     $success");
      var message = convertDataToJson["message"];
      print("delete account message------------>>>>>" + message);

      if (success == "success") {
        sp?.clear();
        // print("message ========message========>"+response.message.toString());
        showToastMessage(message);

        exit(0);
      }
      else
      {
        showToastMessage(message);
      }

    });
  }
}

