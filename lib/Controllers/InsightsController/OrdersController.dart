// // ignore_for_file: depend_on_referenced_packages

// import 'package:flutter/foundation.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:intl/intl.dart';
// import 'package:logger/logger.dart';
// import 'package:miogra_seller/Constants/const_variables.dart';
// import 'dart:convert';

// import 'package:miogra_seller/UrlList/api.dart';

// // class DashboardController extends GetxController {
// //   String userToken = getStorage.read("usertoken") ?? '';

// //   // Observables
// //   var isLoading = false.obs;
// //   var orderData = [].obs;
// //   var formattedDate = ''.obs;
// //   // API URL

// //   @override
// //   void onInit() {
// //     super.onInit();
// //     initializeDate();
// //     fetchOrderData();
// //   }

// //   void initializeDate() {
// //     DateTime now = DateTime.now();
// //     formattedDate.value = DateFormat('MM/dd/yyyy').format(now);
// //   }

// //   // // Function to update date when user selects a new date
// //   // void updateSelectedDate(DateTime selectedDate) {
// //   //   formattedDate.value = DateFormat('MM/dd/yyyy').format(selectedDate);
// //   //   fetchOrderData(); // Fetch new data based on selected date
// //   // }

// //   // void clearSelectedDate() {
// //   //   initializeDate(); // Resets to current date
// //   //   fetchOrderData(); // Refresh data
// //   // }
// //  // New range filters
// //   var fromDate = ''.obs;
// //   var toDate = ''.obs;
// //   var isRangeSelected = false.obs;

// //   void updateSelectedDate(DateTime selectedDate) {
// //     formattedDate.value = DateFormat('MM/dd/yyyy').format(selectedDate);
// //     fromDate.value = '';
// //     toDate.value = '';
// //     isRangeSelected.value = false;
// //     fetchOrderData();
// //   }

// //   void updateSelectedRange(DateTime start, DateTime end) {
// //     fromDate.value = DateFormat('MM/dd/yyyy').format(start);
// //     toDate.value = DateFormat('MM/dd/yyyy').format(end);
// //     formattedDate.value = '';
// //     isRangeSelected.value = true;
// //     fetchOrderData();
// //   }

// //   void clearSelectedDate() {
// //     initializeDate();
// //     fromDate.value = '';
// //     toDate.value = '';
// //     isRangeSelected.value = false;
// //     fetchOrderData();
// //   }
// //   // Fetch API data
// //   Future<void> fetchOrderData() async {
// //     try {
// //       isLoading(true);
// // //  String queryParams;

// // //     if (isRangeSelected.value) {
// // //       queryParams =
// // //           "?date=&fromDate=${fromDate.value}&toDate=${toDate.value}";
// // //     } else {
// // //       queryParams =
// // //           "?date=${formattedDate.value}&fromDate=&toDate=";
// // //     }

// // //     final url = Uri.parse(
// // //       "${API.ordersApi}api/order/dashboard/getSubAdminDashboard"
// // //       "&subAdminId=$userId&orderStatus=$queryParams",
// // //     );
// //       // HTTP GET request
// //       final response = await http.get(
// //           Uri.parse(
// //               '${API.microServiceUrl}api/order/dashboard/getSubAdminDashboard?date=${formattedDate.value}&subAdminId=$userId&fromDate=${fromDate.value}&toDate=${toDate.value}'),
// //           headers: {
// //             'Authorization': 'Bearer $userToken',
// //             'Content-Type': 'application/json',
// //             'userId': userId,
// //           });
// //     // final response = await http.get(url, headers: API().headers);
// //       // if (response.statusCode == 200) {
// //       //   print('ordergrtininsight:${API.microServiceUrl}api/order/dashboard/getSubAdminDashboard?date=${formattedDate.value}&subAdminId=$userId');
// //       //   final data = json.decode(response.body);

