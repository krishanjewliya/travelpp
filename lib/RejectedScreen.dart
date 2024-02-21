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

class RejectedScreen extends StatefulWidget {
  const RejectedScreen({Key? key}) : super(key: key);

  @override
  _RejectedScreenState createState() => _RejectedScreenState();
}

class _RejectedScreenState extends State<RejectedScreen> {
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
            child:Container(
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
                  return Appendlist[i].tripStatus==2?GestureDetector(
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
                                      width: 140,
                                      height: 110,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image:AssetImage("assets/trip2.jpg"),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),

                                    SizedBox(width: 10),
                                    Container(child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                     Row(
                                            children: [
                                              Container(
                                                width:130,
                                                child: Text(Appendlist[i].tripName,
                                                    overflow: TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontSize: 18,
                                                        fontWeight: FontWeight.w500,
                                                        color: AppColors.hintTextColor)),
                                              ),

                                              SizedBox(width: 15),
                                              Container(
                                                width: 60,
                                                  padding: EdgeInsets.symmetric(horizontal: 5,vertical: 3),
                                                  decoration: BoxDecoration(
                                                      color: Colors.redAccent,
                                                      borderRadius: BorderRadius.circular(10)
                                                  ),
                                                  child:
                                                  Text("Rejected",
                                                      textAlign: TextAlign.center,
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
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.hintTextColor)),
                                          ],),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Text("Budget:",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.hintTextColor)),
                                            SizedBox(width: 3),
                                            Text(Appendlist[i].budget.toString()+""+Appendlist[i].currency,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.hintTextColor))
                                          ],),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Text("Start Date:",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.hintTextColor)),
                                            SizedBox(width: 3),
                                            Text(Appendlist[i].startDate,
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.hintTextColor)),
                                          ],),
                                        SizedBox(height: 5),
                                        Row(
                                          children: [
                                            Text("End Date:",
                                                style: TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: AppColors.hintTextColor)),
                                            SizedBox(width: 3),
                                            Text(Appendlist[i].endDate,
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
