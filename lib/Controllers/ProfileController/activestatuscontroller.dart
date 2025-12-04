// ignore_for_file: depend_on_referenced_packages, unnecessary_string_interpolations

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/UrlList/api.dart';

class ActiveStatusController extends GetxController {
  dynamic activeStatusget;

  var activeStatus = 'online'.obs;

  Future<void> updatActiveStatus(String status) async {
    String userToken = getStorage.read("usertoken") ?? '';
    try {
      var response = await http.post(Uri.parse('${API.activeStatusApi}'),
          headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $userToken',
            'userid': userId,
          },
          body: jsonEncode(<String, dynamic>{
            "subAdminId": userId,
            "activeStatus": status,
          }));
      print('Body: ${{
        "subAdminId": userId,
        "activeStatus": status,
      }}');
      print('Status api: ${API.activeStatusApi}');
      print('Active status : ${response.body}');
      if (response.statusCode >= 200 && response.statusCode <= 202) {
        var result = jsonDecode(response.body);

        // activeStatus.value = status;
      } else {}
    } catch (e) {
      debugPrint('The Error in Active Status is $e');
    }
  }





  var isstatusLoading = false.obs;
  dynamic individualstatus;

  updateindividualStatus({activestatus}) async {
      String userToken = getStorage.read("usertoken") ?? '';
    try {
      isstatusLoading(true);
      var response = await http.post(
        Uri.parse(API.individualstatus),
         headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $userToken',
            'userid': userId,
          },
          body: jsonEncode(<String, dynamic>{
            "subAdminId": userId,
            "activeStatus": activestatus,
          }));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        individualstatus = result;
        singleResStatusUpdate(activestatus: result["data"]["activeStatus"]);
        print(result["data"]["activeStatus"]);
      debugPrint("get updateindividualStatus: ${response.body}");
      } else {
        //  print(response.body);
        individualstatus = null;
      }
    } catch (e) {
      individualstatus = null;
      return false;
    } finally {
      isstatusLoading(false);
    }
  }



  var issingleresupdateLoading = false.obs;
  dynamic issingleresupdatestatus;

  singleResStatusUpdate({activestatus}) async {
      String userToken = getStorage.read("usertoken") ?? '';
    try {
      isstatusLoading(true);
      var response = await http.post(
        Uri.parse(API.singleResStatusUpdate),
         headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer $userToken',
            'userid': userId,
          },
          body: jsonEncode(<String, dynamic>{
            "subAdminId": userId,
            "activeStatus": activestatus,
          }));
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        issingleresupdatestatus = result;
        
      debugPrint("get singleResStatusUpdate status ${response.body}");
      } else {
        //  print(response.body);
        issingleresupdatestatus = null;
      }
    } catch (e) {
      issingleresupdatestatus = null;
      return false;
    } finally {
      issingleresupdateLoading(false);
    }
  }
}