// //       //   if (data['status'] == true) {
// //       //     print("Fetched Data: ${data['data']['orderData']}");
// //       //     orderData.value = data['data']['orderData'];
// //       //   } else {
// //       //     Get.snackbar("Error", "Failed to fetch order data");
// //       //   }
// //       // } else {
// //       //   Get.snackbar("Error", "Server error: ${response.statusCode}");
// //       // }
// //       if (response.statusCode == 200) {
// //       print("Dashborad:${'${API.microServiceUrl}api/order/dashboard/getSubAdminDashboard?date=${formattedDate.value}&subAdminId=$userId&fromDate=${fromDate.value}&toDate=${toDate.value}'}");
// //   final data = json.decode(response.body);
// //   if (data['status'] == true) {
// //     final fetchedList = data['data']['orderData'];
// //     if (fetchedList != null && fetchedList is List) {
// //       orderData.value = fetchedList;
// //     } else {
// //       orderData.value = []; // fallback to avoid type error
// //     }
// //   } else {
// //     orderData.value = [];
// //     Get.snackbar("Error", "Failed to fetch order data");
// //   }
// // } else {
// //   Get.snackbar("Error", "Server error: ${response.statusCode}");
// // }

// //     } catch (e) {
// //       Get.snackbar("Error", "An error occurred: $e");
// //     } finally {
// //       isLoading(false);
// //     }
// //   }

// //   // Helper methods to access specific data
// //   int get totalOrders {
// //     if (orderData.isNotEmpty && orderData[0]['totalOrders'] != null) {
// //       return orderData[0]['totalOrders'];
// //     }
// //     return 0;
// //   }

// //   double get totalOrderAmount {
// //     if (orderData.isNotEmpty && orderData[0]['totalOrderAmount'] != null) {
// //       final amount = orderData[0]['totalOrderAmount'];
// //       if (amount is int) return amount.toDouble();
// //       if (amount is double) return amount;
// //     }
// //     return 0.0;
// //   }

// //   List get lastFiveOrders =>
// //       orderData.isNotEmpty ? orderData[0]['lastFiveOrders'] : [];
// // }

// class DashboardController extends GetxController {
//   String userToken = getStorage.read("usertoken") ?? '';
//   var isLoading = false.obs;
//   var orderData = [].obs;
//   var formattedDate = ''.obs;

//   var fromDate = ''.obs;
//   var toDate = ''.obs;
//   var isRangeSelected = false.obs;

//   @override
//   void onInit() {
//     super.onInit();
//     initializeDate();
//     fetchOrderData();
//   }

//   void initializeDate() {
//     DateTime now = DateTime.now();
//     formattedDate.value = DateFormat('MM/dd/yyyy').format(now);
//   }

//   void updateSelectedDate(DateTime selectedDate) {
//     formattedDate.value = DateFormat('MM/dd/yyyy').format(selectedDate);
//     fromDate.value = '';
//     toDate.value = '';
//     isRangeSelected.value = false;
//     fetchOrderData();
//   }

//   void updateSelectedRange(DateTime start, DateTime end) {
//     fromDate.value = DateFormat('MM/dd/yyyy').format(start);
//     toDate.value = DateFormat('MM/dd/yyyy').format(end);
//     formattedDate.value = '';
//     isRangeSelected.value = true;
//     fetchOrderData();
//   }

//   void updateSelectedMonth(DateTime selectedMonth) {
//     final firstDay = DateTime(selectedMonth.year, selectedMonth.month, 1);
//     final lastDay = DateTime(selectedMonth.year, selectedMonth.month + 1, 0);

//     fromDate.value = DateFormat('MM/dd/yyyy').format(firstDay);
//     toDate.value = DateFormat('MM/dd/yyyy').format(lastDay);
//     formattedDate.value = '';
//     isRangeSelected.value = true;

//     fetchOrderData();
//   }

//   void clearSelectedDate() {
//     initializeDate();
//     fromDate.value = '';
//     toDate.value = '';
//     isRangeSelected.value = false;
//     fetchOrderData();
//   }

