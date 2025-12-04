// // ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, must_be_immutable

// import 'dart:async';
// import 'dart:io';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter/widgets.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
// import 'package:miogra_seller/Constants/const_variables.dart';
// import 'package:miogra_seller/Controllers/CategoryController/cusinecontroller.dart';
// import 'package:miogra_seller/Controllers/CategoryController/foodcontroller.dart';
// import 'package:miogra_seller/Controllers/CategoryController/foodlistcontroller.dart';
// import 'package:miogra_seller/Controllers/CategoryController/hashtagcategory.dart';
// import 'package:miogra_seller/Controllers/CategoryController/variantaddonscontroller.dart';
// import 'package:miogra_seller/Controllers/FileuploadController/FileUploader.dart';
// import 'package:miogra_seller/Controllers/service_controller/app_config.dart';
// //import 'package:miogra_seller/Model/getfoodlistmodel.dart';
// import 'package:miogra_seller/Screens/Menu/categoryscreen.dart';
// import 'package:miogra_seller/Screens/Menu/customizationscreen.dart';
// import 'package:miogra_seller/Screens/Menu/customizedComponents/addons_display_component.dart';
// import 'package:miogra_seller/Screens/Menu/customizedComponents/variants_display_component.dart';
// import 'package:miogra_seller/Screens/Menu/itemsHelperScreen.dart';
// import 'package:miogra_seller/Screens/Menu/variantsscreen.dart';
// import 'package:miogra_seller/Validators/validator.dart';
// import 'package:miogra_seller/Widgets/custom_button.dart';
// import 'package:miogra_seller/Widgets/custom_colors.dart';
// import 'package:miogra_seller/Widgets/custom_container.dart';
// import 'package:miogra_seller/Widgets/custom_disabledbutton.dart';
// import 'package:miogra_seller/Widgets/custom_gradienttext.dart';
// import 'package:miogra_seller/Widgets/custom_imagepicker.dart';
// import 'package:miogra_seller/Widgets/custom_text.dart';
// import 'package:miogra_seller/Widgets/custom_textformfield.dart';
// import 'package:miogra_seller/Widgets/custom_textstyle.dart';
// import 'package:get/get.dart';
// import 'package:url_launcher/url_launcher.dart';

// class AddItemScreen extends StatefulWidget {
//   final String? FoodCatid;
//   final String? FoodCat;
//   final List<Variant>? variants;
//   final dynamic foodsListIndex;
//   final List<String>? groupNames;
//   final String? variantGroupName;
//   bool isFromAddonscreen;
//   bool isFromVariantscreen;
//   List<Map<String, dynamic>>? updatedAddOns;
//   List<Map<String, dynamic>>? updatedvariants;
//   final List<List<Map<String, String>>>? groupVariants;

//   AddItemScreen(
//       {super.key,
//       this.FoodCatid,
//       this.FoodCat,
//       this.updatedAddOns,
//       this.updatedvariants,
//       this.foodsListIndex,
//       this.variants,
//       this.groupVariants,
//       this.groupNames,
//       this.variantGroupName,
//       this.isFromAddonscreen = false,
//       this.isFromVariantscreen = false});

//   @override
//   State<AddItemScreen> createState() => _AddItemScreenState();
// }

// String? _primaryImageUrl;
// File? pickedPrimaryImage;

// class _AddItemScreenState extends State<AddItemScreen> {
//    final AppConfigController appCOnfig = Get.put(AppConfigController());
//   late TextEditingController _itemNameController;
//   late TextEditingController _description;
//   late TextEditingController _cuisinetype;
//   final TextEditingController _ingredients = TextEditingController();
//   late TextEditingController _priceController;
//   late TextEditingController _discountController;
//   late TextEditingController _packageController;
//   late TextEditingController _commissionController;
//   bool _isProductExpanded = true;
//   bool _isDishExpanded = true;
//   bool _isPricingExpanded = true;
//   bool _isTimeExpanded = true;
//   final VariantsController variantsController = Get.put(VariantsController());
//   final FoodController foodController = Get.put(FoodController());
//   final HashTagCategoryController hashTagCategoryController =Get.put(HashTagCategoryController());
//   String? _selectedCuisineId; // Variable to store the selected cuisine ID
//   String? cuisineID;

//   final CuisineController cuisineController = Get.put(CuisineController());
//   final ImageUploader imageUploader = Get.put(ImageUploader());
//   final FoodListController foodListController = Get.put(FoodListController());
//   // late String _selectedFoodType;
//   String? _selectedFoodType;
//   late String _preparationTime;
//   Set<String> _selectedAvailabilityTimes = {};
//   List<String> ingredientsList = [];
//   bool isContainerVisible = false;
//   bool isChecked = false;

//   updateFunction() {
//     var food = foodController.foodItem.value;
//     _itemNameController = TextEditingController(text: food?.foodName);
//     _description = TextEditingController(text: food?.foodDesc);
//     _selectedCuisineId =
//         widget.foodsListIndex?.foodCusineDetails?.id ?? food?.foodcuisineId;
//     _cuisinetype = TextEditingController(text: food?.foodCuisine);
//     _priceController = TextEditingController(text: food?.custPrice);
//     _discountController = TextEditingController(text: food?.discPrice);
//     _packageController = TextEditingController(text: food?.packPrice);
//     _commissionController = TextEditingController(text: food?.commission);
//     // _selectedFoodType = AdditionHelperItems()
//     //     .mapFoodType(widget.foodsListIndex?.foodType ?? food?.foodType);
//     // ✅ New: Only assign if there's a valid existing value
// final foodTypeValue = widget.foodsListIndex?.foodType ?? food?.foodType;
// _selectedFoodType = (foodTypeValue != null && foodTypeValue.isNotEmpty)
//     ? AdditionHelperItems().mapFoodType(foodTypeValue)
//     : null;
//     isChecked = (food?.isCustomised == null ? false : food!.isCustomised);
//     // _preparationTime = AdditionHelperItems().mapPreparationTime(
//     //     widget.foodsListIndex?.preparationTime ?? food?.prepTime);
//     // If the value is null or empty, don't set default
// final prepTimeFromWidget = widget.foodsListIndex?.preparationTime ?? food?.prepTime;
// _preparationTime = (prepTimeFromWidget == null || prepTimeFromWidget.isEmpty)
//     ? ''  // empty means no selection
//     : AdditionHelperItems().mapPreparationTime(prepTimeFromWidget);

//     print("print value");
//     print(food?.availableTimings);
//     _initializeSelectedTimes();
//   }

//   @override
//   void initState() {
//     super.initState();
//       cuisineController.getCuisinetype();
//     var food = foodController.foodItem.value;
//     updateFunction();
//     variantsController.initialize(
//         initialVariants: widget.variants,
//         initialGroupVariants: widget.groupVariants,
//         initialGroupNames: widget.groupNames);
//     if (widget.foodsListIndex?.ingredients != null) {
//       ingredientsList = List<String>.from(widget.foodsListIndex!.ingredients!);
//       isContainerVisible = ingredientsList.isNotEmpty;
//     } else if (food?.ingredientsList != null) {
//       ingredientsList = List<String>.from(food!.ingredientsList);
//       isContainerVisible = ingredientsList.isNotEmpty;
//     } else {
//       ingredientsList = [];
//       isContainerVisible = false;
//     }

//     _priceController.addListener(() {
//       if (!_priceController.text.startsWith("₹")) {
//         _priceController.text = "₹${_priceController.text}";
//         _priceController.selection = TextSelection.fromPosition(
//           TextPosition(offset: _priceController.text.length),
//         );
//       }
//     });
//     _discountController.addListener(() {
//       if (!_discountController.text.startsWith("₹")) {
//         _discountController.text = "₹${_discountController.text}";
//         _discountController.selection = TextSelection.fromPosition(
//           TextPosition(offset: _discountController.text.length),
//         );
//       }
//     });
//     _packageController.addListener(() {
//       if (!_packageController.text.startsWith("₹")) {
//         _packageController.text = "₹${_packageController.text}";
//         _packageController.selection = TextSelection.fromPosition(
//           TextPosition(offset: _packageController.text.length),
//         );
//       }
//     });
//     _commissionController.addListener(() {
//       if (!_commissionController.text.startsWith("₹")) {
//         _commissionController.text = "₹${_commissionController.text}";
//         _commissionController.selection = TextSelection.fromPosition(
//           TextPosition(offset: _commissionController.text.length),
//         );
//       }
//     });
//     if (widget.isFromAddonscreen) {
//       print("upppppp${widget.updatedAddOns}");
//       variantsController.initializeAddOns(widget.updatedAddOns);
//     } else if (widget.isFromVariantscreen) {
//       print("From add screen variantlist:${widget.updatedvariants}");
//       variantsController.initializevariant(widget.updatedvariants);
//     }
//   }

//   Future<void> saveData() async {
//     // Prepare available timings
//     final availableTime = AdditionHelperItems()
//         .prepareAvailableTimings(_selectedAvailabilityTimes);
//     print(availableTime);

//     // Upload images
//     Map<String, String> imageUrl = await _uploadAllImages();

//     // Save food item using the controller
//     foodController.saveFoodItem(
//         foodCatId: widget.FoodCatid ?? '',
//         foodImage: imageUrl["primaryImage"] ?? "",
//         custPrice: _priceController.text,
//         discPrice: _discountController.text,
//         packPrice: _packageController.text,
//         commission: _commissionController.text,
//         foodCuisine: _cuisinetype.text,
//         foodDesc: _description.text,
//         foodName: _itemNameController.text,
//         foodType:_selectedFoodType!=null? _selectedFoodType!.toLowerCase():"",
//         prepTime: _preparationTime,
//         additionalImage1: imageUrl["additionalImage1"] ?? "",
//         additionalImage2: imageUrl["additionalImage2"] ?? "",
//         additionalImage3: imageUrl["additionalImage3"] ?? "",
//         additionalImage4: imageUrl["additionalImage4"] ?? "",
//         foodcuisineId: _selectedCuisineId ?? '',
//         availableTimings: availableTime,
//         ingredientsList: ingredientsList,
//         isCustomised: isChecked);
//   }

// void _initializeSelectedTimes() {
//   var food = foodController.foodItem.value;
//   final availableTimings = AdditionHelperItems().parseAvailableTimings(
//     widget.foodsListIndex?["availableTimings"] ?? food?.availableTimings
//   );
//   print("************************* $availableTimings");
//   if (availableTimings == null || availableTimings.isEmpty) {
//     // Instead of defaulting to lunch, make empty set
//     _selectedAvailabilityTimes = <String>{};
//   } else {
//     _selectedAvailabilityTimes = availableTimings
//       .map((timing) => timing.type)
//       .where((type) => type != null && type.isNotEmpty)
//       .cast<String>()
//       .toSet();

//     if (_selectedAvailabilityTimes.containsAll({'Breakfast', 'Lunch', 'Dinner'})) {
//       _selectedAvailabilityTimes.add('All');
//     }
//   }
// }

//   @override
//   void dispose() {
//     _itemNameController.dispose();
//     _cuisinetype.dispose();
//     _description.dispose();
//     _priceController.dispose();
//     _discountController.dispose();
//     _packageController.dispose();
//     _commissionController.dispose();
//     super.dispose();
//   }

//   // void _addIngredient() {
//   //   if (_ingredients.text.isNotEmpty) {
//   //     setState(() {
//   //       ingredientsList.add(_ingredients.text);
//   //       _ingredients.clear();
//   //       isContainerVisible = true;
//   //     });
//   //   }
//   // }
// void _addIngredient() async {
//   String newIngredient = _ingredients.text.trim();
//   if (newIngredient.isEmpty) return;

//   // // Optional: check for duplicates before calling API
//   // if (ingredientsList.contains(newIngredient)) {
//   //   Get.snackbar("Duplicate", "$newIngredient is already added");
//   //   return;
//   // }

