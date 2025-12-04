// // ignore_for_file: avoid_print

// import 'package:http/http.dart' as http;
// import 'package:get/get.dart';
// import 'dart:convert';
// import 'package:miogra_seller/Constants/const_variables.dart';
// import 'package:miogra_seller/UrlList/api.dart';

// class PreparingController extends GetxController {
//   String userToken = getStorage.read("usertoken") ?? '';

//   var dataLoading = false.obs;
//   var preparing = <dynamic>[].obs; // Keep as an observable list

//   @override
//   void onInit() {
//     super.onInit();
//     getNewOrders();
//   }

//   Future<void> getNewOrders() async {
//     print('Fetching Preparing data...');
//     try {
//       dataLoading.value = true;
//       final response = await http.get(
//         Uri.parse("${API.newOrdersGet}$userId&orderStatus=new"),
//         headers: {
//           'Authorization': 'Bearer $userToken',
//           'Content-Type': 'application/json',
//           'userId': userId,
//         },
//       );

//       print('Preparing response status: ${response.statusCode}');
//       if (response.statusCode == 200) {
//         var result = jsonDecode(response.body);

//         // Correctly access the nested "data" field
//         if (result['data'] != null && result['data']['data'] is List) {
//           preparing.value = result['data']['data'];
//         } else {
//           preparing.value = [];
//         }
//       } else {
//         preparing.value = [];
//         throw Exception('Failed to load Preparing');
//       }
//     } catch (e) {
//       print('Error fetching Preparing: $e');
//     } finally {
//       dataLoading.value = false;
//     }
//   }
// }
