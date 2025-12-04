// ignore_for_file: must_be_immutable

import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/Controllers/CategoryController/cusinecontroller.dart';
import 'package:miogra_seller/Controllers/CategoryController/foodcontroller.dart';
import 'package:miogra_seller/Controllers/CategoryController/hashtagcategory.dart';
import 'package:miogra_seller/Screens/Menu/itemsHelperScreen.dart';
import 'package:miogra_seller/Validators/validator.dart';
import 'package:miogra_seller/Widgets/custom_colors.dart';
import 'package:miogra_seller/Widgets/custom_container.dart';
import 'package:miogra_seller/Widgets/custom_imagepicker.dart';
import 'package:miogra_seller/Widgets/custom_text.dart';
import 'package:miogra_seller/Widgets/custom_textformfield.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';

class DishPricingDetails extends StatefulWidget {
  Function(String) buildFoodOption;
  TextEditingController itemNameController;
  TextEditingController cuisinetypeController;
  TextEditingController descriptionController;
  TextEditingController ingredientsController;
  TextEditingController priceController;
  TextEditingController discountController;
  TextEditingController packageController;
  TextEditingController commissionController;
  Function(BuildContext, dynamic) showCuisineDropdown;
  dynamic selectedFoodType;
  dynamic selectedCuisineId;
  List<String> ingredientsList;

  DishPricingDetails({
    super.key,
    required this.showCuisineDropdown,
    required this.buildFoodOption,
    required this.itemNameController,
    required this.ingredientsList,
    required this.selectedCuisineId,
    required this.selectedFoodType,
    required this.cuisinetypeController,
    required this.descriptionController,
    required this.ingredientsController,
    required this.priceController,
    required this.discountController,
    required this.packageController,
    required  this.commissionController,
  });

  @override
  DishPricingDetailsState createState() => DishPricingDetailsState();
}

class DishPricingDetailsState extends State<DishPricingDetails> {

  final FoodController foodController = Get.put(FoodController());
  final HashTagCategoryController hashTagCategoryController =Get.put(HashTagCategoryController());
  final CuisineController cuisineController = Get.put(CuisineController());
  bool _isDishExpanded = false;
  bool _isPricingExpanded = false;
  // String _selectedFoodType = 'veg'; // Default selection
  bool isContainerVisible = false;
  // List<String> ingredientsList = [];

