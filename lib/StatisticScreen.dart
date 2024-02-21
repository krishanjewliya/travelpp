import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:travelbillapp/DashboardScreen.dart';
import 'package:travelbillapp/LoginScreen.dart';
import 'package:travelbillapp/TripDetailsScreen..dart';
import 'package:travelbillapp/Utils/shared_preferences.dart';
import 'package:travelbillapp/api/apiProvider.dart';
import 'package:travelbillapp/api/model/StatisticsModel.dart';
import 'package:travelbillapp/common_widget/custom_textfield.dart';
import 'package:travelbillapp/common_widget/submit_button.dart';
import 'package:travelbillapp/constant/app_colors.dart';
import 'package:travelbillapp/constant/app_text_style.dart';
import 'package:travelbillapp/main.dart';

class StatisticScreen extends StatefulWidget {
  String? id;

  StatisticScreen(this.id);

  @override
  _StatisticScreenState createState() => _StatisticScreenState();
}

class _StatisticScreenState extends State<StatisticScreen> {
  late List<ChartData> chartData = [];

/*    ChartData('David', 25, Color.fromRGBO(9,0,136,1)),
    ChartData('Steve', 38, Color.fromRGBO(147,0,119,1)),
    ChartData('Jack', 34, Color.fromRGBO(228,0,124,1)),
    ChartData('Others', 52, Color.fromRGBO(255,189,57,1))
  ];*/

  void chartget() {
    chartData = staticsList
        .map((data) => ChartData(
            data.Category.toString(), double.parse(data.amount.toString())))
        .toList();
  }

  static List<ExpenseStaticsData> staticsList = [];

  var Totalspend;
  var Daily_avg;
  var Today;
  var total_trip_amount;
  var surplus_money;
  var amount_avg;
  var amountselect;
  var amountselect1;
  var _selectItem;

  var _dropdownlist = [
    "Country",
    "Category",
    "Person",
    "Payment",
    "Year",
  ];