//   Future<void> fetchOrderData() async {
//     try {
//       isLoading(true);
//       final response = await http.get(
//         Uri.parse(
//           '${API.microServiceUrl}api/order/dashboard/getSubAdminDashboard'
//           '?date=${formattedDate.value}&subAdminId=$userId'
//           '&fromDate=${fromDate.value}&toDate=${toDate.value}',
//         ),
//         headers: {
//           'Authorization': 'Bearer $userToken',
//           'Content-Type': 'application/json',
//           'userId': userId,
//         },
//       );

//       if (response.statusCode == 200) {

//         print('API FOR INSIGHTS ${API.microServiceUrl}api/order/dashboard/getSubAdminDashboard'
//           '?date=${formattedDate.value}&subAdminId=$userId'
//           '&fromDate=${fromDate.value}&toDate=${toDate.value}');


//         final data = json.decode(response.body);
//         if (data['status'] == true) {
//           final fetchedList = data['data']['orderData'];
//           if (fetchedList != null && fetchedList is List) {
//             orderData.value = fetchedList;
//           } else {
//             orderData.value = [];
//           }
//         } else {
//           orderData.value = [];
//           Get.snackbar("Error", "Failed to fetch order data");
//         }
//       } else {
//         Get.snackbar("Error", "Server error: ${response.statusCode}");
//       }
//     } catch (e) {
//       Get.snackbar("Error", "An error occurred: $e");
//     } finally {
//       isLoading(false);
//     }
//   }

//   // Summary getters
//   int get totalOrders {
//     if (orderData.isNotEmpty && orderData[0]['totalOrders'] != null) {
//       return orderData[0]['totalOrders'];
//     }
//     return 0;
//   }

//   double get totalOrderAmount {
//     if (orderData.isNotEmpty && orderData[0]['totalOrderAmount'] != null) {
//       final amount = orderData[0]['totalOrderAmount'];
//       if (amount is int) return amount.toDouble();
//       if (amount is double) return amount;
//     }
//     return 0.0;
//   }

//   List get lastFiveOrders =>
//       orderData.isNotEmpty ? orderData[0]['lastFiveOrders'] : [];
// }


// class OrderviewPaginations with ChangeNotifier {
//   final DashboardController dashboard = Get.put(DashboardController());

//   Logger logg = Logger();

//   bool isLoading = false;
//   bool moreDataLoading = false;
//   int limit = 8;

//   List fetchedDatas = [];
//   dynamic totalCount;
//   dynamic fetchCount;

//   /// Fix: Do not reset `isLoading` here
//   Future<void> clearData() async {
//     fetchedDatas.clear();
//     totalCount = 0;
//     fetchCount = 0;
//     notifyListeners();
//   }
// Future<void> fetchviewallorders({int offset = 0}) async {
//   if (moreDataLoading) return;

//   if (offset == 0) {
//     isLoading = true;
//     notifyListeners();
//   }

//   moreDataLoading = true;
//   notifyListeners();

//   try {
//     String queryParams;

//     if (dashboard.isRangeSelected.value) {
//       queryParams =
//           "&date=&fromDate=${dashboard.fromDate.value}&toDate=${dashboard.toDate.value}";
//     } else {
//       queryParams =
//           "&date=${dashboard.formattedDate.value}&fromDate=&toDate=";
//     }

//     final url = Uri.parse(
//       "${API.ordersApi}&value=&limit=$limit&offset=$offset"
//       "&subAdminId=$userId&orderStatus=$queryParams",
//     );
// print("UUUURRRRRLLLL     $url");
//     final response = await http.get(url, headers: API().headers);

//     if (response.statusCode == 200) {
//       logg.i("Orders fetched: $url");
//       final result = jsonDecode(response.body);

//       totalCount = result['data']['totalCount'];
//       fetchCount = result['data']['fetchCount'];

//       fetchedDatas.addAll(result['data']['data']);
//       isLoading = false;
//       notifyListeners();
//     } else {
//       logg.e("Status code: ${response.statusCode}");
//       if (fetchedDatas.isEmpty) {
//         isLoading = false;
//         notifyListeners();
//       }
//     }
//   } catch (e) {
//     logg.e("Error: $e");
//   } finally {
//     moreDataLoading = false;
//     notifyListeners();
//   }
// }

