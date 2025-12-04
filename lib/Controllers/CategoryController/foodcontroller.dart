import 'package:get/get.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/UrlList/api.dart';

class FoodItem {
  final String foodCatId;
  final String foodImage;
  final String custPrice;
  final String discPrice;
  final String packPrice;
  final String commission;
  final String foodCuisine;
  final String foodDesc;
  final String foodName;
  final String foodType;
  final String prepTime;
  final String additionalImage1;
  final String additionalImage2;
  final String additionalImage3;
  final String additionalImage4;
  final String foodcuisineId;
  final bool isCustomised;
  final List<Map<String, dynamic>> availableTimings;
  final List<String> ingredientsList;

  FoodItem({
    required this.isCustomised,
    required this.foodCatId,
    required this.foodImage,
    required this.custPrice,
    required this.discPrice,
    required this.packPrice,
    required this.commission,
    required this.foodCuisine,
    required this.foodDesc,
    required this.foodName,
    required this.foodType,
    required this.prepTime,
    required this.additionalImage1,
    required this.additionalImage2,
    required this.additionalImage3,
    required this.additionalImage4,
    required this.foodcuisineId,
    required this.availableTimings,
    required this.ingredientsList,
  });
}

class FoodController extends GetxController {
  // Observable food item
  Rx<FoodItem?> foodItem = Rx<FoodItem?>(null);

  // Function to save food item
  void saveFoodItem({
    required bool isCustomised,
    required String foodCatId,
    required String foodImage,
    required String custPrice,
    required String discPrice,
    required String packPrice,
    required String commission,
    required String foodCuisine,
    required String foodDesc,
    required String foodName,
    required String foodType,
    required String prepTime,
    required String additionalImage1,
    required String additionalImage2,
    required String additionalImage3,
    required String additionalImage4,
    required String foodcuisineId,
    required List<Map<String, dynamic>> availableTimings,
    required List<String> ingredientsList,
  }) {
    foodItem.value = FoodItem(
      foodCatId: foodCatId,
      foodImage: foodImage,
      custPrice: custPrice,
      discPrice: discPrice,
      packPrice: packPrice,
      commission: commission,
      foodCuisine: foodCuisine,
      foodDesc: foodDesc,
      foodName: foodName,
      foodType: foodType,
      prepTime: prepTime,
      additionalImage1: additionalImage1,
      additionalImage2: additionalImage2,
      additionalImage3: additionalImage3,
      additionalImage4: additionalImage4,
      foodcuisineId: foodcuisineId,
      availableTimings: availableTimings,
      ingredientsList: ingredientsList,
      isCustomised: isCustomised,
    );
  }

  // Function to clear the food item
  void clearFoodItem() {
    foodItem.value = null; // Resetting to null
  }




  ///Fetch Ingredients 
  var isingredientsLoading = false.obs;
  dynamic ingredientsDetails;

  getIngredients({value}) async {
    try {
      isingredientsLoading(true);
      var response = await http.get(
        Uri.parse("${API.hashtagcatapi}?value=$value&limit=10&hashtagType=ingredients&productCateId=$prodCatId"),
        headers: API().headers,
      );
      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);
        ingredientsDetails = result;
        
      debugPrint("get advertisement status ${response.body}");
      } else {
        //  print(response.body);
        ingredientsDetails = null;
      }
    } catch (e) {
      ingredientsDetails = null;
      //print(e.toString());
      return false;
    } finally {
      isingredientsLoading(false);
    }
  }
}
