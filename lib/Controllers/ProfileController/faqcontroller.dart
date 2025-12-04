// ignore_for_file: file_names

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:miogra_seller/UrlList/api.dart';

class FAQController extends GetxController {
 var isLoading = false.obs;
  dynamic faqdetails;

  getFAQ() async {
    try {
      isLoading(true);
      var response = await http.post(
        Uri.parse(API.faq),
        headers: API().headers,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        faqdetails = result;
        debugPrint("get FAQ url ${API.faq}");
      debugPrint("get FAQ status ${response.body}");
      } else {
        //  print(response.body);
        faqdetails = null;
      }
    } catch (e) {
      faqdetails = null;
      //print(e.toString());
      return false;
    } finally {
      isLoading(false);
    }
  }

}