// // ignore_for_file: avoid_print

// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/material.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:miogra_seller/Constants/const_variables.dart';
// import 'package:miogra_seller/Controllers/CategoryController/cusinecontroller.dart';
// import 'package:miogra_seller/Controllers/CategoryController/foodcontroller.dart';
// import 'package:miogra_seller/Controllers/CategoryController/foodlistcontroller.dart';
// import 'package:miogra_seller/Controllers/CategoryController/variantaddonscontroller.dart';
// import 'package:miogra_seller/Controllers/FileuploadController/FileUploader.dart';
// import 'package:miogra_seller/Controllers/ProfileController/profileget.dart';
// import 'package:miogra_seller/Model/getfoodlistmodel.dart';
// import 'package:miogra_seller/Screens/Menu/categoryscreen.dart';
// import 'package:miogra_seller/Screens/Menu/customizationscreen.dart';
// import 'package:miogra_seller/Screens/Menu/customizedComponents/Editsubscreen.dart';
// import 'package:miogra_seller/Screens/Menu/customizedComponents/addons_display_component.dart';
// import 'package:miogra_seller/Screens/Menu/customizedComponents/variants_display_component.dart';
// import 'package:miogra_seller/Screens/Menu/itemsHelperScreen.dart';
// import 'package:miogra_seller/Screens/Menu/variantsscreen.dart';
// import 'package:miogra_seller/Widgets/custom_button.dart';
// import 'package:miogra_seller/Widgets/custom_colors.dart';
// import 'package:miogra_seller/Widgets/custom_container.dart';
// import 'package:miogra_seller/Widgets/custom_gradienttext.dart';
// import 'package:miogra_seller/Widgets/custom_imagepicker.dart';
// import 'package:miogra_seller/Widgets/custom_text.dart';
// import 'package:miogra_seller/Widgets/custom_textstyle.dart';
// import 'package:get/get.dart';

// class EditItemScreen extends StatefulWidget {
//   final String? foodCateId;
//   final String? foodCat;
//   final dynamic foodsListIndex;
//   final List<Variant>? variants;
//   final List<String>? groupNames;
//   final String? variantGroupName;
//   final List<List<Map<String, String>>>? groupVariants;
//   final bool isCustomizedScreen;
//   bool isFromAddonscreen;
//   bool isFromVariantscreen;
//   List<Map<String, dynamic>>? updatedAddOns;
//   List<Map<String, dynamic>>? updatedvariants;

//   EditItemScreen(
//       {super.key,
//       this.foodCateId,
//       this.updatedAddOns,
//       this.updatedvariants,
//       this.foodCat,
//       this.foodsListIndex,
//       this.variants,
//       this.groupVariants,
//       this.groupNames,
//       this.variantGroupName,
//       this.isCustomizedScreen = false,
//       this.isFromAddonscreen = false,
//       this.isFromVariantscreen = false});

//   @override
//   State<EditItemScreen> createState() => _EditItemScreenState();
// }

// class _EditItemScreenState extends State<EditItemScreen> {
//   late TextEditingController _itemNameController;
//   late TextEditingController _description;
//   late TextEditingController _cuisinetype;
//   final TextEditingController _ingredients = TextEditingController();
//   late TextEditingController _priceController;
//   late TextEditingController _discountController;
//   late TextEditingController _packageController;
//   late TextEditingController _commissionController;
//   bool _isProductExpanded = false;
//   bool _isTimeExpanded = false;
//   final editkey = GlobalKey<FormState>();
//   final VariantsController variantsController = Get.put(VariantsController());
//   final ProfilScreeenController profilScreeenController = Get.put(ProfilScreeenController());
//   final FoodController foodController = Get.put(FoodController());

//   String? _selectedCuisineId; // Variable to store the selected cuisine ID
//   String? cuisineID;

//   final CuisineController cuisineController = Get.put(CuisineController());
//   final ImageUploader imageUploader = Get.put(ImageUploader());
//   final FoodListController foodListController = Get.put(FoodListController());
//   late String _selectedFoodType;
//   late String _preparationTime;
//   Set<String> _selectedAvailabilityTimes = {};
//   late List<String> ingredientsList = ["ggg"];
//   bool isContainerVisible = false;
//   String foodImage = '';
//   bool isCustomized = false;
//   bool isLoading = false;
//   List<Variant> variants = [];

//   dataAdded() {
//     var food = foodController.foodItem.value;
//     isCustomized = widget.foodsListIndex?["iscustomizable"];

//     var itemName = widget.foodsListIndex?["foodName"] ?? food?.foodName;
//     _itemNameController = TextEditingController(text: itemName);

//     var foodDesc = widget.foodsListIndex?["foodDiscription"] ?? food?.foodDesc;
//     _description = TextEditingController(text: foodDesc);

//     var cuisine = widget.foodsListIndex?["foodCusineDetails"]?["foodCusineName"] ??food?.foodCuisine;
//     _selectedCuisineId = widget.foodsListIndex?["foodCusineDetails"]?["_id"] ??food?.foodcuisineId;
//     print('CUISINE..........$cuisine');

//     _cuisinetype = TextEditingController(text: cuisine);

//     var foodPrice =widget.foodsListIndex?["food"]?["basePrice"]?.toString() ??food?.custPrice;
//     _priceController = TextEditingController(text: foodPrice);

//     var foodDiscount =widget.foodsListIndex?["food"]?["discount"]?.toString() ??food?.discPrice;
//     _discountController = TextEditingController(text: foodDiscount);

//     var foodPack =widget.foodsListIndex?["food"]?["packagingCharge"]?.toString() ??food?.packPrice;
//     _packageController = TextEditingController(text: foodPack);

//     var foodcommission =widget.foodsListIndex?["food"]?["commission"]?.toString() ??food?.commission;
//     _commissionController = TextEditingController(text: foodcommission);

//     _selectedFoodType = AdditionHelperItems().mapFoodType(widget.foodsListIndex?["foodType"] ?? food?.foodType);
//     _preparationTime = AdditionHelperItems().mapPreparationTime(widget.foodsListIndex?["preparationTime"] ?? food?.prepTime);

//     isContainerVisible = true;

//     ingredientsList = widget.foodsListIndex?["ingredients"].isEmpty
//         ? []
//         : widget.foodsListIndex?["ingredients"].cast<String>();

//     _selectedAvailabilityTimes = <String>{'Lunch'};

//     foodImage = widget.foodsListIndex!["foodImgUrl"].toString();

//     // Additional images
//     if (widget.foodsListIndex!["additionalImage"].isNotEmpty) {
//       _additionalImageUrl1 =widget.foodsListIndex!["additionalImage"].length >= 1
//               ? widget.foodsListIndex!["additionalImage"][0].toString()
//               : "null";
//       _additionalImageUrl2 =widget.foodsListIndex!["additionalImage"].length >= 2
//               ? widget.foodsListIndex!["additionalImage"][1].toString()
//               : "null";
//       _additionalImageUrl3 =widget.foodsListIndex!["additionalImage"].length >= 3
//               ? widget.foodsListIndex!["additionalImage"][2].toString()
//               : "null";
//       _additionalImageUrl4 =widget.foodsListIndex!["additionalImage"].length >= 4
//               ? widget.foodsListIndex!["additionalImage"][3].toString()
//               : "null";
//     }

//     _initializeSelectedTimes();
//   }

//   @override
//   @override
//   void initState() {
//     super.initState();
//     cuisineController.getCuisinetype();
//     _isProductExpanded = true;
//     _isTimeExpanded = true;
//     dataAdded();
//     print("______________________@ ${widget.variants}");
//     print("______________________@ ${widget.foodsListIndex?["iscustomizable"]}");

//     // Post-frame callback ensures state updates happen after the build phase
//     WidgetsBinding.instance.addPostFrameCallback((_) {
//       if (widget.foodsListIndex?["iscustomizable"] == true) {
//         if (widget
//             .foodsListIndex?["customizedFood"]["addVariants"].isNotEmpty) {
//           for (int i = 0;
//               i <widget.foodsListIndex?["customizedFood"]["addVariants"][0]["variantType"].length;i++) {
//             variants.add(Variant(
//               variantGroupName:"${widget.foodsListIndex?["customizedFood"]["addVariants"][0]["variantGroupName"]}",
//               name:"${widget.foodsListIndex?["customizedFood"]["addVariants"][0]["variantType"][i]["variantName"]}",
//               price:"${widget.foodsListIndex?["customizedFood"]["addVariants"][0]["variantType"][i]["customerPrice"]}",
//             ));
//           }
//         }

//         // **Extract AddOns**
//         dynamic addOnsList = [];
//         if (widget.foodsListIndex?["customizedFood"]["addOns"].isNotEmpty) {
//           addOnsList = List<Map<String, dynamic>>.from(widget.foodsListIndex?["customizedFood"]["addOns"]);
//         }

//         // **Extract AddOns**
//         dynamic variantList = [];
//         if (widget.foodsListIndex?["customizedFood"]["addVariants"].isNotEmpty) {
//           variantList = List<Map<String, dynamic>>.from(widget.foodsListIndex?["customizedFood"]["addVariants"]);
//         }

//         // Debugging AddOns (Print after delay)
//         Timer(Duration(seconds: 2), () {
//           print("_________________________________________%");
//           variants.forEach((variant) => print(variant.variantGroupName));
//           addOnsList.forEach(
//               (addOn) => print("AddOn Group: ${addOn["addOnsGroupName"]}"));
//           variantList.forEach(
//               (addOn) => print("Variant Group: ${addOn["variantGroupName"]}"));
//         });