  // void _addIngredient() {
  //   if (widget.ingredientsController.text.isNotEmpty) {
  //     setState(() {
  //       widget.ingredientsList.add(widget.ingredientsController.text);
  //       widget.ingredientsController.clear();
  //       isContainerVisible = true;
  //     });
  //   }
  // }
void _addIngredient() async {
  String newIngredient = widget.ingredientsController.text.trim();
  if (newIngredient.isEmpty) return;

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
        widget.ingredientsList.add(newIngredient);
        widget.ingredientsController.clear();
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
  bool showSuggestions = false;
  void _removeIngredient(int index) {
    setState(() {
      widget.ingredientsList.removeAt(index);
      if (widget.ingredientsList.isEmpty) {
        isContainerVisible = false;
      }
    });
  }

  @override
  void initState() {
    _isDishExpanded = true;
    _isPricingExpanded = true;

    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomContainer(
          backgroundColor: Colors.white,
          borderRadius: BorderRadius.circular(10),
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text: catres=="restaurant"? 'Dish Information':"Product Information",
                          style: CustomTextStyle.mediumBoldBlackText),
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
                            style: CustomTextStyle.categoryBlackText):SizedBox.shrink(),
                              catres=="restaurant"? 
                        const SizedBox(height: 15):SizedBox.shrink(),
                          catres=="restaurant"? 
                        SizedBox(
                          width: MediaQuery.of(context).size.width / 1.5,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: <Widget>[
                              widget.buildFoodOption('veg'),
                              widget.buildFoodOption('nonveg'),
                              widget.buildFoodOption('egg'),
                            ],
                          ),
                        ):SizedBox.shrink(),
                        const SizedBox(height: 15),
                        CustomPriceTextFormField(
                          label: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Item Name',
                                    style: CustomTextStyle
                                        .greyTextFormFieldText),
                                const TextSpan(
                                    text: ' ⁕',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 17)),
                              ],
                            ),
                          ),
                          controller: widget.itemNameController,
                          validator: validateName,
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                        onTap: () {
                                if (cuisineController
                                    .productCategory.isNotEmpty) {
                                  widget.showCuisineDropdown(
                                      context, cuisineController);
                                } else {
                                  Get.snackbar('Loading',
                                      'Please wait, loading cuisines.');}
                                
                        },
                          child: AbsorbPointer(
                            child: CustomTypeTextFormField(
                            readOnly: true,
                              controller: widget.cuisinetypeController,
                              validator: validateName,
                              suffixIcon: Icon(MdiIcons.chevronDown,
                                  color: Colors.grey),
                              label: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                        text: 'Cuisine Type',
                                        style: CustomTextStyle
                                            .greyTextFormFieldText),
                                    const TextSpan(
                                        text: ' ⁕',
                                        style: TextStyle(
                                            color: Colors.red, fontSize: 17)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        CustomPriceTextFormField(
                          controller: widget.descriptionController,
                          label: RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                    text: 'Description',
                                    style: CustomTextStyle
                                        .greyTextFormFieldText),
                                const TextSpan(
                                    text: ' ',
                                    style: TextStyle(
                                        color: Colors.red, fontSize: 17)),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                           catres =="restaurant"? 
                              CustomIngredientsTextFormField(
  controller: widget.ingredientsController,
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
  // if(foodController.isingredientsLoading.isTrue){
  // return CircularProgressIndicator();
  // }
    // final searchList = foodController.ingredientsDetails["data"]?["searchList"] ?? [];

    // if (searchList.isEmpty) return const SizedBox();
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
                  if (!widget.ingredientsList.contains(hashtagName)) {
                    setState(() {
                      widget.ingredientsList.add(hashtagName);
                      widget.ingredientsController.clear();
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


                               
                        // CustomPriceTextFormField(
                        //   // validator: validateName,
                        //   controller: widget.ingredientsController,
                        //   suffixIcon: GestureDetector(
                        //     onTap: _addIngredient,
                        //     child: Icon(MdiIcons.plus, color: Colors.grey),
                        //   ),
                        //   label: CustomText(
                        //       text: 'Ingredients',
                        //       style:
                        //           CustomTextStyle.bigGreyTextFormFieldText),
                        // ),
                       
                        const SizedBox(height: 5),
                        Visibility(
                          // visible: isContainerVisible,
                          visible: widget.ingredientsList.isNotEmpty, // 🔥 fixed here
                          child: Wrap(
                            spacing: 8.0,
                            runSpacing: 8.0,
                            children:widget.ingredientsList.map((ingredient) {
                              int index =widget.ingredientsList.indexOf(ingredient);
                              return CustomContainer(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 8.0, vertical: 6.0),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                  border:
                                      Border.all(color: Colors.grey.shade500),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(ingredient,
                                        style:
                                            CustomTextStyle.ingredientsText),
                                    const SizedBox(width: 4),
                                    InkWell(
                                      onTap: () => _removeIngredient(index),
                                      child: const Icon(Icons.close,
                                          size: 20,
                                          color: Customcolors.decorationGrey),
                                    ),
                                  ],
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                     
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
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(5.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomText(
                          text: 'Pricing Details',
                          style: CustomTextStyle.mediumBoldBlackText),
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
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(height: 15),
                              Expanded(
                                child: CustomPriceTextFormField(
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                  validator: foodaddprice,
                                  keyboardType: TextInputType.number,
                                  controller: widget.priceController,
                                  label: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                            text: 'Price',
                                            style: CustomTextStyle
                                                .greyTextFormFieldText),
                                        const TextSpan(
                                            text: ' ⁕',
                                            style: TextStyle(
                                                color: Colors.red, fontSize: 17)),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              // Expanded(
                              //   child: CustomPriceTextFormField(
                              //     keyboardType: TextInputType.number,
                              //     inputFormatters: [
                              //       FilteringTextInputFormatter.digitsOnly,
                              //     ],
                              //     validator: foodaddprice,
                              //     controller: widget.discountController,
                              //     label: RichText(
                              //       text: TextSpan(
                              //         children: [
                              //           TextSpan(
                              //               text: 'Discount',
                              //               style: CustomTextStyle
                              //                   .greyTextFormFieldText),
                              //           const TextSpan(
                              //               text: ' ⁕',
                              //               style: TextStyle(
                              //                   color: Colors.red, fontSize: 17)),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),

 Expanded(
                            child: CustomPriceTextFormField(
                              keyboardType: TextInputType.number,
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly,
                              ],
                              // validator: addprice,
                              controller: widget.packageController,
                              label: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Package',
                                      style: CustomTextStyle.greyTextFormFieldText,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),


                             // const SizedBox(width: 10),


                              // Expanded(
                              //   child: CustomPriceTextFormField(
                              //     keyboardType: TextInputType.number,
                              //     inputFormatters: [
                              //       FilteringTextInputFormatter.digitsOnly,
                              //     ],
                              //     // validator: addprice,
                              //     controller: widget.packageController,
                              //     label: RichText(
                              //       text: TextSpan(
                              //         children: [
                              //           TextSpan(
                              //               text: 'Package',
                              //               style: CustomTextStyle
                              //                   .greyTextFormFieldText),
                              //           const TextSpan(
                              //               text: ' ⁕',
                              //               style: TextStyle(
                              //                   color: Colors.red, fontSize: 17)),
                              //         ],
                              //       ),
                              //     ),
                              //   ),
                              // ),
                          
                          
                            ],
                          ),
                        
                          // Row(
                          //   children: [
                            
                          //                           Expanded(
                          //   child: CustomPriceTextFormField(
                          //     keyboardType: TextInputType.number,
                          //     inputFormatters: [
                          //       FilteringTextInputFormatter.digitsOnly,
                          //     ],
                          //     // validator: addprice,
                          //     controller: widget.packageController,
                          //     label: RichText(
                          //       text: TextSpan(
                          //         children: [
                          //           TextSpan(
                          //             text: 'Package',
                          //             style: CustomTextStyle.greyTextFormFieldText,
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          //       const SizedBox(width: 10),

                          
                          //                           Expanded(
                          //   child: CustomPriceTextFormField(
                          //     keyboardType: TextInputType.number,
                          //     inputFormatters: [
                          //       FilteringTextInputFormatter.digitsOnly,
                          //     ],
                          //     // validator: addprice,
                          //     controller: widget.commissionController,
                          //     label: RichText(
                          //       text: TextSpan(
                          //         children: [
                          //           TextSpan(
                          //             text: 'Commission',
                          //             style: CustomTextStyle.greyTextFormFieldText,
                          //           ),
                          //         ],
                          //       ),
                          //     ),
                          //   ),
                          // ),
                          //   ],
                          // ),
                         
                        ],
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    );
  }
}

CustomImagePicker additionalImageDesign(
    {required BuildContext context,
    required final VoidCallback onTap,
    File? image,
    required String imgUrl}) {
  return CustomImagePicker(
    imageUrl: imgUrl,
    image: image,
    onTap: onTap,
    height: MediaQuery.of(context).size.height / 14,
    width: MediaQuery.of(context).size.width / 6,
  );
}

// pickImageNew() async {
//   final picker = ImagePicker();
//   final pickedFile = await picker.pickImage(source: ImageSource.gallery);

//   if (pickedFile != null) {
//     final imageFile = File(pickedFile.path);
//     if (AdditionHelperItems().isImageValid(imageFile)) {
//       return imageFile;
//       // setState(() {
//       //   setImage(imageFile);
//       // });
//     } else {
//       // Handle invalid image scenario
//       Get.snackbar("Invalid Image", "Please select a valid image.");
//       return null;
//     }
//   }
// }

pickImageNew() async {
  final picker = ImagePicker();
  final pickedFile = await picker.pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    final imageFile = File(pickedFile.path);

    if (AdditionHelperItems().isImageValid(imageFile)) {
      return imageFile;
    } else {
      // Error snackbar already handled inside isImageValid
      return null;
    }
  }
  return null;
}
