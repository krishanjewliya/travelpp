
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:travelbillapp/api/apiConfigs.dart';
import 'package:travelbillapp/api/model/AccessRoleModel.dart';
import 'package:travelbillapp/api/model/AppendlistModel.dart';
import 'package:travelbillapp/api/model/CategoryModel.dart';
import 'package:travelbillapp/api/model/CurrencyModel.dart';
import 'package:travelbillapp/api/model/EditexpenseModel.dart';
import 'package:travelbillapp/api/model/ExpenseStatusModel.dart';
import 'package:travelbillapp/api/model/ExpensisLatLngtModel.dart';
import 'package:travelbillapp/api/model/GetExpensisModel.dart';
import 'package:travelbillapp/api/model/LoginModel.dart';
import 'package:travelbillapp/api/model/StatisticsModel.dart';
import 'package:travelbillapp/api/model/TotalexpenseModel.dart';
import 'package:travelbillapp/api/model/TriplistModel.dart';
import 'package:travelbillapp/api/model/UserlistModel.dart';



class ApiProvider {
  ///developer base url
 final String BASE_URL = "https://mytravelbill.com/api/v1/";
 final String IMAGE_URL = "https://digimyland.com/public/uploads/";

  Future<LoginModel> login(body, context) async {
    print("response body===================>     $body");
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final response = await http.post(
      Uri.parse(BASE_URL + APIConfigs.Login),
      headers: headers,
      body: jsonEncode(body),
    );
    print(response.body);

   // return response;
   return LoginModel.fromJson(jsonDecode(response.body));
  }
  Future<http.Response> logout(body, context) async {
    print("response body===================>     $body");

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final response = await http.post(
      Uri.parse(BASE_URL + APIConfigs.Logout),
      headers: headers,
      body: jsonEncode(body),
    );
    print(response.body);

    return response;
  // return LoginModel.fromJson(jsonDecode(response.body));
  }
  Future<http.Response> SendMailAPI(body, context) async {
    print("response body===================>     $body");

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final response = await http.post(
      Uri.parse(BASE_URL + APIConfigs.SendMail),
      headers: headers,
      body: jsonEncode(body),
    );
    print(response.body);

    return response;
  // return LoginModel.fromJson(jsonDecode(response.body));
  }
  Future<http.Response> deleteAccount(body, context) async {
    print("response body===================>     $body");

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final response = await http.post(
      Uri.parse(BASE_URL + APIConfigs.AccountDelete),
      headers: headers,
      body: jsonEncode(body),
    );
    print(response.body);

    return response;
  // return LoginModel.fromJson(jsonDecode(response.body));
  }
  Future<http.Response> Tripdelete(body, context) async {
    print("response body===================>     $body");

    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final response = await http.post(
      Uri.parse(BASE_URL + APIConfigs.TripDelete),
      headers: headers,
      body: jsonEncode(body),
    );
    print(response.body);

    return response;
  // return LoginModel.fromJson(jsonDecode(response.body));
  }

 Future<AccessRoleModel> GetUserRoles(body, context) async {
   var headers = {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
     'Accept-Language': 'en',
   };
   final response = await http.post(Uri.parse(BASE_URL + APIConfigs.UserRoles),
       headers: headers, body: jsonEncode(body));

   return AccessRoleModel.fromJson(jsonDecode(response.body));
 }
 Future<GetExpensisModel> GetexpenseList(context) async {
   var headers = {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
     //  'Authorization': 'Bearer ${sp.getString(SpUtil.TOKEN)}',
   };
   final response = await http.get(
     Uri.parse(BASE_URL + APIConfigs.ExpenseList),
     headers: headers,
   );
   print('tripList');
   print(response.body);
   return GetExpensisModel.fromJson(jsonDecode(response.body));
 }
 Future<ExpensisLatLngtModel> getlatlongAPI(body,context) async {
   var headers = {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
     //  'Authorization': 'Bearer ${sp.getString(SpUtil.TOKEN)}',
   };
   final response = await http.post(
       Uri.parse(BASE_URL + APIConfigs.GetLatlong),
       headers: headers,body: jsonEncode(body));
   print('lat long list');
   print(response.body);

   return ExpensisLatLngtModel.fromJson(jsonDecode(response.body));
 }

