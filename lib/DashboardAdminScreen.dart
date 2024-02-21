import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:share_plus/share_plus.dart';
import 'package:travelbillapp/ApprovedScreen.dart';
import 'package:travelbillapp/CreateUserScreen.dart';
import 'package:travelbillapp/ExpensisScreen.dart';
import 'package:travelbillapp/ExportcsvScreen.dart';
import 'package:travelbillapp/HomeScreen.dart';
import 'package:travelbillapp/LocationScreen.dart';
import 'package:travelbillapp/LoginScreen.dart';
import 'package:travelbillapp/PendingScreen.dart';
import 'package:travelbillapp/RejectedScreen.dart';
import 'package:travelbillapp/SettingScreen.dart';
import 'package:travelbillapp/StatisticScreen.dart';
import 'package:travelbillapp/TripDetailsScreen..dart';
import 'package:travelbillapp/TripExpensisScreen..dart';
import 'package:travelbillapp/TripScreen..dart';
import 'package:travelbillapp/UserListScreen.dart';
import 'package:travelbillapp/Utils/shared_preferences.dart';
import 'package:travelbillapp/api/apiProvider.dart';
import 'package:travelbillapp/api/model/AccessRoleModel.dart';
import 'package:travelbillapp/api/model/ExpenseStatusModel.dart';
import 'package:travelbillapp/common_widget/progress_dialog.dart';
import 'package:travelbillapp/constant/app_colors.dart';
import 'package:travelbillapp/constant/app_text_style.dart';
import 'package:travelbillapp/constant/constWidgets.dart';
import 'package:travelbillapp/main.dart';
import 'package:travelbillapp/sharescreen.dart';

import 'api/model/EditexpenseModel.dart';

class DashboardAdminScreen extends StatefulWidget {
  const DashboardAdminScreen({Key? key}) : super(key: key);

  @override
  _DashboardAdminScreenState createState() => _DashboardAdminScreenState();
}

