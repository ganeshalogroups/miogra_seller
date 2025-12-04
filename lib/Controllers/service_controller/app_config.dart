// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:miogra_seller/UrlList/api.dart';

class AppConfigController extends GetxController {
  var isLoading = false.obs;
  dynamic redirectLoadingDetails;

  getredirectDetails() async {
    try {
      isLoading(true);
      var response = await http.get(
        Uri.parse(API.appConfigUrl),
        headers: API().headers,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        redirectLoadingDetails = result;
        debugPrint("get redirect link status ${response.body}");
      } else {
        print(
            "failed---------------------------------------------------------------");
        redirectLoadingDetails = null;
      }
    } catch (e) {
      print(
          "catch---------------------------------------------------------------");
      redirectLoadingDetails = null;
      //print(e.toString());
      return false;
    } finally {
      isLoading(false);
    }
  }
}
