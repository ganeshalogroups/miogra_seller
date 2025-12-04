// ignore_for_file: avoid_print

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/Screens/Home/bottomnavigation.dart';
import 'dart:convert';
import 'package:miogra_seller/UrlList/api.dart';

class HashTagCategoryController extends GetxController {
  String usertokenn = getStorage.read("usertoken") ?? '';
  // String userId = getStorage.read("UserId") ?? '';

  var dataLoading = false.obs;
  var restProfile = <dynamic>[].obs;
  var searchTerm = ''.obs;

  @override
  void onInit() {
    super.onInit();
    debounce(
  searchTerm,
  (_) {
    if (searchTerm.value.trim().isNotEmpty) {
      getHashtagCat(searchTerm.value);
    } else {
      restProfile.clear();
    }
  },
  time: Duration(milliseconds: 500),
);
  }

 Future<void> getHashtagCat(String typingText) async {
  // Ensure we only fetch data for non-empty terms
  if (typingText.trim().isEmpty) {
    restProfile.clear();
    return;
  }

  dataLoading.value = true;

  try {
    final response = await http.get(
      Uri.parse(
          "${API.hashtagcatapi}?value=$typingText&hashtagType=category&productCateId=$prodCatId&default=false"),
      headers: {
        'Authorization': 'Bearer $usertokenn',
        'Content-Type': 'application/json',
        'userId': userId ?? '',
      },
    );

    if (response.statusCode == 200) {
      var responseBody = jsonDecode(response.body);

      // Ensure the current search term matches the input before updating
      if (typingText == searchTerm.value) {
        restProfile.value = responseBody['data']?['searchList'] ?? [];
      }
    }
  } catch (e) {
    print('Error fetching hashtags: $e');
  } finally {
    dataLoading.value = false;
  }
}

  var isCategoryCreateLoading = false.obs;
  dynamic categoryCreateData;

   hashCreate({
   bool isfromaddingredients = false,
    dynamic hashtagName,
    dynamic hastagtype
  }) async {
    try {
      isCategoryCreateLoading(true);
      var response = await http.post(
        Uri.parse(API.hashtagcatapi),
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $usertokenn',
        },
        body: jsonEncode(<String, dynamic>{
          "productTypeToFilter":catres,
          "hashtagName": hashtagName,
          "hashtagType": hastagtype,
          "hashtagImage": "",
          "productCateId": prodCatId,
          "parentAdminId": userId,
          "default": false
        }),
      );

      print('hashCreate response${response.statusCode}');
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);
        categoryCreateData = result;

        print("PRINT HASHTAG   $categoryCreateData");
        if(!isfromaddingredients){
        
        Get.offAll(() => RestaurentBottomNavigation(
              initialIndex: 1,
            ));}
      } else {
        categoryCreateData = null;
      }
    } catch (e) {
      // print('$error');
    } finally {
      isCategoryCreateLoading(false);
    }
  }
}
