// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/UrlList/api.dart';

class NewOrdersGetController extends GetxController {
  String userToken = getStorage.read("usertoken") ?? '';
  // String userId = getStorage.read("UserId") ?? '';

  var dataLoading = false.obs;
  var newOrders = <dynamic>[].obs; // Keep as an observable list

  @override
  void onInit() {
    super.onInit();
    getNewOrders();
  }

  Future<void> getNewOrders() async {
    print('Fetching product category data...');
    try {
      dataLoading.value = true;
      final response = await http.get(
        Uri.parse("${API.newOrdersGet}$userId&orderStatus=initiated"),
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
          'userId': userId,
        },
      );

      print('Product category response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        // Correctly access the nested "data" field
        if (result['data'] != null && result['data']['data'] is List) {
          newOrders.value = result['data']['data'];
        } else {
          newOrders.value = [];
        }
      } else {
        newOrders.value = [];
        throw Exception('Failed to load New Trips by id');
      }
    } catch (e) {
      print('Error fetching new orders: $e');
    } finally {
      dataLoading.value = false;
    }
  }
}