//   // Call the API to create hashtag
//   try {
//     var response = await hashTagCategoryController.hashCreate(
//     isfromaddingredients: true,
//       hashtagName: newIngredient,
//       hastagtype: "ingredients", // or whatever value you use
//     );

//     if (hashTagCategoryController.categoryCreateData != null) {
//       // Success
//       setState(() {
//         ingredientsList.add(newIngredient);
//         _ingredients.clear();
//         isContainerVisible = true;
//          showSuggestions = false; // ✅ CLOSE the suggestions box
//       });
//       FocusScope.of(context).unfocus(); // ✅ Close keyboard
//     } else {
//       // Handle Already Exists message (assuming API returns a body even on 400)
//       Get.snackbar("Error", "Ingredient already exists");
//     }
//   } catch (e) {
//     Get.snackbar("Error", "Something went wrong");
//   }
// }

// Future<void> pickTime() async {
//   final picked = await showTimePicker(
//     context: context,
//     initialTime: TimeOfDay(hour: 6, minute: 0),
//     builder: (context, child) {
//       return MediaQuery(
//         data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: true),
//         child: child!,
//       );
//     },
//   );

//   if (picked != null) {
//     final formatted = picked.format(context);
//     print("Selected Time: $formatted");
//   }
// }




//   void _removeIngredient(int index) {
//     setState(() {
//       ingredientsList.removeAt(index);
//       if (ingredientsList.isEmpty) {
//         isContainerVisible = false;
//       }
//     });
//   }
//   bool showSuggestions = false;

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

// Widget _buildPreparationTime(String prepTime) {
//   bool isSelected =
//       _preparationTime == AdditionHelperItems().normalizePrepTime(prepTime);

//   return GestureDetector(
//     onTap: () {
//       setState(() {
//         _preparationTime = AdditionHelperItems().normalizePrepTime(prepTime);
//       });
//     },
//     child: Row(  mainAxisSize: MainAxisSize.min, // This makes it wrap-friendly
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
//   );
// }

//   Widget _buildAvailabilityTimeOption(String availTime ,time) {
//     bool isSelected = _selectedAvailabilityTimes.contains(availTime);

//     return GestureDetector(
//       onTap: () => setState(() {
//         if (availTime == 'All') {
//           // Select or deselect all options
//           if (!isSelected) {
//             _selectedAvailabilityTimes = {
//               'Breakfast',
//               'Lunch',
//               'Dinner',
//               'All'
//             };
//           } else {
//             _selectedAvailabilityTimes.clear();
//           }
//         } else {
//           if (isSelected) {
//             _selectedAvailabilityTimes.remove(availTime);
//           } else {
//             _selectedAvailabilityTimes.add(availTime);
//           }

//           // Automatically handle "All" selection
//           if (_selectedAvailabilityTimes
//               .containsAll(['Breakfast', 'Lunch', 'Dinner'])) {
//             _selectedAvailabilityTimes.add('All');
//           } else {
//             _selectedAvailabilityTimes.remove('All');
//           }
//         }

//         print(
//             'Updated _selectedAvailabilityTimes: $_selectedAvailabilityTimes');
//       }),
//       child: Row(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           Checkbox(
//             value: isSelected,
//             activeColor:  Color(0xFF623089),
//              side: const BorderSide(
//              color: Color.fromARGB(142, 0, 0, 0), 
//              width: 2,
//            ),
//             onChanged: (_) {
//               // Same logic as GestureDetector
//               setState(() {
//                 if (availTime == 'All') {
//                   if (!isSelected) {
//                     _selectedAvailabilityTimes = {
//                       'Breakfast',
//                       'Lunch',
//                       'Dinner',
//                       'All'
//                     };
//                   } else {
//                     _selectedAvailabilityTimes.clear();
//                   }
//                 } else {
//                   if (isSelected) {
//                     _selectedAvailabilityTimes.remove(availTime);
//                   } else {
//                     _selectedAvailabilityTimes.add(availTime);
//                   }

//                   if (_selectedAvailabilityTimes
//                       .containsAll(['Breakfast', 'Lunch', 'Dinner'])) {
//                     _selectedAvailabilityTimes.add('All');
//                   } else {
//                     _selectedAvailabilityTimes.remove('All');
//                   }
//                 }
//               });
//             },
//           ),
//           Text(availTime, style: CustomTextStyle.timeText),
//           const SizedBox(width: 10),

//           Spacer(),
//           Text(time),
//         ],
//       ),
//     );
//   }

// void _pickImage(Function(File?) setImage, File? currentImage, Function(String?) setError) async {
//   if (currentImage != null) return; // Prevent replacing unless removed

//   final picker = ImagePicker();
//   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//   if (pickedFile != null) {
//     final imageFile = File(pickedFile.path);

//     final extension = pickedFile.path.split('.').last.toLowerCase();
//     if (!(extension == 'jpg' || extension == 'jpeg' || extension == 'png')) {
//       setState(() {
//         setError("Only JPG or PNG files are allowed.");
//       });
//       return;
//     }

//     final bytes = await imageFile.length();
//     if (bytes > 500 * 1024) {
//       setState(() {
//         setError("File size must be less than 500KB.");
//       });
//       return;
//     }

//     setState(() {
//       setError(null);
//       setImage(imageFile);
//     });
//   }
// }

// // Method to Remove an Image
//   void _removeImage(Function(File?) setImage) {
//     setState(() {
//       setImage(null);
//     });
//   }

// Widget buildImagePicker({
//   required File? image,
//   required String? imageUrl,
//   required Function(File?) setImage,
//   required String? errorText,
//   required Function(String?) setError,
// }) {
//   return Column(
//     mainAxisAlignment: MainAxisAlignment.center,
//     children: [
//       CustomImagePicker(
//         imageUrl: imageUrl ?? '',
//         image: image,
//         onTap: () => _pickImage(setImage, image, setError),
//         height: MediaQuery.of(context).size.height / 14,
//         width: MediaQuery.of(context).size.width / 6,
//       ),
//       if (image != null || (imageUrl?.isNotEmpty ?? false))
//         IconButton(
//             onPressed: () {
//               setState(() {
//                 setImage(null);
//                 setError(null);
//               });
//             },
//             icon: Icon(
//               Icons.cancel,
//               size: 15,
//               color: Colors.grey,
//             )),
//       // No error here to avoid overflow
//     ],
//   );
// }
// String? getAdditionalImagesErrorMessage() {
//   if (_additionalImage1Error != null) {
//     return "File size must be less than 500KB in 1st Additional Image";
//   }
//   if (_additionalImage2Error != null) {
//     return "File size must be less than 500KB in 2nd Additional Image";
//   }
//   if (_additionalImage3Error != null) {
//     return "File size must be less than 500KB in 3rd Additional Image";
//   }
//   if (_additionalImage4Error != null) {
//     return "File size must be less than 500KB in 4th Additional Image";
//   }
//   return null;
// }


//   String? _additionalImageUrl1,
//       _additionalImageUrl2,
//       _additionalImageUrl3,
//       _additionalImageUrl4;
//   File? _pickedAdditionalImage1,
//       _pickedAdditionalImage2,
//       _pickedAdditionalImage3,
//       _pickedAdditionalImage4;
//       String? _primaryImageError;
// String? _additionalImage1Error;
// String? _additionalImage2Error;
// String? _additionalImage3Error;
// String? _additionalImage4Error;

//   Future<Map<String, String>> _uploadAllImages() async {
//     Map<String, dynamic> images = {
//       "primaryImage": {"url": _primaryImageUrl, "file": pickedPrimaryImage},
//       "additionalImage1": {
//         "url": _additionalImageUrl1,
//         "file": _pickedAdditionalImage1
//       },
//       "additionalImage2": {
//         "url": _additionalImageUrl2,
//         "file": _pickedAdditionalImage2
//       },
//       "additionalImage3": {
//         "url": _additionalImageUrl3,
//         "file": _pickedAdditionalImage3
//       },
//       "additionalImage4": {
//         "url": _additionalImageUrl4,
//         "file": _pickedAdditionalImage4
//       },
//     };
//     Map<String, String> uploadedImageUrls = {};

//     for (var entry in images.entries) {
//       final imageUrl = entry.value["url"];
//       final imageFile = entry.value["file"];

//       if (imageFile != null) {
//         await imageUploader.uploadImage(file: imageFile);
//         if (imageUploader.imageURL.isNotEmpty) {
//           uploadedImageUrls[entry.key] = imageUploader.imageURL.value;
//         }
//       } else if (imageUrl != null && imageUrl.isNotEmpty) {
//         uploadedImageUrls[entry.key] = imageUrl;
//       }
//     }
//     return uploadedImageUrls;
//   }

//   bool isFormComplete() {
//     return _itemNameController.text.isNotEmpty &&
//         _cuisinetype.text.isNotEmpty &&
//         _priceController.text.isNotEmpty &&
//        // _discountController.text.isNotEmpty &&
//         _packageController.text.isNotEmpty ;
//        // _commissionController.text.isNotEmpty;
//   }
// bool isTimeSelectionValid() {
//   return _preparationTime.isNotEmpty &&
//          _selectedAvailabilityTimes
//              .any((time) => ['Breakfast', 'Lunch', 'Dinner'].contains(time));
// }

