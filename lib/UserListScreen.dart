import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:travelbillapp/DashboardAdminScreen.dart';
import 'package:travelbillapp/DashboardScreen.dart';
import 'package:travelbillapp/EditUserScreen.dart';
import 'package:travelbillapp/LoginScreen.dart';
import 'package:travelbillapp/TripDetailsScreen..dart';
import 'package:travelbillapp/TripExpensisEditScreen..dart';
import 'package:travelbillapp/TripExpensisScreen..dart';
import 'package:travelbillapp/TripScreen..dart';
import 'package:travelbillapp/UserTripListScreen..dart';
import 'package:travelbillapp/Utils/shared_preferences.dart';
import 'package:travelbillapp/api/apiProvider.dart';
import 'package:travelbillapp/api/model/ExpenseStatusModel.dart';
import 'package:travelbillapp/api/model/GetExpensisModel.dart';
import 'package:travelbillapp/api/model/TotalexpenseModel.dart';
import 'package:travelbillapp/api/model/UserlistModel.dart';
import 'package:travelbillapp/common_widget/progress_dialog.dart';
import 'package:travelbillapp/constant/app_colors.dart';
import 'package:travelbillapp/main.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({Key? key}) : super(key: key);

  @override
  _UserListScreenState createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  static List<UserlistData> userslist = [];


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, ()
    {
      userlist();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: AppColors.cardnewColor,
          title: Text('Users List',textAlign: TextAlign.left),
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
          actions: [
          ],

          automaticallyImplyLeading: false,
          centerTitle: false,

        ),

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
                itemCount: userslist.length,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return  GestureDetector(
                    onTap: ()
                    {

                      Navigator.of(context)
                          .pushReplacement(
                          MaterialPageRoute(
                              builder: (
                                  BuildContext context) =>
                                  UserTripListScreen(userslist[i].id.toString())));
                    },
                  child:Card(
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(10),
                          child: Row(
                            children: [
                              Container(
                                padding: EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: Colors.greenAccent.shade100,
                                  borderRadius: BorderRadius.circular(100),
                                  border: Border.all(width: 0.5, color: Colors.black26),
                                ),
                                child: Icon(Icons.person, size: 60, color: Colors.black26),
                              ),
                              SizedBox(width: 20),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 100,
                                          child: Row(children: [
                                            Text(
                                              "EmpID:",
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.hintTextColor,
                                              ),
                                            ),
                                            SizedBox(width: 3),
                                            Text(
                                              userslist[i].empId.toString(),
                                              style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.w500,
                                                color: AppColors.hintTextColor,
                                              ),
                                            ),
                                          ],),
                                        ),

                                        SizedBox(width: 100),
                                        Container(
                                          child: Row(
                                            crossAxisAlignment: CrossAxisAlignment.end,
                                            children: [
                                              GestureDetector(
                                              onTap: () {
                                        Navigator.of(context)
                                            .pushReplacement(
                                        MaterialPageRoute(
                                        builder: (
                                        BuildContext context) =>
                                        EditUserScreen(userslist[i].id.toString())));
                                        },

                                          child:
                                              Icon(Icons.edit, size: 25, color: Colors.black45)),
                                              SizedBox(width: 8),
                                GestureDetector(
                                  onTap: () {
                                    DeleteUser(userslist[i].id.toString());
                                  },

                                  child: Icon(Icons.delete, size: 25, color: Colors.black45)),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          "Name:",
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.hintTextColor,
                                          ),
                                        ),
                                        SizedBox(width: 10),
                                        Text(
                                          userslist[i].name.toString(),
                                          style: TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.hintTextColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(
                                          "Mobile:",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.hintTextColor,
                                          ),
                                        ),
                                        SizedBox(width: 3),
                                        Text(
                                          userslist[i].countryCode.toString() + " " + userslist[i].mobile.toString(),
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.hintTextColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                    Row(
                                      children: [
                                        Text(
                                          "Email:",
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.hintTextColor,
                                          ),
                                        ),
                                        SizedBox(width: 3),
                                        Text(
                                          userslist[i].email.toString(),
                                          style: TextStyle(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w500,
                                            color: AppColors.hintTextColor,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 5),
                                  ],
                                ),
                              ),


                            ],
                          ),
                        ),
                      ))
                  ;



                })))
    );
  }
/*
  _dialog() {
    int _selectedIndex=0;
    showDialog(
      context: context,
      builder: (context) =>
      StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return
            AlertDialog(
              //title: Text('Logout'),
              content: Container(
                // Specify some width
                  width: MediaQuery
                      .of(context)
                      .size
                      .width * .7,
                  height: MediaQuery.of(context).size.height*.5,
                  child: new GridView.count(
                      crossAxisCount: 3,
                      childAspectRatio: 1.0,
                      padding: const EdgeInsets.all(4.0),
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      children: new List<Widget>.generate(
                        20,
                            (index) {
                          return GestureDetector(
                              onTap: () {
                                setState(() {
                                  _selectedIndex = index;
                                });
                              },
                              child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    height: 25.0,
                                    width: 25.0,
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.restaurant,
                                          size: 30,
                                          color: _selectedIndex == index
                                              ? AppColors.blueColor
                                              : null,
                                        ),
                                        SizedBox(height: 5),
                                        Text(("Restaurant"),
                                            style: TextStyle(
                                                color:_selectedIndex == index
                                                    ? AppColors.blueColor
                                                    : null,
                                                fontSize: 12),
                                            textAlign: TextAlign.center),
                                      ],
                                    ),
                                  )));
                        },
                      ))),
              actions: <Widget>[
                new Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: ()
                      {
                        Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (BuildContext context) => const TripExpensisScreen()));
                      },

                  child:Container(
                    padding: EdgeInsets.all(10),
                    child: Text("OK",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: AppColors.bgColor),),
                  )),
                    GestureDetector(
                      onTap: ()
                      {
                        Navigator.pop(context);
                      },

                      child:Container(
                    padding: EdgeInsets.all(10),
                    child: Text("Cancel",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: AppColors.blackColor)),
                  ))
                ],)
              ],
            );
        }
    ));
  }*/

  userlist() {
    final body = {
      "id": sp?.getString(SpUtil.USER_ID.toString()),
    };
    print(body);
    showLoder(context);
    // showLoder(context);
    apiProvider.UsersList(body, context).then((response) {
      Navigator.pop(context);
      var success = ApiProvider.returnResponse(response.status.toString());
      var convertDataToJson = response;
      var data = convertDataToJson.data;
      print("sucess" + success.toString());
      //print("data" + data.toString());

      if (response.status=="success") {
        setState(() {
          userslist = data!;
        });
      }
    });
  }
  DeleteUser(String id ) {
    final body = {
      "id":id,
    };

    {
      showLoder(context);
      print("trip id>>>>>>>>>>>" + body.toString());
      apiProvider.UserDelete(body, context).then((response) {
        Navigator.pop(context);
        FocusScope.of(context).unfocus();
        var convertDataToJson = json.decode(response.body);
        var success = convertDataToJson["status"];
        print("statusCode ===================>     $success");
        var message = convertDataToJson["message"];
        print("delete account message------------>>>>>" + message);
        if (success) {
          Navigator.of(context)
              .pushReplacement(
              MaterialPageRoute(
                  builder: (
                      BuildContext context) =>
                  DashboardAdminScreen()));
        }
        else
          {
            Navigator.of(context)
                .pushReplacement(
                MaterialPageRoute(
                    builder: (
                        BuildContext context) =>
                        UserListScreen()));
          }
      });
    }
  }
}

