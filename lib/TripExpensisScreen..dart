import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelbillapp/DashboardScreen.dart';
import 'package:travelbillapp/LoginScreen.dart';
import 'package:travelbillapp/TripDetailsScreen..dart';
import 'package:travelbillapp/Utils/shared_preferences.dart';
import 'package:travelbillapp/api/apiProvider.dart';
import 'package:travelbillapp/api/model/CategoryModel.dart';
import 'package:travelbillapp/api/model/CurrencyModel.dart';
import 'package:travelbillapp/api/model/GetExpensisModel.dart';
import 'package:travelbillapp/common_widget/custom_textfield.dart';
import 'package:travelbillapp/common_widget/progress_dialog.dart';
import 'package:travelbillapp/common_widget/submit_button.dart';
import 'package:travelbillapp/constant/app_colors.dart';
import 'package:travelbillapp/constant/app_text_style.dart';
import 'package:currency_picker/currency_picker.dart';
import 'package:intl/intl.dart';
import 'package:travelbillapp/constant/constWidgets.dart';
import 'package:travelbillapp/main.dart';

class TripExpensisScreen extends StatefulWidget {
  String id;
  TripExpensisScreen(this.id);


  //const TripExpensisScreen({Key? key}) : super(key: key);

  @override
  _TripExpensisScreenState createState() => _TripExpensisScreenState();
}

class _TripExpensisScreenState extends State<TripExpensisScreen> {
  BuildContext? dialog1Context, dialog2Context;
  String? _currency = "INR";
  String? _country = "INDIA";
  DateTime startDateTime = DateTime.now();
  String? selectedDate = "Today";
  final ImagePicker _picker = ImagePicker();
  String? _selectedItem = "Cash";
  int persons = 0;
  TextEditingController descriptions = new TextEditingController();
  TextEditingController amount = new TextEditingController();
  final List<String> _items = [
    "Cash",
    "Online",
  ];
  static List<GetExpensisData> expensisTypelist = [];