//   final addkey = GlobalKey<FormState>();
//   @override
//   Widget build(BuildContext context) {
//     // variantsController.initialize(
//     //   initialVariants: widget.variants,
//     //   initialGroupVariants: widget.groupVariants,
//     //   initialGroupNames: widget.groupNames,
//     // );
//     return PopScope(
//       canPop: false,
//       onPopInvoked: (bool didPop) async {
//         Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => CategoryScreen(
//                     foodCatId: widget.FoodCatid,
//                     foodCategory: widget.FoodCat)));
//       },
//       child: Scaffold(
//         appBar: AppBar(
//             leading: IconButton(
//               icon: Icon(Icons.arrow_back, color: Colors.grey.shade600),
//               onPressed: () {
//                 Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                         builder: (context) => CategoryScreen(
//                               foodCatId: widget.FoodCatid,
//                               foodCategory: widget.FoodCat,
//                             )));
//               },
//             ),
//             title: InkWell(
//               onTap: () {
//                 variantsController.variants.clear();
//               },
//               child: Center(
//                   child: CustomText(
//                 text: 'Add Item        ',
//                 style: CustomTextStyle.mediumGreyText,
//               )),
//             )),
//         body: SingleChildScrollView(
//           child: Form(
//             key: addkey,
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
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           Padding(
//                             padding: const EdgeInsets.all(8.0),
//                             child: Row(
//                               mainAxisAlignment:
//                                   MainAxisAlignment.spaceBetween,
//                               children: [
//                                 CustomText(
//                                   text: 'Product image',
//                                   style: CustomTextStyle.mediumBoldBlackText,
//                                 ),
//                                 GestureDetector(
//                                 onTap: () {
//                                 setState(() {
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
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const SizedBox(height: 15),
//                                   Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                    const SizedBox(height: 15),
//                                    CustomText(
//                                     text: 'Primary Image',
//                                     style: CustomTextStyle.categoryBlackText,),
//                                     const SizedBox(height: 10),
//                       buildImagePicker(
//                         image: pickedPrimaryImage,
//                         imageUrl: widget.foodsListIndex?.foodImgUrl?.isNotEmpty == true
//                             ? widget.foodsListIndex!.foodImgUrl
//                             : (foodController.foodItem.value?.foodImage.isNotEmpty == true
//                                 ? foodController.foodItem.value!.foodImage
//                                 : null),
//                         setImage: (image) => pickedPrimaryImage = image,
//                         errorText: _primaryImageError,
//                         setError: (val) => _primaryImageError = val,
//                       ),
//                       if (_primaryImageError != null)
//                         Padding(
//                           padding: const EdgeInsets.only(top: 4.0),
//                           child: Text(
//                             _primaryImageError!,
//                             style: TextStyle(color: Colors.red, fontSize: 12),
//                           ),
//                         ),
//                     ],
//                   ),
                  
//                                   const SizedBox(height: 15),
//                                   Text("Note : File size must be less than 500KB",style: CustomTextStyle.rejectred,),
//                                   const SizedBox(height: 15),
//                   //               Column(
//                   //   crossAxisAlignment: CrossAxisAlignment.start,
//                   //   children: [
//                   //     const SizedBox(height: 15),
//                   //     CustomText(
//                   //       text: 'Additional Images',
//                   //       style: CustomTextStyle.categoryBlackText,
//                   //     ),
//                   //     const SizedBox(height: 10),
//                   //     Row(
//                   //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   //       children: [
//                   //         buildImagePicker(
//                   //           image: _pickedAdditionalImage1,
//                   //           imageUrl: _additionalImageUrl1,
//                   //           setImage: (image) => _pickedAdditionalImage1 = image,
//                   //           errorText: _additionalImage1Error,
//                   //           setError: (val) => _additionalImage1Error = val,
//                   //         ),
//                   //         buildImagePicker(
//                   //           image: _pickedAdditionalImage2,
//                   //           imageUrl: _additionalImageUrl2,
//                   //           setImage: (image) => _pickedAdditionalImage2 = image,
//                   //           errorText: _additionalImage2Error,
//                   //           setError: (val) => _additionalImage2Error = val,
//                   //         ),
//                   //         buildImagePicker(
//                   //           image: _pickedAdditionalImage3,
//                   //           imageUrl: _additionalImageUrl3,
//                   //           setImage: (image) => _pickedAdditionalImage3 = image,
//                   //           errorText: _additionalImage3Error,
//                   //           setError: (val) => _additionalImage3Error = val,
//                   //         ),
//                   //         buildImagePicker(
//                   //           image: _pickedAdditionalImage4,
//                   //           imageUrl: _additionalImageUrl4,
//                   //           setImage: (image) => _pickedAdditionalImage4 = image,
//                   //           errorText: _additionalImage4Error,
//                   //           setError: (val) => _additionalImage4Error = val,
//                   //         ),
//                   //       ],
//                   //     ),
//                   //     const SizedBox(height: 5),
//                   //     if (getAdditionalImagesErrorMessage() != null)
//                   //       Text(
//                   //         getAdditionalImagesErrorMessage()!,
//                   //         style: TextStyle(color: Colors.red, fontSize: 12),
//                   //       ),
//                   //   ],
//                   // ),
//                                 ],
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
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
//                                     text:catres=="restaurant"? 'Dish Information':"Product Information",
//                                     style:CustomTextStyle.mediumBoldBlackText),
//                                 GestureDetector(
//                                  onTap: () {
//                                  setState(() {
//                                   _isDishExpanded = !_isDishExpanded;});},
//                                   child: Icon(
//                                     _isDishExpanded
//                                         ? MdiIcons.chevronUp
//                                         : MdiIcons.chevronDown,
//                                     color: Colors.grey.shade600,
//                                     size: 32,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           if (_isDishExpanded)
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const SizedBox(height: 15),
//                                     catres=="restaurant"? 
//                                   CustomText(
//                                       text: 'Food Type',
//                                       style:CustomTextStyle.categoryBlackText):SizedBox.shrink(),
//                                   catres=="restaurant"?   const SizedBox(height: 15):SizedBox.shrink(),
//                                     catres=="restaurant"? 
//                                   SizedBox(
//                                     width: MediaQuery.of(context).size.width /1.5,
//                                     child: Row(
//                                       mainAxisAlignment:MainAxisAlignment.spaceAround,
//                                       children: <Widget>[
//                                         _buildFoodOption('veg'),
//                                         _buildFoodOption('nonveg'),
//                                         _buildFoodOption('egg'),
//                                       ],
//                                     ),
//                                   ):SizedBox.shrink(),
//                                   Obx(() {
//                                     return cuisineController.productCategory.isNotEmpty
//                                         ? SizedBox()
//                                         : SizedBox();
//                                   }),
//                                   const SizedBox(height: 15),
//                                   CustomPriceTextFormField(
//                                       label: RichText(
//                                         text: TextSpan(
//                                           children: [
//                                             TextSpan(
//                                                 text: 'Item Name',
//                                                 style: CustomTextStyle.greyTextFormFieldText),
//                                             TextSpan(
//                                                 text: ' ⁕',
//                                                 style: CustomTextStyle.requireStarText),
//                                           ],
//                                         ),
//                                       ),
//                                       controller: _itemNameController,
//                                       onChanged: (text) {
//                                         setState(() {});
//                                       },
//                                       validator: validateName),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                   GestureDetector(
//                                   onTap: () {
//                                         if (cuisineController.productCategory.isNotEmpty) {
//                                           _showCuisineDropdown(context, cuisineController);
//                                         } else {
//                                           Get.snackbar('Loading','Please wait, loading cuisines.');
//                                         }
//                                       },
//                                     child: AbsorbPointer(
//                                       child: CustomTypeTextFormField(
//                                       readOnly: true,
//                                         controller: _cuisinetype,
//                                         validator: validateName,
//                                         suffixIcon: Icon(
//                                           MdiIcons.chevronDown,
//                                           color: Colors.grey,
//                                         ),
//                                         label: RichText(
//                                           text: TextSpan(
//                                             children: [
//                                               TextSpan(
//                                                 text: 'Cuisine Type',
//                                                 style: CustomTextStyle.greyTextFormFieldText,
//                                               ),
//                                               TextSpan(
//                                                 text: ' ⁕',
//                                                 style: CustomTextStyle.requireStarText,
//                                               ),
//                                             ],
//                                           ),
//                                         ),
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                   CustomPriceTextFormField(
//                                     style:const TextStyle(color: Colors.black),
//                                     controller: _description,
//                                     label: RichText(
//                                       text: TextSpan(
//                                         children: [
//                                           TextSpan(
//                                               text: 'Description',
//                                               style: CustomTextStyle.greyTextFormFieldText),
//                                           TextSpan(
//                                               text: ' ',
//                                               style: CustomTextStyle.requireStarText),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 20,
//                                   ),
//                                     catres=="restaurant"? 
//                                   CustomIngredientsTextFormField(
//   controller: _ingredients,
//   onChanged: (val) {
//     if (val.isNotEmpty) {
//       setState(() => showSuggestions = true);
//       foodController.getIngredients(value: val); // API call
//     } else {
//       setState(() => showSuggestions = false);
//     }
//   },
//   suffixIcon: GestureDetector(
//     onTap: _addIngredient,
//     child: Icon(MdiIcons.plus, color: Colors.grey),
//   ),
//   label: CustomText(
//     text: 'Ingredients',
//     style: CustomTextStyle.bigGreyTextFormFieldText,
//   ),
// ):SizedBox.shrink(),

// if (showSuggestions)
//   Obx(() {
//   // if(foodController.isingredientsLoading.isTrue){
//   // return CircularProgressIndicator();
//   // }
//     // final searchList = foodController.ingredientsDetails["data"]?["searchList"] ?? [];

//     // if (searchList.isEmpty) return const SizedBox();
//   if(foodController.isingredientsLoading.isTrue) {
//             return Center(child: CupertinoActivityIndicator());
//           } else if (foodController.ingredientsDetails == null) {
//             return SizedBox();
//           } else if (foodController.ingredientsDetails["data"]?["searchList"].isEmpty) {
//             return SizedBox();
//           } else {
          
//               double containerHeight = foodController.ingredientsDetails["data"]?["searchList"].length == 1 ? 60 : 150;
//     return Container(
//       height: containerHeight,
//       margin: const EdgeInsets.only(top: 8),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         border: Border.all(color: Colors.grey.shade400),
//         borderRadius: BorderRadius.circular(8),
//       ),
//       child: Scrollbar(
//         thumbVisibility: true,
//         thickness: 4,
//         radius: const Radius.circular(8),
//         child: ListView.builder(
//           itemCount: foodController.ingredientsDetails["data"]?["searchList"].length,
//           itemBuilder: (context, index) {
//             final hashtagName = foodController.ingredientsDetails["data"]?["searchList"][index]["hashtagName"];
//             return InkWell(
//             onTap: () {
//                   if (!ingredientsList.contains(hashtagName)) {
//                     setState(() {
//                       ingredientsList.add(hashtagName);
//                       _ingredients.clear();
//                       isContainerVisible = true;
//                       showSuggestions = false;
//                     });
//                   }
//                 },
//               child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
//                 child: Text(hashtagName,style: CustomTextStyle.blackText,),
//               ),
//             );
//           },
//         ),
//       ),
//     );}
//   }),


//                                   const SizedBox(height: 5),
//                                   Visibility(
//                                     visible: isContainerVisible,
//                                     child: Wrap(
//                                       spacing:8.0, // Space between chips horizontally
//                                       runSpacing:8.0, // Space between chips vertically
//                                       children:ingredientsList.map((ingredient) {
//                                         int index = ingredientsList.indexOf(ingredient);
//                                         return Container(
//                                           padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
//                                           decoration: BoxDecoration(
//                                             color: Colors.white,
//                                             borderRadius:BorderRadius.circular(15),
//                                             border: Border.all(color: Colors.grey.shade500),
//                                           ),
//                                           child: Row(
//                                             mainAxisSize: MainAxisSize
//                                                 .min, // Ensures the container wraps tightly around its content
//                                             children: [
//                                               Text(
//                                                 ingredient,
//                                                 style: CustomTextStyle.ingredientsText,
//                                               ),
//                                               const SizedBox(width: 4),
//                                               InkWell(
//                                                 onTap: () =>_removeIngredient(index),
//                                                 child: const Icon(
//                                                   Icons.close,
//                                                   size:20, // Adjusted size for responsiveness
//                                                   color: Customcolors.decorationGrey,
//                                                 ),
//                                               ),
//                                             ],
//                                           ),
//                                         );
//                                       }).toList(),
//                                     ),
//                                   )
//                                 ],
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
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
//                               mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                               children: [
//                                 CustomText(
//                                     text: 'Pricing Details',
//                                     style:CustomTextStyle.mediumBoldBlackText),
//                                 GestureDetector(
//                                  onTap: () {
//                                  setState(() {
//                                  _isPricingExpanded = !_isPricingExpanded;});},
//                                   child: Icon(
//                                     _isPricingExpanded
//                                         ? MdiIcons.chevronUp
//                                         : MdiIcons.chevronDown,
//                                     color: Colors.grey.shade600,
//                                     size: 32,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ),
//                           const SizedBox(height: 10),
//                           if (_isPricingExpanded)
//                             Padding(
//                               padding: const EdgeInsets.all(8.0),
//                               child: SizedBox(
//                                 width: MediaQuery.of(context).size.width / 1,
//                                 child: Column(
//                                   children: [
//                                     Row(
//                                       mainAxisAlignment:MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         const SizedBox(height: 15),
//                                         Expanded(
//                                           child: CustomPriceTextFormField(
//                                             inputFormatters: [
//                                               FilteringTextInputFormatter.digitsOnly,
//                                             ],
//                                             keyboardType: TextInputType.phone,
//                                             validator: foodaddprice,
//                                             controller: _priceController,
//                                             label: RichText(
//                                               text: TextSpan(
//                                                 children: [
//                                                   TextSpan(
//                                                       text: 'Price',
//                                                       style: CustomTextStyle.greyTextFormFieldText),
//                                                   TextSpan(
//                                                       text: ' ⁕',
//                                                       style: CustomTextStyle.requireStarText),
//                                                 ],
//                                               ),
//                                             ),
//                                           ),
//                                         ),
//                                         const SizedBox(
//                                           width: 10,
//                                         ),
//                                         // Expanded(
//                                         //   child: CustomPriceTextFormField(
//                                         //     inputFormatters: [
//                                         //       FilteringTextInputFormatter.digitsOnly,
//                                         //     ],
//                                         //     validator: foodaddprice,
//                                         //     keyboardType: TextInputType.number,
//                                         //     controller: _discountController,
//                                         //     label: RichText(
//                                         //       text: TextSpan(
//                                         //         children: [
//                                         //           TextSpan(
//                                         //               text: 'Discount',
//                                         //               style: CustomTextStyle.greyTextFormFieldText),
//                                         //           TextSpan(
//                                         //               text: ' ⁕',
//                                         //               style: CustomTextStyle.requireStarText),
//                                         //         ],
//                                         //       ),
//                                         //     ),
//                                         //   ),
//                                         // ),


//                                             Expanded(
//                                             child: CustomPriceTextFormField(
//                                             keyboardType: TextInputType.number,
//                                             inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
//                                             controller: _packageController,
//                                             label: RichText(
//                                             text: TextSpan(
//                                             children: [
//                                             TextSpan(
//                                              text: 'Package',
//                                              style: CustomTextStyle.greyTextFormFieldText,
//                                              ),
//                                             ],),),),
//                                             ),


//                                         // const SizedBox(
//                                         //   width: 10,
//                                         // ),


//                                         // Expanded(
//                                         //   child: CustomPriceTextFormField(
//                                         //       inputFormatters: [
//                                         //         FilteringTextInputFormatter.digitsOnly,
//                                         //       ],
//                                         //       keyboardType: TextInputType.number,
//                                         //       // validator: addprice,
//                                         //       controller: _packageController,
//                                         //       label: RichText(
//                                         //         text: TextSpan(
//                                         //           children: [
//                                         //             TextSpan(
//                                         //                 text: 'Package',
//                                         //                 style: CustomTextStyle.greyTextFormFieldText),
//                                         //             TextSpan(
//                                         //                 text: ' ⁕',
//                                         //                 style: CustomTextStyle.requireStarText),
//                                         //           ],
//                                         //         ),
//                                         //       )),
//                                         // ),
                                       
//                                       ],
//                                     ),

// //                                      Row(
// //                                           children: [


// //                                             Expanded(
// //                                             child: CustomPriceTextFormField(
// //                                             keyboardType: TextInputType.number,
// //                                             inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
// //                                             controller: _packageController,
// //                                             label: RichText(
// //                                             text: TextSpan(
// //                                             children: [
// //                                             TextSpan(
// //                                              text: 'Package',
// //                                              style: CustomTextStyle.greyTextFormFieldText,
// //                                              ),
// //                                             ],),),),
// //                                             ),
// //  const SizedBox(
// //                                           width: 10,
// //                                         ),

// //                                             Expanded(
// //                                             child: CustomPriceTextFormField(
// //                                             keyboardType: TextInputType.number,
// //                                             inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
// //                                             controller: _commissionController,
// //                                             label: RichText(
// //                                             text: TextSpan(
// //                                             children: [
// //                                             TextSpan(
// //                                              text: 'Commission',
// //                                              style: CustomTextStyle.greyTextFormFieldText,
// //                                              ),
// //                                             ],),),),
// //                                             ),
// //                                           ],
// //                                         ),
//                                   ],
//                                 ),
//                               ),
//                             ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 10),
//                      catres=="restaurant"? 
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
//                                     text: 'Time',
//                                     style:CustomTextStyle.mediumBoldBlackText),
//                                 GestureDetector(
//                                 onTap: () {
//                                setState(() {
//                               _isTimeExpanded = !_isTimeExpanded;});},
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
//                                catres=="restaurant"? 
//                                 CustomText(
//                                     text: 'Preparation time',
//                                     style: CustomTextStyle.categoryBlackText):SizedBox.shrink(),
//                                      catres=="restaurant"? 
//                                 const SizedBox(height: 15):SizedBox.shrink(),
//                                 // SizedBox(
//                                 //   width:MediaQuery.of(context).size.width / 1,
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
//                                  catres=="restaurant"? 
//                                 Wrap(
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
//                                     text: 'Availability time',
//                                     style: CustomTextStyle.categoryBlackText),
//                                 const SizedBox(height: 15),
//                                 // Wrap(
//                                 //   spacing: 5,
//                                 //   runSpacing: 5,
//                                 //   children: [
//                                 //     for (var time in [
//                                 //       'Breakfast',
//                                 //       'Lunch',
//                                 //       'Dinner',
//                                 //       'All'
//                                 //     ])
//                                 //       _buildAvailabilityTimeOption(time),
//                                 //   ],
//                                 // ),

//                                  for (var time in [
//                                   'Breakfast',
//                                   'Lunch',
//                                   'Dinner',
//                                   'All'
//                                 ])
//                                  for (var duration in [
//                                 "from: 06:00, to: 11:00",
//      "from: 11:00, to: 16:00",
//     "from: 16:00, to: 22:00"
    
//                                 ])
//                                   _buildAvailabilityTimeOption(time,duration),
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
//   //                 GestureDetector(
//   // onTap: () async {
//   //   setState(() {
//   //     isChecked = true; // optional: if you still want to track this
//   //   });
//   //   await saveData();
//   //   Get.to(() => CustomizationScreen(
//   //         FoodCat: widget.FoodCat,
//   //         FoodCatid: widget.FoodCatid,
//   //         foodsListIndex: widget.foodsListIndex,
//   //         updatedvariants: widget.updatedvariants,
//   //         updatedaddOns: widget.updatedAddOns,
//   //       ));
//   // },
//   // child: Row(
//   //                                   children: [
//   //                                     GradientText(
//   //                                       text: 'Add Customization',
//   //                                       style: CustomTextStyle.smallOrangeText,
//   //                                       gradient: const LinearGradient(
//   //                     begin: Alignment.topCenter,
//   //                     end: Alignment.bottomCenter,
//   //                     colors: [
//   //                       Color(0xFFF98322),
//   //                       Color(0xFFEE4C46),
//   //                     ],
//   //                                       ),
//   //                                     ),
//   //                                     const SizedBox(width: 4),
//   //                                     const Icon(Icons.arrow_forward_ios_rounded, size: 14, color: Color(0xFFEE4C46)),
//   //                                   ],
//   //                                 )),
//                   const SizedBox(height: 35),
//                  //  isFormComplete() && pickedPrimaryImage != null &&isTimeSelectionValid()

//           (catres=="restaurant"? (_selectedFoodType != null && isFormComplete() && pickedPrimaryImage != null && isTimeSelectionValid()):
//           ( isFormComplete() && pickedPrimaryImage != null)
//           )
         
//                        ?
//                        Obx(() {
//                            if (foodListController.isfoodCreateLoading.isTrue) {
//                             return loadingdisableButton(context);
//                          }
//                            else {
//                             return Center(
//                                 child: CustomButton(
//                               borderRadius: BorderRadius.circular(5),
//                               height: MediaQuery.of(context).size.height / 23,
//                               width: MediaQuery.of(context).size.width / 2,

//                               onPressed: () async {
//   if (addkey.currentState!.validate()) {
// bool checkbox = false;
//     // Show alert FIRST
//     showDialog(
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setState) => 
//           AlertDialog(
//                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//                 content: Column(
//           mainAxisSize: MainAxisSize.min,
//           children: [
//             Text(
//               catres=="restaurant"? "Do you want to add this food?":"Do you want to add this product?",
//               style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             ),
//             SizedBox(height: 10),
//             // Text(
//             //   'By continuing, you agree to the Terms & Conditions.',
//             //   textAlign: TextAlign.center,
//             // ),
//             // TextButton(
//             //   onPressed: () {
//             //     // Navigate to terms page
//             //   },
//             //   child: Text('I agree to the Terms & Conditions'),
//             // ),
//              Row(
//                   children: [
//                     Checkbox(
//                       value: checkbox ,
//                       onChanged: (val) {
//                         setState(() {
//                           checkbox  = val!;
//                         });
//                       },
//                     ),
//                     Expanded(
//                       child: InkWell(
//                         onTap: () {
//                             for (var item in appCOnfig
//                                     .redirectLoadingDetails["data"]) {
                                  
//                                    if (item["key"] == "termsandservice") {
//                                     launchwebUrl(context, item["value"]);

//                                     break; // Exit loop once the "whatsappLink" is found and launched
//                                   }
//                                 }
//                         },
//                         child: Text("I agree to the Terms & Conditions",style: TextStyle(color: Colors.blue),)),
//                     ),
//                   ],
//                 ),
          
//                 // TextButton(
//                 //   onPressed: () {
//                 //     // Navigate to full terms page
//                 //   },
//                 //   child: Text("View Full Terms"),
//                 // ),
          
//             SizedBox(height: 10),
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceAround,
//               children: [
//                 ElevatedButton(
//                    style: ElevatedButton.styleFrom(
//                       backgroundColor: Color(0xFF623089),
//                       foregroundColor: Colors.white,
//                     ),
//                   onPressed: () => Navigator.pop(context),
//                   child: Text('No'),
//                 ),
//                 ElevatedButton(
//                    style: ElevatedButton.styleFrom(
//                       backgroundColor:checkbox ? Color(0xFF623089):Colors.grey,
//                       foregroundColor: Colors.white,
//                     ),
//                    onPressed:checkbox ? () async {
//                       Navigator.pop(context); // close dialog
          
//                       foodListController.isfoodCreateLoading.value = true;
          
//                       // Upload Images
//                       Map<String, String> imageUrls = await _uploadAllImages();
          
//                       // Prepare data
//                       String price = _priceController.text.replaceFirst("₹", "");
//                       String discountPrice = _discountController.text.replaceFirst("₹", "");
//                       String packagePrice = _packageController.text.replaceFirst("₹", "");
          
//                       final availableTimings =
//                           AdditionHelperItems().prepareAvailableTimings(_selectedAvailabilityTimes);
          
//                       final groupNames = variantsController.addongroupNames;
//                       final groupVariants = variantsController.groupVariants.map((group) {
//                         return group.map((variant) {
//                           final rawPrice = variant["price"]?.toString() ?? "0.0";
//                           final cleanedPrice = rawPrice.replaceAll(RegExp(r'[^\d.]'), '');
//                           final parsedPrice = double.tryParse(cleanedPrice) ?? 0.0;
//                           return {
//                             "name": variant["name"],
//                             "price": parsedPrice,
//                           };
//                         }).toList();
//                       }).toList();
          
//                       // Create food
//                       await foodListController.foodCreate(
//                         mediumUrl: imageUrls["primaryImage"] ?? "",
//                         thumbUrl: imageUrls["primaryImage"] ?? "",
//                         isCustomised: isChecked,
//                         varianGroupName: widget.variantGroupName ?? "",
//                         foodCatName: widget.FoodCat,
//                         groupNames: groupNames,
//                         groupVariants: groupVariants,
//                         foodCatId: widget.FoodCatid,
//                         foodImage: imageUrls["primaryImage"] ?? "",
//                         custPrice: price,
//                         discPrice: discountPrice,
//                         packPrice: packagePrice,
//                         foodCuisine: _cuisinetype.text,
//                         foodDesc: _description.text,
//                         foodName: _itemNameController.text,
//                         foodType: _selectedFoodType?.toLowerCase() ?? "veg",
//                         prepTime: _preparationTime ?? "",
//                         additionalImage1: imageUrls["additionalImage1"] ?? "",
//                         additionalImage2: imageUrls["additionalImage2"] ?? "",
//                         additionalImage3: imageUrls["additionalImage3"] ?? "",
//                         additionalImage4: imageUrls["additionalImage4"] ?? "",
//                         foodcuisineId: _selectedCuisineId,
//                         availableTimings: availableTimings,
//                         ingredientsList: ingredientsList ?? [],
//                       );
          
//                       foodListController.isfoodCreateLoading.value = false;
//                     }:(){},
          
//                   child: const Text('Yes'),
//                 ),
//               ],
//             )
//           ],
//                 ),
//               ),
//         );
//         // return AlertDialog(
        
//         //   title: Text(
//         // catres=="restaurant"? "Do you want to add this food?":"Do you want to add this product?",
//         //     style: TextStyle(fontSize: 15.sp),
//         //   ),
//         //   actions: [
//         //     Row(
//         //       mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//         //       children: [
//         //         ElevatedButton(
//         //           style: ElevatedButton.styleFrom(
//         //             backgroundColor: Color(0xFF623089),
//         //             foregroundColor: Colors.white,
//         //           ),
//         //           onPressed: () {
//         //             Navigator.pop(context);
//         //           },
//         //           child: Text("No"),
//         //         ),

//         //         ElevatedButton(
//         //           style: ElevatedButton.styleFrom(
//         //             backgroundColor: Color(0xFF623089),
//         //             foregroundColor: Colors.white,
//         //           ),
//         //           onPressed: () async {
//         //             Navigator.pop(context); // close dialog

//         //             foodListController.isfoodCreateLoading.value = true;

//         //             // Upload Images
//         //             Map<String, String> imageUrls = await _uploadAllImages();

//         //             // Prepare data
//         //             String price = _priceController.text.replaceFirst("₹", "");
//         //             String discountPrice = _discountController.text.replaceFirst("₹", "");
//         //             String packagePrice = _packageController.text.replaceFirst("₹", "");

//         //             final availableTimings =
//         //                 AdditionHelperItems().prepareAvailableTimings(_selectedAvailabilityTimes);

//         //             final groupNames = variantsController.addongroupNames;
//         //             final groupVariants = variantsController.groupVariants.map((group) {
//         //               return group.map((variant) {
//         //                 final rawPrice = variant["price"]?.toString() ?? "0.0";
//         //                 final cleanedPrice = rawPrice.replaceAll(RegExp(r'[^\d.]'), '');
//         //                 final parsedPrice = double.tryParse(cleanedPrice) ?? 0.0;
//         //                 return {
//         //                   "name": variant["name"],
//         //                   "price": parsedPrice,
//         //                 };
//         //               }).toList();
//         //             }).toList();

//         //             // Create food
//         //             await foodListController.foodCreate(
//         //               mediumUrl: imageUrls["primaryImage"] ?? "",
//         //               thumbUrl: imageUrls["primaryImage"] ?? "",
//         //               isCustomised: isChecked,
//         //               varianGroupName: widget.variantGroupName ?? "",
//         //               foodCatName: widget.FoodCat,
//         //               groupNames: groupNames,
//         //               groupVariants: groupVariants,
//         //               foodCatId: widget.FoodCatid,
//         //               foodImage: imageUrls["primaryImage"] ?? "",
//         //               custPrice: price,
//         //               discPrice: discountPrice,
//         //               packPrice: packagePrice,
//         //               foodCuisine: _cuisinetype.text,
//         //               foodDesc: _description.text,
//         //               foodName: _itemNameController.text,
//         //               foodType: _selectedFoodType?.toLowerCase() ?? "veg",
//         //               prepTime: _preparationTime ?? "",
//         //               additionalImage1: imageUrls["additionalImage1"] ?? "",
//         //               additionalImage2: imageUrls["additionalImage2"] ?? "",
//         //               additionalImage3: imageUrls["additionalImage3"] ?? "",
//         //               additionalImage4: imageUrls["additionalImage4"] ?? "",
//         //               foodcuisineId: _selectedCuisineId,
//         //               availableTimings: availableTimings,
//         //               ingredientsList: ingredientsList ?? [],
//         //             );

//         //             foodListController.isfoodCreateLoading.value = false;
//         //           },
//         //           child: Text("Yes"),
//         //         ),
//         //       ],
//         //     ),
//         //   ],
//         // );
//       },
//     );
//   } else {
//     Get.snackbar("Error", "Fill the required Fields",
//         backgroundColor: Customcolors.decorationred);
//   }
// },

// //                               onPressed: () async {
// //                                 if (addkey.currentState!.validate()) {
// //                                   // foodListController
// //                                   //     .foodCreateLoadingFunction();
                                  
// //                                   // Upload all images
// //                                   Map<String, String> imageUrls =
// //                                       await _uploadAllImages();

// //                                   // Debugging: Log image URLs and cuisine ID
// //                                   print("Uploaded Image URLs: $imageUrls");
// //                                   print(
// //                                       "Selected Cuisine ID: $_selectedCuisineId");
// //                                   print('update cusine id.....$cuisineID');
// //                                   print('cusine name....${_cuisinetype.text}');

// //                                   String price = _priceController.text
// //                                       .replaceFirst("₹", "");
// //                                   String discountPrice = _discountController
// //                                       .text
// //                                       .replaceFirst("₹", "");
// //                                   String packagePrice = _packageController.text
// //                                       .replaceFirst("₹", "");
// //                                   String commissionPrice = _commissionController.text
// //                                       .replaceFirst("₹", "");
// //                                   final availableTimings = AdditionHelperItems()
// //                                       .prepareAvailableTimings(
// //                                           _selectedAvailabilityTimes);
// //                                   var food = foodController.foodItem.value;

// //                                   final groupNames =
// //                                       variantsController.addongroupNames;
// //                                   final groupVariants = variantsController
// //                                       .groupVariants
// //                                       .map((group) {
// //                                     return group.map((variant) {
// //                                       final rawPrice =
// //                                           variant["price"]?.toString() ?? "0.0";
// //                                       final cleanedPrice = rawPrice.replaceAll(
// //                                           RegExp(r'[^\d.]'), '');
// //                                       final parsedPrice =
// //                                           double.tryParse(cleanedPrice) ?? 0.0;

// //                                       print('Cleaned price: $cleanedPrice');
// //                                       print('Parsed price: $parsedPrice');

// //                                       return {
// //                                         "name": variant["name"],
// //                                         "price": parsedPrice,
// //                                       };
// //                                     }).toList();
// //                                   }).toList();
// //                                   print(
// //                                       'cuisine................${_selectedCuisineId}');

// //                                   print(
// //                                       'cuisine id.......${food?.foodcuisineId}');
// //                                   print(availableTimings);
// //                                   Timer(Duration(seconds: 2), () {
// //                                     if (isChecked == true) {
// //                                            print("THE IF ");
// //                                       // if (variantsController.variants.isNotEmpty) {
// //                                       foodListController.foodCreate(
// //                                         mediumUrl:
// //                                             imageUrls["primaryImage"] ?? "",
// //                                         thumbUrl:
// //                                             imageUrls["primaryImage"] ?? "",
// //                                         isCustomised: isChecked,
// //                                         varianGroupName:
// //                                             widget.variantGroupName,
// //                                         foodCatName: widget.FoodCat,
// //                                         // foodVariants: variantsController.variants,
// //                                         groupNames: groupNames,
// //                                         groupVariants: groupVariants,
// //                                         foodCatId: widget.FoodCatid,
// //                                         foodImage:
// //                                             imageUrls["primaryImage"] ?? "",
// //                                         custPrice: price,
// //                                         discPrice: discountPrice??0,
// //                                         packPrice: packagePrice,
// //                                         commission:commissionPrice??0,
// //                                         foodCuisine: _cuisinetype.text,
// //                                         foodDesc: _description.text,
// //                                         foodName: _itemNameController.text,
// //                                         foodType:_selectedFoodType!.toLowerCase(),
// //                                         prepTime: _preparationTime,
// //                                         additionalImage1:
// //                                             imageUrls["additionalImage1"] ?? "",
// //                                         additionalImage2:
// //                                             imageUrls["additionalImage2"] ?? "",
// //                                         additionalImage3:
// //                                             imageUrls["additionalImage3"] ?? "",
// //                                         additionalImage4:
// //                                             imageUrls["additionalImage4"] ?? "",
// //                                         foodcuisineId: _selectedCuisineId,
// //                                         availableTimings: availableTimings,
// //                                         ingredientsList: ingredientsList,
// //                                       );
// //                                       // } else {
// //                                       //   Get.snackbar(
// //                                       //     "Varient must be added",
// //                                       //     "",
// //                                       //   );
// //                                       // }
// //                                     } else {
// //                                       // Create new food item
// //                                       print("THE ELSE ");

 
// //   showDialog(
// //     context: context,
// //     builder: (context) {
// //       return AlertDialog(
// //         title: Text("Do you want to add this food",style: TextStyle(fontSize: 15.sp,),),
// //        // content: Text("Are you sure you want to exit?"),
// //         actions: [
// //           Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,
// //             children: [
// //               ElevatedButton(
// //                 style:    ElevatedButton.styleFrom(backgroundColor: Color(0xFF623089 ),
// //                 foregroundColor: Colors.white),
// //                 onPressed: (){
// //               Navigator.pop(context);
// //               }, child: Text("No")),

              
// //  ElevatedButton(
// //             style:    ElevatedButton.styleFrom(backgroundColor: Color(0xFF623089 ),
// //             foregroundColor: Colors.white),
// //             onPressed: (){
// //      foodListController.foodCreate(
// //                                         mediumUrl:
// //                                             imageUrls["primaryImage"] ?? "",
// //                                         thumbUrl:
// //                                             imageUrls["primaryImage"] ?? "",
// //                                         isCustomised: isChecked,
// //                                         varianGroupName:
// //                                             widget.variantGroupName??"",
// //                                         foodCatName: widget.FoodCat,
// //                                         // foodVariants: variantsController.variants,
// //                                         groupNames: groupNames,
// //                                         groupVariants: groupVariants,
// //                                         foodCatId: widget.FoodCatid,
// //                                         foodImage:
// //                                             imageUrls["primaryImage"] ?? "",
// //                                         custPrice: price,
// //                                         discPrice: discountPrice??"0",
// //                                         packPrice: packagePrice,
// //                                         foodCuisine: _cuisinetype.text,
// //                                         foodDesc: _description.text,
// //                                         foodName: _itemNameController.text,
// //                                         foodType:_selectedFoodType?.toLowerCase()??"veg",
// //                                         prepTime: _preparationTime??"",
// //                                         additionalImage1:
// //                                             imageUrls["additionalImage1"] ?? "",
// //                                         additionalImage2:
// //                                             imageUrls["additionalImage2"] ?? "",
// //                                         additionalImage3:
// //                                             imageUrls["additionalImage3"] ?? "",
// //                                         additionalImage4:
// //                                             imageUrls["additionalImage4"] ?? "",
// //                                         foodcuisineId: _selectedCuisineId,
// //                                         availableTimings: availableTimings,
// //                                         ingredientsList: ingredientsList??[],
// //                                       );
// //           }, child: Text("Yes")),

// //             ],
// //           ),

        
// //         ],
// //       );
// //     },
// //   );
                                      
                                     
// //                                     }
// //                                    });
// //                                 }
// //                                  else {
// //                                   Get.snackbar(
// //                                       "Error", "Fill the required Fields",
// //                                       backgroundColor:Customcolors.decorationred);
// //                                 }
// //                               },
//                               child: CustomText(
//                                 text: 'Confirm',
//                                 style: CustomTextStyle.mediumWhiteText,
//                               ),
//                             ));
//                           }
//                         })
//                       : disableButton(context),
//                   const SizedBox(height: 20),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Center loadingdisableButton(BuildContext context) {
//     return Center(
//       child: CustomdisabledButton(
//           borderRadius: BorderRadius.circular(20),
//           height: MediaQuery.of(context).size.height / 23,
//           width: MediaQuery.of(context).size.width / 2,
//           onPressed: () async {},
//           child: LoadingAnimationWidget.newtonCradle(
//               color: Colors.white, size: 70)),
//     );
//   }

//   Center disableButton(BuildContext context) {
//     return Center(
//       child: CustomdisabledButton(
//           borderRadius: BorderRadius.circular(20),
//           height: MediaQuery.of(context).size.height / 23,
//           width: MediaQuery.of(context).size.width / 2,
//           onPressed: () async {},
//           child: Text(
//             'Confirm',
//             style: CustomTextStyle.mediumGreyButText,
//           )),
//     );
//   }
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





//   void launchwebUrl(BuildContext context, String url) async {
//     try {
//       await canLaunch(url);
//       await launch(url);
//       print("urllll${url}");
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Something went wrong when launching URL"),
//         ),
//       );
//       print("error");
//     }
//   }
 


// }























































// ignore_for_file: avoid_print, unnecessary_brace_in_string_interps, must_be_immutable

import 'dart:async';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/Controllers/CategoryController/cusinecontroller.dart';
import 'package:miogra_seller/Controllers/CategoryController/foodcontroller.dart';
import 'package:miogra_seller/Controllers/CategoryController/foodlistcontroller.dart';
import 'package:miogra_seller/Controllers/CategoryController/hashtagcategory.dart';
import 'package:miogra_seller/Controllers/CategoryController/variantaddonscontroller.dart';
import 'package:miogra_seller/Controllers/FileuploadController/FileUploader.dart';
import 'package:miogra_seller/Controllers/service_controller/app_config.dart';
//import 'package:miogra_seller/Model/getfoodlistmodel.dart';
import 'package:miogra_seller/Screens/Menu/categoryscreen.dart';
import 'package:miogra_seller/Screens/Menu/customizationscreen.dart';
import 'package:miogra_seller/Screens/Menu/customizedComponents/addons_display_component.dart';
import 'package:miogra_seller/Screens/Menu/customizedComponents/variants_display_component.dart';
import 'package:miogra_seller/Screens/Menu/itemsHelperScreen.dart';
import 'package:miogra_seller/Screens/Menu/variantsscreen.dart';
import 'package:miogra_seller/Validators/validator.dart';
import 'package:miogra_seller/Widgets/custom_button.dart';
import 'package:miogra_seller/Widgets/custom_colors.dart';
import 'package:miogra_seller/Widgets/custom_container.dart';
import 'package:miogra_seller/Widgets/custom_disabledbutton.dart';
import 'package:miogra_seller/Widgets/custom_gradienttext.dart';
import 'package:miogra_seller/Widgets/custom_imagepicker.dart';
import 'package:miogra_seller/Widgets/custom_text.dart';
import 'package:miogra_seller/Widgets/custom_textformfield.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class AddItemScreen extends StatefulWidget {
  final String? FoodCatid;
  final String? FoodCat;
  final List<Variant>? variants;
  final dynamic foodsListIndex;
  final List<String>? groupNames;
  final String? variantGroupName;
  bool isFromAddonscreen;
  bool isFromVariantscreen;
  List<Map<String, dynamic>>? updatedAddOns;
  List<Map<String, dynamic>>? updatedvariants;
  final List<List<Map<String, String>>>? groupVariants;

  AddItemScreen(
      {super.key,
      this.FoodCatid,
      this.FoodCat,
      this.updatedAddOns,
      this.updatedvariants,
      this.foodsListIndex,
      this.variants,
      this.groupVariants,
      this.groupNames,
      this.variantGroupName,
      this.isFromAddonscreen = false,
      this.isFromVariantscreen = false});

  @override
  State<AddItemScreen> createState() => _AddItemScreenState();
}

