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

class ExportCsvScreen extends StatefulWidget {
  const ExportCsvScreen({Key? key}) : super(key: key);

  @override
  _ExportCsvScreenState createState() => _ExportCsvScreenState();
}

class _ExportCsvScreenState extends State<ExportCsvScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.whiteColor,
        title: Text('Export CSV',textAlign: TextAlign.left,style: TextStyle(color: Colors.black54),),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_outlined,
            color: Colors.black54,
            size: 30,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>
                 ShareScreen("0")));
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
          padding: EdgeInsets.only(top: 40, left: 20, right: 20),
          child: Column(
            children: [
              Text("Export to Csv",style: TextStyle(fontWeight: FontWeight.w500,color: Colors.black,fontSize: 30),),
              SizedBox(height: 20),
              Text("Export all your expense data to a csv file so you can analyze it in Excel or Google Sheets",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black,fontSize: 16)),
              SizedBox(height: 15),
              Container(
                padding: EdgeInsets.only(top: 10,bottom: 10,left: 50,right: 50),
                decoration: BoxDecoration(
                  color: AppColors.bgColor,
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 1,color: AppColors.bgColor),
                ),
                child: Text("Learn more about Premium",style: TextStyle(fontSize: 16,color: Colors.white),),
              ),
              SizedBox(height: 15),
              Text("It would be awesome if you could support us so we can keep improving TravelSpend.",style: TextStyle(fontWeight: FontWeight.w400,color: Colors.black,fontSize: 16)),
              SizedBox(height: 10),


            ],
          ),
        ),
      ),
    );
  }
}
