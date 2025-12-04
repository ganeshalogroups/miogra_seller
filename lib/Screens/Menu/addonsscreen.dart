// ignore_for_file: must_be_immutable, avoid_print, prefer_final_fields

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:miogra_seller/Controllers/CategoryController/variantaddonscontroller.dart';
import 'package:miogra_seller/Screens/Menu/additemscreen.dart';
import 'package:miogra_seller/Screens/Menu/editItemScreen.dart';
import 'package:miogra_seller/Screens/Menu/variantsscreen.dart';
import 'package:miogra_seller/Validators/validator.dart';
import 'package:miogra_seller/Widgets/custom_alertdialog.dart';
import 'package:miogra_seller/Widgets/custom_button.dart';
import 'package:miogra_seller/Widgets/custom_colors.dart';
import 'package:miogra_seller/Widgets/custom_container.dart';
import 'package:miogra_seller/Widgets/custom_gradienttext.dart';
import 'package:miogra_seller/Widgets/custom_text.dart';
import 'package:miogra_seller/Widgets/custom_textformfield.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';

class AddOnsScreen extends StatefulWidget {
  final dynamic foodsListIndex;
  final String? foodCatid;
  final String? foodCat;
  final bool isEdit;
  String? variantGroupName;
  List<Variant>? variants;
   final dynamic returnedupdatedaddons;
   final dynamic returnedupdatedvariants;
  AddOnsScreen({
    super.key,
    this.foodsListIndex,
    required this.variantGroupName,
     required this.returnedupdatedvariants,
    this.foodCatid,
    this.foodCat,
    required this.isEdit,
    required this.variants,
    required this.returnedupdatedaddons,
  });

  @override
  State<AddOnsScreen> createState() => _AddOnsScreenState();
}

class _AddOnsScreenState extends State<AddOnsScreen> {
  VariantsController variantsCon = Get.put(VariantsController());
  TextEditingController _groupName = TextEditingController();
  bool _isCreated = false; // To track whether the "Create" button is clicked
  List<dynamic> _groupNames = []; // List to store group names
  List<bool> _isAddonsExpandedList = [];
  List<Variant> variants = [];
  final addonkey = GlobalKey<FormState>();
  List<TextEditingController> _addOnNameControllers = [];
  List<Map<String, dynamic>> updatedAddOns = [];
  List<TextEditingController> _priceControllers = [];
  List<TextEditingController> _typeControllers = [];
  List<List<Map<String, String>>> _groupVariants =[]; // List of lists to store variants for each group
  int? _editingGroupIndex; // Track the group index being edited