String? _primaryImageUrl;
File? pickedPrimaryImage;

class _AddItemScreenState extends State<AddItemScreen> {
   final AppConfigController appCOnfig = Get.put(AppConfigController());
  late TextEditingController _itemNameController;
  late TextEditingController _description;
  late TextEditingController _cuisinetype;
  final TextEditingController _ingredients = TextEditingController();
  late TextEditingController _priceController;
  late TextEditingController _discountController;
  late TextEditingController _packageController;
  late TextEditingController _commissionController;
  bool _isProductExpanded = true;
  bool _isDishExpanded = true;
  bool _isPricingExpanded = true;
  bool _isTimeExpanded = true;
  final VariantsController variantsController = Get.put(VariantsController());
  final FoodController foodController = Get.put(FoodController());
  final HashTagCategoryController hashTagCategoryController =Get.put(HashTagCategoryController());
  String? _selectedCuisineId; // Variable to store the selected cuisine ID
  String? cuisineID;

  final CuisineController cuisineController = Get.put(CuisineController());
  final ImageUploader imageUploader = Get.put(ImageUploader());
  final FoodListController foodListController = Get.put(FoodListController());
  // late String _selectedFoodType;
  String? _selectedFoodType;
  late String _preparationTime;
  Set<String> _selectedAvailabilityTimes = {};
  List<String> ingredientsList = [];
  bool isContainerVisible = false;
  bool isChecked = false;

