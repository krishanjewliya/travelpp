import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:syncfusion_flutter_xlsio/xlsio.dart' hide Column,  Row;

import 'package:http/http.dart' as http;
import 'package:path/path.dart' as p;
import 'package:travelbillapp/DashboardScreen.dart';
import 'package:travelbillapp/Utils/shared_preferences.dart';
import 'package:travelbillapp/main.dart';

class CSVScreen extends StatefulWidget {
  @override
  CSVScreenState createState() => CSVScreenState();
}

class CSVScreenState extends State<CSVScreen> {

  List<List<dynamic>>? _data = [];
  String? path;
  int? _counter = 0;
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, ()
    {
      _loadCSV();
    });
  }
  void _loadCSV() async {
    final _rawData = await rootBundle.loadString("assets/digimyland.csv");
    List<List<dynamic>> _listData =
    const CsvToListConverter().convert(_rawData);
    _data?.clear();
    setState(() {
      _data = _listData;
    });
  }

  /*pickFile() async {
    File? doccsv;
 *//*   FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      PlatformFile file = result.files.first;

      final input = new File(file.path.toString()).openRead();
      final fields = await input
          .transform(utf8.decoder)
          .transform(new CsvToListConverter())
          .toList();

      print(fields);
      _data?.clear();
      setState(() {
        _data = fields;
       // uploadcsv(_data.toString() as List<String>?);
      });*//*
      try {
        FilePickerResult? result = await FilePicker.platform.pickFiles();
         *//* type: FileType.custom,
          allowedExtensions: ["xls", "xlsx", "csv","txt"],
        );*//*
        if (result != null) {
          File file = File(result.files.single.path.toString());
          doccsv = File(file.path);
          var headers = {
            'Content-Type': 'application/json',
            'Accept': 'application/json',
            //'Authorization': 'Bearer ${sp?.getString(SpUtil.TOKEN)}',
          };
          var request = http.MultipartRequest(
            'POST',
            Uri.parse(
                "https://digimyland.com/api/v1/uploadLands"),
          );
          request.fields.addAll(headers);
          print("data records" + doccsv.toString());
          if (doccsv != null) {
            request.files.add(
              http.MultipartFile.fromBytes(
                  'csv',
                  File(doccsv!.path).readAsBytesSync(),
                  filename: doccsv!
                      .path
                      .split("/")
                      .last

              ),
            );

            request.fields['user_id'] = sp?.getString(SpUtil.USER_ID.toString());
            request.fields['admin_id'] = sp?.getString(SpUtil.ADMIN_ID.toString());
            var response = await request.send();

            var responses = await http.Response.fromStream(response);
            debugPrint(responses.body.toString());
            var items = json.decode(responses.body);
            if (items["statusData"] == "success") {
              var data = items['data'];
              _dialog(items['message']);
            } else {
              _dialog(items['message']);
            }
          }

        } else {
          // ImageUploadApi(File(file!.path));
        }
      }
      catch (error) {
        print("error: $error");
      }


  }*/
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        titleSpacing: -10,
        title: Text("CSV Data"),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.of(context).pushReplacement(MaterialPageRoute(
                builder: (BuildContext context) =>
                 DashboardScreen("0")));
          },
        ),
        actions: [
         InkWell(
                      onTap: () {
                       // pickFile();
                      },
                      child: Icon(Icons.cloud_upload,
                          size: 25, color: Colors.white)),
          SizedBox(width: 15,)

        ],
      ),
      body: ListView.builder(
        itemCount: _data?.length,
        itemBuilder: (_, index) {
          return Card(
            margin: const EdgeInsets.all(3),
            color: index == 0 ? Colors.grey.shade300 : Colors.white,
            child: ListTile(
              leading: Text(_data![index][0].toString()),
              title: Text(_data![index][1].toString()),
              trailing: Text(_data![index][2].toString(),style: TextStyle(color: Colors.red, fontSize: 16),),
            ),
          );
        },
      ),
      // Display the contents from the CSV file
    );
  }

  _dialog(String Message) {
    showDialog(
      context: context,
      builder: (context) =>
          AlertDialog(
            //title: Text('Logout'),
            content: new Text(Message,
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
                    Navigator.of(context).pop();

                    //Navigator.of(context).pop();
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
  }