  @override
  void initState() {
    // TODO: implement initState
    chartget();
    ExpensisStatusList();
    ExpensisStaticsList("Category");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.cardColor,

        // backgroundColor: Colors.transparent,
        body: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/background.png'), fit: BoxFit.cover),
          ),
          child: SingleChildScrollView(
              padding: EdgeInsets.all(8),
              child: Column(children: [
                Row(
                  children: [
                    Text("Daily Matrics", style: TextStyle(fontSize: 18)),
                    Spacer(),
                    Text("Adjust Budget",
                        style: TextStyle(
                            fontSize: 18, color: AppColors.cardnewColor)),
                  ],
                ),
                SizedBox(height: 10),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(10),
                      decoration: BoxDecoration(
                          color: AppColors.cardnewColor,
                          border: Border(
                            right: BorderSide(
                              //                   <--- right side
                              color: Colors.white70,
                              width: .5,
                            ),
                          )),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Daily Budget",
                              style: TextStyle(color: Colors.white70)),
                          SizedBox(height: 8),
                          Text(Daily_avg.toString(),
                              style: TextStyle(
                                  fontSize: 22, color: Colors.white70)),
                          Divider(
                            color: Colors.white70,
                            height: 20,
                          ),
                          Text("Total to Date",
                              style: TextStyle(color: Colors.white70)),
                          SizedBox(height: 8),
                          Text(Totalspend.toString(),
                              style: TextStyle(
                                  fontSize: 22, color: Colors.white70)),
                        ],
                      ),
                    )),
                    Expanded(
                        child: Container(
                      padding: EdgeInsets.all(10),
                      color: AppColors.cardnewColor,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Today Budget",
                              style: TextStyle(color: Colors.white70)),
                          SizedBox(height: 8),
                          Text(Today.toString(),
                              style: TextStyle(
                                  fontSize: 22, color: Colors.white70)),
                          Divider(color: Colors.white70, height: 20),
                          Text("Total Trip Amount",
                              style: TextStyle(color: Colors.white70)),
                          SizedBox(height: 8),
                          Text(total_trip_amount.toString(),
                              style: TextStyle(
                                  fontSize: 22, color: Colors.white70)),
                        ],
                      ),
                    ))
                  ],
                ),
                SizedBox(height: 10),
                /* Container(
              margin: EdgeInsets.all(3),
              padding: const EdgeInsets
                  .only(
                  top: 3,
                  left: 12.0,
                  right: 8.0,
                  bottom: 3),
              decoration: BoxDecoration(
                  color: AppColors.cardnewColor,
                  borderRadius: BorderRadius
                      .circular(5),
                  border: Border
                      .all(
                      color: Colors
                          .grey)),
              child: DropdownButton(
                isExpanded: true,
                underline: Container(),
                hint:  Text(
                    'Select charge',
                    style: TextStyle(
                        fontSize: 15.0,
                        color: Colors.white,
                        fontWeight: FontWeight
                            .bold)),
                // Not necessary for Option 1
                value: _selectItem,

                onChanged: (
                    newValue) {

                  setState(() {
                    _selectItem=newValue;
                     ExpensisStaticsList(newValue.toString());
                  });
                },
                items: _dropdownlist.map((
                    location) {
                  return DropdownMenuItem(
                    child: new Text(
                        location
                            .toString()),
                    value: location
                        .toString(),
                  );
                }).toList(),
              ),
            ),*/
                Container(
                    margin: EdgeInsets.all(3),
                    padding: const EdgeInsets.only(
                      top: 3,
                      left: 12.0,
                      right: 8.0,
                      bottom: 3,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.cardnewColor,
                      borderRadius: BorderRadius.circular(5),
                      border: Border.all(color: AppColors.cardnewColor),
                    ),
                    child: Theme(
                      data: ThemeData(
                        textTheme: TextTheme(
                          subtitle1: TextStyle(
                            color: Colors
                                .white70, // Set the global hint color for DropdownButton
                          ),
                        ),
                      ),
                      child: DropdownButton(
                        isExpanded: true,
                        underline: Container(),
                        iconEnabledColor: Colors.white70,
                        style: TextStyle(
                          color: Colors.white, // Set the selected text color
                        ),
                        dropdownColor: AppColors.cardnewColor,
                        hint: Text(
                          'Select charge',
                          style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white70,
                            // Use white color for the hint
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        value: _selectItem,
                        onChanged: (newValue) {
                          setState(() {
                            _selectItem = newValue;
                            ExpensisStaticsList(newValue.toString());
                          });
                        },
                        items: _dropdownlist.map((location) {
                          return DropdownMenuItem(
                            child: Text(
                              location.toString(),
                              style: TextStyle(color: Colors.white70),
                            ),
                            value: location.toString(),
                          );
                        }).toList(),
                      ),
                    )),
                SfCircularChart(
                  legend: Legend(
                    position: LegendPosition.right,
                    iconBorderWidth: .2,
                    isVisible: true,
                    toggleSeriesVisibility: true,
                    iconWidth: 30,
                  ),
                  // onLegendTapped: _handleLegendTapped,
                  //onDataLabelTapped: _handleDataLabelTapped,
                  annotations: <CircularChartAnnotation>[
                    CircularChartAnnotation(
                        widget: Container(
                            child: Image.asset("assets/logo.png",
                                height: 50, width: 50)))
                  ],
                  series: <CircularSeries>[
                    DoughnutSeries<ChartData, String>(
                      legendIconType: LegendIconType.diamond,
                      dataSource: chartData,
                      pointColorMapper: (ChartData data, _) => Colors
                          .primaries[Random().nextInt(Colors.primaries.length)],
                      xValueMapper: (ChartData data, _) => data.Category,
                      yValueMapper: (ChartData data, _) => data.y,
                      name: 'Lands',
                      enableTooltip: true,
                      radius: '100%',
                      dataLabelSettings: DataLabelSettings(
                        isVisible: true,
                      ),
                    )
                  ],
                ),
              ])),
        ));
  }

  ExpensisStatusList() {
    final body = {
      "user_id": sp?.getString(SpUtil.USER_ID.toString()),
      "trip_id": widget.id
      // "id": "1",
    };

    {
      // showLoder(context);
      print("trp id>>>>>>>>>>>" + body.toString());
      apiProvider.ExpenseStatusAPI(body, context).then((response) {
        //1 Navigator.pop(context);
        // FocusScope.of(context).unfocus();
        var success = ApiProvider.returnResponse(response.status.toString());
        print("TotalexpenseList >>>>>>>>>>>" + success.toString());
        var convertDataToJson = response;
        var data = convertDataToJson.data?.totalAmount.toString();
        print("sucess>>>>>>>>>>>" + success.toString());
        print("data>>>>>>>>>>>" + data.toString());
        //print("data" + data.toString());
        if (success) {
          setState(() {
            Totalspend = response.data?.totalAmount;
            Daily_avg = response.data?.dailyAverageSpend;
            Today = response.data?.todaySpend;

            var tta = response.data?.totalTripAmount;
            var sm = response.data?.surplusMoney;

            total_trip_amount = double.tryParse(tta.toString()) ?? 0.0;
            surplus_money = double.tryParse(sm.toString()) ?? 1.0;

            amount_avg = total_trip_amount / surplus_money;
          });
        }
      });
    }
  }

  ExpensisStaticsList(String category) {
    final body = {
      "user_id": sp?.getString(SpUtil.USER_ID.toString()),
      "search": category,
    };
    {
      // showLoder(context);
      print("trp id>>>>>>>>>>>" + body.toString());
      apiProvider.ExpenseStaticsAPI(body, context).then((response) {
        var success = ApiProvider.returnResponse(response.status.toString());
        var convertDataToJson = response;
        var data = convertDataToJson.data;
        print("sucess" + success.toString());

        if (success) {
          setState(() {
            staticsList = response.data!;
          });
          chartget();
        }
      });
    }
  }
}

class ChartData {
  ChartData(this.Category, this.y);

  final String Category;
  final double y;
}
