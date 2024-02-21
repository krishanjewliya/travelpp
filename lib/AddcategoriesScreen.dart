import 'dart:async';
import 'package:flutter/material.dart';
import 'package:travelbillapp/DashboardScreen.dart';
import 'package:travelbillapp/LoginScreen.dart';
import 'package:travelbillapp/SettingScreen.dart';
import 'package:travelbillapp/TripDetailsScreen..dart';
import 'package:travelbillapp/common_widget/custom_textfield.dart';
import 'package:travelbillapp/common_widget/submit_button.dart';
import 'package:travelbillapp/constant/app_colors.dart';
import 'package:travelbillapp/constant/app_text_style.dart';
import 'package:travelbillapp/sharescreen.dart';
import 'package:url_launcher/url_launcher.dart';

class AddCategoriesScreen extends StatefulWidget {
  const AddCategoriesScreen({Key? key}) : super(key: key);

  @override
  _AddCategoriesScreenState createState() => _AddCategoriesScreenState();
}

class _AddCategoriesScreenState extends State<AddCategoriesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Text('Add Categories',textAlign: TextAlign.left,style: TextStyle(color: Colors.black54),),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black54,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>
                const SettingScreen()));
          },
        ),
        elevation: 0,
        actions: [
        ],

        automaticallyImplyLeading: false,
        centerTitle: false,

      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 40, left: 10, right: 10),
          child: Column(
            children: [

              Image.asset(
                'assets/graph.png',
                height: 200,
                width: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 30),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    children: [
                      Text(
                        "Add Categories",
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 22, color: Colors.black),
                      ),
                      SizedBox(height:20),
                      Text(
                        "Just pick a neat icon and give it a name. You can add as many categories as you like and modity existing ones too.",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                      SizedBox(height: 20),
                      Container(
                        padding: EdgeInsets.only(top: 10,bottom: 10,left: 30,right: 30),
                        decoration: BoxDecoration(
                          color: Colors.pinkAccent.shade400,
                          borderRadius: BorderRadius.circular(10)
                        ),
                        child: Text("Learn more about Premium",style: TextStyle(color: Colors.white,fontSize: 16),),
                      ),
                      SizedBox(height: 20),
                      Text(
                        "It would be awesome. if you could support us so we can keep improving TravelSpand",
                        style: TextStyle(
                            fontWeight: FontWeight.w400, fontSize: 14),
                      ),
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
