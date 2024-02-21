import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelbillapp/DashboardScreen.dart';
//import 'package:google_maps_place_picker/google_maps_place_picker.dart';
import 'package:travelbillapp/TripDetailsScreen..dart';
import 'package:travelbillapp/Utils/shared_preferences.dart';

import 'package:travelbillapp/api/apiProvider.dart';
import 'package:travelbillapp/api/model/CurrencyModel.dart';
import 'package:travelbillapp/api/model/EditexpenseModel.dart';
import 'package:travelbillapp/api/model/GetExpensisModel.dart';
import 'package:travelbillapp/common_widget/progress_dialog.dart';
import 'package:travelbillapp/constant/app_colors.dart';
import 'package:travelbillapp/constant/app_text_style.dart';
import 'package:intl/intl.dart';
import 'package:travelbillapp/main.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:http_parser/http_parser.dart';
import 'package:country_picker/country_picker.dart';

class TripExpensisEditScreen extends StatefulWidget {
  String id;
  String tripId;

  TripExpensisEditScreen(this.id, this.tripId);

  //const TripExpensisScreen({Key? key}) : super(key: key);

  @override
  _TripExpensisEditScreenState createState() => _TripExpensisEditScreenState();
}

class _TripExpensisEditScreenState extends State<TripExpensisEditScreen> {
  BuildContext? dialog1Context, dialog2Context;
  String? _currency = "INR";
  String? _country = "INDIA";
  DateTime startDateTime = DateTime.now();
  String? selectedDate = "Today";
  final ImagePicker _picker = ImagePicker();
  String? _selectedItem = "Cash";
  String? latitute;
  String? longitute;
  File? ImageName;
  int persons = 0;
  String? latlong = "37.657";
  String? latlong1 = "-122.776";
  final LatLng location1 = LatLng(37.657, -122.776);
  TextEditingController descriptions = new TextEditingController();
  TextEditingController amount = new TextEditingController();
  final List<String> _items = [
    "Cash",
    "Online",
  ];
  static List<GetExpensisData> expensisTypelist = [];
  static List<EditexpenseModel> expensisEditlist = [];