//         // Initialize controller safely
//         variantsController.initialize(
//           initialVariants: variants,
//           initialGroupVariants: widget.groupVariants,
//           initialGroupNames: widget.groupNames,
//         );
//         // **Send AddOns to Controller**
//         // variantsController.initializeAddOns(addOnsList);
//         // Send extracted AddOn list to the controller
//         if (widget.isFromAddonscreen) {
//           print("upppppp${widget.updatedAddOns}");
//           variantsController.initializeAddOns(widget.updatedAddOns);
//         } else if (widget.isFromVariantscreen) {
//           print("variant in editscreenint:${widget.updatedvariants}");
//           variantsController.initializevariant(widget.updatedvariants);
//         } else {
//           print("opppppp");
//           variantsController.initializeAddOns(addOnsList);
//           variantsController.initializevariant(variantList);
//         }
//       }

//       print("varients list +++++++++++++++++++++++++++++++++++++++++++++++");
//       print("var ${widget.variants}");
//       print("group va ${widget.groupVariants}");
//       print("group name in edit screen: ${widget.groupNames}");

//       // Final initialization in post-frame callback
//       variantsController.initialize(
//         initialVariants: widget.variants,
//         initialGroupVariants: widget.groupVariants,
//         initialGroupNames: widget.groupNames,
//       );
//     });
//   }



// Map<String, Map<String, String>> categoryTimes = {
//   "Breakfast": {"start": "06:00", "end": "11:00"},
//   "Lunch": {"start": "11:00", "end": "16:00"},
//   "Dinner": {"start": "16:00", "end": "22:00"},
//   "All": {"start": "0:00", "end": "12:00"},
// };

// //Set<String> selectedCategories = {};



// Widget _buildAvailabilityTimeOption(String category) {
//   bool isSelected = _selectedAvailabilityTimes.contains(category);

//   String start = categoryTimes[category]!["start"]!;
//   String end = categoryTimes[category]!["end"]!;

//   return Row(
//     children: [
//       Checkbox(
//         value: isSelected,
//         activeColor: Color(0xFF623089),
//         onChanged: (value) {
//           setState(() {
//             if (value == true) {
//              _selectedAvailabilityTimes.add(category);
//             } else {
//              _selectedAvailabilityTimes.remove(category);
//             }
//           });
//         },
//       ),

//       /// Category Name
//       Text(category, style: CustomTextStyle.timeText),

//       const Spacer(),