//   // Future<void> fetchviewallorders({int offset = 0}) async {
//   //   if (moreDataLoading) return;

//   //   if (offset == 0) {
//   //     isLoading = true;
//   //     notifyListeners();
//   //   }

//   //   moreDataLoading = true;
//   //   notifyListeners();

//   //   try {
//   //     final url = Uri.parse(
//   //       "${API.ordersApi}&value=&limit=$limit&offset=$offset"
//   //       "&subAdminId=$userId&orderStatus=&date=${dashboard.formattedDate.value}"
//   //       "&fromDate=&toDate=",
//   //     );

//   //     final response = await http.get(url, headers: API().headers);

//   //     if (response.statusCode == 200) {
//   //       logg.i("Orders fetched: $url");

//   //       final result = jsonDecode(response.body);

//   //       totalCount = result['data']['totalCount'];
//   //       fetchCount = result['data']['fetchCount'];

//   //       fetchedDatas.addAll(result['data']['data']);
//   //       logg.i("Fetched Data Length: ${fetchedDatas.length}");

//   //       // Only mark loading complete if data exists
//   //       isLoading = false;
//   //       notifyListeners();
//   //     } else {
//   //       logg.e("Error status code: ${response.statusCode}");
//   //       if (fetchedDatas.isEmpty) {
//   //         isLoading = false;
//   //         notifyListeners();
//   //       }
//   //     }
//   //   } catch (e) {
//   //     logg.e("Exception occurred: $e");
//   //   } finally {
//   //     moreDataLoading = false;
//   //     notifyListeners();
//   //   }
//   // }

// }


// // // class OrderviewPaginations with ChangeNotifier {
// // DashboardController dashboard= Get.put(DashboardController());
// //   Logger logg = Logger();
// //   bool isLoading = false;

// //   bool moreDataLoading = false;

// //   int limit = 8;
// //   List fetchedDatas = [];

// //   dynamic totalCount;
// //   dynamic fetchCount;

// //   Future<void> clearData() async {
// //     fetchedDatas.clear();
// //     totalCount = 0;
// //     fetchCount = 0;
// //     isLoading = false;
// //     notifyListeners();
// //   }

// //   Future<void> fetchviewallorders({ int offset = 0}) async {
// //     try {
// //       // moreDataLoading = true;
// //       // notifyListeners();
// // if (moreDataLoading) return; // Prevent multiple API calls at the same time
// //   moreDataLoading = true;
// //   notifyListeners();  // 
// //       if (offset == 0) {
// //         isLoading = true;
// //         notifyListeners();
// //       }

// //       var response = await http.get(
// //         Uri.parse("${API.ordersApi}&value=&limit=$limit&offset=$offset&subAdminId=$userId&orderStatus=&date=${dashboard.formattedDate.value}&fromDate=&toDate="),
// //         headers: API().headers,
// //       );

// //       if (response.statusCode == 200) {
// //       print("View all cat fetched sucess");
// //       logg.i("${API.ordersApi}&value=&limit=$limit&offset=$offset&subAdminId=$userId&orderStatus=&date=${dashboard.formattedDate.value}&fromDate=&toDate=");
  
// //         var result = jsonDecode(response.body);

// //         totalCount = result['data']['totalCount'];
// //         fetchCount = result['data']['fetchCount'];

// //         fetchedDatas.addAll(result['data']['data']);
// //         logg.i("fetchedDatas:$fetchedDatas");
// //         notifyListeners();

// //         if (fetchedDatas.isNotEmpty) {
// //           isLoading = false;
// //           notifyListeners();
// //         }

// //         print(response.request);
// //         print('Total Length ... is ..');
        
// //         logg.i(result['data']['data'].length);
      
// //         for (int i = 0; i < fetchedDatas.length; i++) {
// //           print(
// //               '${fetchedDatas[i]['_id']}  === = =>> $totalCount  $fetchCount');
// //         }
// //         // logg.i("${API.martcategory}?productCategoryType=mart&offset=$offset&limit=$limit");
  