  String? _Currency;
  static List<CurrencyDataList> currencyDataList = [];
  String? category;
  String? categoryid;
  String? tripImage;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      expnsisTypelist();
      currencyList();
      expnsisEdit();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: Padding(
            padding: const EdgeInsets.only(bottom: 30.0, right: 20),
            child: FloatingActionButton(
              onPressed: () {
                UpdateExpensis();
              },
              backgroundColor: AppColors.bgColor,
              child: Icon(
                Icons.check,
                color: Colors.white,
                size: 29,
              ),
              tooltip: 'Capture Picture',
              elevation: 5,
              splashColor: Colors.grey,
            )),
        floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
        // backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
            child: Column(children: [
          Container(
            padding: EdgeInsets.all(16),
            width: MediaQuery.of(context).size.width,
            height: 250,
            decoration: BoxDecoration(color: AppColors.cardnewColor),
            child: Column(
              children: [
                SizedBox(height: 30),
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      TripDetailScreen()));
                        },
                        child: Container(
                            alignment: Alignment.topLeft,
                            child: Icon(Icons.arrow_back_outlined,
                                size: 30, color: AppColors.whiteColor))),


                  ],
                ),
                Spacer(),
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          _dialog();
                        },
                        child: Container(
                            alignment: Alignment.topLeft,
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white54,
                                border: Border.all(
                                    width: 0.3, color: AppColors.whiteColor),
                                borderRadius: BorderRadius.circular(100)),
                            child: _buildCategoryImage())),
                    Spacer(),
                    Container(
                        width: 60,
                        child: TextField(
                            controller: amount,
                            keyboardType: TextInputType.number,
                            style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 25,
                                color: AppColors.whiteColor),
                            decoration: InputDecoration(
                              enabledBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.white),
                              ),
                              hintText: '0.00',
                              hintMaxLines: 1,
                              hintStyle: TextStyle(
                                  fontWeight: FontWeight.w500,
                                  fontSize: 25,
                                  color: AppColors.whiteColor),
                            ))),
                    SizedBox(width: 8),
                    Container(
                        alignment: Alignment.topLeft,
                        padding: EdgeInsets.only(
                            left: 20, right: 20, top: 5, bottom: 5),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: AppColors.whiteColor),
                            borderRadius: BorderRadius.circular(10)),
                        child: Column(
                          children: [
                            /*  GestureDetector(
                                  onTap: () {
                                    currencyPicker();
                                  },
                                  child: Text(_currency.toString(),
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 20,
                                          color: AppColors.whiteColor))),
                            */

                            Container(
                              width: 65,
                              height: 35,
                              padding: const EdgeInsets.only(
                                left: 2.0,
                                right: 2.0,
                              ),
                              decoration: BoxDecoration(
                                  border: Border(
                                bottom: BorderSide(
                                  color: Colors.white,
                                  width: 0.5,
                                ),
                              )),
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
                                    iconEnabledColor: Colors.white,
                                    dropdownColor: AppColors.cardnewColor,
                                    hint: const Text('INR',
                                        style: TextStyle(
                                            fontSize: 16.0,
                                            color: Colors.white,
                                            fontWeight: FontWeight.normal)),
                                    // Not necessary for Option 1
                                    value: _Currency,

                                    onChanged: (newValue) {
                                      setState(() {
                                        _Currency = newValue.toString();
                                        print(">>>>_Currency  id" +
                                            _Currency.toString());
                                        // stateDataList.clear();
                                      });
                                    },
                                    items: currencyDataList.map((location) {
                                      return DropdownMenuItem<String>(
                                        child: new Text(
                                          location.currency.toString(),
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 16),
                                        ),
                                        value: location.id.toString(),
                                      );
                                    }).toList(),
                                  )),
                            ),
                           /* Container(
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
                                  border:
                                      Border.all(color: AppColors.cardnewColor),
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
                                      color: Colors
                                          .white, // Set the selected text color
                                    ),
                                    dropdownColor: Colors.grey,
                                    hint: Text(
                                      'Select charge',
                                      style: TextStyle(
                                        fontSize: 15.0,
                                        color: Colors.white70,
                                        // Use white color for the hint
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    value: _Currency,
                                    onChanged: (newValue) {
                                      setState(() {
                                        _Currency = newValue;
                                      });
                                    },
                                    items: currencyDataList.map((location) {
                                      return DropdownMenuItem(
                                        child: Text(
                                          location.toString(),
                                          style:
                                              TextStyle(color: Colors.white70),
                                        ),
                                        value: location.toString(),
                                      );
                                    }).toList(),
                                  ),
                                )),*/
                            SizedBox(height: 5),
                            Text('\u{20B9}${'1.00'}',
                                style: TextStyle(
                                    fontWeight: FontWeight.w300,
                                    fontSize: 14,
                                    color: AppColors.whiteColor)),
                          ],
                        )),
                  ],
                ),
              ],
            ),
          ),
          Container(
              margin: EdgeInsets.symmetric(horizontal: 16),
              padding: EdgeInsets.all(10),
              child: Column(children: [
                SizedBox(height: 15),
                Row(
                  children: [
                    Icon(Icons.edit, size: 20, color: AppColors.bgColor),
                    SizedBox(width: 5),
                    Expanded(
                        flex: 1,
                        child: Container(
                            child: TextField(
                                controller: descriptions,
                                keyboardType: TextInputType.text,
                                style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 18,
                                    color: AppColors.blackColor),
                                decoration: InputDecoration(
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black12),
                                  ),
                                  focusedBorder: UnderlineInputBorder(
                                    borderSide:
                                        BorderSide(color: Colors.black12),
                                  ),
                                  hintText: 'Label or brier description.....',
                                  hintMaxLines: 1,
                                  hintStyle: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: Colors.grey),
                                  //  hintTextDirection: TextDirection.ltr,
                                )))),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          _startDate(context);
                        },
                        child: Container(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Icon(Icons.calendar_today,
                                  size: 20, color: AppColors.bgColor),
                              SizedBox(width: 5),
                              Text(
                                selectedDate.toString(),
                                style: TextStyle(
                                    fontSize: 16, color: AppColors.blackColor),
                              )
                            ],
                          ),
                        )),
                    SizedBox(width: 60),
                    GestureDetector(
                        onTap: () {
                          _showBottomSheet(context);
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Icon(Icons.settings,
                                  size: 20, color: AppColors.bgColor),
                              SizedBox(width: 5),
                              Text(
                                "Distribution",
                                style: TextStyle(
                                    fontSize: 16, color: AppColors.blackColor),
                              )
                            ],
                          ),
                        )),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          _buildCountryPicker1();
                        },
                        child: Container(
                          child: Row(
                            children: [
                              Icon(Icons.language,
                                  size: 20, color: AppColors.bgColor),
                              SizedBox(width: 5),
                              Text(
                                _country.toString(),
                                style: TextStyle(
                                    fontSize: 16, color: AppColors.blackColor),
                              )
                            ],
                          ),
                        )),
                    SizedBox(width: 40),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.cabin_sharp,
                              size: 20, color: AppColors.bgColor),
                          SizedBox(width: 5),
                          Container(
                            margin: EdgeInsets.only(left: 8),
                            child: DropdownButton<String>(
                              underline: Container(),
                              iconEnabledColor: Colors.black,
                              iconSize: 30,
                              value: _selectedItem,
                              onChanged: (String? value) {
                                setState(() {
                                  _selectedItem = value;
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
                                            color: Colors.black,
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
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                GestureDetector(
                    onTap: () {
                   //   _dialogMap();
                    },
                    child: Row(
                      children: [
                        Icon(Icons.location_on_outlined,
                            size: 20, color: AppColors.bgColor),
                        SizedBox(width: 5),
                        Text(
                          latlong != null
                              ? latlong.toString() + "," + latlong1.toString()
                              : "26.842871,75.809281",
                          style: TextStyle(
                              fontSize: 16, color: AppColors.blackColor),
                        )
                      ],
                    )),
                SizedBox(height: 20),
                /*  GestureDetector(
                      onTap: () {
                        _showImagePicker(context);
                      },
                      child: Row(
                        children: [
                          Icon(Icons.camera_alt_rounded,
                              size: 20, color: AppColors.bgColor),
                          SizedBox(width: 5),
                          Text(
                            "Add an image",
                            style: TextStyle(
                                fontSize: 16, color: AppColors.blackColor),
                          )
                        ],
                      )),*/
                SizedBox(height: 10),
                Stack(children: [
                  Container(
                    height: 350,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.zero,
                    margin: EdgeInsets.zero,
                    alignment: Alignment.center,
                    child: tripImage != null &&
                            Uri.parse(tripImage.toString()).isAbsolute
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.network(
                              tripImage.toString(),
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height,
                              fit: BoxFit.fill,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.asset(
                              'assets/bed.png',
                              fit: BoxFit.fill,
                            ),
                          ),
                  ),
                  Positioned(
                    top: 5,
                    right: 5,
                    child: tripImage != null
                        ? ClipOval(
                            child: GestureDetector(
                                onTap: () {
                                  _showImagePicker(context);
                                },
                                child: Container(
                                  padding: EdgeInsets.all(5),
                                  color: Colors.blue.withOpacity(0.5),
                                  child: Icon(Icons.camera, size: 30),
                                )),
                          )
                        : Container(),
                  ),
                ])
              ]))
        ])));
  }

