import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelbillapp/DashboardAdminScreen.dart';
import 'package:travelbillapp/DashboardScreen.dart';
import 'package:travelbillapp/LoginScreen.dart';
import 'package:travelbillapp/TripDetailsScreen..dart';
import 'package:travelbillapp/TripExpensisEditScreen..dart';
import 'package:travelbillapp/TripExpensisScreen..dart';
import 'package:travelbillapp/TripScreen..dart';
import 'package:travelbillapp/UserListScreen.dart';
import 'package:travelbillapp/Utils/shared_preferences.dart';
import 'package:travelbillapp/api/apiProvider.dart';
import 'package:travelbillapp/api/model/CurrencyModel.dart';
import 'package:travelbillapp/api/model/ExpenseStatusModel.dart';
import 'package:travelbillapp/api/model/GetExpensisModel.dart';
import 'package:travelbillapp/api/model/TotalexpenseModel.dart';
import 'package:travelbillapp/api/model/UserlistModel.dart';
import 'package:travelbillapp/common_widget/progress_dialog.dart';
import 'package:travelbillapp/common_widget/submit_button.dart';
import 'package:travelbillapp/constant/app_colors.dart';
import 'package:travelbillapp/constant/app_text_style.dart';
import 'package:travelbillapp/constant/constWidgets.dart';
import 'package:travelbillapp/main.dart';
import 'package:country_picker/country_picker.dart';
import 'package:intl/intl.dart';

class EditUserScreen extends StatefulWidget {
  String id;
  EditUserScreen(this.id);

  @override
  _EditUserScreenState createState() => _EditUserScreenState();
}

class _EditUserScreenState extends State<EditUserScreen> {

  TextEditingController _userIdcontroller = new TextEditingController();
  TextEditingController _usercontroller = new TextEditingController();
  TextEditingController _userMobilecontroller = new TextEditingController();
  TextEditingController _userEmailcontroller = new TextEditingController();
  TextEditingController _userPasswordcontroller = new TextEditingController();
  TextEditingController _userConfirmPasswordcontroller = new TextEditingController();
  TextEditingController _countrycodeController = new TextEditingController();
  final random = Random();
  String? _Currency;

  static List<UserlistData> userData = [];
  final List<String> _imagePaths = [
    'assets/trip1.jpg',
    'assets/trip.png',
    'assets/trip2.jpg',
  ];
  int _selectedIndex = 0;