  updateFunction() {
    var food = foodController.foodItem.value;
    _itemNameController = TextEditingController(text: food?.foodName);
    _description = TextEditingController(text: food?.foodDesc);
    _selectedCuisineId =
        widget.foodsListIndex?.foodCusineDetails?.id ?? food?.foodcuisineId;
    _cuisinetype = TextEditingController(text: food?.foodCuisine);
    _priceController = TextEditingController(text: food?.custPrice);
    _discountController = TextEditingController(text: food?.discPrice);
    _packageController = TextEditingController(text: food?.packPrice);
    _commissionController = TextEditingController(text: food?.commission);
    // _selectedFoodType = AdditionHelperItems()
    //     .mapFoodType(widget.foodsListIndex?.foodType ?? food?.foodType);
    // ✅ New: Only assign if there's a valid existing value
final foodTypeValue = widget.foodsListIndex?.foodType ?? food?.foodType;
_selectedFoodType = (foodTypeValue != null && foodTypeValue.isNotEmpty)
    ? AdditionHelperItems().mapFoodType(foodTypeValue)
    : null;
    isChecked = (food?.isCustomised == null ? false : food!.isCustomised);
    // _preparationTime = AdditionHelperItems().mapPreparationTime(
    //     widget.foodsListIndex?.preparationTime ?? food?.prepTime);
    // If the value is null or empty, don't set default
final prepTimeFromWidget = widget.foodsListIndex?.preparationTime ?? food?.prepTime;
_preparationTime = (prepTimeFromWidget == null || prepTimeFromWidget.isEmpty)
    ? ''  // empty means no selection
    : AdditionHelperItems().mapPreparationTime(prepTimeFromWidget);

    print("print value");
    print(food?.availableTimings);
    _initializeSelectedTimes();
  }