//       /// Custom Time Picker
//       GestureDetector(
//         onTap: () => _changeTimeSlot(category),
//         child: Container(
//           padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey.shade500),
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Text(
//             "$start - $end",
//             style: TextStyle(fontSize: 12),
//           ),
//         ),
//       )
//     ],
//   );
// }



// Future<void> _changeTimeSlot(String category) async {
//   TimeOfDay? pickedStart = await showTimePicker(
//     context: context,
//     initialTime: _convertToTime(categoryTimes[category]!["start"]!),
//   );

//   if (pickedStart == null) return;

//   TimeOfDay? pickedEnd = await showTimePicker(
//     context: context,
//     initialTime: _convertToTime(categoryTimes[category]!["end"]!),
//   );

//   if (pickedEnd == null) return;

//   String start = _format(pickedStart);
//   String end = _format(pickedEnd);

//   setState(() {
//     categoryTimes[category]!["start"] = start;
//     categoryTimes[category]!["end"] = end;
//   });
// }



// TimeOfDay _convertToTime(String time) {
//   final parts = time.split(":");
//   return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
// }

// String _format(TimeOfDay time) {
//   final hour = time.hour.toString().padLeft(2, '0');
//   final min = time.minute.toString().padLeft(2, '0');
//   return "$hour:$min";
// }





//   Future<void> saveData() async {
//     // Prepare available timings
//     final availableTime = AdditionHelperItems().prepareAvailableTimings(_selectedAvailabilityTimes);

//     // Save food item using the controller
//     foodController.saveFoodItem(
//       foodCatId: widget.foodCateId ?? '',
//       foodImage: foodImage,
//       custPrice: _priceController.text,
//       discPrice: _discountController.text,
//       packPrice: _packageController.text,
//       commission: _commissionController.text,
//       foodCuisine: _cuisinetype.text,
//       foodDesc: _description.text,
//       foodName: _itemNameController.text,
//       foodType: _selectedFoodType.toLowerCase(),
//       prepTime: _preparationTime,
//       additionalImage1: _additionalImageUrl1.toString(),
//       additionalImage2: _additionalImageUrl2.toString(),
//       additionalImage3: _additionalImageUrl3.toString(),
//       additionalImage4: _additionalImageUrl4.toString(),
//       foodcuisineId: _selectedCuisineId ?? '',
//       availableTimings: availableTime,
//       ingredientsList: ingredientsList,
//       isCustomised: false,
//     );
//   }

//   String _normalizePrepTime(String prepTime) {
//     return prepTime.replaceAll(' ', '').toLowerCase(); // Remove spaces and convert to lowercase
//   }

//   void _initializeSelectedTimes() {
//     final availableTimings = parseAvailableTimings(widget.foodsListIndex?["availableTimings"]);
//     print(availableTimings!.length);

//     if (availableTimings.isEmpty) {
//       _selectedAvailabilityTimes = <String>{'lunch'};
//       print("av 1");
//     } else {
//       // Map and filter the types directly without re-parsing objects
//       _selectedAvailabilityTimes = availableTimings.map((timing) => timing.type) // Access type directly
//           .where((type) =>type != null && type.isNotEmpty) // Filter out invalid values
//           .cast<String>() // Ensure the result is a Set of Strings
//           .toSet();
//       print("av 2 $_selectedAvailabilityTimes");

//       // Add 'All' if it contains all meal types
//       if (_selectedAvailabilityTimes
//           .containsAll({'breakfast', 'lunch', 'dinner'})) {
//         _selectedAvailabilityTimes.add('All');
//       }
//     }
//   }

//   List<AvailableTiming>? parseAvailableTimings(dynamic timings) {
//     print("Input timings: $timings");
//     print("Type of timings: ${timings.runtimeType}");

//     if (timings == null) {
//       print("timings is null");
//       return null;
//     }

//     if (timings is List<dynamic>) {
//       print("timings is List<dynamic>");
//       print(timings);
//       try {
//         return timings.map((item) =>AvailableTiming.fromJson(item as Map<String, dynamic>)).toList();
//       } catch (e) {
//         print("Error converting List<dynamic> to List<AvailableTiming>: $e");
//         rethrow;
//       }
//     }

//     if (timings is List<AvailableTiming>) {
//       print("timings 2");
//       return timings;
//     } else if (timings is List<Map<String, dynamic>>) {
//       print("timings 3");
//       try {
//         return timings.map((json) => AvailableTiming.fromJson(json)).toList();
//       } catch (e) {
//         print("Error parsing timings: $e");
//         rethrow;
//       }
//     } else {
//       throw ArgumentError(
//           'Invalid type for available timings: ${timings.runtimeType}');
//     }
//   }

//   // Widget _buildFoodOption(String foodType) {
//   //   bool isSelected = _selectedFoodType == foodType;
//   //   return GestureDetector(
//   //     onTap: () {
//   //       setState(() {
//   //         _selectedFoodType = foodType;
//   //       });
//   //     },
//   //     child: Row(
//   //       children: <Widget>[
//   //         Container(
//   //           height: 15,
//   //           width: 15,
//   //           decoration: BoxDecoration(
//   //               shape: BoxShape.circle,
//   //               border: Border.all(
//   //                   color: isSelected
//   //                       ? const Color.fromARGB(255, 249, 88, 2)
//   //                       : Colors.black)),
//   //           child: Padding(
//   //             padding: const EdgeInsets.all(2.0),
//   //             child: CircleAvatar(
//   //               radius: 4,
//   //               backgroundColor: isSelected
//   //                   ? const Color.fromARGB(255, 249, 88, 2)
//   //                   : Colors.white,
//   //             ),
//   //           ),
//   //         ),
//   //         const SizedBox(width: 10),
//   //         Text(
//   //           foodType[0].toUpperCase() + foodType.substring(1),
//   //           style: CustomTextStyle.timeText,
//   //         ),
//   //       ],
//   //     ),
//   //   );
//   // }
// Widget _buildFoodOption(String foodType) {
//   bool isSelected = _selectedFoodType == foodType;
//   return GestureDetector(
//     onTap: () {
//       setState(() {
//         _selectedFoodType = foodType;
//       });
//     },
//     child: Row(
//       children: <Widget>[
//         Container(
//           height: 20, // Slightly bigger than 18
//           width: 20,
//           decoration: BoxDecoration(
//             shape: BoxShape.circle,
//             border: Border.all(
//               color: isSelected ? Color(0xFF623089) : const Color.fromARGB(142, 0, 0, 0),
//               width: 1.8,
//             ),
//           ),
//           child: Center(
//             child: Container(
//               height: 10, // Inner dot slightly bigger than before
//               width: 10,
//               decoration: BoxDecoration(
//                 shape: BoxShape.circle,
//                 color: isSelected ? Color(0xFF623089) : Colors.transparent,
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(width: 8),
//         Text(
//           foodType[0].toUpperCase() + foodType.substring(1),
//           style: CustomTextStyle.timeText.copyWith(fontSize: 15),
//         ),
//       ],
//     ),
//   );
// }
//   Widget _buildPreparationTime(String prepTime) {
//     bool isSelected = _preparationTime == _normalizePrepTime(prepTime);
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           _preparationTime = _normalizePrepTime(prepTime);
//         });
//       },
//       child:  Row(mainAxisSize: MainAxisSize.min, // This makes it wrap-friendly
//       children: <Widget>[
//         Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: Container(
//             height: 20, // Reduced from 24
//             width: 20,
//             decoration: BoxDecoration(
//               shape: BoxShape.circle,
//               border: Border.all(
//                 color: isSelected
//                     ?  Color(0xFF623089)
//                     : const Color.fromARGB(142, 0, 0, 0),
//                 width: 1.8,
//               ),
//             ),
//             child: Center(
//               child: Container(
//                 height: 10, // Reduced inner circle
//                 width: 10,
//                 decoration: BoxDecoration(
//                   shape: BoxShape.circle,
//                   color: isSelected
//                       ?  Color(0xFF623089)
//                       : Colors.transparent,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         const SizedBox(width: 10),
//         Text(
//           prepTime,
//           style: CustomTextStyle.timeText.copyWith(fontSize: 14),
//         ),
//       ],
//     ),
//       // Row(
//       //   children: <Widget>[
//       //     Container(
//       //       height: 15,
//       //       width: 15,
//       //       decoration: BoxDecoration(
//       //         shape: BoxShape.circle,
//       //         border: Border.all(
//       //           color: isSelected
//       //               ? const Color.fromARGB(255, 249, 88, 2)
//       //               : Colors.black,
//       //         ),
//       //       ),
//       //       child: Padding(
//       //         padding: const EdgeInsets.all(2.0),
//       //         child: CircleAvatar(
//       //           radius: 4,
//       //           backgroundColor: isSelected
//       //               ? const Color.fromARGB(255, 249, 88, 2)
//       //               : Colors.white,
//       //         ),
//       //       ),
//       //     ),
//       //     const SizedBox(width: 10),
//       //     Text(
//       //       prepTime,
//       //       style: CustomTextStyle.timeText,
//       //     ),
//       //   ],
//       // ),
  
//     );
//   }

//   // Widget _buildAvailabilityTimeOption(String availTime) {
//   //   bool isSelected = _selectedAvailabilityTimes.contains(availTime);

//   //   return GestureDetector(
//   //     onTap: () => setState(() {
//   //       if (availTime == 'All') {
//   //         if (!isSelected) {
//   //           _selectedAvailabilityTimes = {
//   //             'breakfast',
//   //             'lunch',
//   //             'dinner',
//   //             'All',
//   //           };
//   //         } else {
//   //           _selectedAvailabilityTimes.clear();
//   //         }
//   //       } else {
//   //         if (isSelected) {
//   //           _selectedAvailabilityTimes.remove(availTime);
//   //         } else {
//   //           _selectedAvailabilityTimes.add(availTime);
//   //         }

//   //         // Sync "All" state
//   //         if (_selectedAvailabilityTimes
//   //             .containsAll(['breakfast', 'lunch', 'dinner'])) {
//   //           _selectedAvailabilityTimes.add('All');
//   //         } else {
//   //           _selectedAvailabilityTimes.remove('All');
//   //         }
//   //       }
//   //       print(
//   //           'Updated _selectedAvailabilityTimes: $_selectedAvailabilityTimes');
//   //     }),
//   //     child: Row(
//   //       mainAxisSize: MainAxisSize.min,
//   //       children: [
//   //         Checkbox(
//   //           value: isSelected,
//   //           activeColor:  Color(0xFF623089),
//   //            side: const BorderSide(
//   //            color: Color.fromARGB(142, 0, 0, 0), 
//   //            width: 2,
//   //          ),
//   //           onChanged: (_) {
//   //             // Trigger same logic as tap
//   //             if (availTime == 'All') {
//   //               if (!isSelected) {
//   //                 _selectedAvailabilityTimes = {
//   //                   'breakfast',
//   //                   'lunch',
//   //                   'dinner',
//   //                   'All',
//   //                 };
//   //               } else {
//   //                 _selectedAvailabilityTimes.clear();
//   //               }
//   //             } else {
//   //               if (isSelected) {
//   //                 _selectedAvailabilityTimes.remove(availTime);
//   //               } else {
//   //                 _selectedAvailabilityTimes.add(availTime);
//   //               }

//   //               if (_selectedAvailabilityTimes
//   //                   .containsAll(['breakfast', 'lunch', 'dinner'])) {
//   //                 _selectedAvailabilityTimes.add('All');
//   //               } else {
//   //                 _selectedAvailabilityTimes.remove('All');
//   //               }
//   //             }
//   //             setState(() {});
//   //           },
//   //         ),
//   //         Text(availTime, style: CustomTextStyle.timeText),
//   //       ],
//   //     ),
//   //   );
//   // }

//   void _showCuisineDropdown(
//       BuildContext context, CuisineController cuisineController) {
//     Get.bottomSheet(
//       Container(
//         width: double.maxFinite,
//         height: MediaQuery.of(context).size.height * 0.5,
//         color: Colors.white,
//         child: ListView.builder(
//           itemCount: cuisineController.productCategory.length,
//           itemBuilder: (context, index) {
//             var cuisine = cuisineController.productCategory[index];
//             return ListTile(
//               title: Text(cuisine['foodCusineName']),
//               onTap: () {
//                 // Update the text field and the selected cuisine ID
//                 _cuisinetype.text = cuisine['foodCusineName'];
//                 _selectedCuisineId = cuisine['_id']; // Set the cuisine ID here
//                 print(
//                     "Cuisine selected: ${cuisine['foodCusineName']}"); // Debugging
//                 print("Cuisine ID: $_selectedCuisineId"); // Debugging
//                 Get.back(); // Close the dropdown
//               },
//             );
//           },
//         ),
//       ),
//       isScrollControlled: true,
//     );
//   }

//   bool _isPrimaryImageUploaded = false;
//   bool _isAdditionalImageUploaded1 = false;
//   bool _isAdditionalImageUploaded2 = false;
//   bool _isAdditionalImageUploaded3 = false;
//   bool _isAdditionalImageUploaded4 = false;
//   File? _pickedPrimaryImage;
//   String? _additionalImageUrl1,
//       _additionalImageUrl2,
//       _additionalImageUrl3,
//       _additionalImageUrl4;
//   File? _pickedAdditionalImage1,
//       _pickedAdditionalImage2,
//       _pickedAdditionalImage3,
//       _pickedAdditionalImage4;

//   @override
//   Widget build(BuildContext context) {
//     variantsController.initialize(
//       initialVariants: widget.variants,
//       initialGroupVariants: widget.groupVariants,
//       initialGroupNames: widget.groupNames,
//     );
//     return PopScope(
//       canPop: false,
//       onPopInvoked: (bool didPop) async {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => CategoryScreen(
//               foodCatId: widget.foodCateId,
//               foodCategory: widget.foodCat,
//             ),
//           ),
//         );
//       },
//       child: Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           leading: IconButton(
//             icon: Icon(Icons.arrow_back, color: Colors.grey.shade600),
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (context) => CategoryScreen(
//                     foodCatId: widget.foodCateId,
//                     foodCategory: widget.foodCat,
//                   ),
//                 ),
//               );
//             },
//           ),
//           title: InkWell(
//             onTap: () {
//               print(widget.isFromAddonscreen);
//             },
//             child: CustomText(
//               text: 'Edit Item',
//               style: CustomTextStyle.mediumGreyText,
//             ),
//           ),
//         ),
//         body: SingleChildScrollView(
//           child: Form(
//             key: editkey,
//             // autovalidateMode: AutovalidateMode.onUserInteraction,
//             child: Padding(
//               padding: const EdgeInsets.all(20.0),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CustomContainer(
//                     backgroundColor: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     width: MediaQuery.of(context).size.width / 1,
//                     child: Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.start, // Ensures proper alignment
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between title and icon
//                               children: [
//                                 CustomText(
//                                   text: 'Product image',
//                                   style: CustomTextStyle.mediumBoldBlackText,
//                                 ),
//                                 GestureDetector(
//                                  onTap: () {
//                                  setState(() {
//                                 _isProductExpanded = !_isProductExpanded;});},
//                                   child: Icon(
//                                     _isProductExpanded
//                                         ? MdiIcons.chevronUp
//                                         : MdiIcons.chevronDown,
//                                     color: Colors.grey.shade600,
//                                     size: 32,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           if (_isProductExpanded)
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start, // Aligns to start of the column
//                                 children: [
//                                   const SizedBox(height: 15),
//                                   CustomText(
//                                     text: 'Primary Image',
//                                     style: CustomTextStyle.categoryBlackText,
//                                   ),
//                                   const SizedBox(height: 10),
//                                   Column(
//                                     mainAxisAlignment:MainAxisAlignment.center,
//                                     children: [
//                                       CustomImagePicker(
//                                         imageUrl: '$baseImageUrl$foodImage',
//                                         image: _pickedPrimaryImage,
//                                         onTap: () async {
//                                           if (!_isPrimaryImageUploaded) {
//                                             _pickedPrimaryImage =await pickImageNew();
//                                             String fImg = await imageUploader.uploadReturnImage(file:_pickedPrimaryImage);
//                                             if (fImg != "null") {
//                                               setState(() {
//                                                 foodImage = fImg;
//                                                 _isPrimaryImageUploaded =true;
//                                               });
//                                             }
//                                           }
//                                         },
//                                         height: MediaQuery.of(context).size.height /12,
//                                         width: MediaQuery.of(context).size.width /5,
//                                       ),
//                                       // Display Cancel Icon if image is uploaded
//                                       if (_isPrimaryImageUploaded)
//                                         IconButton(
//                                           icon: Icon(
//                                             Icons.cancel,
//                                             size: 15,
//                                             color: Colors.grey,
//                                           ),
//                                           onPressed: () {
//                                             setState(() {
//                                               _pickedPrimaryImage = null;
//                                               _isPrimaryImageUploaded = false;
//                                             });
//                                           },
//                                         ),
//                                     ],
//                                   ),
                                 
//                                   const SizedBox(height: 15),
//                                   Text("Note : File size must be less than 500KB",style: CustomTextStyle.rejectred,),
//                                   const SizedBox(height: 15),
//                                   // CustomText(
//                                   //   text: 'Additional Image',
//                                   //   style: CustomTextStyle.categoryBlackText,
//                                   // ),
//                                   // const SizedBox(height: 10),
//                                   // Row(
//                                   //   mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between the image placeholders
//                                   //   children: [
//                                   //     Column(
//                                   //       mainAxisSize: MainAxisSize.min,
//                                   //       children: [
//                                   //         additionalImageDesign(
//                                   //           context: context,
//                                   //           imgUrl:_additionalImageUrl1 ?? "",
//                                   //           image: _pickedAdditionalImage1,
//                                   //           onTap: () async {
//                                   //             if (!_isAdditionalImageUploaded1) {
//                                   //               _pickedAdditionalImage1 =await pickImageNew();
//                                   //               String fImg = await imageUploader.uploadReturnImage(file:_pickedAdditionalImage1);
//                                   //               if (fImg != "null") {
//                                   //                 setState(() {
//                                   //                   _additionalImageUrl1 =fImg;
//                                   //                   _isAdditionalImageUploaded1 =true;
//                                   //                 });
//                                   //               }
//                                   //             }
//                                   //           },
//                                   //         ),
//                                   //         if (_isAdditionalImageUploaded1)
//                                   //           IconButton(
//                                   //             icon: Icon(
//                                   //               Icons.cancel,
//                                   //               size: 15,
//                                   //               color: Colors.grey,
//                                   //             ),
//                                   //             onPressed: () {
//                                   //               setState(() {
//                                   //                 _pickedAdditionalImage1 =null;
//                                   //                 _additionalImageUrl1 = "";
//                                   //                 _isAdditionalImageUploaded1 =false;
//                                   //               });
//                                   //             },
//                                   //           ),
//                                   //       ],
//                                   //     ),
//                                   //     Column(
//                                   //       mainAxisSize: MainAxisSize.min,
//                                   //       children: [
//                                   //         additionalImageDesign(
//                                   //           context: context,
//                                   //           imgUrl:_additionalImageUrl2 ?? "",
//                                   //           image: _pickedAdditionalImage2,
//                                   //           onTap: () async {
//                                   //             if (!_isAdditionalImageUploaded2) {
//                                   //               _pickedAdditionalImage2 =await pickImageNew();
//                                   //               String fImg = await imageUploader.uploadReturnImage(file:_pickedAdditionalImage2);
//                                   //               if (fImg != "null") {
//                                   //                 setState(() {
//                                   //                   _additionalImageUrl2 =fImg;
//                                   //                   _isAdditionalImageUploaded2 =true;
//                                   //                 });
//                                   //               }
//                                   //             }
//                                   //           },
//                                   //         ),
//                                   //         if (_isAdditionalImageUploaded2)
//                                   //           IconButton(
//                                   //             icon: Icon(
//                                   //               Icons.cancel,
//                                   //               size: 15,
//                                   //               color: Colors.grey,
//                                   //             ),
//                                   //             onPressed: () {
//                                   //               setState(() {
//                                   //                 _pickedAdditionalImage2 =null;
//                                   //                 _additionalImageUrl2 = "";
//                                   //                 _isAdditionalImageUploaded2 =false;
//                                   //               });
//                                   //             },
//                                   //           ),
//                                   //       ],
//                                   //     ),
//                                   //     Column(
//                                   //       mainAxisSize: MainAxisSize.min,
//                                   //       children: [
//                                   //         additionalImageDesign(
//                                   //           context: context,
//                                   //           imgUrl:_additionalImageUrl3 ?? "",
//                                   //           image: _pickedAdditionalImage3,
//                                   //           onTap: () async {
//                                   //             if (!_isAdditionalImageUploaded3) {
//                                   //               _pickedAdditionalImage3 =await pickImageNew();
//                                   //               String fImg = await imageUploader.uploadReturnImage(file:_pickedAdditionalImage3);
//                                   //               if (fImg != "null") {
//                                   //                 setState(() {
//                                   //                   _additionalImageUrl3 =fImg;
//                                   //                   _isAdditionalImageUploaded3 =true;
//                                   //                 });
//                                   //               }
//                                   //             }
//                                   //           },
//                                   //         ),
//                                   //         if (_isAdditionalImageUploaded3)
//                                   //           IconButton(
//                                   //             icon: Icon(
//                                   //               Icons.cancel,
//                                   //               size: 15,
//                                   //               color: Colors.grey,
//                                   //             ),
//                                   //             onPressed: () {
//                                   //               setState(() {
//                                   //                 _pickedAdditionalImage3 =null;
//                                   //                 _additionalImageUrl3 = "";
//                                   //                 _isAdditionalImageUploaded3 =false;
//                                   //               });
//                                   //             },
//                                   //           ),
//                                   //       ],
//                                   //     ),
//                                   //     Column(
//                                   //       mainAxisSize: MainAxisSize.min,
//                                   //       children: [
//                                   //         additionalImageDesign(
//                                   //           context: context,
//                                   //           imgUrl:_additionalImageUrl4 ?? "",
//                                   //           image: _pickedAdditionalImage4,
//                                   //           onTap: () async {
//                                   //             if (!_isAdditionalImageUploaded4) {
//                                   //               _pickedAdditionalImage4 =await pickImageNew();
//                                   //               String fImg = await imageUploader.uploadReturnImage(file:_pickedAdditionalImage4);
//                                   //               if (fImg != "null") {
//                                   //                 setState(() {
//                                   //                   _additionalImageUrl4 =fImg;
//                                   //                   _isAdditionalImageUploaded4 =true;
//                                   //                 });
//                                   //               }
//                                   //             }
//                                   //           },
//                                   //         ),
//                                   //         if (_isAdditionalImageUploaded4)
//                                   //           IconButton(
//                                   //             icon: Icon(
//                                   //               Icons.cancel,
//                                   //               size: 15,
//                                   //               color: Colors.grey,
//                                   //             ),
//                                   //             onPressed: () {
//                                   //               setState(() {
//                                   //                 _pickedAdditionalImage4 =null;
//                                   //                 _additionalImageUrl4 = "";
//                                   //                 _isAdditionalImageUploaded4 =false;
//                                   //               });
//                                   //             },
//                                   //           ),
//                                   //       ],
//                                   //     ),
//                                   //     // Display Cancel Icon if image is uploaded
//                                   //   ],
//                                   // ),
//                                 ],
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),

//                   // ),
//                   const SizedBox(height: 10),
//                   DishPricingDetails(
//                     showCuisineDropdown: (context, cuisineController) {
//                       _showCuisineDropdown(context, cuisineController);
//                     },
//                     buildFoodOption: _buildFoodOption,
//                     itemNameController: _itemNameController,
//                     cuisinetypeController: _cuisinetype,
//                     descriptionController: _description,
//                     ingredientsController: _ingredients,
//                     priceController: _priceController,
                    
//                     discountController: _discountController,
//                     packageController: _packageController,
//                     commissionController: _commissionController,
//                     ingredientsList: ingredientsList,
//                     selectedCuisineId: _selectedCuisineId,
//                     selectedFoodType: _selectedFoodType,
//                   ),
//   catres=="restaurant"? 
//                   CustomContainer(
//                     backgroundColor: Colors.white,
//                     borderRadius: BorderRadius.circular(10),
//                     width: MediaQuery.of(context).size.width / 1,
//                     child: Padding(
//                       padding: const EdgeInsets.all(5.0),
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                               children: [
//                                 CustomText(
//                                   text: 'Time',
//                                   style: CustomTextStyle.mediumBoldBlackText,
//                                 ),
//                                 GestureDetector(
//                                 onTap: () {
//                                 setState(() {
//                                 _isTimeExpanded = !_isTimeExpanded;});},
//                                   child: Icon(
//                                     _isTimeExpanded
//                                         ? MdiIcons.chevronUp
//                                         : MdiIcons.chevronDown,
//                                     color: Colors.grey.shade600,
//                                     size: 32,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           if (_isTimeExpanded)
//                             Column(
//                               crossAxisAlignment: CrossAxisAlignment.start,
//                               children: [
//                                 const SizedBox(height: 15),
//                                   catres=="restaurant"? 
//                                 CustomText(
//                                   text: 'Preparation time',
//                                   style: CustomTextStyle.categoryBlackText,
//                                 ):SizedBox.shrink(),
//                                   catres=="restaurant"? 
//                                 const SizedBox(height: 15):SizedBox.shrink(),
//                                 // SizedBox(
//                                 //   width:
//                                 //       MediaQuery.of(context).size.width / 1,
//                                 //   child: Row(
//                                 //     mainAxisAlignment:
//                                 //         MainAxisAlignment.spaceBetween,
//                                 //     children: <Widget>[
//                                 //       _buildPreparationTime('15 mins'),
//                                 //       _buildPreparationTime('30 mins'),
//                                 //       _buildPreparationTime('45 mins'),
//                                 //       _buildPreparationTime('60 mins')
//                                 //     ],
//                                 //   ),
//                                 // ),
//                                   catres=="restaurant"? 
//                                    Wrap(
//    spacing: 5,
//    runSpacing: 5,
//   children: [
//     _buildPreparationTime('No Time'),
//     _buildPreparationTime('5 mins'),
//     _buildPreparationTime('10 mins'),
//     _buildPreparationTime('15 mins'),
//     _buildPreparationTime('30 mins'),
//   ],
// ):SizedBox.shrink(),
//                                 const SizedBox(height: 15),
//                                 CustomText(
//                                   text: 'Availability time',
//                                   style: CustomTextStyle.categoryBlackText,
//                                 ),
//                                 const SizedBox(height: 15),
//                                 // Wrap(
//                                 //   spacing: 5,
//                                 //   runSpacing: 5,
//                                 //   children: [
//                                 //     for (var time in [
//                                 //       'breakfast',
//                                 //       'lunch',
//                                 //       'dinner',
//                                 //       'All'
//                                 //     ])
//                                 //       _buildAvailabilityTimeOption(time),
//                                 //   ],
//                                 // ),

//                                   for (var time in [
//                                       'breakfast',
//                                       'lunch',
//                                       'dinner',
//                                       'All'
//                                     ])
//                                       _buildAvailabilityTimeOption(time),
//                               ],
//                             ),
//                         ],
//                       ),
//                     ),
//                   ):SizedBox.shrink(),
//                   const SizedBox(height: 10),
//                   VariantDisplayContainer(),
//                   const SizedBox(height: 10),
//                   AddonsDisplayComponent(),
//                   const SizedBox(height: 20),
//                   // widget.foodsListIndex["iscustomizable"] == false
//                   //     ? Container()
//                   //     :
// //                     Padding(
// //                       padding: const EdgeInsets.symmetric(horizontal: 8,vertical: 8),
// //                       child: Row(
// //                         children: [
// //                           GestureDetector(
// //                             onTap: () async {
// //                               setState(() {
// //                                 isCustomized = true;
// //                               });
// //                               await saveData();
// //                               Get.to(() => CustomizationScreen(
// //                                     variantCateName: widget.variantGroupName,
// //                                     isEdit: true,
// //                                     variants: variants,
// //                                     FoodCat: widget.foodCat,
// //                                     FoodCatid: widget.foodCateId,
// //                                     foodsListIndex: widget.foodsListIndex,
// //                                     updatedvariants: widget.updatedvariants,
// //                                     updatedaddOns: widget.updatedAddOns,
// //                                   ));
// //                             },
// //                             child: 
// //                             // isCustomized? 
// //                             Row(
// //                                     children: [
// //                                       GradientText(
// //                                         text: 'Update Customization',
// //                                         style: CustomTextStyle.smallOrangeText,
// //                                         gradient: const LinearGradient(
// //                       begin: Alignment.topCenter,
// //                       end: Alignment.bottomCenter,
// //                       colors: [
                      
// //    Color(0xFFAE62E8),
// //  Color(0xFF623089)


// //                       ],
// //                                         ),
// //                                       ),
// //                                       const SizedBox(width: 4),
// //                                       const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Color(0xFFEE4C46)),
// //                                     ],
// //                                   )
// //                                 // : const SizedBox(),
// //                           ),
// //                         ],
// //                       ),
// //                     ),
//                     const SizedBox(height: 20),
//                   Center(
//                     child: CustomButton(
//                       borderRadius: BorderRadius.circular(20),
//                       height: MediaQuery.of(context).size.height / 23,
//                       width: MediaQuery.of(context).size.width / 2,
//                       onPressed: () async {
//                         if (isLoading) return ; // Prevent multiple clicks
//                         setState(() => isLoading = true); // Disable button
//                         var singleimage = foodImage.toString().isEmpty
//                             ? widget.foodsListIndex["foodImgUrl"].toString()
//                             : foodImage;
//                         print(_selectedAvailabilityTimes);
//                         final availableTimings = AdditionHelperItems()
//                             .prepareAvailableTimings(
//                                 _selectedAvailabilityTimes);
//                         print("available");
//                         print(availableTimings);
//                         print(_selectedFoodType.toLowerCase());
//                         print({
//                           "foodName": _itemNameController.text,
//                           "foodImage": singleimage,
//                           "mediumUrl": singleimage,
//                           "thumbUrl": singleimage,
//                           // "${widget.foodsListIndex?["foodImgUrl"].toString()}",
//                           "foodType": _selectedFoodType.toLowerCase(),
//                           "foodDesc": _description.text,
//                           "foodCateId": "${widget.foodCateId}",
//                           "foodCatName": widget.foodCat,
//                           "foodCuisine": _cuisinetype.text,
//                           "foodcuisineId": _selectedCuisineId,
//                           "foodId": widget.foodsListIndex?["_id"],
//                           "prepTime": _preparationTime,
//                           "custPrice": _priceController.text,
//                           "discPrice": _discountController.text,
//                           "packPrice": _packageController.text,
//                           "commission":_commissionController,
//                           "additionalImage1": _additionalImageUrl1,
//                           "additionalImage2": _additionalImageUrl2,
//                           "additionalImage3": _additionalImageUrl3,
//                           "additionalImage4": _additionalImageUrl4,
//                           "availableTimings": availableTimings,
//                           "ingredientsList": ingredientsList,
//                         });

//                         final groupNames = variantsController.addOns;
//                         final groupVariants =
//                             variantsController.groupVariants.map((group) {
//                           return group.map((variant) {
//                             final rawPrice =
//                                 variant["price"]?.toString() ?? "0.0";
//                             final cleanedPrice =
//                                 rawPrice.replaceAll(RegExp(r'[^\d.]'), '');
//                             final parsedPrice =
//                                 double.tryParse(cleanedPrice) ?? 0.0;

//                             print('Cleaned price: $cleanedPrice');
//                             print('Parsed price: $parsedPrice');

//                             return {
//                               "name": variant["name"],
//                               "price": parsedPrice,
//                             };
//                           }).toList();
//                         }).toList();
//                         print("addongroupnames: ${groupNames}");
//                         if (editkey.currentState!.validate()) {

//                           foodListController.foodUpdate(
//                             mediumUrl: singleimage, thumbUrl: singleimage,
//                            // status: "false",
//                             // groupNames: groupNames,
//                             // groupVariants: groupVariants,
//                             varianGroupName: widget.variantGroupName??"",
//                             // foodVariants: variantsController.variants,
//                             foodName: _itemNameController.text,
//                             foodImage: singleimage,
//                             // "${widget.foodsListIndex?["foodImgUrl"].toString()}",
//                             foodType: _selectedFoodType.toLowerCase()??"veg",
//                             foodDesc: _description.text,
//                             foodCatId: "${widget.foodCateId}",
//                             foodCatName: widget.foodCat,
//                             foodCuisine: _cuisinetype.text,
//                             foodcuisineId: _selectedCuisineId,
//                             foodId: widget.foodsListIndex?["_id"],
//                             prepTime: _preparationTime,
//                             custPrice: _priceController.text,
//                             discPrice: _discountController.text,
//                             packPrice: _packageController.text,
//                             commissionPrice: widget.foodsListIndex["commission"] == 0 ? profilScreeenController.restaurantCommission ??0 :widget.foodsListIndex["commission"],
//                             iscustomizable:variantsController.variantList.isNotEmpty?true: false,
//                             additionalImage1: _additionalImageUrl1 ?? "",
//                             additionalImage2: _additionalImageUrl2 ?? "",
//                             additionalImage3: _additionalImageUrl3 ?? "",
//                             additionalImage4: _additionalImageUrl4 ?? "",
//                             availableTimings: availableTimings,
//                             ingredientsList: ingredientsList??[],
//                           );
//                        print(" COMMISSION ${widget.foodsListIndex["commission"]}");
//                         } else {
//                           Get.snackbar("Error", "Fill the required Fields",
//                               backgroundColor: Customcolors.decorationred);
//                           setState(() => isLoading =
//                               false); // Enable button after processing
//                         }
//                       },
//                       child: 
//                       // isLoading
//                       //     ? LoadingAnimationWidget.newtonCradle(
//                       //         color: Colors.white, size: 70) // Show loader
//                       //     :
//                            CustomText(
//                               text: 'Confirm',
//                               style: CustomTextStyle.mediumWhiteText),
//                     ),
//                   ),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }





































// ignore_for_file: avoid_print

import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/Controllers/CategoryController/cusinecontroller.dart';
import 'package:miogra_seller/Controllers/CategoryController/foodcontroller.dart';
import 'package:miogra_seller/Controllers/CategoryController/foodlistcontroller.dart';
import 'package:miogra_seller/Controllers/CategoryController/variantaddonscontroller.dart';
import 'package:miogra_seller/Controllers/FileuploadController/FileUploader.dart';
import 'package:miogra_seller/Controllers/ProfileController/profileget.dart';
import 'package:miogra_seller/Model/getfoodlistmodel.dart';
import 'package:miogra_seller/Screens/Menu/categoryscreen.dart';
import 'package:miogra_seller/Screens/Menu/customizationscreen.dart';
import 'package:miogra_seller/Screens/Menu/customizedComponents/Editsubscreen.dart';
import 'package:miogra_seller/Screens/Menu/customizedComponents/addons_display_component.dart';
import 'package:miogra_seller/Screens/Menu/customizedComponents/variants_display_component.dart';
import 'package:miogra_seller/Screens/Menu/itemsHelperScreen.dart';
import 'package:miogra_seller/Screens/Menu/variantsscreen.dart';
import 'package:miogra_seller/Widgets/custom_button.dart';
import 'package:miogra_seller/Widgets/custom_colors.dart';
import 'package:miogra_seller/Widgets/custom_container.dart';
import 'package:miogra_seller/Widgets/custom_gradienttext.dart';
import 'package:miogra_seller/Widgets/custom_imagepicker.dart';
import 'package:miogra_seller/Widgets/custom_text.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';
import 'package:get/get.dart';

class EditItemScreen extends StatefulWidget {
  final String? foodCateId;
  final String? foodCat;
  final dynamic foodsListIndex;
  final List<Variant>? variants;
  final List<String>? groupNames;
  final String? variantGroupName;
  final List<List<Map<String, String>>>? groupVariants;
  final bool isCustomizedScreen;
  bool isFromAddonscreen;
  bool isFromVariantscreen;
  List<Map<String, dynamic>>? updatedAddOns;
  List<Map<String, dynamic>>? updatedvariants;

  EditItemScreen(
      {super.key,
      this.foodCateId,
      this.updatedAddOns,
      this.updatedvariants,
      this.foodCat,
      this.foodsListIndex,
      this.variants,
      this.groupVariants,
      this.groupNames,
      this.variantGroupName,
      this.isCustomizedScreen = false,
      this.isFromAddonscreen = false,
      this.isFromVariantscreen = false});

  @override
  State<EditItemScreen> createState() => _EditItemScreenState();
}

class _EditItemScreenState extends State<EditItemScreen> {
  late TextEditingController _itemNameController;
  late TextEditingController _description;
  late TextEditingController _cuisinetype;
  final TextEditingController _ingredients = TextEditingController();
  late TextEditingController _priceController;
  late TextEditingController _discountController;
  late TextEditingController _packageController;
  late TextEditingController _commissionController;
  bool _isProductExpanded = false;
  bool _isTimeExpanded = false;
  final editkey = GlobalKey<FormState>();
  final VariantsController variantsController = Get.put(VariantsController());
  final ProfilScreeenController profilScreeenController = Get.put(ProfilScreeenController());
  final FoodController foodController = Get.put(FoodController());

  String? _selectedCuisineId; // Variable to store the selected cuisine ID
  String? cuisineID;

  final CuisineController cuisineController = Get.put(CuisineController());
  final ImageUploader imageUploader = Get.put(ImageUploader());
  final FoodListController foodListController = Get.put(FoodListController());
  late String _selectedFoodType;
  late String _preparationTime;
  Set<String> _selectedAvailabilityTimes = {};
  late List<String> ingredientsList = ["ggg"];
  bool isContainerVisible = false;
  String foodImage = '';
  bool isCustomized = false;
  bool isLoading = false;
  List<Variant> variants = [];

  dataAdded() {
    var food = foodController.foodItem.value;
    isCustomized = widget.foodsListIndex?["iscustomizable"];

    var itemName = widget.foodsListIndex?["foodName"] ?? food?.foodName;
    _itemNameController = TextEditingController(text: itemName);

    var foodDesc = widget.foodsListIndex?["foodDiscription"] ?? food?.foodDesc;
    _description = TextEditingController(text: foodDesc);

    var cuisine = widget.foodsListIndex?["foodCusineDetails"]?["foodCusineName"] ??food?.foodCuisine;
    _selectedCuisineId = widget.foodsListIndex?["foodCusineDetails"]?["_id"] ??food?.foodcuisineId;
    print('CUISINE..........$cuisine');

    _cuisinetype = TextEditingController(text: cuisine);

    var foodPrice =widget.foodsListIndex?["food"]?["basePrice"]?.toString() ??food?.custPrice;
    _priceController = TextEditingController(text: foodPrice);

    var foodDiscount =widget.foodsListIndex?["food"]?["discount"]?.toString() ??food?.discPrice;
    _discountController = TextEditingController(text: foodDiscount);

    var foodPack =widget.foodsListIndex?["food"]?["packagingCharge"]?.toString() ??food?.packPrice;
    _packageController = TextEditingController(text: foodPack);

    var foodcommission =widget.foodsListIndex?["food"]?["commission"]?.toString() ??food?.commission;
    _commissionController = TextEditingController(text: foodcommission);

    _selectedFoodType = AdditionHelperItems().mapFoodType(widget.foodsListIndex?["foodType"] ?? food?.foodType);
    _preparationTime = AdditionHelperItems().mapPreparationTime(widget.foodsListIndex?["preparationTime"] ?? food?.prepTime);

    isContainerVisible = true;

    ingredientsList = widget.foodsListIndex?["ingredients"].isEmpty
        ? []
        : widget.foodsListIndex?["ingredients"].cast<String>();

    _selectedAvailabilityTimes = <String>{'Afternoon'};

    foodImage = widget.foodsListIndex!["foodImgUrl"].toString();

    // Additional images
    if (widget.foodsListIndex!["additionalImage"].isNotEmpty) {
      _additionalImageUrl1 =widget.foodsListIndex!["additionalImage"].length >= 1
              ? widget.foodsListIndex!["additionalImage"][0].toString()
              : "null";
      _additionalImageUrl2 =widget.foodsListIndex!["additionalImage"].length >= 2
              ? widget.foodsListIndex!["additionalImage"][1].toString()
              : "null";
      _additionalImageUrl3 =widget.foodsListIndex!["additionalImage"].length >= 3
              ? widget.foodsListIndex!["additionalImage"][2].toString()
              : "null";
      _additionalImageUrl4 =widget.foodsListIndex!["additionalImage"].length >= 4
              ? widget.foodsListIndex!["additionalImage"][3].toString()
              : "null";
    }

    _initializeSelectedTimes();
  }

  @override
  @override
  void initState() {
    super.initState();
    cuisineController.getCuisinetype();
    _isProductExpanded = true;
    _isTimeExpanded = true;
    dataAdded();
    print("______________________@ ${widget.variants}");
    print("______________________@ ${widget.foodsListIndex?["iscustomizable"]}");

    // Post-frame callback ensures state updates happen after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.foodsListIndex?["iscustomizable"] == true) {
        if (widget
            .foodsListIndex?["customizedFood"]["addVariants"].isNotEmpty) {
          for (int i = 0;
              i <widget.foodsListIndex?["customizedFood"]["addVariants"][0]["variantType"].length;i++) {
            variants.add(Variant(
              variantGroupName:"${widget.foodsListIndex?["customizedFood"]["addVariants"][0]["variantGroupName"]}",
              name:"${widget.foodsListIndex?["customizedFood"]["addVariants"][0]["variantType"][i]["variantName"]}",
              price:"${widget.foodsListIndex?["customizedFood"]["addVariants"][0]["variantType"][i]["customerPrice"]}",
            ));
          }
        }

        // **Extract AddOns**
        dynamic addOnsList = [];
        if (widget.foodsListIndex?["customizedFood"]["addOns"].isNotEmpty) {
          addOnsList = List<Map<String, dynamic>>.from(widget.foodsListIndex?["customizedFood"]["addOns"]);
        }

        // **Extract AddOns**
        dynamic variantList = [];
        if (widget.foodsListIndex?["customizedFood"]["addVariants"].isNotEmpty) {
          variantList = List<Map<String, dynamic>>.from(widget.foodsListIndex?["customizedFood"]["addVariants"]);
        }

        // Debugging AddOns (Print after delay)
        Timer(Duration(seconds: 2), () {
          print("_________________________________________%");
          variants.forEach((variant) => print(variant.variantGroupName));
          addOnsList.forEach(
              (addOn) => print("AddOn Group: ${addOn["addOnsGroupName"]}"));
          variantList.forEach(
              (addOn) => print("Variant Group: ${addOn["variantGroupName"]}"));
        });

        // Initialize controller safely
        variantsController.initialize(
          initialVariants: variants,
          initialGroupVariants: widget.groupVariants,
          initialGroupNames: widget.groupNames,
        );
        // **Send AddOns to Controller**
        // variantsController.initializeAddOns(addOnsList);
        // Send extracted AddOn list to the controller
        if (widget.isFromAddonscreen) {
          print("upppppp${widget.updatedAddOns}");
          variantsController.initializeAddOns(widget.updatedAddOns);
        } else if (widget.isFromVariantscreen) {
          print("variant in editscreenint:${widget.updatedvariants}");
          variantsController.initializevariant(widget.updatedvariants);
        } else {
          print("opppppp");
          variantsController.initializeAddOns(addOnsList);
          variantsController.initializevariant(variantList);
        }
      }

      print("varients list +++++++++++++++++++++++++++++++++++++++++++++++");
      print("var ${widget.variants}");
      print("group va ${widget.groupVariants}");
      print("group name in edit screen: ${widget.groupNames}");

      // Final initialization in post-frame callback
      variantsController.initialize(
        initialVariants: widget.variants,
        initialGroupVariants: widget.groupVariants,
        initialGroupNames: widget.groupNames,
      );
    });
  }



