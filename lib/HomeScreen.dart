import 'dart:async';
import 'package:flutter/material.dart';
import 'package:travelbillapp/DashboardAdminScreen.dart';
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
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  bool _passwordVisible = false;
  bool _isChecked = false;
@override
  void initState() {
    // TODO: implement initState
    super.initState();

    _emailController.text="user@gmail.com";
    _passwordController.text="qwerty";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Colors.transparent,
      body: Container(
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
            GestureDetector(
              onTap: ()
              {
                _showBottomSheet(context);
            /*    Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                        builder: (BuildContext context) => const LoginScreen()));*/
              },

            child:Container(
                width: MediaQuery
                    .of(context)
                    .size
                    .width,
                height: 55,
                padding: const EdgeInsets.only(top: 16.0,bottom: 10),
                decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(10)
                ),
                child:
                  Text('LOGIN',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.black,
                    fontWeight:FontWeight.w500,
                    fontSize: 18),
                  ),
                )),
           /* SizedBox(height: 20),
          GestureDetector(
            onTap: ()
            {
           *//*   Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                      builder: (BuildContext context) => const LoginScreen()));*//*
              _showBottomSheet(context);
            },

            child:Container(
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 55,
              padding: const EdgeInsets.only(top: 16.0,bottom: 10),
              decoration: BoxDecoration(
                  color: Colors.white70,
                  borderRadius: BorderRadius.circular(10)
              ),
              child:
              Text('USER',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black,
                    fontWeight:FontWeight.w500,
                    fontSize: 18),
              ),
            )),*/
          ],
        )
      ),


      /*child: Image(
            image: AssetImage('assets/applogo.jpg'),
            width: 100,
            height: 100,
          )),*/
    );
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
     // backgroundColor: Colors.white70,
      shape:  RoundedRectangleBorder(
    borderRadius: BorderRadius.only(
    topLeft: Radius.circular(40.0), // Adjust the radius value as needed
    topRight: Radius.circular(40.0), // Adjust the radius value as needed
    ),
    ),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return SingleChildScrollView(
              child:
                  Container(

                  height: 400,
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                  child:
                  Column(

                    children: [
                      SizedBox(height: 20),
                      CustomRoundTextField(
                        icon: Icon(Icons.email_outlined),
                        fillColor: Colors.black12,
                        hintText: "Enter email",
                        controller: _emailController,
                        onChanged:
                            (text) {},
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomRoundTextField(
                        fillColor: Colors.black12,
                        hintText: "Enter password".trim(),
                        icon: Icon(Icons.key, color: Colors.black38),
                        isPassword: !_passwordVisible,

                        suffixIcon: IconButton(
                          icon: Icon(
                              _passwordVisible ? Icons.visibility : Icons.visibility_off,
                              color: AppColors.bgcardColor),
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
                             loginvalidation();
                          //  _showBottomSheet(context);

                          },
                          child: SubmitButton(
                            height: 60,
                            value: "login".trim().toUpperCase(),
                            color: AppColors.bgcardColor,
                            textStyle: AppTextStyles.mediumStyle(
                                AppFontSize.font_18, AppColors.whiteColor),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Checkbox(
                            checkColor:AppColors.bgcardColor,
                            value: _isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isChecked = value!;
                              });
                            },
                          ),
                          Text('Keep Sign In',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                       /*   Spacer(),
                          Text('Forgot Password?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: AppColors.bgcardColor)),
                   */     ],
                      ),
                   /*   GestureDetector(
                        onTap: ()
                        {
                          Navigator.pop(context);
                          //_showBottomSheetSignup(context);
                        },

                      child:RichText(
                        text: TextSpan(
                          text: 'Dont have an account! ',
                          style: DefaultTextStyle.of(context).style,
                          children: const <TextSpan>[
                            TextSpan(text: 'Sign Up', style: TextStyle(fontWeight: FontWeight.bold, fontSize:16,color: AppColors.bgcardColor)),

                          ],
                        ),
                      )

),*/

]
                  )));
        });
      },
    );
  }
  void _showBottomSheetSignup(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      // backgroundColor: Colors.white70,
      shape:  RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(40.0), // Adjust the radius value as needed
          topRight: Radius.circular(40.0), // Adjust the radius value as needed
        ),
      ),
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return SingleChildScrollView(
              child:
              Container(

                  height: 400,
                  padding: EdgeInsets.symmetric(horizontal: 20,vertical: 30),
                  child:
                  Column(

                    children: [
                      SizedBox(height: 20),
                      CustomRoundTextField(

                        icon: Icon(Icons.email_outlined),
                        fillColor: Colors.black12,
                        hintText: "Enter email",
                        controller: _emailController,
                        onChanged:
                            (text) {},
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      CustomRoundTextField(
                        fillColor: Colors.black12,
                        hintText: "Enter password".trim(),
                        icon: Icon(Icons.key, color: Colors.black38),
                        isPassword: !_passwordVisible,

                        suffixIcon: IconButton(
                          icon: Icon(
                              _passwordVisible ? Icons.visibility : Icons.visibility_off,
                              color: AppColors.bgcardColor),
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
                            value: "Signup".trim().toUpperCase(),
                            color: AppColors.bgcardColor,
                            textStyle: AppTextStyles.mediumStyle(
                                AppFontSize.font_18, AppColors.whiteColor),
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      Row(
                        children: [
                          Checkbox(
                            checkColor:AppColors.bgcardColor,
                            value: _isChecked,
                            onChanged: (bool? value) {
                              setState(() {
                                _isChecked = value!;
                              });
                            },
                          ),
                          Text('Keep Sign In',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16)),
                          Spacer(),
                          Text('Forgot Password?',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 16, color: AppColors.bgcardColor)),
                        ],
                      ),
                      GestureDetector(
                        onTap: ()
                        {
                          Navigator.pop(context);

                        },

                        child:RichText(
                          text: TextSpan(
                              text: 'Dont have an account! ',
                              style: DefaultTextStyle.of(context).style,
                              children: const <TextSpan>[
                              TextSpan(text: 'Sign Up', style: TextStyle(fontWeight: FontWeight.bold, fontSize:16,color: AppColors.bgcardColor)),

                          ],
                        ),
                      )


                      )],

                  )));
        });
      },
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
        sp?.putString(SpUtil.ADMIN_ID, data!.createdBy.toString());
        sp?.putString(SpUtil.TOKEN, data!.remember_token.toString());
        sp?.putString(SpUtil.ISLogin, data!.rolename.toString());
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


}
