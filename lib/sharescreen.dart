import 'dart:async';
import 'package:flutter/material.dart';
import 'package:travelbillapp/DashboardScreen.dart';
import 'package:travelbillapp/LoginScreen.dart';
import 'package:travelbillapp/TripDetailsScreen..dart';
import 'package:travelbillapp/common_widget/custom_textfield.dart';
import 'package:travelbillapp/common_widget/submit_button.dart';
import 'package:travelbillapp/constant/app_colors.dart';
import 'package:travelbillapp/constant/app_text_style.dart';
import 'package:travelbillapp/locallyTripScreen.dart';
import 'package:url_launcher/url_launcher.dart';


class ShareScreen extends StatefulWidget {
  String? id;
   ShareScreen(this.id);

  @override
  _ShareScreenState createState() => _ShareScreenState();
}

class _ShareScreenState extends State<ShareScreen> {
  String? _currency = "INR";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.only(top: 40, left: 16, right: 16),
    width: MediaQuery.of(context).size.width,
    height: MediaQuery.of(context).size.height,
    decoration: const BoxDecoration(
    image: DecorationImage(
    image: AssetImage('assets/background.png'), fit: BoxFit.cover),
    ),
          child: Column(
            children: [
              GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (BuildContext context) =>
                             DashboardScreen(widget.id)));
                  },
                  child: Container(
                      alignment: Alignment.topLeft,
                      child: Icon(Icons.arrow_back_outlined,
                          size: 30, color: AppColors.blackColor))),
              SizedBox(height: 30),
              Image.asset(
                'assets/local.png',
                height: 300,
                width: 200,
                fit: BoxFit.cover,
              ),
              SizedBox(height: 30),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text(
                    "Invite friends son they can enter expenses too. Or just add them locally.",
                    style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                  )),
              SizedBox(height: 15),
              Container(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    "You'll be able to split costs and settle debits.",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                  )),
              SizedBox(height: 50),
              GestureDetector(
                onTap: ()
                {
                  _launchUrl();
                },

              child:Container(
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: .8, color: Colors.black26)),
                child: Text(
                  "INVITE A FRIEND",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      color: Colors.red, fontWeight: FontWeight.w500),
                ),
              )),
              SizedBox(height: 20),
        GestureDetector(
          onTap: ()
          {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>
                const LocallyTripScreen()));
          },

          child:Container(
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    color: Colors.white70,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: .8, color: Colors.black26)),
                child: Text("CREATE lOCALLY",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        color: Colors.red, fontWeight: FontWeight.w500)),
              )),
            ],
          ),
        ),
      ),
    );
  }
  Future<void> _launchUrl() async {

    var whatsappAndroid = Uri.parse(
        'whatsapp://send?phone=918905991690&text=I+am+interested+in+your+travelbillapp+&app_absent=0');
/*    if (await canLaunchUrl(whatsappAndroid)) {
      await launchUrl(whatsappAndroid);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("WhatsApp is not installed on the device"),
        ),
      );
    }*/
  }
}