// //       } else {
// //         if (fetchedDatas.isEmpty) {
// //           isLoading = false;
// //           notifyListeners();
// //         }
// // print("fetchedDatas.isEmpty");
// //         logg.i('${response.statusCode} ====<<status code issue>>');
// //           // logg.i("${API.martcategory}?productCategoryType=mart&offset=$offset&limit=$limit");
       
// //       }
// //     } catch (e) {
// //       print('Its an Exception Error $e');
// //     } finally {
// //       moreDataLoading = false;
// //       notifyListeners();
// //     }
// //   }


// // }




























































// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:logger/logger.dart';
import 'package:miogra_seller/Constants/const_variables.dart';
import 'dart:convert';

import 'package:miogra_seller/UrlList/api.dart';

class DashboardController extends GetxController {
  String userToken = getStorage.read("usertoken") ?? '';
  var isLoading = false.obs;
  var orderData = [].obs;
  // List fetchedDatas = [];
 RxInt totalcount = 0.obs;
RxDouble totalearnings = 0.0.obs;


  var formattedDate = ''.obs;

  var fromDate = ''.obs;
  var toDate = ''.obs;
  var isRangeSelected = false.obs;

  @override
  void onInit() {
    super.onInit();
    initializeDate();
    fetchOrderData();
  }

  void initializeDate() {
    DateTime now = DateTime.now();
    formattedDate.value = DateFormat('MM/dd/yyyy').format(now);
  }

  void updateSelectedDate(DateTime selectedDate) {
    formattedDate.value = DateFormat('MM/dd/yyyy').format(selectedDate);
    fromDate.value = '';
    toDate.value = '';
    isRangeSelected.value = false;
    fetchOrderData();
  }

  void updateSelectedRange(DateTime start, DateTime end) {
    fromDate.value = DateFormat('MM/dd/yyyy').format(start);
    toDate.value = DateFormat('MM/dd/yyyy').format(end);
    formattedDate.value = '';
    isRangeSelected.value = true;
    fetchOrderData();
  }

  void updateSelectedMonth(DateTime selectedMonth) {
    final firstDay = DateTime(selectedMonth.year, selectedMonth.month, 1);
    final lastDay = DateTime(selectedMonth.year, selectedMonth.month + 1, 0);

    fromDate.value = DateFormat('MM/dd/yyyy').format(firstDay);
    toDate.value = DateFormat('MM/dd/yyyy').format(lastDay);
    formattedDate.value = '';
    isRangeSelected.value = true;

    fetchOrderData();
  }

  void clearSelectedDate() {
    initializeDate();
    fromDate.value = '';
    toDate.value = '';
    isRangeSelected.value = false;
    fetchOrderData();
  }

  Future<void> fetchOrderData() async {
    try {
      isLoading(true);
      final response = await http.get(
        Uri.parse(
          '${API.microServiceUrl}api/order/newEarnings?subAdminId=$userId&earningType=restaurant&date=${formattedDate.value}&fromDate=${fromDate.value}&toDate=${toDate.value}',
        // Uri.parse(
        //   '${API.microServiceUrl}api/order/dashboard/getSubAdminDashboard'
        //   '?date=${formattedDate.value}&subAdminId=$userId'
        //   '&fromDate=${fromDate.value}&toDate=${toDate.value}',
        ),
        headers: {
          'Authorization': 'Bearer $userToken',
          'Content-Type': 'application/json',
          'userId': userId,
        },
      );
print("NAVEEN ${response.body}");
      if (response.statusCode == 200) {

        print('API FOR INSIGHTS ${API.microServiceUrl}api/order/newEarnings?subAdminId=$userId&earningType=restaurant&date=${formattedDate.value}&fromDate=${fromDate.value}&toDate=${toDate.value}');
        // print('API FOR INSIGHTS ${API.microServiceUrl}api/order/dashboard/getSubAdminDashboard'
        //   '?date=${formattedDate.value}&subAdminId=$userId'
        //   '&fromDate=${fromDate.value}&toDate=${toDate.value}');


        final data = json.decode(response.body);
        if (data['status'] == true) {
totalcount.value = data["data"]["totalCount"];
totalearnings.value = double.tryParse(data["data"]["totalEarning"].toString()) ?? 0.0;

print("TOTAL ORDER ${ data["data"]["totalCount"]} ");
print("TOTAL uu EARNINGS ${data["data"]["totalEarning"]}" );
// totalcount = data["data"]["totalCount"];

// totalearnings = data["data"]["totalEarning"];

          final fetchedList = data['data']['result'];
          if (fetchedList != null && fetchedList is List) {
            orderData.value = fetchedList;
            //fetchedDatas = fetchedList;
          } else {
            orderData.value = [];
           //  fetchedDatas = [];
          }
        } else {
           totalcount.value = 0;
  totalearnings.value = 0.0;
          orderData.value = [];
          // fetchedDatas = [];
         // Get.snackbar("Error", "Failed to fetch order data");
        }
      } else {
         totalcount.value = 0;
  totalearnings.value = 0.0;
        Get.snackbar("Error", "Server error: ${response.statusCode}");
      }
    } catch (e) {
       totalcount.value = 0;
  totalearnings.value = 0.0;
      Get.snackbar("Error", "An error occurred: $e");
    } finally {
      isLoading(false);
    }
  }

