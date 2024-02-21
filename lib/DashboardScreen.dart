import 'dart:async';
import 'dart:convert';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:travelbillapp/CSVScreen.dart';
import 'package:travelbillapp/ExpensisScreen.dart';
import 'package:travelbillapp/ExportcsvScreen.dart';
import 'package:travelbillapp/HomeScreen.dart';
import 'package:travelbillapp/LocationScreen.dart';
import 'package:travelbillapp/LoginScreen.dart';
import 'package:travelbillapp/SettingScreen.dart';
import 'package:travelbillapp/StatisticScreen.dart';
import 'package:travelbillapp/TripDetailsScreen..dart';
import 'package:travelbillapp/TripExpensisScreen..dart';
import 'package:travelbillapp/TripScreen..dart';
import 'package:travelbillapp/Utils/shared_preferences.dart';
import 'package:travelbillapp/api/apiProvider.dart';
import 'package:travelbillapp/api/model/AccessRoleModel.dart';
import 'package:travelbillapp/api/model/ExpenseStatusModel.dart';
import 'package:travelbillapp/common_widget/progress_dialog.dart';
import 'package:travelbillapp/constant/app_colors.dart';
import 'package:travelbillapp/constant/app_text_style.dart';
import 'package:travelbillapp/constant/constWidgets.dart';
import 'package:travelbillapp/locallyTripScreen.dart';
import 'package:travelbillapp/main.dart';
import 'package:travelbillapp/sharescreen.dart';

import 'api/model/EditexpenseModel.dart';

class DashboardScreen extends StatefulWidget {
  String? id;

