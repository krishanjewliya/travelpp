import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:travelbillapp/DashboardScreen.dart';
import 'package:travelbillapp/EditTripScreen..dart';
import 'package:travelbillapp/TripExpensisScreen..dart';
import 'package:travelbillapp/TripScreen..dart';
import 'package:travelbillapp/Utils/shared_preferences.dart';
import 'package:travelbillapp/api/apiProvider.dart';
import 'package:travelbillapp/api/model/TriplistModel.dart';
import 'package:travelbillapp/common_widget/progress_dialog.dart';
import 'package:travelbillapp/constant/app_colors.dart';
import 'package:travelbillapp/constant/constWidgets.dart';
import 'package:travelbillapp/main.dart';

class TripDetailScreen extends StatefulWidget {
  const TripDetailScreen({Key? key}) : super(key: key);

  @override
  _TripDetailScreenState createState() => _TripDetailScreenState();
}

class _TripDetailScreenState extends State<TripDetailScreen> {
  static List<TripListDataModel> tripDatalist = [];

  @override
  void initState() {
    // TODO: implement initState
    Triplist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 30.0, right: 5),

          child: FloatingActionButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                  builder: (BuildContext context) => const TripScreen()));
            },
            child: Icon(
              Icons.add,
              color: Colors.white,
              size: 29,
            ),
            tooltip: 'Capture Picture',
            elevation: 5,
            splashColor: AppColors.cardnewColor,
          )),
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,

      body: tripDatalist==null?Container(
          margin: EdgeInsets.symmetric(
              horizontal: 16, vertical: 10),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              decoration: const BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/background.png'), fit: BoxFit.cover),
              ),

          child:
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(16),
            width: MediaQuery
                .of(context)
                .size
                .width,
            height: 200,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: AppColors.bgcardColor),
            child: Row(
              children: [
                Expanded(
                    flex: 5,
                    child: Container(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment
                            .start,
                        crossAxisAlignment: CrossAxisAlignment
                            .start,
                        children: [
                          Text(
                            "Get started",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            "To start adding expenses create a trip first. Your expenses will appear here.",
                            textAlign: TextAlign.left,
                            overflow: TextOverflow.clip,
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.black),
                          ),
                          Spacer(),
                          GestureDetector(
                              onTap: () {
                                Navigator.of(context)
                                    .pushReplacement(
                                    MaterialPageRoute(
                                        builder: (
                                            BuildContext context) =>
                                        const TripScreen()));
                              },
                              child: Text(
                                "CREATE A TRIP",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.bgColor),
                              )),
                        ],
                      ),
                    )),
                Expanded(
                    flex: 2,
                    child: Container(
                      alignment: Alignment.center,
                      child: Image.asset(
                          "assets/men.png", width: 100),
                    ))
              ],
            ),
          )):
      SingleChildScrollView(
        scrollDirection: Axis.vertical,

          child:Container(

    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: const BoxDecoration(
    image: DecorationImage(
    image: AssetImage('assets/background.png'), fit: BoxFit.cover),
    ),

      child:
      Column(
        children: [
          SizedBox(height: 40,),
          Text("Trip List",
            style: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 24),
          ),
          Expanded(
            child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: tripDatalist.length,
                    shrinkWrap: true,
                    itemBuilder: (context, i) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                builder: (BuildContext context) => DashboardScreen(
                                    tripDatalist[i].id.toString())));
                          },
                          child: Card(
                              elevation: 8,
                              margin: EdgeInsets.symmetric(horizontal: 16,vertical: 5),
                              child: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 8, vertical: 16),
                                padding: EdgeInsets.symmetric(horizontal: 10),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [

                                         Row(children: [
                                                Icon(Icons.email_outlined, size: 20),
                                                SizedBox(width: 5),
                                              Container(
                                                width: 130,
                                                  child:
                                                Text(
                                                  tripDatalist[i].tripName.toString(),
                                                  overflow: TextOverflow.ellipsis,
                                                  style: TextStyle(
                                                      fontWeight: FontWeight.w400,
                                                      fontSize: 14),
                                                )),
                                              ],),
                                           


                                            Spacer(),
                            Row(children: [
                                            getStatusContainer(tripDatalist[i].tripStatus!),

                                            SizedBox(width: 10),
                                            InkWell(
                                                onTap: () {
                                                  Navigator.of(context).pushReplacement(
                                                      MaterialPageRoute(
                                                          builder:
                                                              (BuildContext context) =>
                                                                  EditTripScreen(
                                                                      tripDatalist[i]
                                                                          .id
                                                                          .toString())));
                                                },
                                                child: Icon(
                                                  Icons.edit,
                                                  size: 25,
                                                  color: Colors.black26,
                                                )),
                                            SizedBox(width: 5),
                                            InkWell(
                                                onTap: () {
                                                  deleteTrip(
                                                      tripDatalist[i].id.toString());
                                                },
                                                child: Icon(Icons.delete,
                                                    size: 25, color: Colors.black26)),
                                          ],
                                        ),


                                    ]),
                                    SizedBox(height: 10),
                                    Row(children: [
                                      Icon(Icons.calendar_today, size: 20),
                                      SizedBox(width: 5),
                                      Text(
                                        tripDatalist[i].startDate.toString() +
                                            " " +
                                            "to" +
                                            " " +
                                            tripDatalist[i].endDate.toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14),
                                      ),
                                    ]),
                                    SizedBox(height: 10),
                                    Row(children: [
                                      Icon(Icons.question_mark_rounded, size: 20, color: Colors.blueAccent,),
                                      SizedBox(width: 5),
                                      Text("Remark :"+
                                        tripDatalist[i].statusRemark.toString(),
                                        style: TextStyle(
                                          color: Colors.blueAccent,
                                            fontWeight: FontWeight.w400,
                                            fontSize: 14),
                                      ),
                                    ]),
                                    SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Icon(Icons.account_balance_wallet_outlined,
                                            size: 20),
                                        SizedBox(width: 5),
                                        Text(
                                          tripDatalist[i].budget.toString() +
                                              " " +
                                              tripDatalist[i].currency.toString(),
                                          style: TextStyle(
                                              fontWeight: FontWeight.w400,
                                              fontSize: 14),
                                        ),
                                        Spacer(),
                                        InkWell(
                                          onTap: ()
                                          {
                                            Navigator.of(context).pushReplacement(MaterialPageRoute(
                                                builder: (BuildContext context) => DashboardScreen(
                                                    tripDatalist[i].id.toString())));

                                          },

                                       child: Container(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 10, vertical: 5),
                                            decoration: BoxDecoration(
                                                color: Colors.black12,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                                border: Border.all(
                                                    color: Colors.grey, width: 0.5)),
                                            child: Text("Details"))

                                    ),
                                    SizedBox(height: 5),
                                  ],
                                ),
                              ]))
                      ));
                    }),

          ),

        ],
      )),

      ),
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
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: boxDecoration,
      child: Text(
        statusText,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.w500,
          color: AppColors.whiteColor,
        ),
      ),
    );
  }

  Triplist() {
    final body = {
      "user_id": sp?.getString(SpUtil.USER_ID.toString()),
      // "id": "1",
      "admin_id": SpUtil.ADMIN_ID.toString()!=null?sp?.getString(SpUtil.ADMIN_ID.toString()):"1", // "id": "1",
      //  "country": "101",
      //country_id
    };

    {
      // showLoder(context);
      print("trp id>>>>>>>>>>>" + body.toString());
      apiProvider.TripList(body, context).then((response) {
        //1 Navigator.pop(context);
        // FocusScope.of(context).unfocus();
        var success = ApiProvider.returnResponse(response.status.toString());
        print("trip >>>>>>>>>>>" + success.toString());
        var convertDataToJson = response;
        var data = convertDataToJson.data;
        print("sucess>>>>>>>>>>>" + success.toString());
        //print("data" + data.toString());

        if (success) {
          setState(() {
            tripDatalist.clear();
            tripDatalist = data! as List<TripListDataModel>;
            /*for (int i = 0; i < chartDataList2.length; i++) {
              ChartListName2.add(chartDataList2[i].district);
              ChartListName2.add(chartDataList2[i].acres);
              // countryListName.add(countryDataList[i].id);
              // reniorListName.add(listdata[i].name + listdata[i].id.toString());
            }
            print("data ========== ChartAPIDistrict =========> " +
                ChartListName2.toString());*/
            // isDataLoad=true;
          });
        }
      });
    }
  }

  void deleteTrip(String tripId) {
    final body = {
      "user_id": sp?.getString(SpUtil.USER_ID.toString()),
      "trip_id": tripId,
    };
    print(body);
    showLoder(context);
    apiProvider.Tripdelete(body, this).then((response) {
      Navigator.pop(context);
      FocusScope.of(context).unfocus();
      var convertDataToJson = json.decode(response.body);
      var success = convertDataToJson["status"];
      print("statusCode ===================>     $success");
      var message = convertDataToJson["message"];
      print("delete account message------------>>>>>" + message);

      if (success == "success") {
       // sp?.clear();
        // print("message ========message========>"+response.message.toString());
        showToastMessage(message);
        Triplist();
      } else {
        showToastMessage(message);
        Triplist();
      }
    });
  }
}
