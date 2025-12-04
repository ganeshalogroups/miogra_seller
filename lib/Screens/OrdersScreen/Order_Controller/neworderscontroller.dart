// ignore_for_file: file_names, avoid_print

import 'dart:convert';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/UrlList/api.dart';
import 'package:http/http.dart' as http;

// class NewordersController extends GetxController {
//   final PagingController<int, dynamic> neworderpagingcontroller = PagingController(firstPageKey: 0);
//   static const int perPage = 6;


//   @override
//   void onInit() {
//     super.onInit();
//     neworderpagingcontroller.addPageRequestListener((pageKey) {
//       fetchResPage(pageKey);
//     });
//   }


//   @override
//   void onReady() {
//     super.onReady();
//     // Reset the paging controller when the screen is ready to avoid duplicates
//     neworderpagingcontroller.refresh();
//   }

//   Future<void> fetchResPage(int pageKey) async {
//     try {
//       await newordersget(pageKey,API.ordersApi, neworderpagingcontroller);
//     } catch (e) {
//       neworderpagingcontroller.error = 'Error: $e';
//     }
//   }


  

// Future<void> newordersget(int pageKey, String apiUrl, PagingController<int, dynamic> pagingController) async {


//   try {
//     var response = await http.get(
//       Uri.parse('${API.ordersApi}limit=$perPage&offset=$pageKey&subAdminId=$userId&orderStatus=initiated'),
//       headers: API().headers,
//     );


//     if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {

//       print('neworders:${API.ordersApi}limit=$perPage&offset=$pageKey&subAdminId=$userId&orderStatus=initiated');
//       final result     = jsonDecode(response.body);
//       final newItems   = result["data"]["data"];
//       final isLastPage = newItems.length < perPage;


//       // Get IDs of existing items
//       final existingItems = pagingController.itemList ?? [];
//       final existingItemIds = existingItems.map((item) => item["_id"]).toSet();

//       // Filter out new items that are already in the existing list
//       final filteredNewItems = newItems.where((item) => !existingItemIds.contains(item["_id"])).toList();

//       if (isLastPage) {
//         pagingController.appendLastPage(filteredNewItems);
//       } else {
//         final nextPageKey = pageKey + 1;
//         pagingController.appendPage(filteredNewItems, nextPageKey);
//       }
//     } else {
//       pagingController.error = 'Unexpected error: ${response.statusCode}';

//     }
//   } catch (e) {
//     pagingController.error = 'Error: $e';
//   }
// }



//   @override
//   void onClose() {
//     neworderpagingcontroller.dispose();
//     super.onClose();
//   }


// }

class NewordersController extends GetxController {
  final PagingController<int, dynamic> neworderpagingcontroller = PagingController(firstPageKey: 0);
  static const int perPage = 6;

  /// Persistent store for shown order IDs
  final Set<String> shownOrderIds = {};

  @override
  void onInit() {
    super.onInit();
    neworderpagingcontroller.addPageRequestListener((pageKey) {
      fetchResPage(pageKey);
    });
  }

  @override
  void onReady() {
    super.onReady();
    neworderpagingcontroller.refresh();
  }

  Future<void> fetchResPage(int pageKey) async {
    try {
      await newordersget(pageKey, API.ordersApi, neworderpagingcontroller);
    } catch (e) {
      neworderpagingcontroller.error = 'Error: $e';
    }
  }

  Future<void> newordersget(int pageKey, String apiUrl, PagingController<int, dynamic> pagingController) async {
    try {
      var response = await http.get(
        Uri.parse('${API.ordersApi}limit=$perPage&offset=$pageKey&subAdminId=$userId&orderStatus=initiated'),
        headers: API().headers,
      );

      if (response.statusCode == 200 || response.statusCode == 201 || response.statusCode == 202) {
        print('neworders: ${API.ordersApi}limit=$perPage&offset=$pageKey&subAdminId=$userId&orderStatus=initiated');

        final result = jsonDecode(response.body);
        final newItems = result["data"]["data"];
        final isLastPage = newItems.length < perPage;

        final existingItems = pagingController.itemList ?? [];
        final existingItemIds = existingItems.map((item) => item["_id"]).toSet();
        final filteredNewItems = newItems.where((item) => !existingItemIds.contains(item["_id"])).toList();

        if (isLastPage) {
          pagingController.appendLastPage(filteredNewItems);
        } else {
          final nextPageKey = pageKey + 1;
          pagingController.appendPage(filteredNewItems, nextPageKey);
        }
      } else {
        pagingController.error = 'Unexpected error: ${response.statusCode}';
      }
    } catch (e) {
      pagingController.error = 'Error: $e';
    }
  }

  void clearShownOrders() {
    shownOrderIds.clear();
  }

  @override
  void onClose() {
    neworderpagingcontroller.dispose();
    super.onClose();
  }
}
