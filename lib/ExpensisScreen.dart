import 'dart:async';
import 'package:flutter/material.dart';
import 'package:travelbillapp/DashboardScreen.dart';
import 'package:travelbillapp/LoginScreen.dart';
import 'package:travelbillapp/TripExpensisEditScreen..dart';
import 'package:travelbillapp/TripExpensisScreen..dart';
import 'package:travelbillapp/TripScreen..dart';
import 'package:travelbillapp/Utils/shared_preferences.dart';
import 'package:travelbillapp/api/apiProvider.dart';
import 'package:travelbillapp/api/model/ExpenseStatusModel.dart';
import 'package:travelbillapp/api/model/GetExpensisModel.dart';
import 'package:travelbillapp/api/model/TotalexpenseModel.dart';
import 'package:travelbillapp/common_widget/progress_dialog.dart';
import 'package:travelbillapp/constant/app_colors.dart';
import 'package:travelbillapp/main.dart';

class ExpensisScreen extends StatefulWidget {
  String? id;
   ExpensisScreen(this.id);

  @override
  _ExpensisScreenState createState() => _ExpensisScreenState();
}

class _ExpensisScreenState extends State<ExpensisScreen> {
  static List<GetExpensisData> expensisTypelist = [];
  static List<Expense> totalExpensislist = [];
  ExpensisData expensisData= ExpensisData();


  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, ()
    {
      expnsisTypelist();
      totalExpensisList();

    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor:AppColors.cardColor,
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 30.0, right: 5),
            child: FloatingActionButton(
              onPressed: () {
                Navigator.of(context)
                    .pushReplacement(
                    MaterialPageRoute(
                        builder: (
                            BuildContext context) =>
                            TripExpensisScreen(widget.id.toString())));


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
        body:
             Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(top: 5),
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/background.png'),
                      fit: BoxFit.cover),
                ),
            child:ListView.builder(
                scrollDirection: Axis.vertical,
                physics: ScrollPhysics(),
                itemCount: totalExpensislist.length,
                shrinkWrap: true,
                itemBuilder: (context, i) {
                  return  GestureDetector(
                      onTap: () {
                        Navigator.of(context)
                            .pushReplacement(
                            MaterialPageRoute(
                                builder: (
                                    BuildContext context) =>
                                    TripExpensisEditScreen(totalExpensislist[i].id.toString(),totalExpensislist[i].tripId.toString())));
                      },

                      child:Card(
                        margin: EdgeInsets.symmetric(horizontal: 10,vertical: 3),
                        color: Colors.white70,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10), // Set the radius of the Card
                          ),
                    elevation: 5,
                    child: Container(

                      padding: EdgeInsets.symmetric(horizontal: 8,vertical: 12),
                    child:
                    Row(
                      children: [
                        totalExpensislist[i].billImage!=null?
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image: NetworkImage(expensisTypelist[i].category_logo.toString()),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ):
                        Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                              image:AssetImage("assets/trip.png"),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        SizedBox(width: 20),
                        Container(child: Column(children: [
                          Text(totalExpensislist[i].expenseCategory.toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.hintTextColor)),
                          SizedBox(height: 5),
                          Text(totalExpensislist[i].description.toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.hintTextColor))
                        ],),),
                        Spacer(),
                        getStatusContainer(expensisData.expenses![i].expense_status),
                        SizedBox(width: 15),
                        Container(child: Column(children: [
                          Text(totalExpensislist[i].amount.toString(),
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.hintTextColor)),
                          SizedBox(height: 5),
                          Text(expensisData.totalExpense.toString(),
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w400,
                                  color: AppColors.hintTextColor))
                        ],),)

                    ]))));


                }))
    );
  }


  Widget getStatusContainer(int tripStatus) {
    BoxDecoration boxDecoration;
    String statusText;

    switch (tripStatus) {
      case 0:
        boxDecoration = BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(10),
        );
        statusText = "Pending";
        break;
      case 1:
        boxDecoration = BoxDecoration(
          color: Colors.green,
          borderRadius: BorderRadius.circular(10),
        );
        statusText = "Approved";
        break;
      default:
        boxDecoration = BoxDecoration(
          color: Colors.red,
          borderRadius: BorderRadius.circular(10),
        );
        statusText = "Rejected";
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: boxDecoration,
      child: Text(
        statusText,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w500,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }
  _dialog() {
    int _selectedIndex = 0;
    showDialog(
        context: context,
        builder: (context) =>
            StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return AlertDialog(
                    //title: Text('Logout'),
                    content: Container(
                      // Specify some width
                        height: 300,
                        child: new GridView.count(

                            crossAxisCount: 3,
                            childAspectRatio: 1.0,
                            padding: const EdgeInsets.all(4.0),
                            mainAxisSpacing: 4.5,
                            crossAxisSpacing: 4.5,
                            children: new List<Widget>.generate(
                              expensisTypelist.length,
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

                                          child: Column(
                                            children: [
                                              Image.network(expensisTypelist[index].category_logo.toString(), height: 30,width: 30,),
                                              SizedBox(height: 5),
                                              Text(expensisTypelist[index].category_name.toString(),
                                                  style: TextStyle(
                                                      color: _selectedIndex ==
                                                          index
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
                              onTap: () {
                           /*     Navigator.of(context).pushReplacement(
                                    MaterialPageRoute(
                                        builder: (BuildContext context) =>
                                         TripExpensisScreen(expensisTypelist[index].id.toString())));*/
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  "OK",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w500,
                                      color: AppColors.bgColor),
                                ),
                              )),
                          GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Container(
                                padding: EdgeInsets.all(10),
                                child: Text("Cancel",
                                    style: TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        color: AppColors.blackColor)),
                              ))
                        ],
                      )
                    ],
                  );
                }));
  }
  expnsisTypelist() {
     showLoder(context);
    apiProvider.GetexpenseList(this).then((response) {
      Navigator.pop(context);
      var success = ApiProvider.returnResponse(response.status.toString());
      var convertDataToJson = response;
      var data = convertDataToJson.data;
      print("sucess" + success.toString());
      //print("data" + data.toString());

      if (success) {
        setState(() {
          expensisTypelist = data!;


        });
      }
    });
  }
  totalExpensisList() {
    final body = {
      "user_id": sp?.getString(SpUtil.USER_ID.toString()),
      "trip_id":widget.id// "id": "1",
      //  "country": "101",
      //country_id
    };

    {
       showLoder(context);
      print("trp id>>>>>>>>>>>" + body.toString());
      apiProvider.TotalexpenseList(body, context).then((response) {
         Navigator.pop(context);
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
          expensisData=response.data;
          totalExpensislist = response.data.expenses!;

        });
      }
    });
  }
}



}
