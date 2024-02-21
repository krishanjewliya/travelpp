import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelbillapp/DashboardScreen.dart';
import 'package:travelbillapp/LoginScreen.dart';
import 'package:travelbillapp/TripDetailsScreen..dart';
import 'package:travelbillapp/Utils/shared_preferences.dart';
import 'package:travelbillapp/api/apiProvider.dart';
import 'package:travelbillapp/api/model/CurrencyModel.dart';
import 'package:travelbillapp/common_widget/custom_textfield.dart';
import 'package:travelbillapp/common_widget/progress_dialog.dart';
import 'package:travelbillapp/common_widget/submit_button.dart';
import 'package:travelbillapp/constant/app_colors.dart';
import 'package:travelbillapp/constant/app_text_style.dart';
import 'package:intl/intl.dart';
import 'package:travelbillapp/constant/constWidgets.dart';
import 'package:travelbillapp/main.dart';
class TripScreen extends StatefulWidget {
  const TripScreen({Key? key}) : super(key: key);

  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  DateTime endDateTime = DateTime.now();
  DateTime startDateTime = DateTime.now();
  TextEditingController _startDatecontroller = new TextEditingController();
  TextEditingController _endDatecontroller = new TextEditingController();
  TextEditingController _tripcontroller = new TextEditingController();
  TextEditingController _tripbudgetcontroller = new TextEditingController();
  TextEditingController _tripcurrencycontroller = new TextEditingController();
  final ImagePicker _picker = ImagePicker();
  final random = Random();
  String? _Currency;

  static List<CurrencyDataList> currencyDataList = [];
  final List<String> _imagePaths = [
    'assets/trip1.jpg',
    'assets/trip.png',
    'assets/trip2.jpg',
  ];
  int _selectedIndex = 0;

  void _changeImage() {
    setState(() {
      _selectedIndex = Random().nextInt(_imagePaths.length);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    currencyList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // backgroundColor: Colors.transparent,
      body:


      SingleChildScrollView(
       child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            decoration: const BoxDecoration(
              image: DecorationImage(
                  image: AssetImage('assets/background.png'), fit: BoxFit.cover),
            ),

          child: Column(children: [
            Container(
              padding: EdgeInsets.all(16),
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 250,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(_imagePaths[_selectedIndex]),
                  fit: BoxFit.cover,
                ),
              ),
              child: Column(children: [
                SizedBox(height: 40),
                GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (
                                  BuildContext context) => TripDetailScreen()));
                    },
                    child: Container(
                        alignment: Alignment.topLeft,
                        child: Icon(Icons.arrow_back_outlined, size: 30,
                            color: AppColors.whiteColor))),
                SizedBox(height: 10),
                GestureDetector(
                    onTap: () {
                      _showImagePicker(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          horizontal: 35, vertical: 14),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(
                            width: 1, color: AppColors.whiteColor),
                      ),
                      child: Text("CHOOSE PHOTO",
                        style: TextStyle(fontWeight: FontWeight.w500,
                            fontSize: 18,
                            color: AppColors.whiteColor),),
                    )),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: ()
                  {
                    _changeImage();
                  },

                child:Container(
                  padding: EdgeInsets.symmetric(horizontal: 35, vertical: 14),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(width: 1, color: AppColors.whiteColor),
                  ),
                  child: Text("RANDOM PHOTO",
                    style: TextStyle(fontWeight: FontWeight.w500,
                        fontSize: 18,
                        color: AppColors.whiteColor),),
                )),

              ],),
            ),
            Container(

              margin: EdgeInsets.symmetric(horizontal: 10),
              padding: EdgeInsets.all(10),
              child: Column(children: [

                TextField(
                  controller: _tripcontroller,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Enter Trip',
                    hintStyle:
                    TextStyle(
                      color: Colors.white, // Change the hint text color
                      fontSize: 16, // Change the hint text font size// Apply italic style to the hint text
                      fontWeight: FontWeight.w400, // Change the hint text font weight
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white), // Change the underline color
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  //  controller: myController,
                ),
                SizedBox(height: 10),
                TextField(
                  controller: _tripbudgetcontroller,
                    keyboardType: TextInputType.text,
                    obscureText: false,
                    decoration: InputDecoration(
                      hintText: 'Enter Trip Budget (optional)',
                      hintStyle:
                      TextStyle(
                        color: Colors.white, // Change the hint text color
                        fontSize: 16, // Change the hint text font size// Apply italic style to the hint text
                        fontWeight: FontWeight.w400, // Change the hint text font weight
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white), // Change the underline color
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                      border: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.white),
                      ),
                    )),
                SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets
                      .only(
                      left: 1.0,
                      right: 2.0,
                     ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white,
                        width: 1,
                      ),
                    )),
                  child:  Theme(
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
                      dropdownColor: AppColors.cardnewColor,
                      iconEnabledColor: Colors.white70,
                    iconSize: 40,
                    hint: const Text(
                        'Select Currency',
                        style: TextStyle(
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight
                                .normal)),
                    // Not necessary for Option 1
                    value: _Currency,

                    onChanged: (
                        newValue) {
                      setState(() {
                        _Currency =
                            newValue
                                .toString();
                        print(
                            ">>>>_Currency  id" +
                                _Currency
                                    .toString());
                        // stateDataList.clear();

                      });
                    },
                    items: currencyDataList
                        .map((
                        location) {
                      return DropdownMenuItem<
                          String>(
                        child: new Text(
                            location
                                .currency
                                .toString()),
                        value: location
                            .id
                            .toString(),
                      );
                    }).toList(),
                  )),
                ),