class _DashboardAdminScreenState extends State<DashboardAdminScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  static List<AccessRoleModelData> roleDataList = [];
  String? email=sp?.getString(SpUtil.EMAIL.toString());
  String? name=sp?.getString(SpUtil.USER_FNAME.toString());

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        key: _scaffoldKey,
        appBar: AppBar(
          backgroundColor: AppColors.cardnewColor,
          title: Text(name.toString(), textAlign: TextAlign.left),
          leading: new IconButton(
            icon: new Icon(Icons.menu, size: 25, color: Colors.white),
            onPressed: () => _scaffoldKey.currentState!.openDrawer(),
          ),
          elevation: 0,
          bottom: _preferedBar(),
          actions: [
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
                    child: Text('Support'),
                  ),
                ];
              },
              onSelected: (value) {
                if(value==1)
                  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ExportCsvScreen()),
                    );
                  }
                else if(value==2)
                {
                  Share.share('Please contact me as soon as me');
                }

                else if(value==3)
                  {
                    _dialogSupport();
                  }
              },
            ),
          ],
          automaticallyImplyLeading: false,
          centerTitle: false,
        ),
        // handle your image tap here
        drawer:_buildDrawer(context) ,

        body: TabBarView(
          controller: _tabController,
          children: [
            PendingScreen(),
            ApprovedScreen(),
            RejectedScreen(),
          ],
        ),
      ),
    );
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
    ),child:ListView(
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
                icon: Icons.person,
                title: 'Create User',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => CreateUserScreen()),
                  );
                },
              ),
              _buildListTile(
                icon: Icons.people_alt,
                title: 'User List',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (BuildContext context) => UserListScreen()),
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
  Widget _buildHeader() {
    return Container(
     // color: AppColors.bgColor,
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
          Text(name.toString(),
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: AppColors.whiteColor,
            ),
          ),
          SizedBox(height: 10),
          Text(email.toString(),
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.whiteColor,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildListTile({required IconData icon, required String title, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: onTap,
    );
  }

  _dialogSupport() {
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
                          height: MediaQuery.of(context).size.height/7,
                          child:Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                            Text("Send us an email",style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),),
                            SizedBox(height: 15),
                            Text("We're happy to help and respond to every message personally",style: TextStyle(fontSize: 18, fontWeight: FontWeight.w400),),
                            SizedBox(height: 15),
                            Text("Usally we reply within 24 hours"),

                          ],)),


                      actions: <Widget>[
                        new Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                                onTap: ()
                                {
                                  Navigator.pop(context);
                                 /* Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (BuildContext context) => const TripExpensisScreen()));*/
                                },

                                child:Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text("Cancel",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: AppColors.blackColor),),
                                )),
                            GestureDetector(
                                onTap: ()
                                {
                                  Navigator.pop(context);
                                  sendMail();
                                },

                                child:Container(
                                  padding: EdgeInsets.all(10),
                                  child: Text("Send Email",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w500,color: AppColors.bgColor)),
                                ))
                          ],)
                      ],
                    );
                }
            ));
  }
  shareData() {
    Share.share('I am interested in your travelbillapp',
        subject:
        'https://api.whatsapp.com/send/?phone=919313131032&text=I am interested in your travelbillapp&app_absent=0',
        sharePositionOrigin: Rect.fromLTWH(10, 20, 100, 200));
  }
  Future<bool> _dialoglogout() async {
    return (await
    showDialog(
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
            crossAxisAlignment:
            CrossAxisAlignment.center,
            mainAxisAlignment:
            MainAxisAlignment.center,
            children: [
              ElevatedButton(
                  child: Text('Yes'),
                  onPressed: () {
                    LogoutAPI();
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),)
              ),
              SizedBox(width: 10),
              ElevatedButton(
                  child: Text('No'),
                  onPressed: () => Navigator.of(context).pop(false),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.black12),)
              ),
            ],)
        ],
      ),
    )) ??
        false;
  }
  _Drawer() {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          Container(
            color: AppColors.bgColor,
            height: 230,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
              SizedBox(height: 10),
              SizedBox(
              height: 100,
              width: 100,
              child: CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                backgroundImage: AssetImage("assets/trip2.jpg"),
                // Provide a placeholder image or an error widget
              )






                ),
                SizedBox(height: 10),
        Text(
        "ShreeKishan Jewliya",
        textAlign: TextAlign.center,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          color: AppColors.whiteColor
        ),),
      SizedBox(height: 10),
      Text(
        "krishanjew@gmail.com",
        style: TextStyle(
          fontWeight: FontWeight.bold,
            color: AppColors.whiteColor
        )),
              ],
            ),
          ),

          ListTile(
            leading: Icon(
              Icons.home,
            ),
            title: const Text('Home'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.train,
            ),
            title: const Text('About'),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.train,
            ),
            title: const Text('User List'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) =>
                  const UserListScreen()));
            },
          ),
          ListTile(
            leading: Icon(
              Icons.train,
            ),
            title: const Text('Create User'),
            onTap: () {
              Navigator.pop(context);
              Navigator.of(context).pushReplacement(MaterialPageRoute(
                  builder: (BuildContext context) =>
                  const CreateUserScreen()));
            },
          ),
          AboutListTile(
            // <-- SEE HERE
            icon: Icon(
              Icons.info,
            ),
            child: Text('About app'),
            applicationIcon: Icon(
              Icons.local_play,
            ),
            applicationName: 'Travel',
            applicationVersion: '1.0.0',
            applicationLegalese: '© 2023 Travel',
            aboutBoxChildren: [

              ///Content goes here...
            ],
          ),
        ],
      ),
    );
  }
  _preferedBar() {
    return PreferredSize(
        preferredSize: Size.fromHeight(50.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [

            SizedBox(height: 5),
            TabBar(
              controller: _tabController,
              indicatorColor: Colors.white,
              indicatorWeight: 2,
              labelStyle: TextStyle(fontSize: 13),
              labelPadding: EdgeInsets.symmetric(horizontal: 2.0),
              unselectedLabelColor: Colors.white,
              tabs: [
                Tab(text: "PENDING"),
                Tab(text: "APPROVED"),
                Tab(text: "REJECTED"),
              ],
            )
          ],
        ));
  }

  void LogoutAPI() {


    final body = {
      //"id": userid.toString(),
      "id": sp?.getString(SpUtil.USER_ID.toString()),
    };
    print(body);
    showLoder(context);
    apiProvider.logout(body, this).then((response) {
      Navigator.pop(context);
      FocusScope.of(context).unfocus();
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
            builder: (BuildContext context) =>
                HomeScreen()));
      }
      else
      {
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