 Future<EditexpenseModel> EditexpenseList(body, context) async {
   var headers = {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
     //  'Authorization': 'Bearer ${sp.getString(SpUtil.TOKEN)}',
   };
   final response = await http.post(
     Uri.parse(BASE_URL + APIConfigs.Editexpensis),
     headers: headers,body: jsonEncode(body)
   );
   print('EditexpenseList');
   print(response.body);
   return EditexpenseModel.fromJson(jsonDecode(response.body));
 }
 Future<UserListModel>UsersList(body, context) async {
   var headers = {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
     //  'Authorization': 'Bearer ${sp.getString(SpUtil.TOKEN)}',
   };
   final response = await http.post(
     Uri.parse(BASE_URL + APIConfigs.Userlist),
     headers: headers,body: jsonEncode(body)
   );
   print('UserList');
   print(response.body);
   return UserListModel.fromJson(jsonDecode(response.body));
 }
 Future<TripListModel> TripList(body,context) async {
   var headers = {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
     //  'Authorization': 'Bearer ${sp.getString(SpUtil.TOKEN)}',
   };
   final response = await http.post(
       Uri.parse(BASE_URL + APIConfigs.TripList),
       headers: headers,body: jsonEncode(body));
   print('get trip details');
   print(response.body);
   //return response;
   return TripListModel.fromJson(jsonDecode(response.body));
 }
 Future<CategoryModel> TripCategoryList(body,context) async {
   var headers = {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
     //  'Authorization': 'Bearer ${sp.getString(SpUtil.TOKEN)}',
   };
   final response = await http.post(
       Uri.parse(BASE_URL + APIConfigs.ExpenseCategory),
       headers: headers,body: jsonEncode(body));
   print('get category details');
   print(response.body);
   //return response;
   return CategoryModel.fromJson(jsonDecode(response.body));
 }

 Future<CurrencyModel> Currencylist(context) async {
   var headers = {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
     //  'Authorization': 'Bearer ${sp.getString(SpUtil.TOKEN)}',
   };
   final response = await http.get(
     Uri.parse(BASE_URL + APIConfigs.CurrencyList),
     headers: headers,
   );
   print('countryList');
   print(response.body);

   return CurrencyModel.fromJson(jsonDecode(response.body));
 }
 Future<TotalexpenseModel> TotalexpenseList(body,context) async {
   var headers = {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
     //  'Authorization': 'Bearer ${sp.getString(SpUtil.TOKEN)}',
   };
   final response = await http.post(
       Uri.parse(BASE_URL + APIConfigs.TotalExpensisList),
       headers: headers,body: jsonEncode(body));
   print('get trip details');
   print(response.body);
   //return response;
   return TotalexpenseModel.fromJson(jsonDecode(response.body));
 }
 Future<AppendListModel> AppendList(body,context) async {
   var headers = {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
     //  'Authorization': 'Bearer ${sp.getString(SpUtil.TOKEN)}',
   };
   final response = await http.post(
       Uri.parse(BASE_URL + APIConfigs.AppendList),
       headers: headers,body: jsonEncode(body));
   print('get trip details');
   print(response.body);
   //return response;
   return AppendListModel.fromJson(jsonDecode(response.body));
 }

 Future<ExpenseStatusModel> ExpenseStatusAPI(body,context) async {
   var headers = {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
     //  'Authorization': 'Bearer ${sp.getString(SpUtil.TOKEN)}',
   };
   final response = await http.post(
       Uri.parse(BASE_URL + APIConfigs.ExpensisStatusList),
       headers: headers,body: jsonEncode(body));
   print('ExpenseStatusAPI');
   print(response.body);
   //return response;
   return ExpenseStatusModel.fromJson(jsonDecode(response.body));
 }
 Future<ExpenseStaticsModel> ExpenseStaticsAPI(body,context) async {
   var headers = {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
     //  'Authorization': 'Bearer ${sp.getString(SpUtil.TOKEN)}',
   };
   final response = await http.post(
       Uri.parse(BASE_URL + APIConfigs.ExpensisStaticsList),
       headers: headers,body: jsonEncode(body));
   print('ExpenseStaticsAPI');
   print(response.body);
   //return response;
   return ExpenseStaticsModel.fromJson(jsonDecode(response.body));
 }

