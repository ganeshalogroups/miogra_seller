// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps

import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'dart:convert';
import 'package:logger/logger.dart';
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/Controllers/CategoryController/variantaddonscontroller.dart';
import 'package:miogra_seller/Screens/Menu/categoryscreen.dart';
import 'package:miogra_seller/UrlList/api.dart';

class FoodListController extends GetxController {
  Logger loge = Logger();
  final VariantsController variantCon = Get.put(VariantsController());
  String usertokenn = getStorage.read("usertoken") ?? '';
  var dataLoading = false.obs;
  var productCategory = <dynamic>[].obs; // Keep as an observable list

  Future<void> getFoods(dynamic foodCatid) async {
    print('getFoods data...');
    try {
      dataLoading.value = true;
      final response = await http.get(
        Uri.parse(
            "${API.getFoodlist}restaurantId=$userId&foodCategoryId=$foodCatid"),
        headers: {
          'Authorization': 'Bearer $usertokenn',
          'Content-Type': 'application/json',
          'userId': userId,
        },
      );
      print(
          'api............${API.getFoodlist}restaurantId=$userId&foodCategoryId=$foodCatid');
      print('getFoods response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        var responseBody = jsonDecode(response.body);
        if (responseBody['data'] != null) {
          productCategory.value = [responseBody['data']];
        } else {}
      } else {
        print("Error: API returned status ${response.statusCode}");
      }
    } catch (e) {
      print("Error: $e");
    } finally {
      dataLoading.value = false;
    }
  }

  var isfoodCreateLoading = false.obs;
  dynamic foodCreateData;

  foodCreateLoadingFunction() {
    isfoodCreateLoading(true);
  }