  @override
  void initState() {
    super.initState();
      cuisineController.getCuisinetype();
    var food = foodController.foodItem.value;
    updateFunction();
    variantsController.initialize(
        initialVariants: widget.variants,
        initialGroupVariants: widget.groupVariants,
        initialGroupNames: widget.groupNames);
    if (widget.foodsListIndex?.ingredients != null) {
      ingredientsList = List<String>.from(widget.foodsListIndex!.ingredients!);
      isContainerVisible = ingredientsList.isNotEmpty;
    } else if (food?.ingredientsList != null) {
      ingredientsList = List<String>.from(food!.ingredientsList);
      isContainerVisible = ingredientsList.isNotEmpty;
    } else {
      ingredientsList = [];
      isContainerVisible = false;
    }

    _priceController.addListener(() {
      if (!_priceController.text.startsWith("₹")) {
        _priceController.text = "₹${_priceController.text}";
        _priceController.selection = TextSelection.fromPosition(
          TextPosition(offset: _priceController.text.length),
        );
      }
    });
    _discountController.addListener(() {
      if (!_discountController.text.startsWith("₹")) {
        _discountController.text = "₹${_discountController.text}";
        _discountController.selection = TextSelection.fromPosition(
          TextPosition(offset: _discountController.text.length),
        );
      }
    });
    _packageController.addListener(() {
      if (!_packageController.text.startsWith("₹")) {
        _packageController.text = "₹${_packageController.text}";
        _packageController.selection = TextSelection.fromPosition(
          TextPosition(offset: _packageController.text.length),
        );
      }
    });
    _commissionController.addListener(() {
      if (!_commissionController.text.startsWith("₹")) {
        _commissionController.text = "₹${_commissionController.text}";
        _commissionController.selection = TextSelection.fromPosition(
          TextPosition(offset: _commissionController.text.length),
        );
      }
    });
    if (widget.isFromAddonscreen) {
      print("upppppp${widget.updatedAddOns}");
      variantsController.initializeAddOns(widget.updatedAddOns);
    } else if (widget.isFromVariantscreen) {
      print("From add screen variantlist:${widget.updatedvariants}");
      variantsController.initializevariant(widget.updatedvariants);
    }
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
   // final availableTime =  buildAvailableTimings();
    // final availableTime = AdditionHelperItems()
    //    .prepareAvailableTimings(_selectedAvailabilityTimes);
    final availableTime = AdditionHelperItems()
    .prepareAvailableTimings(_selectedAvailabilityTimes, categoryTimes);

    // print(availableTime);

    // Upload images
    Map<String, String> imageUrl = await _uploadAllImages();

    // Save food item using the controller
    foodController.saveFoodItem(
        foodCatId: widget.FoodCatid ?? '',
        foodImage: imageUrl["primaryImage"] ?? "",
        custPrice: _priceController.text,
        discPrice: _discountController.text,
        packPrice: _packageController.text,
        commission: _commissionController.text,
        foodCuisine: _cuisinetype.text,
        foodDesc: _description.text,
        foodName: _itemNameController.text,
        foodType:_selectedFoodType!=null? _selectedFoodType!.toLowerCase():"",
        prepTime: _preparationTime,
        additionalImage1: imageUrl["additionalImage1"] ?? "",
        additionalImage2: imageUrl["additionalImage2"] ?? "",
        additionalImage3: imageUrl["additionalImage3"] ?? "",
        additionalImage4: imageUrl["additionalImage4"] ?? "",
        foodcuisineId: _selectedCuisineId ?? '',
        availableTimings: availableTime,
        ingredientsList: ingredientsList,
        isCustomised: isChecked);
  }

void _initializeSelectedTimes() {
  var food = foodController.foodItem.value;
  final availableTimings = AdditionHelperItems().parseAvailableTimings(
    widget.foodsListIndex?["availableTimings"] ?? food?.availableTimings
  );
  print("************************* $availableTimings");
  if (availableTimings == null || availableTimings.isEmpty) {
    // Instead of defaulting to lunch, make empty set
    _selectedAvailabilityTimes = <String>{};
  } else {
    _selectedAvailabilityTimes = availableTimings
      .map((timing) => timing.type)
      .where((type) => type != null && type.isNotEmpty)
      .cast<String>()
      .toSet();

    if (_selectedAvailabilityTimes.containsAll({'Morning', 'Afternoon', 'Evening','Night','Mid-night'})) {
      _selectedAvailabilityTimes.add('All');
    }
  }
}

  @override
  void dispose() {
    _itemNameController.dispose();
    _cuisinetype.dispose();
    _description.dispose();
    _priceController.dispose();
    _discountController.dispose();
    _packageController.dispose();
    _commissionController.dispose();
    super.dispose();
  }

  // void _addIngredient() {
  //   if (_ingredients.text.isNotEmpty) {
  //     setState(() {
  //       ingredientsList.add(_ingredients.text);
  //       _ingredients.clear();
  //       isContainerVisible = true;
  //     });
  //   }
  // }
void _addIngredient() async {
  String newIngredient = _ingredients.text.trim();
  if (newIngredient.isEmpty) return;

  // // Optional: check for duplicates before calling API
  // if (ingredientsList.contains(newIngredient)) {
  //   Get.snackbar("Duplicate", "$newIngredient is already added");
  //   return;
  // }

  // Call the API to create hashtag
  try {
    var response = await hashTagCategoryController.hashCreate(
    isfromaddingredients: true,
      hashtagName: newIngredient,
      hastagtype: "ingredients", // or whatever value you use
    );

    if (hashTagCategoryController.categoryCreateData != null) {
      // Success
      setState(() {
        ingredientsList.add(newIngredient);
        _ingredients.clear();
        isContainerVisible = true;
         showSuggestions = false; // ✅ CLOSE the suggestions box
      });
      FocusScope.of(context).unfocus(); // ✅ Close keyboard
    } else {
      // Handle Already Exists message (assuming API returns a body even on 400)
      Get.snackbar("Error", "Ingredient already exists");
    }
  } catch (e) {
    Get.snackbar("Error", "Something went wrong");
  }
}