  String? _Currency;
  static List<CurrencyDataList> currencyDataList = [];
  String? category;
  String? categoryid;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      expnsisTypelist();
      currencyList();
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
          padding: const EdgeInsets.only(bottom: 30.0, right: 20),
          child: FloatingActionButton(
            onPressed: () {
              addExpensis();
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
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              height: 250,
              decoration: BoxDecoration(color: AppColors.bgColor),
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
                                     DashboardScreen(widget.id)));
                          },
                          child: Container(
                              alignment: Alignment.topLeft,
                              child: Icon(Icons.arrow_back_outlined,
                                  size: 30, color: AppColors.whiteColor))),
                      Spacer(),
                      GestureDetector(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                                MaterialPageRoute(
                                    builder: (BuildContext context) =>
                                     DashboardScreen("0")));
                          },
                          child: Container(
                              alignment: Alignment.topRight,
                              child: Icon(Icons.more_vert,
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
                            controller:amount ,
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
                              border:
                              Border.all(width: 1, color: AppColors.whiteColor),
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
                            */  Container(

                                width:60,
                                height: 35,
                                padding: const EdgeInsets
                                    .only(
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
                                child: DropdownButton(
                                  isExpanded: true,
                                  underline: Container(),
                                  hint: const Text(
                                      'INR',
                                      style: TextStyle(
                                          fontSize: 16.0,
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
                                              .toString(),
                                      style: TextStyle(color: Colors.black,fontSize: 16),),
                                      value: location
                                          .id
                                          .toString(),
                                    );
                                  }).toList(),
                                ),
                              ),
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
              child: Column(
                children: [
                  SizedBox(height: 15),
                  Row(
                    children: [
                      Icon(Icons.edit, size: 20, color: AppColors.bgColor),
                      SizedBox(width: 5),
                      Expanded(
                          flex: 1,
                          child: Container(
                              child: TextField(
                                  controller:descriptions ,
                                  keyboardType: TextInputType.text,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 18,
                                      color: AppColors.blackColor),
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black12),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: Colors.black12),
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
                                      fontSize: 16,
                                      color: AppColors.blackColor),
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
                                      fontSize: 16,
                                      color: AppColors.blackColor),
                                )
                              ],
                            ),
                          )),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
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
                      ),
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
                  Row(
                    children: [
                      Icon(Icons.location_on_outlined,
                          size: 20, color: AppColors.bgColor),
                      SizedBox(width: 5),
                      Text(
                        "26.842871,75.809281",
                        style: TextStyle(
                            fontSize: 16, color: AppColors.blackColor),
                      )
                    ],
                  ),
                  SizedBox(height: 20),
                  GestureDetector(
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
                      )),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Image.asset("assets/refund.png",
                          height: 20, width: 20, color: AppColors.bgColor),
                      SizedBox(width: 5),
                      Text(
                        "Refund",
                        style: TextStyle(
                            fontSize: 16, color: AppColors.blackColor),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ])),
    );
  }


  _dialog() {
    int _selectedIndex = 0;
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) =>
            StatefulBuilder(
                builder: (BuildContext context, StateSetter setState) {
                  return AlertDialog(
                    //title: Text('Logout'),
                    content: Container(
                      // Specify some width
                        width: MediaQuery
                            .of(context)
                            .size
                            .width * .7,
                        height: MediaQuery
                            .of(context)
                            .size
                            .height * .5,
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
                                        padding: const EdgeInsets.all(5.0),
                                        child: Container(
                                          height: 40.0,
                                          width: 40.0,
                                          child: Column(
                                            children: [
                                              Image.network(
                                                expensisTypelist[index]
                                                    .category_logo.toString(),
                                                height: 25,
                                                width: 25,),
                                              SizedBox(height: 5),
                                              Text(expensisTypelist[index]
                                                  .category_name.toString(),
                                                  style: TextStyle(
                                                      color: _selectedIndex ==
                                                          index
                                                          ? AppColors.blueColor
                                                          : null,
                                                      fontSize: 10),
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
                                expnsisCategory(
                                    expensisTypelist[_selectedIndex].id
                                        .toString());
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
        selectedDate = formatter.format(startDateTime);
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
/*    try {
      final List<XFile>? selectedImages = await _picker.pickMultiImage(
          maxHeight: 480, maxWidth: 640, imageQuality: 70);
      if (selectedImages!.isNotEmpty) {
        // landImageName!.addAll(selectedImages);
      }
      //  print("Document files" + landImageName!.toString());
    } catch (e) {
      setState(() {
        debugPrint(e.toString());
      });
    }*/
  }
  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return StatefulBuilder(builder: (context, StateSetter setState) {
          return SingleChildScrollView(
              child:
              Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery
                          .of(context)
                          .viewInsets
                          .bottom),
                  child:
                  Column(
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
                                          borderRadius: BorderRadius.circular(
                                              100),
                                          border: Border.all(width: 1,
                                              color: AppColors.blackColor)
                                      ),
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
                                          borderRadius: BorderRadius.circular(
                                              100),
                                          border: Border.all(width: 1,
                                              color: AppColors.blackColor)
                                      ),
                                      child: Icon(Icons.remove),
                                    )
                                )
                              ])),
                          Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                children: [
                                  Text("Person"),
                                  SizedBox(height: 5),
                                  Text(persons.toString(), style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16),),
                                  SizedBox(height: 5),
                                  Text("Per expense"),
                                  SizedBox(height: 5),
                                  Text('\u{20B9}${'0.50'}', style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16)),

                                ],)),
                          Container(
                              padding: EdgeInsets.all(10),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment
                                    .spaceBetween,
                                children: [
                                  Text("Spand Expense"),
                                  SizedBox(height: 10),
                                  Text("Today- 5/4/2023", style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16)),
                                  SizedBox(height: 10),
                                  Container(
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(
                                              10),
                                          color: AppColors.bgColor
                                      ),
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 20, vertical: 8),
                                      child: Text("SAVE", style: TextStyle(
                                          color: AppColors.whiteColor),)),

                                ],))
                        ],),
                      SizedBox(height: 10)
                    ],

                  )));
        });
      },
    );
  }
  expnsisCategory(String selectedId) {
    categoryid=selectedId;
    final body = {
      "category_id": selectedId,
    };
    print(body);
    showLoder(context);
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
            category=data?.category_logo.toString();
            print("category" + category.toString());

            // expensisCategory = convertDataToJson.data as List<CategoryModel>;
         /*   for (int i = 0; i < expensisCategory.length; i++) {
              // category.add(expensisCategory[i].category_logo.toString());
              print("category   >>>>>>" + category.toString());
            }*/
          });
          Navigator.of(context).pop();
        }
        Navigator.of(context).pop();
      });
        }
  addExpensis() {
    final body = {
      "user_id": sp?.getString(SpUtil.USER_ID.toString()),
      "trip_id": widget.id,
      "expense_category": categoryid,
      "amount": amount.text,
      "currency": _Currency,
      "country": _country,
      "distribution": persons,
      "description": descriptions.text,
      "payment_mode": _selectedItem,
      "date": selectedDate,
      "latitude": "26.9124",
      "longitude": "75.7873",
      "bill_image": "",
    };
    print(body);
    showLoder(context);
    apiProvider.addExpensis(body, this).then((response) {
      FocusScope.of(context).unfocus();
      var convertDataToJson = json.decode(response.body);
      var success = convertDataToJson["status"];
      print("statusCode ===================>     $success");
      var message = convertDataToJson["message"];
      print("message------------>>>>>" + message);
        if (convertDataToJson['status'] == "success") {

            Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                    builder: (BuildContext context) =>
                     DashboardScreen(widget.id)));
            // expensisCategory = convertDataToJson.data as List<CategoryModel>;
         /*   for (int i = 0; i < expensisCategory.length; i++) {
              // category.add(expensisCategory[i].category_logo.toString());
              print("category   >>>>>>" + category.toString());
            }*/

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

  Widget _buildCategoryImage() {
      return category!=null?Image.network(category.toString(),width: 40, height: 40):Image.asset(
        "assets/bed.png",
        width: 40,
        height: 40,
      );

  }
}