Map<String, Map<String, String>> categoryTimes = {
   "Morning": {"start": "09:00", "end": "11:00"},
  "Afternoon": {"start": "11:00", "end": "15:00"},
  "Evening": {"start": "15:00", "end": "18:00"},
  "Night": {"start": "18:00", "end": "22:00"},
  "Mid-night": {"start": "22:00", "end": "00:00"},
  "All": {"start": "00:00", "end": "23:59"},
};

//Set<String> selectedCategories = {};



Widget _buildAvailabilityTimeOption(String category) {
  bool isSelected = _selectedAvailabilityTimes.contains(category);

  String start = categoryTimes[category]!["start"]!;
  String end = categoryTimes[category]!["end"]!;

  return Row(
    children: [
      Checkbox(
        value: isSelected,
        activeColor: Color(0xFF623089),
        onChanged: (value) {
          setState(() {
            if (value == true) {
             _selectedAvailabilityTimes.add(category);
            } else {
             _selectedAvailabilityTimes.remove(category);
            }
          });
        },
      ),

      /// Category Name
      Text(category, style: CustomTextStyle.timeText),

      const Spacer(),

      /// Custom Time Picker
      GestureDetector(
        onTap: () => _changeTimeSlot(category),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey.shade500),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            "$start - $end",
            style: TextStyle(fontSize: 12),
          ),
        ),
      )
    ],
  );
}



