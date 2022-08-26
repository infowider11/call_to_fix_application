import 'dart:convert' as convert;
import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../functions/showSnackbar.dart';
import 'api_urls.dart';

class Webservices {
  static Future<http.Response> getData(String url) async {
    http.Response response =
    http.Response('{"message":"failure","status":0}', 404);
    log('called $url');
    try {
      response = await http.get(
        Uri.parse(url),
      );
      if(response.statusCode!=200){
        print('The response status for url $url is ${response.statusCode}');
      }
      log(response.body);
    } catch (e) {
      // showSnackbar(context, text)
      log('Error in $url : ------ $e');
    }
    return response;
  }

  static Future<Map<String, dynamic>> postData(
      {required String apiUrl,
        required Map body,
        bool showSuccessMessage = false,
        required BuildContext context}) async {
    http.Response response =
    http.Response('{"message":"failure","status":0}', 404);
    try {
      log('the request for $apiUrl is $body');
      print('eee');
      response = await http.post(Uri.parse(apiUrl), body: body);
      print('the response ${response.statusCode} of ${response.body}');
      if (response.statusCode == 200) {
        print('dkfhsk');
        var jsonResponse = convert.jsonDecode(response.body);
        print('sdfsdfsd');
        log('the response for $apiUrl is $jsonResponse');
        if (jsonResponse['status'] == 1) {
          if(showSuccessMessage)
            showSnackbar(jsonResponse['message'].toString());
          return jsonResponse;
        } else {
          showSnackbar( jsonResponse['message'].toString());
        }
        return jsonResponse;
      }
      else{
        log('The response for $apiUrl is ${response.statusCode} and ${response.body}');
        showSnackbar('Some Error occured. Please try again later');
      }
    } catch (e) {
      log('Error in $apiUrl : ------ $e');
    }
    return {"status": 0, "message": "Please try again later."};
  }

  // static Future<http.Response> postMultipartData({required String url, required Map<String, dynamic> request})async{
  //   http.Response response = http.Response('{"message":"failure","status":0}', 404);
  //   try{
  //     log('the request for $url is $request');
  //     response = await http.post(
  //         Uri.parse(url),
  //         body: request
  //     );
  //   }
  //   catch(e){
  //     log('Error in $url : ------ $e');
  //   }
  //   return response;
  // }


  static Future<Map<String, dynamic>> getMap(String url, {Map<String, dynamic>? request}) async {

    Map<String, dynamic> tempRequest = {};
    if(request!=null){
      request.forEach((key, value) {
        if(value!=null){
          tempRequest['$key'] = value;
        }
      });
    }
    try{
      log('the request for url $url is $tempRequest');
      late http.Response response;
      if(request==null){
        response = await http.get(Uri.parse(url));
      }else{
        response = await http.post(Uri.parse(url), body: tempRequest);
      }
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse['status'].toString() == '1') {
          log('the respognse for url: $url is ${jsonResponse}');
          return jsonResponse['data'] ?? jsonResponse['content']??jsonResponse;
        } else {
          log('Error in response for url $url -----${response.body}');
        }
      }else{
        print('error in status code ${response.statusCode}');
        log(response.body);
      }
    }catch(e){
      print('inside catch block 546745 $e');
    }

    return {};
  }

  static Future<List> getList(String url) async {
    var response = await getData(url);
    if (response.statusCode == 200) {
      var jsonResponse = convert.jsonDecode(response.body);
      if (jsonResponse['status'] == 1) {
        log('the response for url: $url is ${jsonResponse}');
        return jsonResponse['data']??[];
      } else {
        log('Error in response for url $url -----${response.body}');
      }
    }
    return [];
  }
  static Future<List> getListFromRequestParameters(String url, Map<String, dynamic> request) async {

    Map<String, dynamic> tempRequest = {};
    request.forEach((key, value) {
      if(value!=null){
        tempRequest['$key'] = value;
      }
    });
    try{
      log('the request for url $url is $tempRequest');
      var response = await http.post(Uri.parse(url), body: tempRequest);
      if (response.statusCode == 200) {
        var jsonResponse = convert.jsonDecode(response.body);
        if (jsonResponse['status'] == 1) {
          log('the respognse for url: $url is ${jsonResponse}');
          try{
            print('the length is ${jsonResponse['data'].length}');
          }catch(e){
            print('Error in catch block coud not read length 32 $e');
          }
          return jsonResponse['data'] ?? [];
        } else {
          log('Error in response getlistfromrequest for url $url -----${response.body}');
        }
      }else{
        print('error in status code ${response.statusCode} for url ${url} and request $request');
        log(response.body);
      }
    }catch(e){
      print('inside catch block. 564 $e');
    }

    return [];
  }


  static Future<Map<String, dynamic>> postDataWithImageFunction({
    required Map<String, dynamic> body,
    required Map<String, dynamic> files,
    required BuildContext context,

    /// endpoint of the api
    required String apiUrl,
    bool successAlert = false,
    bool errorAlert = true,
  }) async {
    print('the request is $body');
    var url = Uri.parse(apiUrl);
    //
    log(apiUrl);
    try {
      var request = new http.MultipartRequest("POST", url);
      body.forEach((key, value) {
        request.fields[key] = value;
        // log(value2);
      });

      if (files != null) {
        (files as Map<dynamic, dynamic>).forEach((key, value) async {
          request.files.add(await http.MultipartFile.fromPath(key, value.path));
        });
      }


      log(request.fields.toString());
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);
      log(response.body);
      var jsonResponse = convert.jsonDecode(response.body);

      if (jsonResponse['status'] == 1) {
        if (successAlert) {
          showSnackbar(jsonResponse['message']);
        }
      } else {
        if (errorAlert) {
          showSnackbar(jsonResponse['message']);
        }
      }
      return jsonResponse;
      // return response;
    } catch (e) {
      print(e);
      try{
        var response = await http.post(
            url,
            body: body
        );
        if(response.statusCode==200){
          var jsonResponse = convert.jsonDecode(response.body);
          return jsonResponse;
        }
      }catch(error){
        print('inside double catch block $error');
      }
      return {'status': 0, 'message': "fail"};
      // return null;
    }
  }



  // static Future<void> updateDeviceToken({
  //   required String userId,
  //   required String token,
  // }) async {
  //   var request = {
  //     "user_id": userId,
  //     "device_id": token,
  //   };
  //   print('the device token request for url ${ApiUrls.updateDeviceToken} is $request');
  //   try {
  //     var response = await http.post(
  //       Uri.parse(ApiUrls.updateDeviceToken),
  //       body: request,
  //     );
  //     if (response.statusCode == 200) {
  //       print('the device token is updated');
  //     } else {
  //
  //       print('error in device token with status code ${response.statusCode}');
  //       log(response.body);
  //     }
  //   } catch (e) {
  //     print('error in device token:  $e');
  //   }
  // }
  static Future<void> updateDeviceToken({
    required String userId,
    required String token,
  }) async {
    var request = {
      "user_id": userId,
      "device_id": token,
    };
    print('the device token request for url ${ApiUrls.updateDeviceToken} is $request');
    try {
      var response = await http.post(
        Uri.parse(ApiUrls.updateDeviceToken),
        body: request,
      );
      if (response.statusCode == 200) {
        print('the device token is updated');
      } else {

        print('error in device token with status code ${response.statusCode}');
        log(response.body);
      }
    } catch (e) {
      print('error in device token:  $e');
    }
  }

}