  void _removeIngredient(int index) {
    setState(() {
      ingredientsList.removeAt(index);
      if (ingredientsList.isEmpty) {
        isContainerVisible = false;
      }
    });
  }
  bool showSuggestions = false;

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
  bool isSelected =
      _preparationTime == AdditionHelperItems().normalizePrepTime(prepTime);

  return GestureDetector(
    onTap: () {
      setState(() {
        _preparationTime = AdditionHelperItems().normalizePrepTime(prepTime);
      });
    },
    child: Row(  mainAxisSize: MainAxisSize.min, // This makes it wrap-friendly
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

  // Widget _buildAvailabilityTimeOption(String availTime ) {
  //   bool isSelected = _selectedAvailabilityTimes.contains(availTime);

  //   return GestureDetector(
  //     onTap: () => setState(() {
  //       if (availTime == 'All') {
  //         // Select or deselect all options
  //         if (!isSelected) {
  //           _selectedAvailabilityTimes = {
  //             'Morning',
  //             'Lunch',
  //             'Dinner',
  //             'All'
  //           };
  //         } else {
  //           _selectedAvailabilityTimes.clear();
  //         }
  //       } else {
  //         if (isSelected) {
  //           _selectedAvailabilityTimes.remove(availTime);
  //         } else {
  //           _selectedAvailabilityTimes.add(availTime);
  //         }

  //         // Automatically handle "All" selection
  //         if (_selectedAvailabilityTimes
  //             .containsAll(['Breakfast', 'Lunch', 'Dinner'])) {
  //           _selectedAvailabilityTimes.add('All');
  //         } else {
  //           _selectedAvailabilityTimes.remove('All');
  //         }
  //       }

  //       print(
  //           'Updated _selectedAvailabilityTimes: $_selectedAvailabilityTimes');
  //     }),
  //     child: Row(
  //       mainAxisSize: MainAxisSize.min,
  //       children: [
  //         Checkbox(
  //           value: isSelected,
  //           activeColor:  Color(0xFF623089),
  //            side: const BorderSide(
  //            color: Color.fromARGB(142, 0, 0, 0), 
  //            width: 2,
  //          ),
  //           onChanged: (_) {
  //             // Same logic as GestureDetector
  //             setState(() {
  //               if (availTime == 'All') {
  //                 if (!isSelected) {
  //                   _selectedAvailabilityTimes = {
  //                     'Breakfast',
  //                     'Lunch',
  //                     'Dinner',
  //                     'All'
  //                   };
  //                 } else {
  //                   _selectedAvailabilityTimes.clear();
  //                 }
  //               } else {
  //                 if (isSelected) {
  //                   _selectedAvailabilityTimes.remove(availTime);
  //                 } else {
  //                   _selectedAvailabilityTimes.add(availTime);
  //                 }

  //                 if (_selectedAvailabilityTimes
  //                     .containsAll(['Breakfast', 'Lunch', 'Dinner'])) {
  //                   _selectedAvailabilityTimes.add('All');
  //                 } else {
  //                   _selectedAvailabilityTimes.remove('All');
  //                 }
  //               }
  //             });
  //           },
  //         ),
  //         Text(availTime, style: CustomTextStyle.timeText),
  //         const SizedBox(width: 10),

  //         Spacer(),
  //         Text("ngfn"),
  //       ],
  //     ),
  //   );
  // }

void _pickImage(Function(File?) setImage, File? currentImage, Function(String?) setError) async {
  if (currentImage != null) return; // Prevent replacing unless removed

  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    final imageFile = File(pickedFile.path);

    final extension = pickedFile.path.split('.').last.toLowerCase();
    if (!(extension == 'jpg' || extension == 'jpeg' || extension == 'png')) {
      setState(() {
        setError("Only JPG or PNG files are allowed.");
      });
      return;
    }

    final bytes = await imageFile.length();
    if (bytes > 500 * 1024) {
      setState(() {
        setError("File size must be less than 500KB.");
      });
      return;
    }

    setState(() {
      setError(null);
      setImage(imageFile);
    });
  }
}

// Method to Remove an Image
  void _removeImage(Function(File?) setImage) {
    setState(() {
      setImage(null);
    });
  }

Widget buildImagePicker({
  required File? image,
  required String? imageUrl,
  required Function(File?) setImage,
  required String? errorText,
  required Function(String?) setError,
}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      CustomImagePicker(
        imageUrl: imageUrl ?? '',
        image: image,
        onTap: () => _pickImage(setImage, image, setError),
        height: MediaQuery.of(context).size.height / 14,
        width: MediaQuery.of(context).size.width / 6,
      ),
      if (image != null || (imageUrl?.isNotEmpty ?? false))
        IconButton(
            onPressed: () {
              setState(() {
                setImage(null);
                setError(null);
              });
            },
            icon: Icon(
              Icons.cancel,
              size: 15,
              color: Colors.grey,
            )),
      // No error here to avoid overflow
    ],
  );
}
String? getAdditionalImagesErrorMessage() {
  if (_additionalImage1Error != null) {
    return "File size must be less than 500KB in 1st Additional Image";
  }
  if (_additionalImage2Error != null) {
    return "File size must be less than 500KB in 2nd Additional Image";
  }
  if (_additionalImage3Error != null) {
    return "File size must be less than 500KB in 3rd Additional Image";
  }
  if (_additionalImage4Error != null) {
    return "File size must be less than 500KB in 4th Additional Image";
  }
  return null;
}


  String? _additionalImageUrl1,
      _additionalImageUrl2,
      _additionalImageUrl3,
      _additionalImageUrl4;
  File? _pickedAdditionalImage1,
      _pickedAdditionalImage2,
      _pickedAdditionalImage3,
      _pickedAdditionalImage4;
      String? _primaryImageError;
String? _additionalImage1Error;
String? _additionalImage2Error;
String? _additionalImage3Error;
String? _additionalImage4Error;

  Future<Map<String, String>> _uploadAllImages() async {
    Map<String, dynamic> images = {
      "primaryImage": {"url": _primaryImageUrl, "file": pickedPrimaryImage},
      "additionalImage1": {
        "url": _additionalImageUrl1,
        "file": _pickedAdditionalImage1
      },
      "additionalImage2": {
        "url": _additionalImageUrl2,
        "file": _pickedAdditionalImage2
      },
      "additionalImage3": {
        "url": _additionalImageUrl3,
        "file": _pickedAdditionalImage3
      },
      "additionalImage4": {
        "url": _additionalImageUrl4,
        "file": _pickedAdditionalImage4
      },
    };
    Map<String, String> uploadedImageUrls = {};

    for (var entry in images.entries) {
      final imageUrl = entry.value["url"];
      final imageFile = entry.value["file"];

      if (imageFile != null) {
        await imageUploader.uploadImage(file: imageFile);
        if (imageUploader.imageURL.isNotEmpty) {
          uploadedImageUrls[entry.key] = imageUploader.imageURL.value;
        }
      } else if (imageUrl != null && imageUrl.isNotEmpty) {
        uploadedImageUrls[entry.key] = imageUrl;
      }
    }
    return uploadedImageUrls;
  }

  bool isFormComplete() {
    return _itemNameController.text.isNotEmpty &&
        _cuisinetype.text.isNotEmpty &&
        _priceController.text.isNotEmpty &&
       // _discountController.text.isNotEmpty &&
        _packageController.text.isNotEmpty ;
       // _commissionController.text.isNotEmpty;
  }
