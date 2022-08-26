import 'dart:convert';
import 'dart:developer';

import 'package:calltofix/constants/global_keys.dart';
import 'package:flutter/material.dart';

import '../pages/welcome.dart';
import '../services/api_urls.dart';
import '../services/firebase_push_notifications.dart';
import '../services/webservices.dart';
import 'global_data.dart';
import 'package:http/http.dart' as http;

updateSharedPreferences(String userId) async {
  try {
    http.Response response =
        await Webservices.getData(ApiUrls.getUserDetails + userId);
    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      sharedPreferences.setString(
          'user_data', jsonEncode(jsonResponse['data']));
      sharedPreferences.setString('id', jsonResponse['data']['id']);
      userData = jsonResponse['data'];
      String? token = await FirebasePushNotifications.getToken();
      if(token!=null){
        await Webservices.updateDeviceToken(userId: userData!['id'], token: token);
      }
      MyGlobalKeys.navigatorKey.currentState!.setState(() {});

      log('the response is');
      // showSnackbar(MyGlobalKeys.navigatorKey.currentContext!, 'Updated Successfully');
      log(response.body);
    } else {
      print('error in updating shared preference');
    }
  } catch (e) {
    print('Error in catch block  43 $e');
  }
}



logout() async {
  sharedPreferences.clear();
  userData = null;
  Navigator.popUntil(
      MyGlobalKeys.navigatorKey.currentContext!, (route) => route.isFirst);
  Navigator.pushReplacementNamed(
      MyGlobalKeys.navigatorKey.currentContext!, WelcomePage.id);
}
String timeAgo(DateTime d) {
  Duration diff = DateTime.now().difference(d);
  print('the diff is ${diff.inMilliseconds}');
  if (diff.inDays > 365)
    return "${(diff.inDays / 365).floor()} ${(diff.inDays / 365).floor() == 1 ? "year" : "years"} ago";
  if (diff.inDays > 30)
    return "${(diff.inDays / 30).floor()} ${(diff.inDays / 30).floor() == 1 ? "month" : "months"} ago";
  if (diff.inDays > 7)
    return "${(diff.inDays / 7).floor()} ${(diff.inDays / 7).floor() == 1 ? "week" : "weeks"} ago";
  if (diff.inDays > 0)
    return "${diff.inDays} ${diff.inDays == 1 ? "day" : "days"} ago";
  if (diff.inHours > 0)
    return "${diff.inHours} ${diff.inHours == 1 ? "hour" : "hours"} ago";
  if (diff.inMinutes > 0)
    return "${diff.inMinutes} ${diff.inMinutes == 1 ? "min" : "mins"} ago";
  if(diff.inSeconds>3)
    return "${diff.inSeconds} ${diff.inSeconds == 1 ? "sec" : "secs"} ago";
  if(diff.inSeconds<0){
    return 'Uploading soon';
  }
  return "just now";
}