  @override
  void initState() {
    super.initState();
    _addVariant();
    // processFoodData();
      print("returnedupdatedaddons in addonspage: ${widget.returnedupdatedaddons}");
       print("returnedupdated variants in addonpage: ${widget.returnedupdatedvariants}");
      print(" variants in sddon page:${widget.variants}");
     if (widget.returnedupdatedaddons != null && widget.returnedupdatedaddons.isNotEmpty) {
    print("returnedupdatedaddons: ${widget.returnedupdatedaddons}");
    _groupNames.clear();
    _groupVariants.clear();
    _isAddonsExpandedList.clear();
    loadUpdatedAddonsData(widget.returnedupdatedaddons);
    _isCreated = true;
  } else {
    processFoodData(); // fallback to original data only if there's no updated data
  }
    _groupName.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _groupName.dispose();
    for (var controller in _addOnNameControllers) {
      controller.dispose();
    }
    for (var controller in _priceControllers) {
      controller.dispose();
    }
    for (var controller in _typeControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  void _showTypeSelectionDialog(
      BuildContext iconContext, TextEditingController controller) {
    final RenderBox renderBox = iconContext.findRenderObject() as RenderBox;
    final Offset offset = renderBox.localToGlobal(Offset.zero);
    final Size size = renderBox.size;

    showMenu(
      shape: RoundedRectangleBorder(),
      surfaceTintColor: Colors.white,
      context: context,
      position: RelativeRect.fromLTRB(
        offset.dx,
        offset.dy + size.height,
        offset.dx + size.width,
        offset.dy + size.height,
      ),
      items: [
        const PopupMenuItem(
          value: 'veg',
          child: Text('Veg'),
        ),
        const PopupMenuItem(
          value: 'nonveg',
          child: Text('nonveg'),
        ),
        const PopupMenuItem(
          value: 'egg',
          child: Text('Egg'),
        ),
      ],
    ).then((value) {
      if (value != null) {
        setState(() {
          controller.text = value;
        });
      }
    });
  }

  void _addVariant() {
    setState(() {
      _addOnNameControllers.add(TextEditingController());
      _priceControllers.add(TextEditingController(text: "₹"));
      _typeControllers.add(TextEditingController());
    });
  }

  void _handleEdit(int groupIndex) {
    setState(() {
      _editingGroupIndex = groupIndex;
      _groupName.text = _groupNames[groupIndex];

      // Clear existing controllers
      _addOnNameControllers.clear();
      _priceControllers.clear();
      _typeControllers.clear();

      // Populate controllers with the values of the group being edited
      for (var variant in _groupVariants[groupIndex]) {
        _addOnNameControllers.add(TextEditingController(text: variant['name']));
        _priceControllers.add(TextEditingController(text: variant['price']));
        _typeControllers.add(TextEditingController(text: variant['type']));
      }
    });
  }

  void processFoodData() {
    print("addonlist${widget.foodsListIndex?["customizedFood"]["addOns"]}");

    dynamic addOns = widget.foodsListIndex?["customizedFood"]["addOns"];

    if (addOns != null && addOns.isNotEmpty) {
      setState(() {
        _isCreated = true;
      });

      _groupNames.clear();
      _groupVariants.clear();

      for (var addOn in addOns) {
        _groupNames.add(addOn['addOnsGroupName'] ?? "");

        List<Map<String, String>> variants = [];

        if (addOn["addOnsType"] != null && addOn["addOnsType"].isNotEmpty) {
          for (var addOnType in addOn["addOnsType"]) {
            variants.add({
              'name': addOnType['variantName'] ?? "",
              'price': addOnType['basePrice']?.toString() ?? "",
              'type': addOnType['type'] ?? "",
            });
          }
        }

        // Add the list of variants to _groupVariants as a single entry
        _groupVariants.add(variants);
      }

      // Initialize _isAddonsExpandedList after populating _groupNames
      // _isAddonsExpandedList = List.generate(_groupNames.length, (_) => false);
       _isAddonsExpandedList = List.generate(_groupNames.length, (_) => true);
    } else {
      _groupNames = [];
      _groupVariants = [];
      _isAddonsExpandedList = [];
    }

    print('Group Names: $_groupNames');
    print('Group Variants: $_groupVariants');

    setState(() {});
  }
// void loadUpdatedAddonsData(List<dynamic> returnedAddons) {
//   for (var group in returnedAddons) {
//     String groupName = group['addOnsGroupName'] ?? '';
//     List<dynamic> addOnTypes = group['addOnsType'] ?? [];

//     int existingIndex = _groupNames.indexOf(groupName);

//     List<Map<String, String>> newAddons = addOnTypes.map<Map<String, String>>((addon) {
//       return {
//         'name': addon['variantName'] ?? '',
//         'price': addon['customerPrice']?.toString() ?? '',
//         'type': addon['type'] ?? '',
//       };
//     }).toList();

//     if (existingIndex >= 0) {
//       // ✅ Replace existing group
//       _groupVariants[existingIndex] = newAddons;
//     } else {
//       // ✅ Add new group
//       _groupNames.add(groupName);
//       _groupVariants.add(newAddons);
//       _isAddonsExpandedList.add(true);
//     }
//   }

//   _isCreated = true;
//   setState(() {});
// }
void loadUpdatedAddonsData(List<dynamic> returnedAddons) {
  for (var group in returnedAddons) {
    String groupName = group['addOnsGroupName'] ?? '';
    List<dynamic> addOnTypes = group['addOnsType'] ?? [];

    int existingIndex = _groupNames.indexOf(groupName);

    List<Map<String, String>> newAddons = addOnTypes.map<Map<String, String>>((addon) {
      return {
        'name': addon['variantName'] ?? '',
        'price': addon['basePrice']?.toString() ?? '',
        'type': addon['type'] ?? '',
      };
    }).toList();

    if (existingIndex >= 0) {
      _groupVariants[existingIndex] = newAddons;
    } else {
      _groupNames.add(groupName);
      _groupVariants.add(newAddons);
      _isAddonsExpandedList.add(true);
    }
  }

  _isCreated = true;

  // ✅ Important: populate updatedAddOns from loaded data
  _updateVariants();

  setState(() {});
}



  void _updateVariants() {
    // List<Map<String, dynamic>> updatedAddOns = [];
     updatedAddOns.clear();

    for (int i = 0; i < _groupNames.length; i++) {
      // Ensure _groupVariants[i] is a list before mapping
      List<Map<String, dynamic>> variantsList =
          List.from(_groupVariants[i] ?? []);

      updatedAddOns.add({
        "addOnsGroupName": _groupNames[i], // Assign correct group name
        "addOnsType": variantsList.map((variant) {
          return {
            "variantName":variant["name"] ?? "", // Ensure variant name is updated
            "variantImage": variant["variantImage"] ?? null,
            "additionalImage": variant["additionalImage"] ?? [],
            "type": variant["type"] ?? "veg", // Default to veg if null
            "basePrice": variant["price"] ?? 0, // Ensure basePrice is updated
            "customerPrice": variant["price"] ?? 0, // Ensure correct price
            "totalPrice":variant["price"] ?? 0, // Ensure total price is updated
            "deleted": variant["deleted"] ?? false,
            "status": variant["status"] ?? true,
            "_id": variant["_id"] ?? null,
          };
        }).toList(),
      });
    }

    // Update VariantsController with the new values
    variantsCon.initializeAddOns(updatedAddOns);
    print("Updated AddOns: ${updatedAddOns}");
  }

  void _handleCreateOrUpdate() {
    if (widget.returnedupdatedvariants==null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Please create a variant before proceeding to the add-on section",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 255, 89, 0),
        ),
      );
    }else if (_groupName.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Add valid addOns with AddonGroup name ",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 255, 89, 0),
        ),
      );
    } else if (!addonkey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            "Addon fields cannot be empty",
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Color.fromARGB(255, 255, 89, 0),
        ),
      );
    } else {
      if (_addOnNameControllers.isEmpty ||
          _priceControllers.isEmpty ||
          _typeControllers.isEmpty ||
          _addOnNameControllers[0].text.isEmpty ||
          _priceControllers[0].text.isEmpty ||
          _typeControllers[0].text.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              "Please fill in the required fields",
              style: TextStyle(color: Colors.white),
            ),
            backgroundColor: Color.fromARGB(255, 255, 89, 0),
          ),
        );
      } else {
        setState(() {
          if (_editingGroupIndex != null) {
            // Update the group and variants for the existing group
            _groupNames[_editingGroupIndex!] = _groupName.text;
            _groupVariants[_editingGroupIndex!] = List.generate(
              _addOnNameControllers.length,
              (index) {
                return {
                  'name': _addOnNameControllers[index].text,
                  'price': _priceControllers[index].text,
                  'type': _typeControllers[index].text,
                };
              },
            );
          } else {
            String groupName =
                _groupName.text.isEmpty ? "Extra Cheese!!" : _groupName.text;
            _groupNames.add(groupName);

            List<Map<String, String>> newVariants = List.generate(
              _addOnNameControllers.length,
              (index) {
                return {
                  'name': _addOnNameControllers[index].text,
                  'price': _priceControllers[index].text,
                  'type': _typeControllers[index].text,
                };
              },
            );

            _groupVariants.add(newVariants);
           setState(() {
          _isAddonsExpandedList.add(true); 
           });
            // Add a new entry in the expansion state list for the new group
            // _isAddonsExpandedList.add(false);
          }

          // Reset controllers
          _groupName.clear();
          _addOnNameControllers.clear();
          _priceControllers.clear();
          _typeControllers.clear();

          // // Add one default variant field if needed
          // _addOnNameControllers.add(TextEditingController());
          // _priceControllers.add(TextEditingController(text: "₹"));
          // _typeControllers.add(TextEditingController());
          if (_editingGroupIndex != null) {
  // If editing, re-add one empty field for further input
          _addOnNameControllers.add(TextEditingController());
          _priceControllers.add(TextEditingController(text: "₹"));
          _typeControllers.add(TextEditingController());
}

          _isCreated = true;
          _editingGroupIndex = null;
        });

        /// Call `_updateVariants()` here to update the VariantsController
        _updateVariants();
      }
    }
  }

  // void _deleteGroup(int index) {
  //   setState(() {
  //     _groupNames.removeAt(index);
  //     _groupVariants.removeAt(index);
  //     _isAddonsExpandedList.removeAt(index);
  //   });

  //   // Update VariantsController after deletion
  //   _updateVariants();
  //   print("Deleted Group Index: $index");
  //   print("Updated Group Names: $_groupNames");
  //   print("Updated Group Variants: $_groupVariants");
  // }