bool isTimeSelectionValid() {
  return _preparationTime.isNotEmpty &&
         _selectedAvailabilityTimes
             .any((time) => ['Morning', 'Afternoon', 'Evening','Night','Mid-night','All'].contains(time));
}

  final addkey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    // variantsController.initialize(
    //   initialVariants: widget.variants,
    //   initialGroupVariants: widget.groupVariants,
    //   initialGroupNames: widget.groupNames,
    // );
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryScreen(
                    foodCatId: widget.FoodCatid,
                    foodCategory: widget.FoodCat)));
      },
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.grey.shade600),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CategoryScreen(
                              foodCatId: widget.FoodCatid,
                              foodCategory: widget.FoodCat,
                            )));
              },
            ),
            title: InkWell(
              onTap: () {
                variantsController.variants.clear();
              },
              child: Center(
                  child: CustomText(
                text: 'Add Item        ',
                style: CustomTextStyle.mediumGreyText,
              )),
            )),
        body: SingleChildScrollView(
          child: Form(
            key: addkey,
            // autovalidateMode: AutovalidateMode.onUserInteraction,
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
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
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 15),
                                  Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                   const SizedBox(height: 15),
                                   CustomText(
                                    text: 'Primary Image',
                                    style: CustomTextStyle.categoryBlackText,),
                                    const SizedBox(height: 10),
                      buildImagePicker(
                        image: pickedPrimaryImage,
                        imageUrl: widget.foodsListIndex?.foodImgUrl?.isNotEmpty == true
                            ? widget.foodsListIndex!.foodImgUrl
                            : (foodController.foodItem.value?.foodImage.isNotEmpty == true
                                ? foodController.foodItem.value!.foodImage
                                : null),
                        setImage: (image) => pickedPrimaryImage = image,
                        errorText: _primaryImageError,
                        setError: (val) => _primaryImageError = val,
                      ),
                      if (_primaryImageError != null)
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Text(
                            _primaryImageError!,
                            style: TextStyle(color: Colors.red, fontSize: 12),
                          ),
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
                  const SizedBox(height: 10),
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
                                    text:catres=="restaurant"? 'Dish Information':"Product Information",
                                    style:CustomTextStyle.mediumBoldBlackText),
                                GestureDetector(
                                 onTap: () {
                                 setState(() {
                                  _isDishExpanded = !_isDishExpanded;});},
                                  child: Icon(
                                    _isDishExpanded
                                        ? MdiIcons.chevronUp
                                        : MdiIcons.chevronDown,
                                    color: Colors.grey.shade600,
                                    size: 32,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (_isDishExpanded)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 15),
                                    catres=="restaurant"? 
                                  CustomText(
                                      text: 'Food Type',
                                      style:CustomTextStyle.categoryBlackText):SizedBox.shrink(),
                                  catres=="restaurant"?   const SizedBox(height: 15):SizedBox.shrink(),
                                    catres=="restaurant"? 
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width /1.5,
                                    child: Row(
                                      mainAxisAlignment:MainAxisAlignment.spaceAround,
                                      children: <Widget>[
                                        _buildFoodOption('veg'),
                                        _buildFoodOption('nonveg'),
                                        _buildFoodOption('egg'),
                                      ],
                                    ),
                                  ):SizedBox.shrink(),
                                  Obx(() {
                                    return cuisineController.productCategory.isNotEmpty
                                        ? SizedBox()
                                        : SizedBox();
                                  }),
                                  const SizedBox(height: 15),
                                  CustomPriceTextFormField(
                                      label: RichText(
                                        text: TextSpan(
                                          children: [
                                            TextSpan(
                                                text: 'Item Name',
                                                style: CustomTextStyle.greyTextFormFieldText),
                                            TextSpan(
                                                text: ' ⁕',
                                                style: CustomTextStyle.requireStarText),
                                          ],
                                        ),
                                      ),
                                      controller: _itemNameController,
                                      onChanged: (text) {
                                        setState(() {});
                                      },
                                      validator: validateName),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  GestureDetector(
                                  onTap: () {
                                        if (cuisineController.productCategory.isNotEmpty) {
                                          _showCuisineDropdown(context, cuisineController);
                                        } else {
                                          Get.snackbar('Loading','Please wait, loading cuisines.');
                                        }
                                      },
                                    child: AbsorbPointer(
                                      child: CustomTypeTextFormField(
                                      readOnly: true,
                                        controller: _cuisinetype,
                                        validator: validateName,
                                        suffixIcon: Icon(
                                          MdiIcons.chevronDown,
                                          color: Colors.grey,
                                        ),
                                        label: RichText(
                                          text: TextSpan(
                                            children: [
                                              TextSpan(
                                                text: 'Cuisine Type',
                                                style: CustomTextStyle.greyTextFormFieldText,
                                              ),
                                              TextSpan(
                                                text: ' ⁕',
                                                style: CustomTextStyle.requireStarText,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  CustomPriceTextFormField(
                                    style:const TextStyle(color: Colors.black),
                                    controller: _description,
                                    label: RichText(
                                      text: TextSpan(
                                        children: [
                                          TextSpan(
                                              text: 'Description',
                                              style: CustomTextStyle.greyTextFormFieldText),
                                          TextSpan(
                                              text: ' ',
                                              style: CustomTextStyle.requireStarText),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                    catres=="restaurant"? 
                                  CustomIngredientsTextFormField(
  controller: _ingredients,
  onChanged: (val) {
    if (val.isNotEmpty) {
      setState(() => showSuggestions = true);
      foodController.getIngredients(value: val); // API call
    } else {
      setState(() => showSuggestions = false);
    }
  },
  suffixIcon: GestureDetector(
    onTap: _addIngredient,
    child: Icon(MdiIcons.plus, color: Colors.grey),
  ),
  label: CustomText(
    text: 'Ingredients',
    style: CustomTextStyle.bigGreyTextFormFieldText,
  ),
):SizedBox.shrink(),

if (showSuggestions)
  Obx(() {
  
  if(foodController.isingredientsLoading.isTrue) {
            return Center(child: CupertinoActivityIndicator());
          } else if (foodController.ingredientsDetails == null) {
            return SizedBox();
          } else if (foodController.ingredientsDetails["data"]?["searchList"].isEmpty) {
            return SizedBox();
          } else {
          
              double containerHeight = foodController.ingredientsDetails["data"]?["searchList"].length == 1 ? 60 : 150;
    return Container(
      height: containerHeight,
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey.shade400),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Scrollbar(
        thumbVisibility: true,
        thickness: 4,
        radius: const Radius.circular(8),
        child: ListView.builder(
          itemCount: foodController.ingredientsDetails["data"]?["searchList"].length,
          itemBuilder: (context, index) {
            final hashtagName = foodController.ingredientsDetails["data"]?["searchList"][index]["hashtagName"];
            return InkWell(
            onTap: () {
                  if (!ingredientsList.contains(hashtagName)) {
                    setState(() {
                      ingredientsList.add(hashtagName);
                      _ingredients.clear();
                      isContainerVisible = true;
                      showSuggestions = false;
                    });
                  }
                },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 10),
                child: Text(hashtagName,style: CustomTextStyle.blackText,),
              ),
            );
          },
        ),
      ),
    );}
  }),


                                  const SizedBox(height: 5),
                                  Visibility(
                                    visible: isContainerVisible,
                                    child: Wrap(
                                      spacing:8.0, // Space between chips horizontally
                                      runSpacing:8.0, // Space between chips vertically
                                      children:ingredientsList.map((ingredient) {
                                        int index = ingredientsList.indexOf(ingredient);
                                        return Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 6.0),
                                          decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:BorderRadius.circular(15),
                                            border: Border.all(color: Colors.grey.shade500),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize
                                                .min, // Ensures the container wraps tightly around its content
                                            children: [
                                              Text(
                                                ingredient,
                                                style: CustomTextStyle.ingredientsText,
                                              ),
                                              const SizedBox(width: 4),
                                              InkWell(
                                                onTap: () =>_removeIngredient(index),
                                                child: const Icon(
                                                  Icons.close,
                                                  size:20, // Adjusted size for responsiveness
                                                  color: Customcolors.decorationGrey,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      }).toList(),
                                    ),
                                  )
                                ],
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                              mainAxisAlignment:MainAxisAlignment.spaceBetween,
                              children: [
                                CustomText(
                                    text: 'Pricing Details',
                                    style:CustomTextStyle.mediumBoldBlackText),
                                GestureDetector(
                                 onTap: () {
                                 setState(() {
                                 _isPricingExpanded = !_isPricingExpanded;});},
                                  child: Icon(
                                    _isPricingExpanded
                                        ? MdiIcons.chevronUp
                                        : MdiIcons.chevronDown,
                                    color: Colors.grey.shade600,
                                    size: 32,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          if (_isPricingExpanded)
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width / 1,
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                      children: [
                                        const SizedBox(height: 15),
                                        Expanded(
                                          child: CustomPriceTextFormField(
                                            inputFormatters: [
                                              FilteringTextInputFormatter.digitsOnly,
                                            ],
                                            keyboardType: TextInputType.phone,
                                            validator: foodaddprice,
                                            controller: _priceController,
                                            label: RichText(
                                              text: TextSpan(
                                                children: [
                                                  TextSpan(
                                                      text: 'Price',
                                                      style: CustomTextStyle.greyTextFormFieldText),
                                                  TextSpan(
                                                      text: ' ⁕',
                                                      style: CustomTextStyle.requireStarText),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      
                                            Expanded(
                                            child: CustomPriceTextFormField(
                                            keyboardType: TextInputType.number,
                                            inputFormatters: [FilteringTextInputFormatter.digitsOnly,],
                                            controller: _packageController,
                                            label: RichText(
                                            text: TextSpan(
                                            children: [
                                            TextSpan(
                                             text: 'Package',
                                             style: CustomTextStyle.greyTextFormFieldText,
                                             ),
                                            ],),),),
                                            ),


                                    
                                       
                                      ],
                                    ),

//                                      
                                  ],
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
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
                                    style:CustomTextStyle.mediumBoldBlackText),
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
                                    style: CustomTextStyle.categoryBlackText):SizedBox.shrink(),
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
                                    style: CustomTextStyle.categoryBlackText),
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
  
                  const SizedBox(height: 35),
                

          (catres=="restaurant"? (_selectedFoodType != null && isFormComplete() && pickedPrimaryImage != null && isTimeSelectionValid()):
          ( isFormComplete() && pickedPrimaryImage != null)
          )
         
                       ?
                       Obx(() {
                           if (foodListController.isfoodCreateLoading.isTrue) {
                            return loadingdisableButton(context);
                         }
                           else {
                            return Center(
                                child: CustomButton(
                              borderRadius: BorderRadius.circular(5),
                              height: MediaQuery.of(context).size.height / 23,
                              width: MediaQuery.of(context).size.width / 2,

                              onPressed: () async {
  if (addkey.currentState!.validate()) {
bool checkbox = false;
    // Show alert FIRST
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) => 
          AlertDialog(
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              catres=="restaurant"? "Do you want to add this food?":"Do you want to add this product?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
          
             Row(
                  children: [
                    Checkbox(
                      value: checkbox ,
                      onChanged: (val) {
                        setState(() {
                          checkbox  = val!;
                        });
                      },
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                            for (var item in appCOnfig
                                    .redirectLoadingDetails["data"]) {
                                  
                                   if (item["key"] == "termsandservice") {
                                    launchwebUrl(context, item["value"]);

                                    break; // Exit loop once the "whatsappLink" is found and launched
                                  }
                                }
                        },
                        child: Text("I agree to the Terms & Conditions",style: TextStyle(color: Colors.blue),)),
                    ),
                  ],
                ),
          
             
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                ElevatedButton(
                   style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFF623089),
                      foregroundColor: Colors.white,
                    ),
                  onPressed: () => Navigator.pop(context),
                  child: Text('No'),
                ),
                ElevatedButton(
                   style: ElevatedButton.styleFrom(
                      backgroundColor:checkbox ? Color(0xFF623089):Colors.grey,
                      foregroundColor: Colors.white,
                    ),
                   onPressed:checkbox ? () async {
                      Navigator.pop(context); // close dialog
          
                      foodListController.isfoodCreateLoading.value = true;
          
                      // Upload Images
                      Map<String, String> imageUrls = await _uploadAllImages();
          
                      // Prepare data
                      String price = _priceController.text.replaceFirst("₹", "");
                      String discountPrice = _discountController.text.replaceFirst("₹", "");
                      String packagePrice = _packageController.text.replaceFirst("₹", "");
          
                      // final availableTimings =
                      //     AdditionHelperItems().prepareAvailableTimings(_selectedAvailabilityTimes);
                      final availableTimings = AdditionHelperItems()
    .prepareAvailableTimings(_selectedAvailabilityTimes, categoryTimes);

          
                      final groupNames = variantsController.addongroupNames;
                      final groupVariants = variantsController.groupVariants.map((group) {
                        return group.map((variant) {
                          final rawPrice = variant["price"]?.toString() ?? "0.0";
                          final cleanedPrice = rawPrice.replaceAll(RegExp(r'[^\d.]'), '');
                          final parsedPrice = double.tryParse(cleanedPrice) ?? 0.0;
                          return {
                            "name": variant["name"],
                            "price": parsedPrice,
                          };
                        }).toList();
                      }).toList();
          
                      // Create food
                      await foodListController.foodCreate(
                        mediumUrl: imageUrls["primaryImage"] ?? "",
                        thumbUrl: imageUrls["primaryImage"] ?? "",
                        isCustomised: isChecked,
                        varianGroupName: widget.variantGroupName ?? "",
                        foodCatName: widget.FoodCat,
                        groupNames: groupNames,
                        groupVariants: groupVariants,
                        foodCatId: widget.FoodCatid,
                        foodImage: imageUrls["primaryImage"] ?? "",
                        custPrice: price,
                        discPrice: discountPrice,
                        packPrice: packagePrice,
                        foodCuisine: _cuisinetype.text,
                        foodDesc: _description.text,
                        foodName: _itemNameController.text,
                        foodType: _selectedFoodType?.toLowerCase() ?? "veg",
                        prepTime: _preparationTime ?? "",
                        additionalImage1: imageUrls["additionalImage1"] ?? "",
                        additionalImage2: imageUrls["additionalImage2"] ?? "",
                        additionalImage3: imageUrls["additionalImage3"] ?? "",
                        additionalImage4: imageUrls["additionalImage4"] ?? "",
                        foodcuisineId: _selectedCuisineId,
                        availableTimings: availableTimings,
                        ingredientsList: ingredientsList ?? [],
                      );
          
                      foodListController.isfoodCreateLoading.value = false;
                    }:(){},
          
                  child: const Text('Yes'),
                ),
              ],
            )
          ],
                ),
              ),
        );
      
      },
    );
  } else {
    Get.snackbar("Error", "Fill the required Fields",
        backgroundColor: Customcolors.decorationred);
  }
},

                              child: CustomText(
                                text: 'Confirm',
                                style: CustomTextStyle.mediumWhiteText,
                              ),
                            ));
                          }
                        })
                      : disableButton(context),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Center loadingdisableButton(BuildContext context) {
    return Center(
      child: CustomdisabledButton(
          borderRadius: BorderRadius.circular(20),
          height: MediaQuery.of(context).size.height / 23,
          width: MediaQuery.of(context).size.width / 2,
          onPressed: () async {},
          child: LoadingAnimationWidget.newtonCradle(
              color: Colors.white, size: 70)),
    );
  }

  Center disableButton(BuildContext context) {
    return Center(
      child: CustomdisabledButton(
          borderRadius: BorderRadius.circular(20),
          height: MediaQuery.of(context).size.height / 23,
          width: MediaQuery.of(context).size.width / 2,
          onPressed: () async {},
          child: Text(
            'Confirm',
            style: CustomTextStyle.mediumGreyButText,
          )),
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





  void launchwebUrl(BuildContext context, String url) async {
    try {
      await canLaunch(url);
      await launch(url);
      print("urllll${url}");
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Something went wrong when launching URL"),
        ),
      );
      print("error");
    }
  }
 


}