/*
                TextField(
                  controller: _tripcurrencycontroller,
                  keyboardType: TextInputType.text,
                  obscureText: false,
                  decoration: InputDecoration(
                    hintText: 'Enter your currency(101)',
                  ),
                ),
*/

                SizedBox(height: 10),
                GestureDetector(
                  onTap: ()
                  {
                    _startDate(context);
                  },
                child:TextField(
                  keyboardType: TextInputType.none,
                  enabled: false,
                  readOnly: true,
                  controller: _startDatecontroller,
                  onTap: () {

                  },
                  decoration: InputDecoration(
                    hintText: 'Start Date',
                    hintStyle:
                    TextStyle(
                      color: Colors.white, // Change the hint text color
                      fontSize: 16, // Change the hint text font size// Apply italic style to the hint text
                      fontWeight: FontWeight.w400, // Change the hint text font weight
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white), // Change the underline color
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                )),
                SizedBox(height: 10),
                TextFormField(
                  keyboardType: TextInputType.none,
                  controller: _endDatecontroller,
                  onTap: () {
                    _endDate(context);
                  },
                  decoration: InputDecoration(
                    hintText: 'End Date',
                    hintStyle:
                    TextStyle(
                      color: Colors.white, // Change the hint text color
                      fontSize: 16, // Change the hint text font size// Apply italic style to the hint text
                      fontWeight: FontWeight.w400, // Change the hint text font weight
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white), // Change the underline color
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),

                  ),
                ),
                SizedBox(height: 30),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      tripValidation();
                                        /*    Navigator.of(context).pushReplacement(
                          MaterialPageRoute(
                              builder: (
                                  BuildContext context) => const TripDetailScreen()));*/
                    },
                    child: SubmitButton(
                      height: 60,
                      value: "Save Trip".trim().toUpperCase(),
                      color: AppColors.blackColor,
                      textStyle: AppTextStyles.mediumStyle(
                          AppFontSize.font_16, AppColors.whiteColor),
                    ),
                  ),
                ),
              ],),),
          ]))),
    );
  }

  Future<void> _endDate(BuildContext context) async {
     DateFormat formatter = DateFormat('dd-MM-yyyy');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: endDateTime,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != endDateTime) {
      setState(() {
        endDateTime = picked;
        _endDatecontroller..text = formatter.format(endDateTime);
      });
    }
  }

  Future<void> _startDate(BuildContext context) async {
    DateFormat formatter = DateFormat('dd-MM-yyyy');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startDateTime,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != startDateTime) {
      setState(() {
        startDateTime = picked;
        _startDatecontroller..text = formatter.format(startDateTime);
      });
    }
  }

  void _showImagePicker(context) {
    FocusScope.of(context).unfocus();
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: Wrap(
                children: <Widget>[
                  ListTile(
                      leading: const Icon(Icons.photo_library),
                      title: const Text('Photo Gallery'),
                      onTap: () {
                        _imgFromGallery();
                      //  Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                     // Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
/*    final XFile? image =
    await _picker.pickImage(source: ImageSource.camera, imageQuality: 50);
    //ImageUploadApi(File(image!.path));
    print("image file" + image!.path.toString());
    if (image != null) {
      setState(() {
        // docImageName = File(image.path);
      });
      //ImageUploadApi(File(docImageName!.path));
    }*/
  }

  _imgFromGallery() async {
    /*try {
      final List<XFile>? selectedImages = await
      _picker.pickMultiImage(maxHeight: 480, maxWidth: 640, imageQuality: 70);
      if (selectedImages!.isNotEmpty) {
        // landImageName!.addAll(selectedImages);
      }
      //  print("Document files" + landImageName!.toString());
    }

    catch (e) {
      setState(() {
        debugPrint(e.toString());
      });
    }*/
  }
  void tripValidation() {
    if(_tripcontroller.text=="")
    {
      showToastMessage("Please enter trip name");
    }
    else if(_tripbudgetcontroller.text=="")
    {
      showToastMessage("Please enter trip budget");
    }
    else if(_startDatecontroller.text=="")
    {
      showToastMessage("Please enter trip start date");
    }
    else if(_endDatecontroller.text=="")
    {
      showToastMessage("Please enter trip end date");
    }
    else
    {
      CreateTripAPI(_tripcontroller.text,_tripbudgetcontroller.text,_startDatecontroller.text,_endDatecontroller.text);
    }
  }

  void CreateTripAPI(String tripName, String tripBudget, String startdate, String endDate) {

      {
        final body = {
          "user_id": sp?.getString(SpUtil.USER_ID.toString()),
          "admin_id": sp?.getString(SpUtil.ADMIN_ID.toString()),
          "trip_name":tripName,
          "trip_type":"local",
          "budget":tripBudget,
          "currency": _Currency,
          "start_date": startdate,
          "end_date": endDate,
        };
        print("response body===================>     $body");
        showLoder(context);
        apiProvider.createTrip(body, this).then((response) {
          Navigator.pop(context);
          var convertDataToJson = json.decode(response.body);
          var success = convertDataToJson["success"];
          // print("statusCode ===================>     $success");
          if (convertDataToJson['status'] == "success") {
            print("statusCode ===================>"+convertDataToJson['status']);
            print("message ========message========>"+convertDataToJson['message']);

            showToastMessage(convertDataToJson['message']);
            FocusScope.of(context).unfocus();
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const TripDetailScreen()));
          }
          else
          {
            print("message ========message========>"+convertDataToJson['message'].toString());
            showToastMessage(convertDataToJson['message'].toString());
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) => const TripScreen()));
          }
        });
      }
    }
  currencyList() {
    // showLoder(context);
    apiProvider.Currencylist(this).then((response) {
      var success = ApiProvider.returnResponse(response.status.toString());
      var convertDataToJson = response;
      var data = convertDataToJson.data;
      print("sucess" + success.toString());
      //print("data" + data.toString());

      if (success) {
        setState(() {
          currencyDataList = data!;
          for (int i = 0; i < currencyDataList.length; i++) {
           // countryListName.add(currencyDataList[i].name);
            // countryListName.add(countryDataList[i].id);
            // reniorListName.add(listdata[i].name + listdata[i].id.toString());
          }

        });
      }
    });
  }

}


