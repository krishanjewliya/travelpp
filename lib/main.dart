
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelbillapp/DashboardAdminScreen.dart';
import 'package:travelbillapp/SplashScrreen.dart';
import 'package:travelbillapp/TripDetailsScreen..dart';
import 'package:travelbillapp/Utils/shared_preferences.dart';
import 'package:travelbillapp/api/apiProvider.dart';
import 'package:travelbillapp/constant/app_colors.dart';
import 'package:travelbillapp/constant/app_theme.dart';
ApiProvider apiProvider = ApiProvider();
SpUtil? sp;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GestureBinding.instance?.resamplingEnabled = true;
  sp = await SpUtil.getInstance();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown

  ]);
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: AppColors.cardnewColor, // Replace this with your desired color
    statusBarIconBrightness: Brightness.light, // Set the status bar icons' color (light/dark)
  ));
  runApp(MyApp());

}

class MyApp extends StatefulWidget {
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? isLogin;
  @override
  void initState() {
    getPref();
    super.initState();
  }

  getPref() async {
    print("check isLogin ->>  " + isLogin.toString());
    SharedPreferences preferences = await SharedPreferences.getInstance();
    setState(() {
      isLogin = preferences.getString(SpUtil.ISLogin.toString());
    });
    print("check isLogin ->>  " + isLogin.toString());
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: [
          const Breakpoint(start: 0, end: 450, name: MOBILE),
          const Breakpoint(start: 451, end: 800, name: TABLET),
          const Breakpoint(start: 801, end: 1920, name: DESKTOP),
          const Breakpoint(start: 1921, end: double.infinity, name: '4K'),
        ],
      ),
        title: "appTitle",

        theme: AppTheme.lightTheme,

        home: isLogin.toString() == "User Admin"
        ? DashboardAdminScreen()
        : isLogin.toString() == "User"
        ? TripDetailScreen()
        : SplashScreen(),
    );
  }
}


