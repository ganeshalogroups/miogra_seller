import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';
import 'package:miogra_seller/Constants/const_variables.dart';

import 'package:miogra_seller/UrlList/api.dart';

// class OrderStatusController extends GetxController {
//   String userToken = getStorage.read("usertoken");
//   String userID = getStorage.read("userId");

class OrderStatusController extends GetxController {
  String userToken = getStorage.read("usertoken") ?? "";
  String userID = getStorage.read("userId") ?? "";


  var isOrderUpdateLoading = false.obs;
  dynamic orderUpdateData;

  // Future<void> updateOrderStatus(
  //     {context, dynamic rejectedNote, dynamic resid, id, orderStatus}) async {
  //   isOrderUpdateLoading(true);

  //   try {
  //     // Construct request body conditionally
  //     Map<String, dynamic> requestBody;
  //     if (orderStatus == "rejected") {
  //       requestBody = {
  //         "orderStatus": "rejected",
  //         "id": id,
  //         "rejectedNote": rejectedNote ?? '',
  //         "rejectedById": resid ?? '',
  //         "rejectedType": 'subadminuserslists',
  //       };
  //     } else {
  //       requestBody = {
  //         "_id": id,
  //         "orderStatus": orderStatus,
  //       };
  //     }

  //     final response = await http.put(
  //       Uri.parse('${API.orderStatusApi}$id'),
  //       headers: {
  //         'Content-Type': 'application/json',
  //         'Authorization': 'Bearer $userToken',
  //         'userid': userID,
  //       },
  //       body: jsonEncode(requestBody),
  //     );
  //     print('id:$id');
  //     print('orderstatus: $orderStatus');
  //     print('api....${API.orderStatusApi}$id');
  //     print('response status: ${response.statusCode}');

  //     if (response.statusCode == 200) {
  //       var result = jsonDecode(response.body);
  //       orderUpdateData = result;
  //       if (orderStatus == "rejected") {
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => RestaurentBottomNavigation(
  //                     initialIndex: 0, initialTabInOrders: 2)));
  //       } else {
  //         Navigator.push(
  //             context,
  //             MaterialPageRoute(
  //                 builder: (context) => RestaurentBottomNavigation(
  //                     initialIndex: 0, initialTabInOrders: 1)));
  //       }
  //     } else {
  //       var result = jsonDecode(response.body);
  //       print("response after :${response.body}");
  //       orderUpdateData = null;
  //     }
  //   } catch (e) {
  //     orderUpdateData = null;
  //     print('error in $e');
  //   } finally {
  //     isOrderUpdateLoading(false);
  //   }
  // }
Future<bool> updateOrderStatus({
  required BuildContext context,
  required String orderStatus,
  required String id,
  String? resid,
  String? rejectedNote,
}) async {
  isOrderUpdateLoading(true);

  try {
    Map<String, dynamic> requestBody = (orderStatus == "rejected")
        ? {
            "orderStatus": "rejected",
            "id": id,
            "rejectedNote": rejectedNote ?? '',
            "rejectedById": resid ?? '',
            "rejectedType": 'subadminuserslists',
          }
        : {
            "_id": id,
            "orderStatus": orderStatus,
          };

    final response = await http.put(
      Uri.parse('${API.orderStatusApi}$id'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $userToken',
        'userid': userID,
      },
      body: jsonEncode(requestBody),
    );

    final responseBody = jsonDecode(response.body);

    if (response.statusCode == 200 && responseBody['status'] == true) {
      orderUpdateData = responseBody['data'];
      return true;
    } else {
      orderUpdateData = null;
      final message = responseBody['message'] ?? 'Something went wrong';
      Get.snackbar('Error', message,
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.redAccent,
          colorText: Colors.white);
      return false;
    }
  } catch (e) {
    orderUpdateData = null;
    Get.snackbar('Error', 'Failed to update order. Please try again.',
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.redAccent,
        colorText: Colors.white);
    return false;
  } finally {
    isOrderUpdateLoading(false);
  }
}

  ///For Order Dialog
  var isOrderUpdatedialogLoading = false.obs;
  dynamic orderUpdateDatadialog;

  Future<void> updateOrderStatusdialog(
      {context, dynamic rejectedNote, dynamic resid, id, orderStatus}) async {
    isOrderUpdatedialogLoading(false);

    try {
      // Construct request body conditionally
      Map<String, dynamic> requestBody;
      if (orderStatus == "rejected") {
        requestBody = {
          "orderStatus": "rejected",
          "id": id,
          "rejectedNote": rejectedNote ?? '',
          "rejectedById": resid ?? '',
          "rejectedType": 'subadminuserslists',
        };
      } else {
        requestBody = {
          "_id": id,
          "orderStatus": orderStatus,
        };
      }

      final response = await http.put(
        Uri.parse('${API.orderStatusApi}$id'),
        headers: {
          'Content-Type': 'application/json',
          'Authorization': 'Bearer $userToken',
          'userid': userID,
        },
        body: jsonEncode(requestBody),
      );
      print('id:$id');
      print('orderstatus: $orderStatus');
      print('api....${API.orderStatusApi}$id');
      print('response status: ${response.statusCode}');

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        orderUpdateDatadialog = result;
      } else {
        var result = jsonDecode(response.body);
        print("response after :${response.body}");
        orderUpdateDatadialog = null;
      }
    } catch (e) {
      orderUpdateDatadialog = null;
      print('error in $e');
    } finally {
      isOrderUpdatedialogLoading(false);
    }
  }

  dynamic orderviewget;
  var isorderviewgetloading = false.obs;

  void orderviewgetapi({orderid}) async {
    try {
      isorderviewgetloading(true);
      var response = await http.get(
        Uri.parse('${API.orderStatusApi}$orderid'),
        headers: API().headers,
      );

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        print('orderbyid:${API.orderStatusApi}$orderid');
        var result = jsonDecode(response.body);
        orderviewget = result;
      } else {
        orderviewget = null;
      }
    } catch (e) {
      print("${e.toString()}error in orderviewgetapi");
    } finally {
      isorderviewgetloading(false);
    }
  }
}
