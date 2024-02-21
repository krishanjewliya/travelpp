import 'dart:async';
import 'package:flutter/material.dart';
import 'package:travelbillapp/DashboardScreen.dart';
import 'package:travelbillapp/LoginScreen.dart';
import 'package:travelbillapp/RejectionMarkScreen.dart';
import 'package:travelbillapp/TripExpensisEditScreen..dart';
import 'package:travelbillapp/TripExpensisScreen..dart';
import 'package:travelbillapp/TripScreen..dart';
import 'package:travelbillapp/Utils/shared_preferences.dart';
import 'package:travelbillapp/api/apiProvider.dart';
import 'package:travelbillapp/api/model/AppendlistModel.dart';
import 'package:travelbillapp/api/model/ExpenseStatusModel.dart';
import 'package:travelbillapp/api/model/GetExpensisModel.dart';
import 'package:travelbillapp/api/model/TotalexpenseModel.dart';
import 'package:travelbillapp/constant/app_colors.dart';
import 'package:travelbillapp/main.dart';

class PendingScreen extends StatefulWidget {
  const PendingScreen({Key? key}) : super(key: key);

  @override
  _PendingScreenState createState() => _PendingScreenState();
}

class _PendingScreenState extends State<PendingScreen> {
  static List<AppendData> Appendlist = [];


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, ()
    {
      AppendList();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 30.0, right: 5),
            child: FloatingActionButton(
              onPressed: () {

              },
              child: Icon(
                Icons.add,
                color: Colors.white,
                size: 29,
              ),
              tooltip: 'Capture Picture',
              elevation: 5,
              splashColor: Colors.grey,
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        body: SingleChildScrollView(
          child:   Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              padding: EdgeInsets.only(top: 5),
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background.png'),
                    fit: BoxFit.cover),
              ),


            child: ListView.builder(
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                itemCount: Appendlist.length,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return Appendlist[i].tripStatus==0?GestureDetector(
                      onTap: () {
                          Navigator.of(context)
                            .pushReplacement(
                            MaterialPageRoute(
                                builder: (
                                    BuildContext context) =>
                                    RejectionMarkScreen(Appendlist[i].id.toString(),Appendlist[i].userId.toString())));
                      },

                      child:Card(
                          elevation: 2,
                          child: Container(
                              padding: EdgeInsets.all(10),
                              child:
                              Row(
                                  children: [
                                    Container(
                                      width: 150,
                                      height: 140,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image:AssetImage("assets/trip2.jpg"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                    SizedBox(width: 20),
                                    Container(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [

                                        Row(

                                            children: [
                                              Text(Appendlist[i].tripName,
                                                  textAlign: TextAlign.center,
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      fontWeight: FontWeight.w500,
                                                      color: AppColors.hintTextColor)),
                                              SizedBox(width: 15),

                                              Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                                                  decoration: BoxDecoration(
                                                      color: Colors.orange,
                                                      borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  child:
                                                  Text("Pending",
                                                      overflow: TextOverflow.ellipsis,
                                                      style: TextStyle(
                                                          fontSize: 12,
                                                          fontWeight: FontWeight.w500,
                                                          color: AppColors.whiteColor))),
                                            ]),
                                        Row(
                                          children: [
                                            Text("Name:",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.hintTextColor)),
                                            SizedBox(width: 10),
                                            Text(Appendlist[i].name,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.hintTextColor)),
                                          ],),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Text("Advance Amount:",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.hintTextColor)),
                                            SizedBox(width: 3),
                                            Text("5000",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.hintTextColor))
                                          ],),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Text("Total Exp:",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.hintTextColor)),
                                            SizedBox(width: 3),
                                            Text(Appendlist[i].budget.toString()+" "+Appendlist[i].currency.toString(),
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.hintTextColor))
                                          ],),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Text("Balance:",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.hintTextColor)),
                                            SizedBox(width: 3),
                                            Text("5000",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.hintTextColor))
                                          ],),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Text("Start Date:",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.hintTextColor)),
                                            SizedBox(width: 3),
                                            Text(Appendlist[i].startDate,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.hintTextColor)),
                                          ],),
                                        Row(
                                          children: [
                                            Text("End Date:",
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.hintTextColor)),
                                            SizedBox(width: 3),
                                            Text(Appendlist[i].endDate,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.hintTextColor)),
                                          ],),

                                      ],),),
                                  ])))):Container();
                  ;



                })))
    );
  }



  AppendList() {
    final body = {
      "admin_id": sp?.getString(SpUtil.USER_ID.toString()),
    };

    {
      // showLoder(context);
      print("AppendList>>>>>>>>>>>" + body.toString());
      apiProvider.AppendList(body, context).then((response) {
        //1 Navigator.pop(context);
        // FocusScope.of(context).unfocus();
        var success = ApiProvider.returnResponse(response.status.toString());
        print("AppendList >>>>>>>>>>>" + success.toString());
        var convertDataToJson = response;
        var data = convertDataToJson.data;
        print("sucess>>>>>>>>>>>" + success.toString());
        print("sucess>>>>>>>>>>>" + data.toString());
        //print("data" + data.toString());
        if (success) {
          setState(() {
            Appendlist=data!;

          });
        }
      });
    }
  }

}