// void _deleteGroup(int index) {
//   setState(() {
//     _groupNames.removeAt(index);
//     _groupVariants.removeAt(index);
//     _isAddonsExpandedList.removeAt(index);
//   });

//   // 🔥 Step 1: Clear old data
//   widget.returnedupdatedaddons.clear();

//   // 🔁 Step 2: Rebuild updatedvariants with new data
//   for (int i = 0; i < _groupNames.length; i++) {
//     widget.returnedupdatedaddons.add({
//       'variantGroupName': _groupNames[i],
//       'variantType': _groupVariants[i],
//     });
//   }

//   // 🔍 Debug print to confirm
//   print("Updated AddOns After Deletion: ${widget.returnedupdatedaddons}");
// }
void _deleteGroup(int index) {
  setState(() {
    _groupNames.removeAt(index);
    _groupVariants.removeAt(index);
    _isAddonsExpandedList.removeAt(index);
  });

  // Clear updatedvariants as well if no groups remain
  if (_groupNames.isEmpty || _groupVariants.isEmpty) {
    updatedAddOns.clear(); // ✅ clear it
    variantsCon.addongroupNames.clear(); // (optional GetX controller clear)
    variantsCon.addOns.clear();

    // Now navigate with truly empty values
   Future.delayed(Duration(milliseconds: 100), () {
 if (widget.isEdit == true){  Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => EditItemScreen(
            updatedAddOns: const [],
            variants: widget.variants,
            foodCat: widget.foodCat,
            isFromVariantscreen: true,
            updatedvariants: widget.returnedupdatedvariants,
            foodCateId: widget.foodCatid,
            foodsListIndex: widget.foodsListIndex,
            variantGroupName:widget.variantGroupName,
            groupNames: const [],
          ),
        ),
      );
      }else{  Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => AddItemScreen(
            updatedAddOns: const [],
            variants: widget.variants,
            FoodCat: widget.foodCat,
            isFromVariantscreen: true,
            updatedvariants:widget.returnedupdatedvariants,
            FoodCatid: widget.foodCatid,
            foodsListIndex: widget.foodsListIndex,
            groupNames: const [],
          ),
        ),
      );}
    });
  } else {
    _updateVariants(); // ✅ update normally
  }

  print("Deleted Group Index: $index");
  print("Updated Group Names: $_groupNames");
  print("Updated Group Variants: $_groupVariants");
  print("Updated Final Variants: $updatedAddOns");
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: addonkey,
          // autovalidateMode: AutovalidateMode.onUserInteraction,
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: 'Create Add-On Groups',
                  style: CustomTextStyle.addOnsBlackText,
                ),
                const SizedBox(height: 20),
                CustomContainer(
                  borderRadius: BorderRadius.circular(15),
                  width: MediaQuery.of(context).size.width / 1.15,
                  child: CustomPriceTextFormField(
                    controller: _groupName,
                    label: CustomText(
                      text: 'Enter add on group name',
                      style: CustomTextStyle.greyTextFormFieldText,
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                ...List.generate(_addOnNameControllers.length, (index) {return _buildVariantRow(index);}),
                const SizedBox(height: 15),
                GestureDetector(
                  onTap: () {
                    _addVariant();
                  },
                  child: Row(
                    children: [
                      const SizedBox(width: 15),
                      SizedBox(
                        height: 25,
                        width: 25,
                        child: Image.asset('assets/images/add.png'),
                      ),
                      GradientText(
                        text: 'Add Option',
                        style: CustomTextStyle.smallOrangeText,
                        gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Color(0xFFF98322), // Color code for #F98322
                            Color(0xFFEE4C46), // End color
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                CustomButton(
                  borderRadius: BorderRadius.circular(20),
                  width: MediaQuery.of(context).size.width / 3,
                  onPressed: _handleCreateOrUpdate,
                  child: CustomText(
                    text: _editingGroupIndex == null ? 'Create' : 'Update',
                    style: CustomTextStyle.smallWhiteText,
                  ),
                ),
                const SizedBox(height: 35),
                _isCreated
                    ? Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ...List.generate(_groupNames.length, (groupIndex) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isAddonsExpandedList[groupIndex] =!_isAddonsExpandedList[groupIndex];
                                    });
                                  },
                                  child: Row(
                                    mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                    children: [
                                      CustomText(
                                        text: _groupNames[groupIndex],
                                        style: CustomTextStyle.addonText,
                                      ),
                                      SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: Icon(
                                          _isAddonsExpandedList[groupIndex]
                                              ? MdiIcons.chevronUp
                                              : MdiIcons.chevronDown,
                                          color: Colors.grey.shade600,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(height: 20),
                                if (_isAddonsExpandedList[groupIndex])
                                  Column(crossAxisAlignment:CrossAxisAlignment.start,
                                      children: [
                                        ListView.builder(
                                          shrinkWrap: true,
                                          physics:NeverScrollableScrollPhysics(),
                                          itemCount:_groupVariants[groupIndex].length,
                                          itemBuilder: (context, index) {
                                            dynamic variant =_groupVariants[groupIndex];
                                            return Column(
                                              children: [
                                                Row(
                                                  mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                  children: [
                                                    Row(
                                                      children: [
                                                        SizedBox(
                                                          height: 20,
                                                          width: 20,
                                                          child: Image.asset(
                                                            variant[index]['type'] =='veg'
                                                                ? 'assets/images/veg.png'
                                                                : variant[index]['type'] =='egg'
                                                                    ? 'assets/images/egg.jpg'
                                                                    : 'assets/images/nonveg.png',
                                                          ),
                                                        ),
                                                        const SizedBox(width: 10),
                                                        SizedBox(
                                                        width: MediaQuery.of(context).size.width/2,
                                                          child: CustomText(
                                                            text: variant[index]['name']!,
                                                            style: CustomTextStyle.categoryBlackText,
                                                            overflow: TextOverflow.clip,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                    CustomText(
                                                      text: variant[index]['price']!,
                                                      style: CustomTextStyle
                                                          .categoryBlackText,
                                                    ),
                                                  ],
                                                ),
                                                const SizedBox(height: 15),
                                              ],
                                            );
                                          },
                                        )
                                      ]),
                                const SizedBox(height: 15),
                                Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        //  _deleteGroup(groupIndex); // Trigger delete mode
                                        showDialog(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return DeleteConfirmationDialog(
                                              onConfirm: () {
                                                _deleteGroup(groupIndex);
                                              },
                                            );
                                          },
                                        );
                                      },
                                      child: SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: Image.asset(
                                          'assets/images/orangetrash.png',
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 15),
                                    GestureDetector(
                                      onTap: () {
                                        _handleEdit(groupIndex); // Trigger edit mode
                                      },
                                      child: SizedBox(
                                        height: 25,
                                        width: 25,
                                        child: Image.asset(
                                          'assets/images/edit.png',
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 20),
                              ],
                            );
                          }),
                           // ✅ Conditionally show the "Done" button
                      if (_groupNames.isNotEmpty && _groupVariants.isNotEmpty)
                          Column(mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment:CrossAxisAlignment.start,
                            children: [
                              CustomButton(
                                borderRadius: BorderRadius.circular(20),
                                width: MediaQuery.of(context).size.width / 3.5,
                                onPressed: () {
                                  variantsCon.initializeAddOns(updatedAddOns);
                                  _updateVariants(); // Make sure the latest variant list is used
                                  if (_groupNames.isEmpty ||
                                      _groupVariants.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          "Please create at least one AddOngroup before proceeding",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        backgroundColor:Customcolors.decorationErrorRed,
                                      ),
                                    );
                                  } else if (widget.isEdit == true) {
                                    print(  "  updatedAddOns in navigate:${updatedAddOns}");
                                    Navigator.push(
                                        context,MaterialPageRoute(
                                            builder: (context) => EditItemScreen(
                                            updatedvariants: widget.returnedupdatedvariants,
                                                  foodCat: widget.foodCat,
                                                  foodCateId: widget.foodCatid,
                                                  foodsListIndex:widget.foodsListIndex,
                                                  variantGroupName:widget.variantGroupName,
                                                  variants: widget.variants,
                                                  isFromAddonscreen: true,
                                                  updatedAddOns: updatedAddOns,
                                                    groupNames: _groupNames.where((e) =>e !=null).map((e) => e.toString()) .toList(),)));
                                  } else {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => AddItemScreen(
                                            updatedvariants: widget.returnedupdatedvariants,
                                                  variants: widget.variants,
                                                  FoodCat: widget.foodCat,
                                                  isFromAddonscreen: true,
                                                  updatedAddOns: updatedAddOns,
                                                  FoodCatid: widget.foodCatid,
                                                  foodsListIndex:widget.foodsListIndex,
                                                  variantGroupName:widget.variantGroupName,
                                                  groupNames: _groupNames.where((e) =>e !=null).map((e) => e.toString()) .toList(),
                                                )));}},
                                child: Text(
                                  "Done",
                                  style: CustomTextStyle.smallWhiteText,
                                ),
                              ),
                                      SizedBox(height: 10,),
             const Text(
      'Note: Click "Done" after adding all the Add-Ons.',
      style: TextStyle(
        color: Colors.red,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    ), 
                            ],
                          ),
                   ],): SizedBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildVariantRow(int index) {
    return Row(
      key: ValueKey(index),
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: CustomPriceTextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: validationNoempty,
            controller: _addOnNameControllers[index],
            label: CustomText(
              text: 'Add-On Name',
              style: CustomTextStyle.greyTextFormFieldText,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4.0, right: 4),
          child: CustomContainer(
            width: MediaQuery.of(context).size.width / 4.h,
            child: CustomPriceTextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: validationNoaddonpriceEmpty,
              keyboardType: TextInputType.number,
              controller: _priceControllers[index],
              label: CustomText(
                text: 'Price',
                style: CustomTextStyle.greyTextFormFieldText,
              ),
            ),
          ),
        ),
        Builder(
          builder: (iconContext) {
            return CustomContainer(
              width: MediaQuery.of(context).size.width / 2.8.h,
              child: CustomTypeTextFormField(
              readOnly: true,
                controller: _typeControllers[index],
                onTap: () => _showTypeSelectionDialog(
                    iconContext, _typeControllers[index]),
                suffixIcon:
                    Icon(MdiIcons.chevronDown, color: Colors.grey.shade600),
                label: CustomText(
                  text: 'Type',
                  style: CustomTextStyle.greyTextFormFieldText,
                ),
              ),
            );
          },
        ),
        GestureDetector(
          onTap: () {
            setState(() {
              _addOnNameControllers.removeAt(index);
              _priceControllers.removeAt(index);
              _typeControllers.removeAt(index);
            });
          },
          child: SizedBox(
            height: 25,
            width: 25,
            child: Image.asset(
              'assets/images/orangetrash.png',
            ),
          ),
        )
      ],
    );
  }
}