Future<void> _changeTimeSlot(String category) async {
  TimeOfDay? pickedStart = await showTimePicker(
    context: context,
    initialTime: _convertToTime(categoryTimes[category]!["start"]!),
  );

  if (pickedStart == null) return;

  TimeOfDay? pickedEnd = await showTimePicker(
    context: context,
    initialTime: _convertToTime(categoryTimes[category]!["end"]!),
  );

  if (pickedEnd == null) return;

  String start = _format(pickedStart);
  String end = _format(pickedEnd);

  setState(() {
    categoryTimes[category]!["start"] = start;
    categoryTimes[category]!["end"] = end;
  });
}



TimeOfDay _convertToTime(String time) {
  final parts = time.split(":");
  return TimeOfDay(hour: int.parse(parts[0]), minute: int.parse(parts[1]));
}

String _format(TimeOfDay time) {
  final hour = time.hour.toString().padLeft(2, '0');
  final min = time.minute.toString().padLeft(2, '0');
  return "$hour:$min";
}




  Future<void> saveData() async {
    // Prepare available timings
    final availableTime = AdditionHelperItems() .prepareAvailableTimings(_selectedAvailabilityTimes, categoryTimes);
    //.prepareAvailableTimings(_selectedAvailabilityTimes,);

    // Save food item using the controller
    foodController.saveFoodItem(
      foodCatId: widget.foodCateId ?? '',
      foodImage: foodImage,
      custPrice: _priceController.text,
      discPrice: _discountController.text,
      packPrice: _packageController.text,
      commission: _commissionController.text,
      foodCuisine: _cuisinetype.text,
      foodDesc: _description.text,
      foodName: _itemNameController.text,
      foodType: _selectedFoodType.toLowerCase(),
      prepTime: _preparationTime,
      additionalImage1: _additionalImageUrl1.toString(),
      additionalImage2: _additionalImageUrl2.toString(),
      additionalImage3: _additionalImageUrl3.toString(),
      additionalImage4: _additionalImageUrl4.toString(),
      foodcuisineId: _selectedCuisineId ?? '',
      availableTimings: availableTime,
      ingredientsList: ingredientsList,
      isCustomised: false,
    );
  }

  String _normalizePrepTime(String prepTime) {
    return prepTime.replaceAll(' ', '').toLowerCase(); // Remove spaces and convert to lowercase
  }

  void _initializeSelectedTimes() {
  var timings = parseAvailableTimings(widget.foodsListIndex?["availableTimings"]);

  if (timings == null || timings.isEmpty) {
    _selectedAvailabilityTimes = {};
    return;
  }

  // 🟣 1. Restore category selections
  _selectedAvailabilityTimes = timings
      .map((t) => _normalize(t.type!))
      .where((t) => t.isNotEmpty)
      .toSet();

  // ➕ Auto include ALL
  if (_selectedAvailabilityTimes.containsAll({
    "Morning", "Afternoon", "Evening",'Night','Mid-night'
  })) {
    _selectedAvailabilityTimes.add("All");
  }

  // 🟣 2. RESTORE TIME RANGES into `categoryTimes`
  for (var t in timings) {
    final key = _normalize(t.type!);

    if (categoryTimes.containsKey(key)) {
      categoryTimes[key]!["start"] = t.from!;
      categoryTimes[key]!["end"] = t.to!;
    }
  }

  print("RESTORED categoryTimes => $categoryTimes");
}

