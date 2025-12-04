// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/Screens/Home/bottomnavigation.dart';
import 'package:miogra_seller/UrlList/api.dart';

class CategoryController extends GetxController {
  String usertokenn = getStorage.read("usertoken") ?? '';

  var isCategoryCreateLoading = false.obs;
  dynamic categoryCreateData;

  void categoryCreate(
      {dynamic productTypeToFilter,
        dynamic foodCategoryName,
      dynamic foodCategoryImage,
      dynamic thumbUrl,
      dynamic mediumUrl,
      dynamic productCateId}) async {
    try {
      isCategoryCreateLoading(true);
      var response = await http.post(
        Uri.parse(API.categoryCreateApi),
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $usertokenn',
          'userId': userId,
        },
        body: jsonEncode(<String, dynamic>{
          "productTypeToFilter":productTypeToFilter,
          "foodCateName": foodCategoryName,
          "mediumImgUrl": mediumUrl,
          "thumbImgUrl": thumbUrl,
          "foodCateImage": foodCategoryImage,
          "productCateId": productCateId,
          "restaurantId": userId,
          "status": true,
        }),
      );
print( "productTypeToFilter:$productTypeToFilter,");
print("ABABABA");
 print('Category Response   ${response.body}');
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);


      
        categoryCreateData = result;
        Get.offAll(() => RestaurentBottomNavigation(
              initialIndex: 1,
            ));
      } else {
        categoryCreateData = null;
      }
    } catch (e) {
      // print('$error');
    } finally {
      isCategoryCreateLoading(false);
    }
  }

  var isCategoryupdateLoading = false.obs;
  dynamic categoryupdateData;

  void categoryUpdate({
    dynamic productTypeToFilter,
    dynamic thumbUrl,
    dynamic mediumUrl,
    dynamic foodCategoryName,
    dynamic foodCategoryImage,
    dynamic foodcateid,
    dynamic restaurantId,
  }) async {
    try {
      isCategoryupdateLoading(true);
      var response = await http.post(
        Uri.parse(API.categoryUpdateApi),
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $usertokenn',
          'userId': userId,
        },
        body: jsonEncode(<String, dynamic>{
          "productTypeToFilter":productTypeToFilter,
          "foodCateName": foodCategoryName,
          "mediumImgUrl": mediumUrl,
          "thumbImgUrl": thumbUrl,
          "foodCateImage": foodCategoryImage,
          "foodCateId": foodcateid,
          "restaurantId": restaurantId,
        }),
      );

      print('category update response${response.body}');
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);
        categoryupdateData = result;
        Get.offAll(() => RestaurentBottomNavigation(
              initialIndex: 1,
            ));
      } else {
        categoryupdateData = null;
      }
    } catch (e) {
      // print('$error');
    } finally {
      isCategoryupdateLoading(false);
    }
  }
}