/*  Future<bool> _dialogMap() async {
    final selected = await showDialog<bool>(
      context: context as BuildContext,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            'Select Coordinates',
            textAlign: TextAlign.center,
            style: AppTextStyles.boldStyle(
              AppFontSize.font_16,
              AppColors.blackColor,
            ),
          ),
          content: SizedBox(
            width: MediaQuery.of(context).size.width - 2,
            child: PlacePicker(
              apiKey: "AIzaSyCrfZW4Yn9i6Fk9zq_YEsCwW-sbdXyVCzs",
              initialPosition: location1,
              useCurrentLocation: true,
              selectInitialPosition: true,
              usePlaceDetailSearch: true,
              searchForInitialValue: true,
              onPlacePicked: (result) {
                print(result.addressComponents);
                Navigator.of(context).pop(true);
              },
              selectedPlaceWidgetBuilder:
                  (_, selectedPlace, state, isSearchBarFocused) {
                latlong = selectedPlace?.geometry?.location.lat.toString();
                latlong1 = selectedPlace?.geometry?.location.lng.toString();

                if (Platform.isIOS && selectedPlace != null) {
                //  state = SearchingState.Idle;
                }

                return Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          bottom: 10.0, left: 10, right: 60),
                      child: Container(
                        padding: EdgeInsets.only(top: 50, left: 10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(color: Colors.black12, width: 2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                            selectedPlace?.formattedAddress.toString() ?? '',
                            style: TextStyle(fontSize: 14)),
                      ),
                    ),
                    Text('LatLong: $latlong - $latlong1',
                        style: AppTextStyles.boldStyle(
                            AppFontSize.font_10, AppColors.blackColor)),
                    SizedBox(height: 5),
                  ],
                );
              },
            ),
          ),
          actions: <Widget>[
            GestureDetector(
              onTap: () => Navigator.of(context).pop(false),
              child: Container(
                alignment: Alignment.center,
                width: 150,
                height: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.blue,
                ),
                child: Text(
                  'Select Latlong',
                  style: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontWeight: FontWeight.normal),
                ),
              ),
            ),
            SizedBox(height: 5),
          ],
        ),
      ),
    );
    return selected ?? false;
  }*/

  _dialog() {
    int _selectedIndex = 0;

    Widget buildGridItem(int index) {
      return GestureDetector(
        onTap: () {
          setState(() {
            _selectedIndex = index;
          });
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 40.0,
            width: 40.0,
            child: Column(
              children: [
                Image.network(
                  expensisTypelist[index].category_logo.toString(),
                  height: 25,
                  width: 25,
                ),
                SizedBox(height: 6),
                Text(
                  expensisTypelist[index].category_name.toString(),
                  style: TextStyle(
                    color: _selectedIndex == index ? AppColors.blueColor : null,
                    fontSize: 10,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      );
    }

    Widget buildGridView() {
      return Container(

        height: 300,

        child: GridView.count(
          crossAxisCount: 3,
          childAspectRatio: 1.0,
          padding: const EdgeInsets.all(4.0),
          mainAxisSpacing: 4.5,
          crossAxisSpacing: 4.5,
          children: List.generate(
            expensisTypelist.length,
                (index) => buildGridItem(index),
          ),
        ),
      );
    }

    Widget buildActionsRow() {
      return Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              expnsisCategory(expensisTypelist[_selectedIndex].id.toString());
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Colors.black26),
              ),
              child: Text(
                "OK",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.bgColor,
                ),
              ),
            ),
          ),
          SizedBox(width: 30),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 10),
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 8),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(width: 1, color: Colors.black26),
              ),
              child: Text(
                "Cancel",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  color: AppColors.blackColor,
                ),
              ),
            ),
          ),
        ],
      );
    }

    showDialog(
      context: context as BuildContext,
      barrierDismissible: true,
      builder: (context) => StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
          return AlertDialog(
            content:
              Container(
              width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height/2,
          child:
          Column(
              children: [
                buildGridView(),
                SizedBox(height: 20),
                buildActionsRow(),
              ],
            )),
          );
        },
      ),
    );
  }


  _dialog1(String Message) {
    showDialog(
      context: context as BuildContext,
      builder: (context) => AlertDialog(
        //title: Text('Logout'),
        content: new Text(
          Message,
          style: TextStyle(
            fontFamily: "Hind-SemiBold",
            color: Colors.black,
            fontSize: 16,
          ),
        ),
        actions: <Widget>[
          new ElevatedButton(
              style: ElevatedButton.styleFrom(
                primary: Colors.blueAccent, // background
                onPrimary: Colors.white, // foreground
              ),
              onPressed: () {
                /*  Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (BuildContext context) =>
                                DownloadScreen(widget
                                    .id)));*/
                Navigator.of(context).pop();
              },
              child: Text('Yes')),
          TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('No'))
        ],
      ),
    );
  }

  Future<void> _startDate(BuildContext context) async {
    DateFormat formatter = DateFormat('yyyy-MM-dd');
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: startDateTime,
        firstDate: DateTime.now(),
        lastDate: DateTime(2101));
    if (picked != null && picked != startDateTime) {
      setState(() {
        startDateTime = picked;
        selectedDate = formatter.format(startDateTime);
      });
    }
  }

  _buildCountryPicker1() {
    return showCountryPicker(
        context: context,
        showWorldWide: false,
        showPhoneCode: true,
        showSearch: true,
        exclude: <String>['KN', 'MF'],
        favorite: <String>['SE'],
        countryListTheme: CountryListThemeData(
            backgroundColor: AppColors.whiteColor,
            // borderRadius: BorderRadius.circular(8),
            bottomSheetHeight: 380,
            flagSize: 20,
            textStyle: TextStyle(
                color: AppColors.blackColor, fontSize: 14, height: 2.0)),
        onSelect: (Country country) {
          setState(() {
            _country = country.name;
          });
        });
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
                        Navigator.of(context).pop();
                      }),
                  ListTile(
                    leading: const Icon(Icons.photo_camera),
                    title: const Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
/*    final File? image =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);
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
/*    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);
    // ImageUploadApi(File(image!.path));
    setState(() {
      ImageName = XFile(image!.path);
    });*/
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return SingleChildScrollView(
              child: Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              padding: EdgeInsets.all(10),
                              child: Column(children: [
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (persons >= 0) {
                                          persons++;
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                              width: 1,
                                              color: AppColors.blackColor)),
                                      child: Icon(Icons.add),
                                    )),
                                SizedBox(height: 10),
                                GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        if (persons > 0) {
                                          persons--;
                                        }
                                      });
                                    },
                                    child: Container(
                                      padding: EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          border: Border.all(
                                              width: 1,
                                              color: AppColors.blackColor)),
                                      child: Icon(Icons.remove),
                                    ))
                              ])),
                          Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Text("Person"),
                                  SizedBox(height: 5),
                                  Text(
                                    persons.toString(),
                                    style: TextStyle(
                                        fontWeight: FontWeight.w500,
                                        fontSize: 16),
                                  ),
                                  SizedBox(height: 5),
                                  Text("Per expense"),
                                  SizedBox(height: 5),
                                  Text('\u{20B9}${'0.50'}',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16)),
                                ],
                              )),
                          Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("Spand Expense"),
                                  SizedBox(height: 10),
                                  Text("Today- 5/4/2023",
                                      style: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16)),
                                  SizedBox(height: 10),
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          color: AppColors.bgColor),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 8),
                                      child: Text(
                                        "SAVE",
                                        style: TextStyle(
                                            color: AppColors.whiteColor),
                                      )),
                                ],
                              ))
                        ],
                      ),
                      SizedBox(height: 10)
                    ],
                  )));
        });
      },
    );
  }

  expnsisCategory(String selectedId) {
    categoryid = selectedId;
    final body = {
      "category_id": selectedId,
    };
    print(body);
    showLoder(context as BuildContext);
    apiProvider.TripCategoryList(body, this).then((response) {
      var success = ApiProvider.returnResponse(response.status.toString());
      var convertDataToJson = response;
      //var data = convertDataToJson.data;
      print("sucess" + success.toString());
      //print("data" + data.toString());
      if (success) {
        setState(() {
          var data = convertDataToJson.data;
          //category.add(data!.category_logo.toString());
          category = data?.category_logo.toString();
          print("category" + category.toString());

          // expensisCategory = convertDataToJson.data as List<CategoryModel>;
          /*   for (int i = 0; i < expensisCategory.length; i++) {
              // category.add(expensisCategory[i].category_logo.toString());
              print("category   >>>>>>" + category.toString());
            }*/
        });
        Navigator.of(context as BuildContext).pop();
      }
      Navigator.of(context as BuildContext).pop();
    });
  }

  UpdateExpensis() async {
    showDialog(
      barrierDismissible: false,
      context: context as BuildContext,
      builder: (context) {
        return Container(
          height: 50,
          width: 50,
          child: Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.blueColor),
            ),
          ),
        );
      },
    );
    final Map<String, String> data = new Map<String, String>();
    data['user_id'] = sp?.getString(SpUtil.USER_ID.toString());
    data['trip_id'] = widget.tripId;
    data['expense_id'] = widget.id;
    data['expense_category'] = categoryid.toString();
    data['amount'] = amount.text;
    data['currency'] = _Currency.toString();
    data['distribution'] = persons.toString();
    data['description'] = descriptions.text;
    data['payment_mode'] = _selectedItem!;
    data['date'] = selectedDate!;
    data['latitude'] = latlong!;
    data['longitude'] = latlong1!;
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      //'Authorization': 'Bearer ${sp?.getString(SpUtil.TOKEN)}',
    };

    var request = http.MultipartRequest(
      'POST',
      Uri.parse("https://mytravelbill.com/api/v1/updateExpense"),
    );
    print("bill_image  List Length:" + ImageName.toString());
    request.fields.addAll(data);
    request.fields.addAll(headers);
    print("data records" + data.toString());
    if (ImageName != null) {
      final extension = p.extension(ImageName!.path);
      print('extension $extension');
      request.files.add(
        http.MultipartFile.fromBytes(
            'bill_image', File(ImageName!.path).readAsBytesSync(),
            filename: ImageName!.path.split("/").last,
            contentType: MediaType(ImageName!.toString(), extension)),
      );
    }
    // print("bill_image  images path" + ImageName.path);