String _normalize(String txt) {
  if (txt.toLowerCase() == "all") return "All";
  return txt[0].toUpperCase() + txt.substring(1).toLowerCase();
}

  // void _initializeSelectedTimes() {
  //   final availableTimings = parseAvailableTimings(widget.foodsListIndex?["availableTimings"]);
  //   print(availableTimings!.length);

  //   if (availableTimings.isEmpty) {
  //     _selectedAvailabilityTimes = <String>{'lunch'};
  //     print("av 1");
  //   } else {
  //     // Map and filter the types directly without re-parsing objects
  //     _selectedAvailabilityTimes = availableTimings.map((timing) => timing.type) // Access type directly
  //         .where((type) =>type != null && type.isNotEmpty) // Filter out invalid values
  //         .cast<String>() // Ensure the result is a Set of Strings
  //         .toSet();
  //     print("av 2 $_selectedAvailabilityTimes");

  //     // Add 'All' if it contains all meal types
  //     if (_selectedAvailabilityTimes
  //         .containsAll({'Breakfast', 'Lunch', 'Dinner'})) {
  //       _selectedAvailabilityTimes.add('All');
  //     }
  //   }
  // }

  List<AvailableTiming>? parseAvailableTimings(dynamic timings) {
    print("Input timings: $timings");
    print("Type of timings: ${timings.runtimeType}");

    if (timings == null) {
      print("timings is null");
      return null;
    }

    if (timings is List<dynamic>) {
      print("timings is List<dynamic>");
      print(timings);
      try {
        return timings.map((item) =>AvailableTiming.fromJson(item as Map<String, dynamic>)).toList();
      } catch (e) {
        print("Error converting List<dynamic> to List<AvailableTiming>: $e");
        rethrow;
      }
    }

    if (timings is List<AvailableTiming>) {
      print("timings 2");
      return timings;
    } else if (timings is List<Map<String, dynamic>>) {
      print("timings 3");
      try {
        return timings.map((json) => AvailableTiming.fromJson(json)).toList();
      } catch (e) {
        print("Error parsing timings: $e");
        rethrow;
      }
    } else {
      throw ArgumentError(
          'Invalid type for available timings: ${timings.runtimeType}');
    }
  }

