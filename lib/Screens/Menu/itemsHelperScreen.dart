// ignore_for_file: avoid_print

import 'dart:io';
import 'package:get/get.dart';
import 'package:miogra_seller/Model/getfoodlistmodel.dart';

class AdditionHelperItems {
  String mapFoodType(String? backendFoodType) {
    // Using a map for more scalable mapping logic
    const foodTypeMapping = {
      'veg': 'veg',
      'nonveg': 'nonveg',
      'egg': 'egg',
    };

    // Convert input to lowercase, check in map, or fallback to 'veg'.
    return foodTypeMapping[backendFoodType?.toLowerCase()] ?? 'veg';
  }

  String normalizePrepTime(String prepTime) {
    return prepTime
        .replaceAll(' ', '')
        .toLowerCase(); // Remove spaces and convert to lowercase
  }

  String mapPreparationTime(String? backendPrepTime) {
    switch (normalizePrepTime(backendPrepTime ?? '30 mins')) {
      case '15mins':
        return '15mins';
      case '30mins':
        return '30mins';
      case '45mins':
        return '45mins';
      case '60mins':
        return '60mins';
      default:
        return '30mins';
    }
  }

  String? validatePrepTime(List selectedFoodType) {
    if (selectedFoodType.isEmpty) {
      return 'Please select a food type';
    }
    return null;
  }

  // bool isImageValid(File? image) {
  //   if (image == null) {
  //     return false;
  //   }
  //   return true;
  // }

    // Max size in bytes (500KB)
  static const int maxFileSize = 500 * 1024;

  bool isImageValid(File? image) {
    if (image == null) return false;

    final allowedExtensions = ['jpg', 'jpeg', 'png'];
    final extension = image.path.split('.').last.toLowerCase();

    if (!allowedExtensions.contains(extension)) {
      Get.snackbar("Invalid Image", "Only JPG and PNG images are allowed.");
      return false;
    }

    final fileSize = image.lengthSync();
    if (fileSize > maxFileSize) {
      Get.snackbar("Image Too Large", "Image must be less than 500KB.");
      return false;
    }

    return true;
  }

  bool areAllImagesValid({File? img1, File? img2, File? img3, File? img4 , File? img5}) {
    return isImageValid(img1) &&
        isImageValid(img2) &&
        isImageValid(img3) &&
        isImageValid(img4) &&
        isImageValid(img5);
  }

 List<AvailableTiming>? parseAvailableTimings(dynamic timings) {
    print("Input timings: $timings");
    print("Type of timings: ${timings.runtimeType}");

    if (timings == null) {
     // print("timings is null");
      return null;
    }
    if (timings is List<dynamic>) {
      // print("timings is List<dynamic>");
      // print(timings);
      try {
        return timings
            .map((item) =>
                AvailableTiming.fromJson(item as Map<String, dynamic>))
            .toList();
      } catch (e) {
       // print("Error converting List<dynamic> to List<AvailableTiming>: $e");
        rethrow;
      }
      //return timings;
    }

    if (timings is List<AvailableTiming>) {
      //print("timings 2");
      return timings;
    } else if (timings is List<Map<String, dynamic>>) {
     // print("timings 3");
      try {
        return timings.map((json) => AvailableTiming.fromJson(json)).toList();
      } catch (e) {
        print("Error parsing timings: $e");
        rethrow;
      }
    }else if (timings is List<Map<String, String>>) {
     // print("timings 3");
      try {
        return timings.map((json) => AvailableTiming.fromJson(json)).toList();
      } catch (e) {
        print("Error parsing timings: $e");
        rethrow;
      }
    } 
     else {
      throw ArgumentError(
          'Invalid type for available timings: ${timings.runtimeType}');
    }
  }


  //   List<Map<String, dynamic>> prepareAvailableTimings(Set<String> selectedTimes) {
  //   const availableTimingsData = {
  //     "Breakfast": {"from": "06:00", "to": "11:00","checked":true},
  //     "Lunch": {"from": "11:00", "to": "16:00","checked":true},
  //     "Dinner": {"from": "16:00", "to": "22:00","checked":true},
  //     "All": {"from": "00:00", "to": "12:00","checked":true}
  //   };

  //   return selectedTimes
  //       .map((time) => {
  //             "type": time,
  //             "from": availableTimingsData[time]!["from"]!,
  //             "to": availableTimingsData[time]!["to"]!,
  //             "checked":availableTimingsData[time]!["checked"]!
  //           })
  //       .toList();
  // }





List<Map<String, dynamic>> prepareAvailableTimings(
      Set<String> selectedTimes,
      Map<String, Map<String, String>> categoryTimes) {

    // If All is selected → full 24 Hours
    // if (selectedTimes.contains("All")) {
    //   return [
    //     {
    //       "type": "All",
    //       "from": "00:00",
    //       "to": "23:59",
    //       "checked": true,
    //     }
    //   ];
    // }

    return selectedTimes.map((category) {
      final timing = categoryTimes[category];

      return {
        "type": category,
        "from": timing?["start"] ?? "00:00",
        "to": timing?["end"] ?? "23:59",
        "checked": true,
      };
    }).toList();
  }





}



