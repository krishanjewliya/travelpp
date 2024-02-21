import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
import 'package:travelbillapp/BillActionScreen.dart';
import 'package:travelbillapp/DashboardAdminScreen.dart';
import 'package:travelbillapp/DashboardScreen.dart';
import 'package:travelbillapp/LoginScreen.dart';
import 'package:travelbillapp/TripExpensisEditScreen..dart';
import 'package:travelbillapp/TripExpensisScreen..dart';
import 'package:travelbillapp/TripScreen..dart';
import 'package:travelbillapp/Utils/shared_preferences.dart';
import 'package:travelbillapp/api/apiProvider.dart';
import 'package:travelbillapp/api/model/ExpenseStatusModel.dart';
import 'package:travelbillapp/api/model/GetExpensisModel.dart';
import 'package:intl/intl.dart';
import 'package:travelbillapp/api/model/TotalexpenseModel.dart';
import 'package:travelbillapp/api/model/TriplistModel.dart';
import 'package:travelbillapp/common_widget/progress_dialog.dart';
import 'package:travelbillapp/constant/app_colors.dart';
import 'package:travelbillapp/main.dart';

class UserTripDetailScreen extends StatefulWidget {
  String? id;
  String? trip_id;

  UserTripDetailScreen(this.id, this.trip_id);

  @override
  _UserTripDetailScreenState createState() => _UserTripDetailScreenState();
}

class _UserTripDetailScreenState extends State<UserTripDetailScreen> {
  static List<Expense> totalExpensislist = [];
  ExpensisData expensisData = ExpensisData();

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      totalExpensisList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          titleSpacing: -10,
          title: Container(
              padding: const EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
              child:
                  Text("Trip Expensis", style: TextStyle(color: Colors.white))),
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
                  builder: (BuildContext context) =>
                      const DashboardAdminScreen()));
            },
          ),
        ),
        body: SingleChildScrollView(
            child: Column(
          children: [
            ListView.builder(
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                itemCount: totalExpensislist.length,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return GestureDetector(
                      onTap: () {
                            Navigator.of(context)
                                .pushReplacement(
                                MaterialPageRoute(
                                    builder: (
                                        BuildContext context) =>
                                        BillActionScreen(totalExpensislist[i].id.toString(),totalExpensislist[i].tripId.toString())));
                      },
                      child: Card(
                          elevation: 2,
                          child: Container(
                              padding: EdgeInsets.all(10),
                              child: Row(children: [
                                totalExpensislist[i].billImage != null
                                    ? ClipRRect(
                                  borderRadius: BorderRadius.circular(100), // Adjust the radius as needed
                                  child: Image.network(
                                    totalExpensislist[i].billImage.toString(),
                                    width: 40,
                                    height: 40,
                                    fit: BoxFit.cover, // Adjust the fit to determine how the image fills the clipped area
                                    errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                                      // Handle error case when the image fails to load
                                      return Center(
                                        child: Icon(Icons.error, size: 40,),
                                      );
                                    },
                                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                                      // Handle loading case when the image is being loaded
                                      if (loadingProgress == null) {
                                        return child;
                                      }
                                      return Center(
                                        child: CircularProgressIndicator(),
                                      );
                                    },
                                  ),
                                )

                                    : Container(
                                        width: 40,
                                        height: 40,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          image: DecorationImage(
                                            image:
                                                AssetImage("assets/graph.png"),
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                SizedBox(width: 20),
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                          totalExpensislist[i]
                                              .expenseCategory
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.hintTextColor)),
                                      SizedBox(height: 5),
                                      Text(
                                          totalExpensislist[i]
                                              .description
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 14,
                                              fontWeight: FontWeight.w500,
                                              color: AppColors.hintTextColor))
                                    ],
                                  ),
                                ),
                                Spacer(),
                                Container(
                                  child: Column(
                                    children: [
                                      Text(
                                          totalExpensislist[i]
                                              .amount
                                              .toString()+".00"+" "+ totalExpensislist[i]
                                              .currency
                                              .toString(),
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.w400,
                                              color: AppColors.hintTextColor)),

                                    ],
                                  ),
                                )
                              ]))));


                }),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text("Total Bill: ",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor)),
                Text(expensisData.totalExpense.toString() + ".00",
                    style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: AppColors.blackColor)),
                SizedBox(width: 15),
              ],
            )
          ],
        )));
  }



  totalExpensisList() {
    final body = {
      "user_id": widget.trip_id,
      "trip_id": widget.id // "id": "1",
      //  "country": "101",
      //country_id
    };

    {
      // showLoder(context);
      print("trp id>>>>>>>>>>>" + body.toString());
      apiProvider.TotalexpenseList(body, context).then((response) {
        //1 Navigator.pop(context);
        // FocusScope.of(context).unfocus();
        var success = ApiProvider.returnResponse(response.status.toString());
        print("TotalexpenseList >>>>>>>>>>>" + success.toString());
        var convertDataToJson = response;
        var data = convertDataToJson.data.totalExpense;
        print("sucess>>>>>>>>>>>" + success.toString());
        print("sucess>>>>>>>>>>>" + data.toString());
        //print("data" + data.toString());
        if (success) {
          setState(() {
            expensisData = response.data;
            totalExpensislist = response.data.expenses!;
          });
        }
      });
    }
  }
}