Widget _buildFoodOption(String foodType) {
  bool isSelected = _selectedFoodType == foodType;
  return GestureDetector(
    onTap: () {
      setState(() {
        _selectedFoodType = foodType;
      });
    },
    child: Row(
      children: <Widget>[
        Container(
          height: 20, // Slightly bigger than 18
          width: 20,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: isSelected ? Color(0xFF623089) : const Color.fromARGB(142, 0, 0, 0),
              width: 1.8,
            ),
          ),
          child: Center(
            child: Container(
              height: 10, // Inner dot slightly bigger than before
              width: 10,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected ? Color(0xFF623089) : Colors.transparent,
              ),
            ),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          foodType[0].toUpperCase() + foodType.substring(1),
          style: CustomTextStyle.timeText.copyWith(fontSize: 15),
        ),
      ],
    ),
  );
}
  Widget _buildPreparationTime(String prepTime) {
    bool isSelected = _preparationTime == _normalizePrepTime(prepTime);
    return GestureDetector(
      onTap: () {
        setState(() {
          _preparationTime = _normalizePrepTime(prepTime);
        });
      },
      child:  Row(mainAxisSize: MainAxisSize.min, // This makes it wrap-friendly
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            height: 20, // Reduced from 24
            width: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected
                    ?  Color(0xFF623089)
                    : const Color.fromARGB(142, 0, 0, 0),
                width: 1.8,
              ),
            ),
            child: Center(
              child: Container(
                height: 10, // Reduced inner circle
                width: 10,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: isSelected
                      ?  Color(0xFF623089)
                      : Colors.transparent,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        Text(
          prepTime,
          style: CustomTextStyle.timeText.copyWith(fontSize: 14),
        ),
      ],
    ),
      
    );
  }


  void _showCuisineDropdown(
      BuildContext context, CuisineController cuisineController) {
    Get.bottomSheet(
      Container(
        width: double.maxFinite,
        height: MediaQuery.of(context).size.height * 0.5,
        color: Colors.white,
        child: ListView.builder(
          itemCount: cuisineController.productCategory.length,
          itemBuilder: (context, index) {
            var cuisine = cuisineController.productCategory[index];
            return ListTile(
              title: Text(cuisine['foodCusineName']),
              onTap: () {
                // Update the text field and the selected cuisine ID
                _cuisinetype.text = cuisine['foodCusineName'];
                _selectedCuisineId = cuisine['_id']; // Set the cuisine ID here
                print(
                    "Cuisine selected: ${cuisine['foodCusineName']}"); // Debugging
                print("Cuisine ID: $_selectedCuisineId"); // Debugging
                Get.back(); // Close the dropdown
              },
            );
          },
        ),
      ),
      isScrollControlled: true,
    );
  }

  bool _isPrimaryImageUploaded = false;
  bool _isAdditionalImageUploaded1 = false;
  bool _isAdditionalImageUploaded2 = false;
  bool _isAdditionalImageUploaded3 = false;
  bool _isAdditionalImageUploaded4 = false;
  File? _pickedPrimaryImage;
  String? _additionalImageUrl1,
      _additionalImageUrl2,
      _additionalImageUrl3,
      _additionalImageUrl4;
  File? _pickedAdditionalImage1,
      _pickedAdditionalImage2,
      _pickedAdditionalImage3,
      _pickedAdditionalImage4;

  @override
  Widget build(BuildContext context) {
    variantsController.initialize(
      initialVariants: widget.variants,
      initialGroupVariants: widget.groupVariants,
      initialGroupNames: widget.groupNames,
    );
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryScreen(
              foodCatId: widget.foodCateId,
              foodCategory: widget.foodCat,
            ),
          ),
        );
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.grey.shade600),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CategoryScreen(
                    foodCatId: widget.foodCateId,
                    foodCategory: widget.foodCat,
                  ),
                ),
              );
            },
          ),
          title: InkWell(
            onTap: () {
              print(widget.isFromAddonscreen);
            },
            child: CustomText(
              text: 'Edit Item',
              style: CustomTextStyle.mediumGreyText,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Form(
            key: editkey,
            
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomContainer(
                    backgroundColor: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    width: MediaQuery.of(context).size.width / 1,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start, // Ensures proper alignment
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween, // Space between title and icon
                              children: [
                                CustomText(
                                  text: 'Product image',
                                  style: CustomTextStyle.mediumBoldBlackText,
                                ),
                                GestureDetector(
                                 onTap: () {
                                 setState(() {
                                _isProductExpanded = !_isProductExpanded;});},
                                  child: Icon(
                                    _isProductExpanded
                                        ? MdiIcons.chevronUp
                                        : MdiIcons.chevronDown,
                                    color: Colors.grey.shade600,
                                    size: 32,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_isProductExpanded)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start, // Aligns to start of the column
                                children: [
                                  const SizedBox(height: 15),
                                  CustomText(
                                    text: 'Primary Image',
                                    style: CustomTextStyle.categoryBlackText,
                                  ),
                                  const SizedBox(height: 10),
                                  Column(
                                    mainAxisAlignment:MainAxisAlignment.center,
                                    children: [
                                      CustomImagePicker(
                                        imageUrl: '$baseImageUrl$foodImage',
                                        image: _pickedPrimaryImage,
                                        onTap: () async {
                                          if (!_isPrimaryImageUploaded) {
                                            _pickedPrimaryImage =await pickImageNew();
                                            String fImg = await imageUploader.uploadReturnImage(file:_pickedPrimaryImage);
                                            if (fImg != "null") {
                                              setState(() {
                                                foodImage = fImg;
                                                _isPrimaryImageUploaded =true;
                                              });
                                            }
                                          }
                                        },
                                        height: MediaQuery.of(context).size.height /12,
                                        width: MediaQuery.of(context).size.width /5,
                                      ),
                                      // Display Cancel Icon if image is uploaded
                                      if (_isPrimaryImageUploaded)
                                        IconButton(
                                          icon: Icon(
                                            Icons.cancel,
                                            size: 15,
                                            color: Colors.grey,
                                          ),
                                          onPressed: () {
                                            setState(() {
                                              _pickedPrimaryImage = null;
                                              _isPrimaryImageUploaded = false;
                                            });
                                          },
                                        ),
                                    ],
                                  ),
                                 
                                  const SizedBox(height: 15),
                                  Text("Note : File size must be less than 500KB",style: CustomTextStyle.rejectred,),
                                  const SizedBox(height: 15),
                             
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  // ),
                  const SizedBox(height: 10),
                  DishPricingDetails(
                    showCuisineDropdown: (context, cuisineController) {
                      _showCuisineDropdown(context, cuisineController);
                    },
                    buildFoodOption: _buildFoodOption,
                    itemNameController: _itemNameController,
                    cuisinetypeController: _cuisinetype,
                    descriptionController: _description,
                    ingredientsController: _ingredients,
                    priceController: _priceController,
                    
                    discountController: _discountController,
                    packageController: _packageController,
                    commissionController: _commissionController,
                    ingredientsList: ingredientsList,
                    selectedCuisineId: _selectedCuisineId,
                    selectedFoodType: _selectedFoodType,
                  ),
  catres=="restaurant"? 
                  CustomContainer(
                    backgroundColor: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    width: MediaQuery.of(context).size.width / 1,
                    child: Padding(
                      padding: const EdgeInsets.all(5.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                  text: 'Time',
                                  style: CustomTextStyle.mediumBoldBlackText,
                                ),
                                GestureDetector(
                                onTap: () {
                                setState(() {
                                _isTimeExpanded = !_isTimeExpanded;});},
                                  child: Icon(
                                    _isTimeExpanded
                                        ? MdiIcons.chevronUp
                                        : MdiIcons.chevronDown,
                                    color: Colors.grey.shade600,
                                    size: 32,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_isTimeExpanded)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 15),
                                  catres=="restaurant"? 
                                CustomText(
                                  text: 'Preparation time',
                                  style: CustomTextStyle.categoryBlackText,
                                ):SizedBox.shrink(),
                                  catres=="restaurant"? 
                                const SizedBox(height: 15):SizedBox.shrink(),
                               
                                  catres=="restaurant"? 
                                   Wrap(
   spacing: 5,
   runSpacing: 5,
  children: [
    _buildPreparationTime('No Time'),
    _buildPreparationTime('5 mins'),
    _buildPreparationTime('10 mins'),
    _buildPreparationTime('15 mins'),
    _buildPreparationTime('30 mins'),
  ],
):SizedBox.shrink(),
                                const SizedBox(height: 15),
                                CustomText(
                                  text: 'Availability time',
                                  style: CustomTextStyle.categoryBlackText,
                                ),
                                const SizedBox(height: 15),
                              
                                  for (var time in [
                                  'Morning',
                                  'Afternoon',
                                  'Evening',
                                  'Night',
                                  'Mid-night',
                                  'All'
                                    ])
                                      _buildAvailabilityTimeOption(time),
                              ],
                            ),
                        ],
                      ),
                    ),
                  ):SizedBox.shrink(),
                  const SizedBox(height: 10),
                  VariantDisplayContainer(),
                  const SizedBox(height: 10),
                  AddonsDisplayComponent(),
                  const SizedBox(height: 20),
                 
                    const SizedBox(height: 20),
                  Center(
                    child: CustomButton(
                      borderRadius: BorderRadius.circular(20),
                      height: MediaQuery.of(context).size.height / 23,
                      width: MediaQuery.of(context).size.width / 2,
                      onPressed: () async {
                        if (isLoading) return ; // Prevent multiple clicks
                        setState(() => isLoading = true); // Disable button
                        var singleimage = foodImage.toString().isEmpty
                            ? widget.foodsListIndex["foodImgUrl"].toString()
                            : foodImage;
                        print(_selectedAvailabilityTimes);
                        final availableTimings =
                           AdditionHelperItems() .prepareAvailableTimings(_selectedAvailabilityTimes, categoryTimes);
                        // final availableTimings = AdditionHelperItems()
                        //     .prepareAvailableTimings(
                        //         _selectedAvailabilityTimes);
                        print("available");
                        print(availableTimings);
                        print(_selectedFoodType.toLowerCase());
                        print({
                          "foodName": _itemNameController.text,
                          "foodImage": singleimage,
                          "mediumUrl": singleimage,
                          "thumbUrl": singleimage,
                          // "${widget.foodsListIndex?["foodImgUrl"].toString()}",
                          "foodType": _selectedFoodType.toLowerCase(),
                          "foodDesc": _description.text,
                          "foodCateId": "${widget.foodCateId}",
                          "foodCatName": widget.foodCat,
                          "foodCuisine": _cuisinetype.text,
                          "foodcuisineId": _selectedCuisineId,
                          "foodId": widget.foodsListIndex?["_id"],
                          "prepTime": _preparationTime,
                          "custPrice": _priceController.text,
                          "discPrice": _discountController.text,
                          "packPrice": _packageController.text,
                          "commission":_commissionController,
                          "additionalImage1": _additionalImageUrl1,
                          "additionalImage2": _additionalImageUrl2,
                          "additionalImage3": _additionalImageUrl3,
                          "additionalImage4": _additionalImageUrl4,
                          "availableTimings": availableTimings,
                          "ingredientsList": ingredientsList,
                        });

                        final groupNames = variantsController.addOns;
                        final groupVariants =
                            variantsController.groupVariants.map((group) {
                          return group.map((variant) {
                            final rawPrice =
                                variant["price"]?.toString() ?? "0.0";
                            final cleanedPrice =
                                rawPrice.replaceAll(RegExp(r'[^\d.]'), '');
                            final parsedPrice =
                                double.tryParse(cleanedPrice) ?? 0.0;

                            print('Cleaned price: $cleanedPrice');
                            print('Parsed price: $parsedPrice');

                            return {
                              "name": variant["name"],
                              "price": parsedPrice,
                            };
                          }).toList();
                        }).toList();
                        print("addongroupnames: ${groupNames}");
                        if (editkey.currentState!.validate()) {

                          foodListController.foodUpdate(
                            mediumUrl: singleimage, thumbUrl: singleimage,
                           
                            varianGroupName: widget.variantGroupName??"",
                            // foodVariants: variantsController.variants,
                            foodName: _itemNameController.text,
                            foodImage: singleimage,
                            // "${widget.foodsListIndex?["foodImgUrl"].toString()}",
                            foodType: _selectedFoodType.toLowerCase()??"veg",
                            foodDesc: _description.text,
                            foodCatId: "${widget.foodCateId}",
                            foodCatName: widget.foodCat,
                            foodCuisine: _cuisinetype.text,
                            foodcuisineId: _selectedCuisineId,
                            foodId: widget.foodsListIndex?["_id"],
                            prepTime: _preparationTime,
                            custPrice: _priceController.text,
                            discPrice: _discountController.text,
                            packPrice: _packageController.text,
                            commissionPrice: widget.foodsListIndex["commission"] == 0 ? profilScreeenController.restaurantCommission ??0 :widget.foodsListIndex["commission"],
                            iscustomizable:variantsController.variantList.isNotEmpty?true: false,
                            additionalImage1: _additionalImageUrl1 ?? "",
                            additionalImage2: _additionalImageUrl2 ?? "",
                            additionalImage3: _additionalImageUrl3 ?? "",
                            additionalImage4: _additionalImageUrl4 ?? "",
                            availableTimings: availableTimings,
                            ingredientsList: ingredientsList??[],
                          );
                       print(" COMMISSION ${widget.foodsListIndex["commission"]}");
                        } else {
                          Get.snackbar("Error", "Fill the required Fields",
                              backgroundColor: Customcolors.decorationred);
                          setState(() => isLoading =
                              false); // Enable button after processing
                        }
                      },
                      child: 
                    
                           CustomText(
                              text: 'Confirm',
                              style: CustomTextStyle.mediumWhiteText),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

