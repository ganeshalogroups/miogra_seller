// ignore_for_file: unnecessary_string_interpolations, avoid_print

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';

import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/UrlList/api.dart';

class ProductCategoryController extends GetxController{
 String userToken = getStorage.read("usertoken") ?? '';
  // String userId = getStorage.read("UserId") ?? '';

  var dataLoading = false.obs;
  var productCategory = <dynamic>[].obs; // Keep as an observable list

  @override
  void onInit() {
    super.onInit();
    getProductCategory();
  }

  Future<void> getProductCategory() async {
  print('Fetching product category data...');
  try {
    dataLoading.value = true;
    final response = await http.get(
      Uri.parse("${API.productCategoryapi}"),
      headers: {
        'Authorization': 'Bearer $userToken',
        'Content-Type': 'application/json',
        'userId': userId,
      },
    );

    print('Product category response status: ${response.statusCode}');
    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);

      // Check if data is a non-empty list containing '_id' in each item
      if (responseBody['data'] is List && responseBody['data'].isNotEmpty) {
        var data = responseBody['data'];
        if (data[0] is Map && data[0].containsKey('_id')) {
          productCategory.value = data;
          prodCatId=data[0]['_id'];
          print("prod id........$prodCatId");
          print("Product categories loaded successfully.");
        } else {
          print("Error: '_id' key not found in product category items.");
          productCategory.clear();
        }
      } else {
        print("Error: 'data' is not a valid list or is empty.");
        productCategory.clear();
      }
    } else {
      print("Error: API returned status ${response.statusCode}");
    }
  } catch (e) {
    print("Error: $e");
  } finally {
    dataLoading.value = false;
  }
}


 
}