  DashboardScreen(this.id);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen>
    with SingleTickerProviderStateMixin {
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  TabController? _tabController;
  int? _selectedIndex;
  int? bottomIndex;
  PageController? _pageController = PageController();
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static List<AccessRoleModelData> roleDataList = [];
  String? email = sp?.getString(SpUtil.EMAIL.toString());
  String? name = sp?.getString(SpUtil.USER_FNAME.toString());
  ExpenseStatusModel expensisStatusData = ExpenseStatusModel();
  var expensis = [];
  String? Trip_name;
  var Totalspend;
  var Daily_avg;
  var Today;
  var total_trip_amount;
  var surplus_money;
  var amount_avg;
  var amountselect;
  var amountselect1;
  var role = [];
  final List<String> _items = ["Total Spend", "Daily Average", "Today"];
  final List<String> _itemss = ["Total Spend", "Daily Average", "Today"];
  String? _selectedItem = "Total Spend";
  String? _selectedItems = "Total Spend";

  @override
  void initState() {
    ExpensisStatusList();
    userRoles();
    _selectedIndex = bottomIndex ?? 0;
    _tabController = TabController(length: 3, vsync: this);



    int _currentIndex = 0;
    _tabController!.addListener(_handleTabSelection);
    _pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabController?.dispose();
    _pageController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        drawer:_buildDrawer(context),
        appBar: AppBar(
          backgroundColor: AppColors.cardnewColor,
          title: Text(Trip_name.toString(), textAlign: TextAlign.left),
          leading: new IconButton(
            icon: new Icon(Icons.menu_sharp, size: 25, color: Colors.white),
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          ),
          elevation: 0,
          bottom: _preferedBar(),
          actions: [
            IconButton(
              icon: Icon(Icons.people_alt),
              onPressed: () {
                Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (BuildContext context) =>  ShareScreen(widget.id.toString())));
                // Perform search action here
              },
            ),
            IconButton(
              icon: Icon(Icons.search),
              onPressed: () {
                // Perform search action here
              },
            ),
            PopupMenuButton(
              itemBuilder: (BuildContext context) {
                return [
                  PopupMenuItem(
                    value: 1,
                    child: Text('Export to csv'),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Text('Shared TravelSpend'),
                  ),
                  PopupMenuItem(
                    value: 3,
                    child: Text('Settings'),
                  ),
                  PopupMenuItem(
                    value: 4,
                    child: Text('Support'),
                  ),
                ];
              },
              onSelected: (value) {
                if (value == 1) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ExportCsvScreen()),
                  );
                } else if (value == 2) {
                  Share.share('Please contact me as soon as me');
                } else if (value == 3) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingScreen()),
                  );
                } else if (value == 4) {
                  _dialogSupport();
                }
              },
            ),
          ],
          automaticallyImplyLeading: false,
          centerTitle: false,
        ),
        // handle your image tap here


        bottomNavigationBar: _buildBottomBar(),
        body: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: <Widget>[
            ExpensisScreen(widget.id),
            StatisticScreen(widget.id),
            LocationScreen(),
          ],
        ),
      ),
    );
  }

  _buildBottomBar() {
    return CurvedNavigationBar(
      key: _bottomNavigationKey,
      index: 0,
      height: 60.0,
      items: <Widget>[
        Icon(Icons.line_style, size: 30, color: Colors.white),
        Icon(Icons.bar_chart, size: 30, color: Colors.white),
        Icon(Icons.map_outlined, size: 30, color: Colors.white),
      ],
      color: AppColors.cardnewColor,
      buttonBackgroundColor: AppColors.redColor,
      backgroundColor: AppColors.orangeColor,
      animationCurve: Curves.easeInOut,
      animationDuration: Duration(milliseconds: 600),
      onTap: _onTappedBar,
      letIndexChange: (index) => true,
    );
  }

  _dialogSupport() {
    int _selectedIndex = 0;
    showDialog(
        context: context,
        builder: (context) => StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
              return AlertDialog(
                //title: Text('Logout'),
                content: Container(
                    // Specify some width
                    width: MediaQuery.of(context).size.width * .7,
                    height: MediaQuery.of(context).size.height / 7,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Send us an email",
                          style: TextStyle(
                              fontSize: 22, fontWeight: FontWeight.w500),
                        ),
                        SizedBox(height: 15),
                        Text(
                          "We're happy to help and respond to every message personally",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.w400),
                        ),
                        SizedBox(height: 15),
                        Text("Usally we reply within 24 hours"),
                      ],
                    )),

                actions: <Widget>[
                  new Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            /* Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) => const TripExpensisScreen()));*/
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                  color: AppColors.blackColor),
                            ),
                          )),
                      GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                            sendMail();
                          },
                          child: Container(
                            padding: EdgeInsets.all(10),
                            child: Text("Send Email",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.bgColor)),
                          ))
                    ],
                  )
                ],
              );
            }));
  }

  shareData() {
    Share.share('I am interested in your travelbillapp',
        subject:
            'https://api.whatsapp.com/send/?phone=919313131032&text=I am interested in your travelbillapp&app_absent=0',
        sharePositionOrigin: Rect.fromLTWH(10, 20, 100, 200));
  }

  void _onTappedBar(int value) {
    FocusScope.of(context).unfocus();
    setState(() {
      _selectedIndex = value;
      _tabController?.animateTo(value);
    });
    //  _pageController?.jumpToPage(value);
    _pageController?.animateToPage(value,
        duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  void _handleTabSelection() {
    if (_selectedIndex != _tabController?.index) {
      setState(() {
        _selectedIndex = _tabController?.index;
        _pageController?.jumpToPage(_selectedIndex as int);
        //_onTappedBar(_selectedItem as int);
      });
      _pageController?.animateToPage(_selectedIndex as int,
          duration: Duration(milliseconds: 300), curve: Curves.easeInOut);
    }
  }

  ClipRRect _buildDrawer(BuildContext context) {
    return ClipRRect(
        borderRadius: BorderRadius.only(
            topRight: Radius.circular(45), bottomRight: Radius.circular(45)),
        child: Drawer(
        child: Container(
        decoration: BoxDecoration(
    image: DecorationImage(
    image: AssetImage('assets/drawerback.png'),
    fit: BoxFit.cover,
    ),
    ),
          child: ListView(
            padding: EdgeInsets.zero,
            physics: NeverScrollableScrollPhysics(),
            children: [
              _buildHeader(),
              _buildListTile(
                icon: Icons.home,
                title: 'Home',
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              _buildListTile(
                icon: Icons.train,
                title: 'Create Trips',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => TripScreen()),
                  );
                },
              ),
              _buildListTile(
                icon: Icons.file_copy_outlined,
                title: 'Trips List',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => TripDetailScreen()),
                  );
                },
              ),
              _buildListTile(
                icon: Icons.settings,
                title: 'Settings',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => SettingScreen()),
                  );
                },
              ),
              _buildListTile(
                icon: Icons.cloud_sync,
                title: 'CSV File',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (BuildContext context) => CSVScreen()),
                  );
                },
              ),
              AboutListTile(
                icon: Icon(Icons.info),
                child: Text('About app'),
                applicationIcon: Icon(Icons.local_play),
                applicationName: 'Travel',
                applicationVersion: '1.0.0',
                applicationLegalese: '© 2023 Travel',
                aboutBoxChildren: [
                  // Additional content goes here...
                ],
              ),
              Spacer(),
              Divider(),
              _buildListTile(
                icon: Icons.logout,
                title: 'Logout',
                onTap: () {
                  Navigator.pop(context);
                  _dialoglogout();
                },
              ),
            ],
          ),
        )));
  }

  Future<bool> _dialoglogout() async {
    return (await showDialog(
          context: context,
          builder: (context) => AlertDialog(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            title: Text(
              "Confirm Logout !",
              style: AppTextStyles.boldStyle(
                  AppFontSize.font_16, AppColors.blackColor),
            ),
            content: Text("Do you want to logout from travelbillapp",
                style: AppTextStyles.mediumStyle(
                    AppFontSize.font_14, AppColors.blackColor)),
            actions: <Widget>[
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                      child: Text('Yes'),
                      onPressed: () {
                        LogoutAPI();
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                      )),
                  SizedBox(width: 10),
                  ElevatedButton(
                      child: Text('No'),
                      onPressed: () => Navigator.of(context).pop(false),
                      style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.all(Colors.black12),
                      )),
                ],
              )
            ],
          ),
        )) ??
        false;
  }

  Widget _buildHeader() {
    return Container(
     // color: AppColors.cardnewColor,
      height: 230,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/drawerbg.png'),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          CircleAvatar(
            radius: 50,
            backgroundColor: Colors.white,
            backgroundImage: AssetImage("assets/trip2.jpg"),
          ),
          SizedBox(height: 10),
          Text(
            name.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.whiteColor,
            ),
          ),
          SizedBox(height: 10),
          Text(
            email.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile(
      {required IconData icon,
      required String title,
      required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  _preferedBar() {
    return PreferredSize(
        preferredSize: Size.fromHeight(160.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                    child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        child: DropdownButton<String>(
                          underline: Container(),
                          iconEnabledColor: Colors.white,
                          iconSize: 30,
                          value: _selectedItems,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedItems = value;
                              if (_selectedItems == "Total Spend") {
                                amountselect = Totalspend.toString();
                              } else if (_selectedItems == "Daily Average") {
                                amountselect = Daily_avg.toString();
                              } else if (_selectedItems == "Today") {
                                amountselect = Today.toString();
                              }
                              print("selected items" + amountselect.toString());
                            });
                          },
                          selectedItemBuilder: (BuildContext context) {
                            return _itemss.map<Widget>((String item) {
                              return Align(
                                  alignment: Alignment.centerLeft,
                                  // Align selected value to left
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            12), // Change selected text color here
                                  ));
                            }).toList();
                          },
                          items: _itemss.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 10, bottom: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                              '\u{20B9}${amountselect != null ? amountselect : "00"}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18))),
                      LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width / 3,
                        animation: true,
                        lineHeight: 8.0,
                        animationDuration: 2500,
                        percent: 0.6,
                        center: Text(
                          "80.0%",
                          style: TextStyle(
                              color: AppColors.whiteColor, fontSize: 8),
                        ),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Colors.orange,
                      ),
                      SizedBox(height: 5),
                      Row(children: [
                        SizedBox(width: 10),
                        Text(surplus_money.toString(),
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 6,
                        ),
                        Text(
                            '\u{20B9}${total_trip_amount != null ? total_trip_amount.toString() : "00"}',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                      ]),
                    ],
                  ),
                )),
                Expanded(
                    child: Container(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 8),
                        child: DropdownButton<String>(
                          underline: Container(),
                          iconEnabledColor: Colors.white,
                          iconSize: 30,
                          value: _selectedItem,
                          onChanged: (String? value) {
                            setState(() {
                              _selectedItem = value;
                              if (_selectedItem == "Total Spend") {
                                amountselect1 = Totalspend.toString();
                              } else if (_selectedItem == "Daily Average") {
                                amountselect1 = Daily_avg.toString();
                              } else if (_selectedItem == "Today") {
                                amountselect1 = Today.toString();
                              }
                            });
                          },
                          selectedItemBuilder: (BuildContext context) {
                            return _items.map<Widget>((String item) {
                              return Align(
                                  alignment: Alignment.centerLeft,
                                  // Align selected value to left
                                  child: Text(
                                    item,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize:
                                            12), // Change selected text color here
                                  ));
                            }).toList();
                          },
                          items: _items.map((String item) {
                            return DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            );
                          }).toList(),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.only(left: 10, bottom: 5),
                          alignment: Alignment.centerLeft,
                          child: Text(
                              '\u{20B9}${amountselect1 != null ? amountselect1 : "00"}',
                              textAlign: TextAlign.left,
                              style: TextStyle(
                                  color: Colors.white, fontSize: 18))),
                      LinearPercentIndicator(
                        width: MediaQuery.of(context).size.width / 3,
                        animation: true,
                        lineHeight: 8.0,
                        animationDuration: 2500,
                        percent: 0.6,
                        center: Text(
                          "80.0%",
                          style: TextStyle(
                              color: AppColors.whiteColor, fontSize: 8),
                        ),
                        linearStrokeCap: LinearStrokeCap.roundAll,
                        progressColor: Colors.orange,
                      ),
                      SizedBox(height: 5),
                      Row(children: [
                        SizedBox(width: 10),
                        Text('Left',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 4.5,
                        ),
                        Text('\u{20B9}${' 25000'}',
                            style:
                                TextStyle(color: Colors.white, fontSize: 12)),
                      ]),
                    ],
                  ),
                )),
              ],
            ),
            SizedBox(height: 15),
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.orange,
              indicatorWeight: 5,
              labelStyle: TextStyle(fontSize: 13),
              labelPadding:
                  EdgeInsets.symmetric(horizontal: 0.2, vertical: 0.2),
              unselectedLabelColor: Colors.white70,
              tabs: [
                Tab(text: "EXPENSES"),
                Tab(text: "STATISTICS"),
                Tab(text: "LOCATION"),
              ],
            ),
          ],
        ));
  }

  userRoles() {
    final body = {
      "id": sp?.getString(SpUtil.USER_ID.toString()),
    };

    {
    //  showLoder(context);
      apiProvider.GetUserRoles(body, context).then((response) {
        // Navigator.pop(context);
        var success = ApiProvider.returnResponse(response.status.toString());
        var convertDataToJson = response;
        var data = convertDataToJson.data;
        print("list of states >>>>>>>>>>>" + success.toString());
        if (success) {
          roleDataList.clear();
          roleDataList = data!;
          for (int i = 0; i <= roleDataList.length; i++) {
            role.add(roleDataList[i].rolename.toString());
            role.add(roleDataList[i].plan_id.toString());
            //  stateListName.add(stateDataList[i].id);
            // reniorListName.add(listdata[i].name + listdata[i].id.toString());

            print("data roles list=========>" + role.toString());
          }

          //   _State=stateListName[0];
        }
      });
    }
  }

  ExpensisStatusList() {
    final body = {
      "user_id": sp?.getString(SpUtil.USER_ID.toString()),
      "trip_id": widget.id // "id": "1",
    };

    {
    //  showLoder(context);
      print("trp id>>>>>>>>>>>" + body.toString());
      apiProvider.ExpenseStatusAPI(body, context).then((response) {
      //   Navigator.pop(context);
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
            Trip_name = response.data?.trip_name;
            Totalspend = response.data?.totalAmount;
            Daily_avg = response.data?.dailyAverageSpend;
            Today = response.data?.todaySpend;

            total_trip_amount = response.data?.totalTripAmount?.toString() ?? '';
            surplus_money = response.data?.surplusMoney?.toString() ?? '';

            amount_avg = double.tryParse(total_trip_amount) ?? 0.0;
            amount_avg /= double.tryParse(surplus_money) ?? 1.0;
          });

        }
      });
    }
  }

  void LogoutAPI() {
    final body = {
      //"id": userid.toString(),
      "id": sp?.getString(SpUtil.USER_ID.toString()),
    };
    print(body);
    //showLoder(context);
    apiProvider.logout(body, this).then((response) {
    //  Navigator.pop(context);
    //  FocusScope.of(context).unfocus();
      var convertDataToJson = json.decode(response.body);
      var success = convertDataToJson["status"];
      print("statusCode ===================>     $success");
      var message = convertDataToJson["message"];
      print("message------------>>>>>" + message);

      if (success == "success") {
        sp?.clear();
        // print("message ========message========>"+response.message.toString());
        showToastMessage(message);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => HomeScreen()));
      } else {
        showToastMessage(message);
      }
    });
  }
  void sendMail() {
    final body = {
      //"id": userid.toString(),
      "user_id": sp?.getString(SpUtil.USER_ID.toString()),
    };
    print(body);
    //showLoder(context);
    apiProvider.SendMailAPI(body, this).then((response) {
      //  Navigator.pop(context);
      //  FocusScope.of(context).unfocus();
      var convertDataToJson = json.decode(response.body);
      var success = convertDataToJson["status"];
      print("statusCode ===================>     $success");
      var message = convertDataToJson["message"];
      print("message------------>>>>>" + message);

      if (success == "success") {
        // print("message ========message========>"+response.message.toString());
        showToastMessage(message);
      } else {
        showToastMessage(message);
      }
    });
  }
}


