import 'dart:async';
import 'package:flutter/material.dart';
import 'package:travelbillapp/DashboardScreen.dart';
import 'package:travelbillapp/LoginScreen.dart';
import 'package:travelbillapp/TripDetailsScreen..dart';
import 'package:travelbillapp/common_widget/custom_textfield.dart';
import 'package:travelbillapp/common_widget/submit_button.dart';
import 'package:travelbillapp/constant/app_colors.dart';
import 'package:travelbillapp/constant/app_text_style.dart';
import 'package:travelbillapp/sharescreen.dart';
import 'package:url_launcher/url_launcher.dart';

class LocallyTripScreen extends StatefulWidget {
  const LocallyTripScreen({Key? key}) : super(key: key);

  @override
  _LocallyTripScreenState createState() => _LocallyTripScreenState();
}

class _LocallyTripScreenState extends State<LocallyTripScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 40, left: 16, right: 16),
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.png'), fit: BoxFit.cover),
          ),
          child: Column(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                            ShareScreen("0")));
                  },
                  child: Container(
                      alignment: Alignment.topLeft,
                      child: Icon(Icons.arrow_back_outlined,
                          size: 30, color: AppColors.blackColor))),
              Image.asset(
                'assets/local.png',
                height: 300,
                width: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 30),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Text(
                        "Invite friends son they can enter expenses too. Or just add them locally.",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 16),
                      ),
                      SizedBox(height: 40),
                      TextField(
                        keyboardType: TextInputType.text,
                        obscureText: false,
                        decoration: InputDecoration(
                            hintText: 'krishan@gmail.com',
                            hintStyle: TextStyle(color: Colors.white),
                            suffixIcon: Icon(Icons.edit, color: Colors.white,),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          border: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                        ),
                        //  controller: myController,
                      ),
                      SizedBox(height: 15),
                      TextField(
                          keyboardType: TextInputType.text,
                          obscureText: false,
                          decoration: InputDecoration(
                            hintText: 'Enter Trip',
                            hintStyle: TextStyle(color:Colors.white),
                            suffixIcon: Icon(Icons.edit, color: Colors.white),
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            border: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                          ),

                      ),
                      SizedBox(height: 40),
                      Container(
                        width: MediaQuery.of(context).size.width,
                        padding:
                            EdgeInsets.symmetric( vertical: 15),
                        decoration: BoxDecoration(
                            color: Colors.white70,
                            borderRadius: BorderRadius.circular(10),
                            border:
                                Border.all(width: .8, color: Colors.black26)),
                        child: Text(
                          "SAVE",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.red, fontWeight: FontWeight.w500),
                        ),
                      )
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
