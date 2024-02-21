/*
* ©️  2021 Inventcolabs Pvt. Ltd. ,  All rights reserved.
*/
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelbillapp/HomeScreen.dart';
import 'package:travelbillapp/Utils/shared_preferences.dart';
import 'package:travelbillapp/constant/app_colors.dart';
import 'dart:math';
import '../../main.dart';

class IntroductionSliderScreen extends StatefulWidget {
  static const  routeName = "/";
  @override
  IntroductionSliderScreenState createState() =>
      IntroductionSliderScreenState();
}

class IntroductionSliderScreenState extends State<IntroductionSliderScreen> {
  var indicatorindex = 0;
 // Future<SharedPreferences> pref =  SharedPreferences.getInstance();

  @override
  void initState() {
   setState(() {
     sp?.putString(SpUtil.ISSeen, "true");
     if(indicatorindex==2) {
       new Future.delayed(const Duration(seconds: 1), () {
   /*      Navigator.push(
           context,
           MaterialPageRoute(builder: (context) => HomeScreen()),
         );*/
       });
     }});

    super.initState();
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/background.png"),
                fit: BoxFit.cover,
              ),
            ),
            child: ListView(
                physics: NeverScrollableScrollPhysics(),
                children: [
              Container(
                  padding: EdgeInsets.all(3.0),
                  decoration: BoxDecoration(),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [

                      Row(crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          GestureDetector(
                            onTap: (){
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder:
                                          (BuildContext context) =>
                                          HomeScreen()));
                            },
                        child:Text("Skip",
                            style: TextStyle(
                                fontFamily: "Hind-Medium",
                                decoration: TextDecoration.underline,
                                color:
                                AppColors.blackColor,
                                fontSize: 18))),
                          SizedBox(width: 15),
                      ],),
                      SizedBox(height: 10),
                      Container(
                          padding: EdgeInsets.all(12.0),
                          margin: EdgeInsets.all(12.0),
                          alignment: Alignment.center,
                          child: ImageSlideshow(
                            /// Width of the [ImageSlideshow].
                            width: double.infinity,

                            /// Height of the [ImageSlideshow].
                            height: 450,

                            /// The page to show when first creating the [ImageSlideshow].
                            initialPage: 0,

                            /// The color to paint the indicator.
                            indicatorColor: Colors.transparent,

                            /// The color to paint behind th indicator.
                            indicatorBackgroundColor: Colors.transparent,

                            /// The widgets to display in the [ImageSlideshow].
                            /// Add the sample image file into the images folder
                            children: [
                              Image.asset(
                                'assets/intro_three.png',
                                fit: BoxFit.cover,
                              ),
                              Image.asset(
                                'assets/intro_two.png',
                                fit: BoxFit.cover,
                              ),
                              Image.asset(
                                'assets/intro1.png',
                                fit: BoxFit.cover,
                              ),
                            ],

                            /// Called whenever the page in the center of the viewport changes.
                            onPageChanged: (value) {
                              setState(() {
                                indicatorindex = value;
                              });
                             // print('Page changed: $value');
                            },

                            /// Auto scroll interval.
                            /// Do not auto scroll with null or 0.
                            autoPlayInterval: 4000,

                            /// Loops back to first slide.
                            isLoop: true,
                          )),

                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            indicatorindex == 0
                                ? Container(
                              decoration: BoxDecoration(
                              color: AppColors.redColor,
                                  border: Border.all(
                                      color: AppColors.redColor,
                                      width: 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                                    width: 8,
                                    height: 22,

                                  )
                                : Container(
                              decoration: BoxDecoration(
                                  color: AppColors.blackColor,
                                  border: Border.all(
                                      color: AppColors.blackColor,
                                      width: 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                                    width: 18,
                                    height: 8,

                                  ),
                            SizedBox(width: 8),
                            indicatorindex == 1
                                ? Container(
                              decoration: BoxDecoration(
                                  color: AppColors.redColor,
                                  border: Border.all(
                                      color: AppColors.redColor,
                                      width: 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              width: 8,
                              height: 22,

                                  )
                                : Container(
                              decoration: BoxDecoration(
                                  color: AppColors.blackColor,
                                  border: Border.all(
                                      color:AppColors.blackColor,
                                      width: 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                                    width: 18,
                                    height: 8,

                                  ),
                            SizedBox(width: 8),
                            indicatorindex == 2
                                ? Container(
                              decoration: BoxDecoration(
                                  color: AppColors.redColor,
                                  border: Border.all(
                                      color:AppColors.redColor,
                                      width: 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                              width: 8,
                              height: 22,

                                  )
                                : Container(
                              decoration: BoxDecoration(
                                  color: AppColors.blackColor,
                                  border: Border.all(
                                      color: AppColors.blackColor,
                                      width: 1),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(10))),
                                    width: 18,
                                    height: 8,

                                  )
                          ]),

                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            indicatorindex == 0
                                ? Expanded(
                                    child: Container(
                                        padding: EdgeInsets.all(10.0),
                                        margin: EdgeInsets.all(7.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                                "PLAN YOUR BUDGETS",
                                                overflow: TextOverflow.clip,
                                                maxLines: 2,
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontFamily: "Poppins-SemiBold",
                                                    color:
                                                    AppColors.redColor,
                                                    fontSize: 25)),
                                            SizedBox(height: 5),
                                            Text(
                                                "Create personalized itineraries for your trips. Add attractions, activities, and restaurants to your schedule. Keep track of reservations and important details, ensuring a smooth and organized travel experience.",
                                                maxLines: 5,
                                                overflow: TextOverflow.clip,
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                    fontFamily: "Hind-Medium",
                                                    color:
                                                    AppColors.blackColor,
                                                    fontSize: 20)),
                                          ],
                                        )))
                                : Container(
                                    width: 0,
                                    height: 0,
                                    color: AppColors.bgcardColor,
                                  ),
                            indicatorindex == 1
                                ? Expanded(
                                    child: Container(
                                        padding: EdgeInsets.all(20.0),
                                        margin: EdgeInsets.all(5.0),
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text("FIND BEST TRIP",
                                                overflow: TextOverflow.clip,
                                                textAlign: TextAlign.center,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontFamily: "Poppins-SemiBold",
                                                    color:
                                                    AppColors.redColor,
                                                    fontSize: 25)),
                                            SizedBox(height: 10),
                                            Text(
                                                "Travelly helps you find the best deals on flights, hotels, and transportation. Compare prices, read reviews, and book with confidence. Save time and money by accessing exclusive offers and discounts.",
                                                overflow: TextOverflow.clip,
                                                maxLines: 5,
                                                textAlign: TextAlign.justify,
                                                style: TextStyle(
                                                    fontFamily: "Hind-Medium",
                                                    color:
                                                    AppColors.blackColor,
                                                    fontSize: 20)),
                                          ],
                                        )))
                                : Container(
                                    width: 0,
                                    height: 0,
                                    color: AppColors.bgcardColor,
                                  ),

                            indicatorindex == 2
                                ? Expanded(
                                    child: GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder:
                                                      (BuildContext context) =>
                                                          HomeScreen()));
                                        },
                                        child: Container(
                                            padding: EdgeInsets.all(10.0),
                                            margin: EdgeInsets.all(7.0),
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                Text(
                                                    "CONNECT WITH PEOPLE",
                                                    overflow: TextOverflow.clip,
                                                    textAlign: TextAlign.center,
                                                    maxLines: 2,
                                                    style: TextStyle(
                                                        fontFamily: "Poppins-SemiBold",
                                                        color: AppColors.redColor,
                                                        fontSize: 25)),
                                                SizedBox(height: 5),
                                                Text(
                                                    "Connect with like-minded travelers through Travelly's social features. Share your experiences, post photos, and exchange travel tips. Build a global network of travel enthusiasts and gain valuable insights.",
                                                    overflow: TextOverflow.clip,
                                                    textAlign: TextAlign.justify,
                                                    maxLines: 5,
                                                    style: TextStyle(
                                                        fontFamily:
                                                            "Hind-Medium",
                                                        color: AppColors.blackColor,
                                                        fontSize: 20)),
                                              ],
                                            ))))
                                : Container(
                                    width: 0,
                                    height: 0,
                                    color: AppColors.bgcardColor,
                                  ),
                          ]),
                    ],
                  )),
            ])));
  }

  void setString() {
    //var setString = pref.setString("isLogged","seen");
  }
}