//  request.fields['land_id'] = widget.id.toString();
    var response = await request.send();
    response.stream.transform(utf8.decoder).listen((response) {
      Navigator.pop(context as BuildContext);
      var convertDataToJson = json.decode(response);
      var success = convertDataToJson["status"];
      print("convertDataToJson ===================>     $success");
      if (convertDataToJson["status"] == "success") {
        _dialog1(convertDataToJson['message']);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) => TripDetailScreen()));
      } else {
        _dialog1(convertDataToJson['message']);
        Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (BuildContext context) =>
                TripExpensisEditScreen(widget.id.toString(), widget.tripId)));
      }
    });
  }

  expnsisTypelist() {
    // showLoder(context);
    apiProvider.GetexpenseList(this).then((response) {
      var success = ApiProvider.returnResponse(response.status.toString());
      var convertDataToJson = response;
      var data = convertDataToJson.data;
      print("sucess" + success.toString());
      //print("data" + data.toString());

      if (success) {
        setState(() {
          expensisTypelist = data!;
          for (int i = 0; i < expensisTypelist.length; i++) {
            // countryListName.add(countryDataList[i].name);
            // countryListName.add(countryDataList[i].id);
            // reniorListName.add(listdata[i].name + listdata[i].id.toString());
          }
        });
      }
    });
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

  expnsisEdit() {
    final body = {
      "user_id": sp?.getString(SpUtil.USER_ID.toString()),
      "trip_id": widget.tripId,
      "expense_id": widget.id,
    };
    print(body);
    showLoder(context as BuildContext);
    apiProvider.EditexpenseList(body, this).then((response) {
      var success = ApiProvider.returnResponse(response.status.toString());
      Navigator.of(context as BuildContext).pop();
      var convertDataToJson = response;
      var data = convertDataToJson.data;
      print("sucess" + success.toString());
      //print("data" + data.toString());
      if (success) {
        setState(() {
          expensisEditlist = data!.cast<EditexpenseModel>();
          for (int i = 0; i < expensisEditlist.length; i++) {
            descriptions.text = data[i].description;
            amount.text = data[i].amount.toString();
            //  _Currency=data.currency.toString();
            categoryid=data[i].expenseCategory.toString();

            selectedDate = DateFormat('yyyy-MM-dd').format(data[i].date);
            persons = int.parse(data[i].distribution.toString());
            latitute = data[i].latitude.toString();
            longitute = data[i].longitude.toString();
            tripImage = data[i].billImage;
          }
        });
      }
    });
  }

  Widget _buildCategoryImage() {
    return category != null
        ? Image.network(category.toString(), width: 40, height: 40)
        : Image.asset(
            "assets/bed.png",
            width: 40,
            height: 40,
          );
  }
}