 Future <void> foodCreate({
    dynamic foodCatName,
    dynamic varianGroupName,
    dynamic foodName,
    dynamic foodImage,
    dynamic foodType,
    dynamic foodDesc,
    dynamic foodCatId,
    dynamic foodCuisine,
    dynamic foodcuisineId,
    dynamic prepTime,
    dynamic custPrice,
    dynamic discPrice,
    dynamic packPrice,
    dynamic commission,
    dynamic additionalImage1,
    dynamic additionalImage2,
    dynamic additionalImage3,
    dynamic additionalImage4,
    dynamic thumbUrl,
    dynamic mediumUrl,
    required bool isCustomised,
    List<Map<String, dynamic>>? availableTimings,
    List<String>? ingredientsList,
    // required List<Map<String, dynamic>> foodVariants,
    required List<List<Map<String, dynamic>>> groupVariants,
    required List<String> groupNames,
  }) async {

    

    try {
      print(
          'API URL: ${API.createFoodlist}restaurantId=$userId&foodCategoryId=$foodCatId');
      print("isCustomised:${isCustomised}");
      print('food cuisine id......$foodcuisineId');
 print("user $usertokenn");
      final List<Map<String, dynamic>> formattedAddOns = variantCon
              .addOns.isNotEmpty
          ? List.from(variantCon.addOns.map((addOn) {
              return {
                "addOnsGroupName": addOn["addOnsGroupName"],
                if (addOn["_id"] != null)
                  "_id": addOn["_id"], // Include only if not null
                "addOnsType": (addOn["addOnsType"] as List).map((variant) {
                  return {
                    "variantName": variant["variantName"],
                    "variantImage": variant["variantImage"],
                    "additionalImage": variant["additionalImage"] ?? [],
                    "type": variant["type"],
                    "basePrice":
                        variant["basePrice"].toString().replaceAll('₹', ''),
                    "customerPrice":
                        variant["customerPrice"].toString().replaceAll('₹', ''),
                    "totalPrice":
                        variant["totalPrice"].toString().replaceAll('₹', ''),
                    "deleted": variant["deleted"],
                    "status": variant["status"],
                    if (variant["_id"] != null)
                      "_id": variant["_id"], // Include only if not null
                  };
                }).toList(),
              };
            }).toList())
          : []; // Ensure it's an empty list if there are no add-ons

      final List<Map<String, dynamic>> formattedVariants = variantCon
              .variantList.isNotEmpty
          ? List.from(variantCon.variantList.map((variant) {
              return {
                "variantGroupName": variant["variantGroupName"],
                if (variant["_id"] != null)
                  "_id": variant["_id"], // Include only if not null
                "variantType": (variant["variantType"] as List).map((variantt) {
                  return {
                    "variantName": variantt["variantName"],
                    "variantImage": variantt["variantImage"],
                    "additionalImage": variantt["additionalImage"] ?? [],
                    "type": variantt["type"],
                    "basePrice":
                        variantt["basePrice"].toString().replaceAll('₹', ''),
                    "customerPrice": variantt["customerPrice"]
                        .toString()
                        .replaceAll('₹', ''),
                    "totalPrice":
                        variantt["totalPrice"].toString().replaceAll('₹', ''),
                    "deleted": variantt["deleted"],
                    "status": variantt["status"],
                    if (variantt["_id"] != null)
                      "_id": variantt["_id"], // Include only if not null
                  };
                }).toList(),
              };
            }).toList())
          : []; // Ensure it's an empty list if there are no varaints

      print("foodUpdateData :${formattedAddOns}");

     

      dynamic additionalImages = [
        additionalImage1,
        additionalImage2,
        additionalImage3,
        additionalImage4,
      ]
          .where((image) =>
              image != null && image.isNotEmpty) // Remove null values
          .toList();
      isfoodCreateLoading(true);
      
      var response = await http.post(
        Uri.parse(
            '${API.createFoodlist}restaurantId=$userId&foodCategoryId=$foodCatId'),
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $usertoken',
          'userId': userId,
        },
        body: jsonEncode(<String, dynamic>{
         "productTypeToFilter" : catres,
         "commission":0,
          "mediumImgUrl": mediumUrl,
          "thumbImgUrl": thumbUrl,
          "foodName": foodName,
          "foodImgUrl": foodImage,
          "foodCategoryName": foodCatName.toString(),
          "foodRestaurantName": username.toString(),
          "additionalImage": additionalImages,
          "foodType": foodType,
          "foodTitle": foodCuisine,
          "foodDiscription": foodDesc,
          "foodCusineTypeId": foodcuisineId,
          "foodCategoryId": foodCatId,
          "restaurantId": userId,
          "iscustomizable": isCustomised,
          "ingredients": ingredientsList,
          "availableTimings": availableTimings,
          "preparationTime": prepTime,
          "food": {
            "unit": "",
            "basePrice": custPrice,
            "customerPrice": custPrice,
            "packagingCharge": packPrice,
            
            // "totalPrice": double.parse(custPrice.toString()) +
            //     double.parse(discPrice.toString()),
            "totalPrice": (double.tryParse(custPrice.toString()) ?? 0) +
              (double.tryParse(discPrice.toString()) ?? 0),

            "discount": discPrice,
            "GST": "",
            "SGST": "",
            "CGST": ""
          },
          "customizedFood": {
            "addVariants": formattedVariants,
            "addOns": formattedAddOns
          },
          "offerAmount": "",
          "offerName": "",
          "notes": "",
          "isRecommended": false
        }),
      );
       print("IF SHOWING   $foodImage");
      print("additionalimages: ${additionalImages}");
      print(
          'FOOD LIST api..........${API.createFoodlist}restaurantId=$userId&foodCategoryId=$foodCatId');
      print('FOOD LIST  Response Body: ${response.body}');
      print('FOOD LIST  response${response.statusCode}');
      print('Filter $catres');


    //  print("FOOD DATA $foodCreateData");
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);
        foodCreateData = result;
        Get.offAll(() => CategoryScreen(
              foodCatId: foodCatId,
              foodCategory: foodCatName,
            ));
      } else {
        foodCreateData = null;
        print("ERROR SHOWING");
      }
    } catch (e) {
       print('erroe   $e');
       print(" Catch ERROR SHOWING");
    } finally {
      isfoodCreateLoading(false);
    }
  }

  var isFoodDeleteLoading = false.obs;
  dynamic foodDeleteData;

  void deleteFood(
      {dynamic foodid, dynamic foodCatid, dynamic foodCatname}) async {
    try {
      if (foodid == null || foodid.toString().isEmpty) {
        print('Food ID is null or empty');
        return;
      }

      isFoodDeleteLoading(true);
      var response = await http.post(
        Uri.parse(API.deleteFood),
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $usertokenn',
          'userId': userId,
        },
        body: jsonEncode({"foodId": foodid}),
      );

      print('FOOD DELETE response code: ${response.statusCode}');
      print('FOOD DELETE response body: ${response.body}');

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);
        foodDeleteData = result;
        Get.offAll(() => CategoryScreen(
              foodCatId: foodCatid,
              foodCategory: foodCatname,
            ));
      } else if (response.statusCode == 403) {
        print('403 Forbidden: Check token or permissions.');
      } else {
        foodDeleteData = null;
        print('Error deleting food: ${response.body}');
      }
    } catch (e) {
      print('Exception during deleteFood: $e');
    } finally {
      isFoodDeleteLoading(false);
    }
  }

  var isfoodUpdaeLoading = false.obs;
  dynamic foodupdateData;

  void foodUpdate({
    dynamic varianGroupName,
    dynamic status,
    dynamic foodName,
    dynamic foodImage,
    dynamic foodType,
    dynamic foodDesc,
    dynamic foodCatId,
    dynamic foodCatName,
    dynamic foodCuisine,
    dynamic foodcuisineId,
    dynamic foodId,
    dynamic prepTime,
    dynamic custPrice,
    dynamic discPrice,
    dynamic packPrice,
    dynamic commissionPrice,
    dynamic thumbUrl,
    dynamic mediumUrl,
    dynamic additionalImage1,
    dynamic additionalImage2,
    dynamic additionalImage3,
    dynamic additionalImage4,
    bool? iscustomizable,
    List<Map<String, dynamic>>? availableTimings,
    // required List<Map<String, dynamic>> foodVariants,
    // required List<List<Map<String, dynamic>>> groupVariants,
    List<String>? ingredientsList,
    // required List<String> groupNames,
  }) async {
    try {
      print(" jnknknkmkm");
      final List<Map<String, dynamic>> formattedAddOns = variantCon
              .addOns.isNotEmpty
          ? List.from(variantCon.addOns.map((addOn) {
              return {
                "addOnsGroupName": addOn["addOnsGroupName"],
                if (addOn["_id"] != null)
                  "_id": addOn["_id"], // Include only if not null
                "addOnsType": (addOn["addOnsType"] as List).map((variant) {
                  return {
                    "variantName": variant["variantName"],
                    "variantImage": variant["variantImage"],
                    "additionalImage": variant["additionalImage"] ?? [],
                    "type": variant["type"],
                    "basePrice":
                        variant["basePrice"].toString().replaceAll('₹', ''),
                    "customerPrice":
                        variant["customerPrice"].toString().replaceAll('₹', ''),
                    "totalPrice":
                        variant["totalPrice"].toString().replaceAll('₹', ''),
                    "deleted": variant["deleted"],
                    "status": variant["status"],
                    if (variant["_id"] != null)
                      "_id": variant["_id"], // Include only if not null
                  };
                }).toList(),
              };
            }).toList())
          : []; // Ensure it's an empty list if there are no add-ons

      final List<Map<String, dynamic>> formattedVariants = variantCon
              .variantList.isNotEmpty
          ? List.from(variantCon.variantList.map((variant) {
              return {
                "variantGroupName": variant["variantGroupName"],
                if (variant["_id"] != null)
                  "_id": variant["_id"], // Include only if not null
                "variantType": (variant["variantType"] as List).map((variantt) {
                  return {
                    "variantName": variantt["variantName"],
                    "variantImage": variantt["variantImage"],
                    "additionalImage": variantt["additionalImage"] ?? [],
                    "type": variantt["type"],
                    "basePrice":
                        variantt["basePrice"].toString().replaceAll('₹', ''),
                    "customerPrice": variantt["customerPrice"]
                        .toString()
                        .replaceAll('₹', ''),
                    "totalPrice":
                        variantt["totalPrice"].toString().replaceAll('₹', ''),
                    "deleted": variantt["deleted"],
                    "status": variantt["status"],
                    if (variantt["_id"] != null)
                      "_id": variantt["_id"], // Include only if not null
                  };
                }).toList(),
              };
            }).toList())
          : []; // Ensure it's an empty list if there are no add-ons
      dynamic additionalImages = [
        additionalImage1,
        additionalImage2,
        additionalImage3,
        additionalImage4,
      ]
          .where((image) =>
              image != null && image.isNotEmpty) // Remove null values
          .toList();
      print("formattedVariants:${formattedVariants}");
      print("foodUpdateData :${formattedAddOns}");
      print("iscustomised in update :${iscustomizable}");
      isfoodUpdaeLoading(true);
      var response = await http.post(
        Uri.parse('${API.updateFood}'),
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $usertoken',
          'userId': userId,
        },
        body: jsonEncode(<String, dynamic>{
          "productTypeToFilter" : catres,
          "commission":commissionPrice,
         // "status":status,
          "foodName": foodName,
          "foodImgUrl": foodImage,
          "mediumImgUrl": mediumUrl,
          "thumbImgUrl": thumbUrl,
          // "additionalImage": [
          //   additionalImage1,
          //   additionalImage2,
          //   additionalImage3,
          //   additionalImage4,
          // ],
          "additionalImage": additionalImages,
          "foodType": foodType,
          "foodTitle": foodCuisine,
          "foodDiscription": foodDesc,
          "foodCusineTypeId": foodcuisineId,
          "foodCategoryId": foodCatId,
          "restaurantId": userId,
          "foodId": foodId,
          "iscustomizable": iscustomizable,
          "ingredients": ingredientsList,
          "availableTimings": availableTimings,
          "preparationTime": prepTime,
          "food": {
            "unit": "",
            "basePrice": custPrice,
            "customerPrice": custPrice,
            "packagingCharge": packPrice,
            "commission":commissionPrice,
            "totalPrice": custPrice,
            "discount": discPrice,
            "GST": "",
            "SGST": "",
            "CGST": ""
          },
          "customizedFood": {
            "addVariants": formattedVariants,
            "addOns": formattedAddOns
          },
          "offerAmount": "",
          "offerName": "",
          "notes": "",
          "isRecommended": true
        }),
      );
      loge.i(' ${response.body}');
      print(
          'FOOD update api..........${API.createFoodlist}restaurantId=$userId&foodCategoryId=$foodCatId');
      print('FOOD Additionalimage: ${additionalImages}');
      print('FOOD Additionalimage: ${additionalImage1}');
      print('FOOD Additionalimage: $additionalImage2');
      print('FOOD Additionalimage: ${additionalImage3}');
      print('FOOD Additionalimage: ${additionalImage4}');
      print('FOOD update  response${response.statusCode}');
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        var result = jsonDecode(response.body);
        foodupdateData = result;
        Get.offAll(() => CategoryScreen(
              foodCatId: foodCatId,
              foodCategory: foodCatName,
            ));
            print(result["message"]);
      } else {
        foodupdateData = null;
        print("ELSE  $status");
      }
    } catch (e) {
      print('Error ASASAS: $e');
    } finally {
      isfoodUpdaeLoading(false);
    }
  }








  Future<void> foodstatusUpdate({
   
    dynamic status,
    dynamic id
   
  }) async {
    try {
     
    //  isfoodUpdaeLoading(true);
      var response = await http.post(
        Uri.parse('${API.updateFood}'),
        headers: {
          "Accept": "*/*",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $usertoken',
          'userId': userId,
        },
        body: jsonEncode(<String, dynamic>{
        
         "status": status,
          "foodId": id,
        
        }),
      );
     
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          response.statusCode == 202) {
        print("Success  $status");
       print("OOOOOOO");
      } else {
      
        print("ELSE  $status  ${response.statusCode}");
      }
    } catch (e) {
      print('Error:SSS $e');
    } finally {

    }
  }
}