 Future<http.Response> forgetPassword(body, context) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Accept-Language': 'en',
    };
    final response = await http.post(Uri.parse(BASE_URL + APIConfigs.ForgetPassword),
        headers: headers, body: jsonEncode(body));
    return response;
  }
 Future<http.Response> addExpensis(body, context) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
     // 'Accept-Language': 'en',
    };
    final response = await http.post(Uri.parse(BASE_URL + APIConfigs.AddExpense),
        headers: headers, body: jsonEncode(body));
    return response;
  }
Future<http.Response> updateExpensis(body, context) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
     // 'Accept-Language': 'en',
    };
    final response = await http.post(Uri.parse(BASE_URL + APIConfigs.UpdateExpense),
        headers: headers, body: jsonEncode(body));
    return response;
  }



 Future<http.Response> createTrip(body, context) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      //'Accept-Language': 'en',
    };
    final response = await http.post(Uri.parse(BASE_URL + APIConfigs.CreateTrip),
        headers: headers, body: jsonEncode(body));
    return response;
  }
 Future<http.Response> createUser(body, context) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      //'Accept-Language': 'en',
    };
    final response = await http.post(Uri.parse(BASE_URL + APIConfigs.CreateUser),
        headers: headers, body: jsonEncode(body));
    return response;
  }
 Future<http.Response> UpdateUser(body, context) async {
   var headers = {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
     //'Accept-Language': 'en',
   };
   final response = await http.post(Uri.parse(BASE_URL + APIConfigs.UpdateUser),
       headers: headers, body: jsonEncode(body));
   return response;
 }

  Future<http.Response> signUP(body, context) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Accept-Language': 'en',
    };
    final response = await http.post(Uri.parse(BASE_URL + APIConfigs.SignUp),
        headers: headers, body: jsonEncode(body));

   // return RegisterModel.fromJson(jsonDecode(response.body));
    return response;
  }

 Future<http.Response> coupon(body, context) async {
   var headers = {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
     'Accept-Language': 'en',
   };
   final response = await http.post(Uri.parse(BASE_URL + APIConfigs.checkCoupon),
       headers: headers, body: jsonEncode(body));

   // return RegisterModel.fromJson(jsonDecode(response.body));
   return response;
 }

 Future<http.Response> createTeam(body, context) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      'Accept-Language': 'en',
    };
    final response = await http.post(Uri.parse(BASE_URL + APIConfigs.teamCreate),
        headers: headers,
    body: jsonEncode(body));
   // return RegisterModel.fromJson(jsonDecode(response.body));
    print('create team');
    print(response.body);

    return response;
  }
Future<http.Response> updateTrip(body, context) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      //'Accept-Language': 'en',
    };
    final response = await http.post(Uri.parse(BASE_URL + APIConfigs.UpdateTrip),
        headers: headers,
    body: jsonEncode(body));
   // return RegisterModel.fromJson(jsonDecode(response.body));
    print('update trip ');
    print(response.body);

    return response;
  }
Future<TripListModel>EditTripDetails(body, context) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      //'Accept-Language': 'en',
    };
    final response = await http.post(Uri.parse(BASE_URL + APIConfigs.EditTripDetails),
        headers: headers,
        body: jsonEncode(body));

    print('update trip ');
    print(response.body);
    return TripListModel.fromJson(jsonDecode(response.body));
    //return response;
  }