  // Summary getters
 // int get totalOrders {
   // if (totalearnings.value.isNotEmpty ) {
    //  return totalcount;
   // }
    //return 0;
  //}

  // double get totalOrderAmount {
  //  // if (totalearnings.value.isNotEmpty  && totalearnings.value != null) {
  //     final amount = totalearnings;
  //     if (amount is int) return amount.toDouble();
  //     if (amount is double) return amount;
  //   // }
  //    return 0.0;
  // }

  List get lastFiveOrders =>
      orderData.isNotEmpty ? orderData[0]['lastFiveOrders'] : [];
}


class OrderviewPaginations with ChangeNotifier {
  final DashboardController dashboard = Get.put(DashboardController());

  Logger logg = Logger();

  bool isLoading = false;
  bool moreDataLoading = false;
  int limit = 8;

  List fetchedDatas = [];
  // dynamic totalCount;
  // dynamic fetchCount;

  /// Fix: Do not reset `isLoading` here
  Future<void> clearData() async {
    fetchedDatas.clear();
    // totalCount = 0;
    // fetchCount = 0;
    notifyListeners();
  }
Future<void> fetchviewallorders({int offset = 0}) async {
  if (moreDataLoading) return;

  if (offset == 0) {
    isLoading = true;
    notifyListeners();
  }

  moreDataLoading = true;
  notifyListeners();

  try {
    String queryParams;

    if (dashboard.isRangeSelected.value) {
      queryParams =
          "&date=&fromDate=${dashboard.fromDate.value}&toDate=${dashboard.toDate.value}";
    } else {
      queryParams =
          "&date=${dashboard.formattedDate.value}&fromDate=&toDate=";
    }
print("QUERY ${queryParams}");
    final url = Uri.parse(
      // "${API.ordersApi}&value=&limit=$limit&offset=$offset"
      // "&subAdminId=$userId&orderStatus=$queryParams",
      '${API.microServiceUrl}api/order/newEarnings?subAdminId=$userId&earningType=restaurant$queryParams'
    );
print("UUUURRRRRLLLL     $url");

    final response = await http.get(url, headers: API().headers);
print("RRRRRLLLL     ${response.body}");
    if (response.statusCode == 200) {
      logg.i("Orders fetched: $url");
      final result = jsonDecode(response.body);

      // totalCount = result['data']['totalCount'];
      // fetchCount = result['data']['fetchCount'];

      fetchedDatas.addAll(result['data']['result']);
      isLoading = false;
      notifyListeners();
    } else {
      logg.e("Status code: ${response.statusCode}");
      if (fetchedDatas.isEmpty) {
        isLoading = false;
        notifyListeners();
      }
    }
  } catch (e) {
    
    logg.e("Error: $e");
  } finally {
    moreDataLoading = false;
    notifyListeners();
  }
}


}


