  void _changeImage() {
    setState(() {

      _selectedIndex = Random().nextInt(_imagePaths.length);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    EditDetails();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body:
      SingleChildScrollView(
        child:   Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: EdgeInsets.only(top: 5),
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background.png'),
                  fit: BoxFit.cover),
            ),

          child: Column(children: [
            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(_imagePaths[_selectedIndex]),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(children: [
                SizedBox(height: 40),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (
                                  BuildContext context) => const UserListScreen()));
                    },
                    child: Container(
                        alignment: Alignment.topLeft,
                        child: Icon(Icons.arrow_back_outlined, size: 30,
                            color: AppColors.whiteColor))),
              //  SizedBox(height: 10),
              /*  GestureDetector(
                    onTap: () {
                      _showImagePicker(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 35, vertical: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 1, color: AppColors.whiteColor),
                      ),
                      child: Text("CHOOSE PHOTO",
                        style: TextStyle(fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: AppColors.whiteColor),),
                    )),*/
                SizedBox(height: 20),
                GestureDetector(
                    onTap: ()
                    {
                      _changeImage();
                    },

                    child:Container(
                      padding: EdgeInsets.symmetric(horizontal: 35, vertical: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(width: 1, color: AppColors.whiteColor),
                      ),
                      child: Text("RANDOM PHOTO",
                        style: TextStyle(fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: AppColors.whiteColor),),
                    )),

              ],),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(10),
              child: Column(children: [
                SizedBox(height: 5),
                TextField(
                    controller: _userIdcontroller,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.whiteColor),
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      hintStyle: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: AppColors.whiteColor),
                      hintText: 'Enter Employee id',

                    )),
                SizedBox(height: 10),
                TextField(
                  controller: _usercontroller,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.whiteColor),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.whiteColor),
                    hintText: 'Enter User Name',
                  ),
                  //  controller: myController,
                ),
                SizedBox(height: 10),
                _buildCountryPicker(),
                SizedBox(height: 10),

                TextField(
                  controller: _userEmailcontroller,
                  keyboardType: TextInputType.emailAddress,
                  obscureText: false,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.whiteColor),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.whiteColor),
                    hintText: 'Enter valid email',
                  ),
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _userPasswordcontroller,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.whiteColor),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.whiteColor),
                    hintText: 'Enter password',
                  ),
                  //  controller: myController,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _userConfirmPasswordcontroller,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 14,
                      color: AppColors.whiteColor),
                  decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    hintStyle: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 14,
                        color: AppColors.whiteColor),
                    hintText: 'Enter confirm password',
                  ),
                  //  controller: myController,
                ),
                SizedBox(height: 40),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      userValidation();
                      /*    Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (
                                  BuildContext context) => const TripDetailScreen()));*/
                    },
                    child: SubmitButton(
                      height: 60,
                      value: "Create User".trim().toUpperCase(),
                      color: AppColors.blackColor,
                      textStyle: AppTextStyles.mediumStyle(
                          AppFontSize.font_16, AppColors.whiteColor),
                    ),
                  ),
                ),
              ],),),
          ]))),
    );
  }







  void userValidation() {
    if(_userIdcontroller.text=="")
    {
      showToastMessage("Please enter user id ");
    }
    else if(_usercontroller.text=="")
    {
      showToastMessage("Please enter user name");
    }
    else if(_userMobilecontroller.text=="")
    {
      showToastMessage("Please enter mobile number");
    }
    else if(_userMobilecontroller.text.length<10)
    {
      showToastMessage("Please enter mobile number not less then  10 digits");
    }

    else if(_userEmailcontroller.text=="")
    {
      showToastMessage("Please enter email");
    }
    else if(_userPasswordcontroller.text=="")
    {
      showToastMessage("Please enter password");
    }
    else if(_userPasswordcontroller.toString().length<6)
    {
      showToastMessage("Please enter password length minimum 6 characters");
    }
    else if(_userPasswordcontroller.text!=_userConfirmPasswordcontroller.text)
    {
      showToastMessage("Please confirm password noy matched");
    }
    else
    {
      CreateTripAPI(_userIdcontroller.text,_usercontroller.text,_countrycodeController.text,_userMobilecontroller.text,_userEmailcontroller.text,_userPasswordcontroller.text);
    }
  }

  void CreateTripAPI(String userId, String userName, String countrycode, String userMobile, String userEmail,String userPassword) {

    {
      final body = {
        "created_by":sp?.getString(SpUtil.USER_ID.toString()),
        "id":widget.id,
        "emp_id":userId,
        "name":userName,
        "mobile":userMobile,
        "email":userEmail,
        "password":userPassword,
        "country_code":countrycode,
        "roles":"User",
      };
      print("response body===================>     $body");
      showLoder(context);
      apiProvider.UpdateUser(body, this).then((response) {
        Navigator.pop(context);
        var convertDataToJson = json.decode(response.body);
        var success = convertDataToJson["success"];
        // print("statusCode ===================>     $success");
        if (convertDataToJson['status'] == "success") {
          print("statusCode ===================>"+convertDataToJson['status']);
          print("message ========message========>"+convertDataToJson['message']);

          showToastMessage(convertDataToJson['message']);
          FocusScope.of(context).unfocus();
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) => const DashboardAdminScreen()));
        }
        else
        {
          print("message ========message========>"+convertDataToJson['message'].toString());
          showToastMessage(convertDataToJson['message'].toString());
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) =>  EditUserScreen(widget.id)));
        }
      });
    }
  }

  _buildCountryPicker() {
    return Container(
      height: 50,
      decoration: BoxDecoration(
    border: Border(
    bottom: BorderSide(
    color: Colors.grey, // Replace with your desired color
    width: 1.0, // Replace with your desired border width
    ),
    )),
      child: Row(
        children: [
          SizedBox(width: 8),
          Expanded(
            flex: 1,
            child: _buildCountryPicker1(),
          ),

          const SizedBox(
            width: 5,
          ),
          Expanded(flex: 8, child: _buildTextField())
        ],
      ),
    );
  }


  _buildCountryPicker1() {
    return TextField(
      controller: _countrycodeController,
      style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: AppColors.whiteColor),
      decoration: InputDecoration(
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.white),
        ),
        hintStyle: TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 25,
            color: AppColors.whiteColor),
        border: InputBorder.none,
        hintText: "+91",
      ),
      readOnly: true,
      onTap: () {
        showCountryPicker(
            context: context,
            showWorldWide: false,
            showPhoneCode: true,
            showSearch: true,
            exclude: <String>['KN', 'MF'],
            favorite: <String>['SE'],

            countryListTheme: CountryListThemeData(
                backgroundColor: AppColors.whiteColor,
               // borderRadius: BorderRadius.circular(8),
                bottomSheetHeight: 380,
                flagSize: 20,
                textStyle: TextStyle(
                    color: AppColors.blackColor,
                    fontSize: 14,
                    height: 2.0
                )
            ),
            onSelect: (Country country) {
              _countrycodeController.text =
                   country.phoneCode;
              // log(country.toString());
            }
        );
      },
    );
  }


  _buildTextField() {
    return TextField(
      maxLength: 10,
      inputFormatters: [
        FilteringTextInputFormatter.allow(RegExp(r"[0-9]")),
      ],
      controller: _userMobilecontroller,
      keyboardType: TextInputType.number,

      style: TextStyle(
          fontWeight: FontWeight.w500,
          fontSize: 14,
          color: AppColors.whiteColor),
      decoration: InputDecoration(
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          hintStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 25,
              color: AppColors.whiteColor),
          border: InputBorder.none,
          hintText: "Enter mobile number",

          counterText: ""),
    );
  }
  EditDetails() {
    final body = {
      "user_id":widget.id, // "id": "1",
      "id":sp?.getString(SpUtil.USER_ID.toString()),
      //country_id
    };

    {
      // showLoder(context);
      print("user id>>>>>>>>>>>" + body.toString());
      apiProvider.EditUserDetails(body, context).then((response) {
        //1 Navigator.pop(context);
        // FocusScope.of(context).unfocus();
        var success = ApiProvider.returnResponse(response.status.toString());
        print("user >>>>>>>>>>>" + success.toString());
        var convertDataToJson = response;
        var data = convertDataToJson.data;
        print("sucess>>>>>>>>>>>" + success.toString());
        //print("data" + data.toString());

        if (success) {
          setState(() {
            userData.clear();
            userData = data!;
            print("tripDatalist>>>>>>>>>>>" + userData.toString());
            for (int i = 0; i < userData.length; i++) {
              _userIdcontroller.text=userData[i].id.toString();
              _usercontroller.text=userData[i].name.toString();
              _userMobilecontroller.text=userData[i].mobile.toString();
              _userEmailcontroller.text=userData[i].email.toString();
              _countrycodeController.text=userData[i].countryCode.toString();
            }

            // isDataLoad=true;
          });
        }
      });
    }
  }
}