Future<UserListModel>EditUserDetails(body, context) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
      //'Accept-Language': 'en',
    };
    final response = await http.post(Uri.parse(BASE_URL + APIConfigs.EditUserDetails),
        headers: headers,
        body: jsonEncode(body));

    print('update trip ');
    print(response.body);
    return UserListModel.fromJson(jsonDecode(response.body));
    //return response;
  }

 Future<http.Response> RejectedAPI(body, context) async {
   print("response body===================>     $body");
   var headers = {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
   };
   final response = await http.post(
     Uri.parse(BASE_URL + APIConfigs.ExpenseRejected),
     headers: headers,
     body: jsonEncode(body),
   );
   print(response.body);

   return response;
   // return LoginModel.fromJson(jsonDecode(response.body));
 }
 Future<http.Response> ApprovedAPI(body, context) async {
   print("response body===================>     $body");

   var headers = {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
   };
   final response = await http.post(
     Uri.parse(BASE_URL + APIConfigs.ExpenseApproved),
     headers: headers,
     body: jsonEncode(body),
   );
   print(response.body);

   return response;
   // return LoginModel.fromJson(jsonDecode(response.body));
 }

 Future<http.Response> UserDelete(body, context) async {
   print("response body===================>     $body");

   var headers = {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
   };
   final response = await http.post(
     Uri.parse(BASE_URL + APIConfigs.TeamDelete),
     headers: headers,
     body: jsonEncode(body),
   );
   print(response.body);

   return response;
   // return LoginModel.fromJson(jsonDecode(response.body));
 }
 Future<http.Response> TeamDelete(body, context) async {
   print("response body===================>     $body");

   var headers = {
     'Content-Type': 'application/json',
     'Accept': 'application/json',
   };
   final response = await http.post(
     Uri.parse(BASE_URL + APIConfigs.TeamDelete),
     headers: headers,
     body: jsonEncode(body),
   );
   print(response.body);

   return response;
   // return LoginModel.fromJson(jsonDecode(response.body));
 }

 static bool returnResponse(String statusCode) {
   if (statusCode == "success") {
     return true;
   } else {
     return false;
   }
   // if (statusCode >= 200 && statusCode <= 299) {
   //   return true;
   // } else if (statusCode >= 400 && statusCode <= 499) {
   //   return false;
   // } else if (statusCode >= 500 && statusCode <= 599) {
   //   return false;
   // } else {
   //   return false;
   // }
 }

  /// *================================= Check OTP API ===========================================* ///
  Future<http.Response> resetPassword(body, context) async {
    var headers = {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    };
    final response = await http.post(
      Uri.parse(BASE_URL + APIConfigs.ResetPassword),
      headers: headers,
      body: jsonEncode(body),
    );

    return response;
  }

  sendFCMFlutter() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization':
      'key=AAAAe8zb_lU:APA91bEOx1fN2LxBRiKe4Tgf788V396TAlpf5uFEddtpk0x4MAj0aQv8J8NtVhPEetcfj14ROniOykm9PIRtvfYIOSJWdrGc2m9EaJyRHwM1SztC5gTEYaAqLYhJPvSId1aVjN8GRAMp',
    };
    var body = {
      "notification":{
        "click_action":"FLUTTER_NOTIFICATION_CLICK",
        "body":"messageBody",
        "title":"messageTitle",
        "sound":"default"
      },
      "priority":"high",
      "data":{
        "click_action":"FLUTTER_NOTIFICATION_CLICK",
        "id":"1",
        "status":"done",
        "type":"messagetype1",
        "typeId":"messagetypeId:1"
      },
      "to":"fB8fLhIdRRi68B_H7SUH9y:APA91bH2BPBBxse94NByemraWlEEq-J_0FvR9RKYPmZY4FPEVN8JfCKSQ7y9uQ72zxcNWkBZ8HyIh_e_qq9JfdGfM5xFFmJBrV19An9sj3-zUXKnrOOJ4Lynkm7KKjCUOHp5RJIK7bJ2"
    };

    final response = await http.post(
      Uri.parse('https://fcm.googleapis.com/fcm/send'),
      headers: headers,
      body: jsonEncode(body),
    );
    print(body);
    print(headers);
    print(response.body);
  }
  

}
