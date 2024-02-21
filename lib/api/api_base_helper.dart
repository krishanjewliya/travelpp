import 'dart:convert';
import 'dart:io';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:travelbillapp/Utils/connectivity.dart';
import 'package:travelbillapp/api/app_exception.dart';
import 'package:travelbillapp/constant/app_prefkeys.dart';
class ApiBaseHelper {
  SharedPreferences? prefs;
  final String BASE_URL = "https://digimyland.com/travel/api/v1/";
  Future<dynamic> getApiCall(String url) async {
    var responseJson;
    prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs!.getString(AppPrefKeys.AUTHENTICATION);
    //bool isNetActive = await ConnectionStatus.getInstance().checkConnection();
 //   print('isNetActive - ${isNetActive.toString()}');
    print('getApiCall - ${BASE_URL + url}');
    print('apiToken:-$apiToken');
    var apiHeader = {
    //  'Authorization': 'Bearer $apiToken',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };
    try {
      final response =
          await http.get(Uri.parse(BASE_URL + url), headers: apiHeader);
      print('response');
      print(response.statusCode);
      print(response.body);
      var res = jsonDecode(response.body);

      if (res['status'].toString() == '401') {
        if (res['message'].toString() == 'Unauthorized User: Login required.') {
          Fluttertoast.showToast(msg: res['message']);
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.clear();
        }
      }

      responseJson = _returnResponse(response);
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  Future<dynamic> postApiCall(
    String url,
    Map<String, dynamic> jsonData,
  ) async {
    var responseJson;
    prefs = await SharedPreferences.getInstance();
    String? apiToken = prefs!.getString(AppPrefKeys.AUTHENTICATION);
    print('postApiCall - ${BASE_URL + url}');
    print('apiToken:-$apiToken');
    print(jsonEncode(jsonData));
    var apiHeader = {
    //  'Authorization': 'Bearer $apiToken',
      'Accept': 'application/json',
      'Content-Type': 'application/json',
    };

    try {
      final http.Response response = await http.post(
        Uri.parse(BASE_URL + url),
        headers: apiHeader,
        body: jsonEncode(jsonData),
      );
      print('response');
      print(response.statusCode);
      print(response.body);

      try {
        responseJson = _returnResponse(response);
      } catch (e) {}
    } on SocketException {
      throw FetchDataException('No Internet connection');
    }
    return responseJson;
  }

  dynamic _returnResponse(http.Response response) {
    print(response.statusCode);
    switch (response.statusCode) {
      case 200:
        var responseJson = json.decode(response.body.toString());
        return responseJson;
      case 400:
        throw BadRequestException(response.body.toString());
      case 401:
        throw UnauthorisedException(response.body.toString());
      case 403:
        throw UnauthorisedException(response.body.toString());
      case 404:
        throw UnauthorisedException(response.body.toString());
      case 500:
      default:
        throw FetchDataException(
            'Error occured while Communication with Server with StatusCode : ${response.statusCode}');
    }
  }
}
