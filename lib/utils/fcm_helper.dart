import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:http/http.dart' as http;

class FCMHelper {
  FCMHelper._();

  static final FCMHelper fcmHelper = FCMHelper._();

  static final FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  Future<String?> fetchFCMToken() async {
    String? token = await firebaseMessaging.getToken();
    print("===============");
    print(token);
    print("===============");
    return token;
  }

  Future<void>subScribe({required String topic})async{
    await firebaseMessaging.subscribeToTopic(topic);
  }

  Future<void>unSubScribe({required String topic})async{
    await firebaseMessaging.unsubscribeFromTopic(topic);
  }

  sendFcmByApi() async {
    String api = "https://fcm.googleapis.com/fcm/send";

    Map<String, String> myHeaders = {
      "Content-Type": "application/json",
      "Authorization":
          "key=AAAACZs2GLw:APA91bGOrPugOxUa0FjEdRMbS6OZSeaNUY5Mv4BWUbegu2fbExJVhb3vA3BGHI_Lq0eKGjzvxs28VllvQxtqwbJ-zjA5pPWzSBTAZp0saaV9h3F5yM8EIBPkClRjMui48pDJzqDKu2Ze"
    };

    Map<String, dynamic> mybody = {
      // "to":
      //     "dERzTBKJT7mn2FHQRNC5IR:APA91bF8hyeNciVgCLctk96khp85zbMZOFovUKb7O_dv6rj3xdeeGSc34w6VPNef8-9CbqVME6WrVuOxdofQ69FJDn4bhROFb2lbN7xBn7aG78g5n9PdjYrAblbLYYAxlyLh9joTBFCU",

      "to":"/topics/sport",
      "notification": {
        "title": "Check this Mobile (title)",
        "body": "Rich Notification testing (body)",
      },
      "data": {
        "name": "vivek baraiya",
        "age": 22,
        "clg":"Jz shah",
      }
    };

    http.Response res = await http.post(Uri.parse(api),headers: myHeaders,body: jsonEncode(mybody));


    print("================");
    print(mybody);
    print(myHeaders);
    print("================");
    print("================");
    print(res.statusCode);
    print("================");

    if(res.statusCode == 200){

    }else{
      print("================");
      print(res.statusCode);
      print("================");
    }
  }
}
