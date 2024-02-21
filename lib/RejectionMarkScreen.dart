import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:flutter/material.dart';
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
import 'package:travelbillapp/api/model/TriplistModel.dart';
import 'package:travelbillapp/common_widget/progress_dialog.dart';
import 'package:travelbillapp/constant/app_colors.dart';
import 'package:travelbillapp/main.dart';

class RejectionMarkScreen extends StatefulWidget {
  String? id;
  String? trip_id;

  RejectionMarkScreen(this.id, this.trip_id);

  @override
  _RejectionMarkScreenState createState() => _RejectionMarkScreenState();
}

class _RejectionMarkScreenState extends State<RejectionMarkScreen> {
  TextEditingController _remarkcontroller = new TextEditingController();
  static List<TripListDataModel> tripDatalist = [];

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      EditTripDetails();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.bgColor,
          title: Text('Users List', textAlign: TextAlign.left),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back_outlined,
              color: Colors.white,
            ),
            onPressed: () {
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      const DashboardAdminScreen()));
            },
          ),
          elevation: 0,
          actions: [],
          automaticallyImplyLeading: false,
          centerTitle: false,
        ),
        body: SingleChildScrollView(
            child:tripDatalist![0].id.toString()!=null? Card(
                elevation: 2,
                child: Container(
                    padding: EdgeInsets.all(10),
                    child: Row(children: [
                      Container(
                        width: 150,
                        height: 210,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          image: DecorationImage(
                            image: AssetImage("assets/trip2.jpg"),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                          child: Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Row(children: [
                              Text(tripDatalist[0].tripName.toString(),
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.hintTextColor)),

                              SizedBox(width: 15),
          /*                    Container(
                                padding: EdgeInsets.symmetric(horizontal: 10,vertical: 5),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(width: 1,color: Colors.black45)
                                  ),
                                child: Text("Details",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.hintTextColor))),*/
                            ]),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text("Name:",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.hintTextColor)),
                                SizedBox(width: 10),
                                Text(tripDatalist[0].name.toString(),
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.hintTextColor)),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text("Budget:",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.hintTextColor)),
                                SizedBox(width: 3),
                                Text(tripDatalist[0].budget.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.hintTextColor))
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text("Start Date:",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.hintTextColor)),
                                SizedBox(width: 3),
                                Text(tripDatalist[0].startDate.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.hintTextColor)),
                              ],
                            ),
                            SizedBox(height: 5),
                            Row(
                              children: [
                                Text("End Date:",
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.hintTextColor)),
                                SizedBox(width: 3),
                                Text(tripDatalist[0].endDate.toString(),
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.hintTextColor)),
                              ],
                            ),
                            SizedBox(height: 5),
                            Container(
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      TextField(
                                        controller: _remarkcontroller,
                                        decoration: InputDecoration(
                                          labelText: 'Enter Remark',
                                          border: OutlineInputBorder(),
                                        ),
                                      ),
                                    ])),
                            SizedBox(height: 10),
                            Row(
                              children: [
                                GestureDetector(
                                  onTap: ()
                                  {
                                    ApprovedAPI();
                                  },
                                  child:
                                Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text("Approved",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.whiteColor)))),
                                SizedBox(width: 40),
                                GestureDetector(
                                  onTap: ()
                                  {
                                    Rejected();
                                  },
                                child:Container(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 5),
                                    decoration: BoxDecoration(
                                        color: Colors.red,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Text("Rejected",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.whiteColor)))),
                              ],
                            ),
                          ],
                        ),
                      )),
                    ]))):
            Center(
              child: CircularProgressIndicator(
                  valueColor:
                  AlwaysStoppedAnimation<Color>(AppColors.blueColor)),
            ),
        ));
  }

  EditTripDetails() {
    final body = {
      "user_id": widget.trip_id, // "id": "1",
      "trip_id": widget.id,
      //country_id
    };
    {
       showLoder(context);
      print("trip id>>>>>>>>>>>" + body.toString());
      apiProvider.EditTripDetails(body, context).then((response) {
        Navigator.pop(context);
        // FocusScope.of(context).unfocus();
        var success = ApiProvider.returnResponse(response.status.toString());
        print("Trip >>>>>>>>>>>" + success.toString());
        var convertDataToJson = response;
        var data = convertDataToJson.data;
        print("sucess>>>>>>>>>>>" + success.toString());
        //print("data" + data.toString());

        if (success) {
          setState(() {
            tripDatalist.clear();
            tripDatalist = data!;
          });
        }
      });
          };
       }

  Rejected() {
    final body = {
      "admin_id":sp?.getString(SpUtil.USER_ID.toString()), // "id": "1",
      "trip_id": widget.id,
      "status_remark":_remarkcontroller.text
      //country_id
    };

    {
       showLoder(context);
      print("trip id>>>>>>>>>>>" + body.toString());
      apiProvider.RejectedAPI(body, context).then((response) {
        Navigator.pop(context);
        FocusScope.of(context).unfocus();
        var convertDataToJson = json.decode(response.body);
        var success = convertDataToJson["status"];
        print("statusCode ===================>     $success");
        var message = convertDataToJson["message"];
        print("Rejected message------------>>>>>" + message);
        if(convertDataToJson["status"]=="success")
          {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>
                const DashboardAdminScreen()));
          }

      });
    }
  }
  ApprovedAPI() {
    final body = {
      "admin_id": sp?.getString(SpUtil.USER_ID.toString()), // "id": "1",
      "trip_id": widget.id,
      "status_remark":_remarkcontroller
      //country_id
    };

    {
       showLoder(context);
      print("trip id>>>>>>>>>>>" + body.toString());
      apiProvider.ApprovedAPI(body, context).then((response) {
        Navigator.pop(context);
        FocusScope.of(context).unfocus();
        var convertDataToJson = json.decode(response.body);
        var success = convertDataToJson["status"];
        print("statusCode ===================>     $success");
        var message = convertDataToJson["message"];
        print("ApprovedAPI message------------>>>>>" + message);
        if(convertDataToJson["status"]=="success")
        {
          Navigator.of(context).pushReplacement(MaterialPageRoute(
              builder: (BuildContext context) =>
              const DashboardAdminScreen()));
        }
      });
    }
  }


}
