// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:io';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/Controllers/CategoryController/categorycreate.dart';
import 'package:miogra_seller/Controllers/CategoryController/hashtagcategory.dart';
import 'package:miogra_seller/Controllers/CategoryController/productcateget.dart';
import 'package:miogra_seller/Controllers/FileuploadController/FileUploader.dart';
import 'package:miogra_seller/Controllers/service_controller/app_config.dart';
import 'package:miogra_seller/Screens/Home/bottomnavigation.dart';
import 'package:miogra_seller/Screens/Menu/categoryscreen.dart';
import 'package:miogra_seller/UrlList/api.dart';
import 'package:miogra_seller/Widgets/container_decoration.dart';
import 'package:miogra_seller/Widgets/custom_button.dart';
import 'package:miogra_seller/Widgets/custom_colors.dart';
import 'package:miogra_seller/Widgets/custom_container.dart';
import 'package:miogra_seller/Widgets/custom_gradienttext.dart';
import 'package:miogra_seller/Widgets/custom_snackbar.dart';
import 'package:miogra_seller/Widgets/custom_text.dart';
import 'package:miogra_seller/Widgets/custom_textformfield.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:provider/provider.dart';

class MenuScreen extends StatefulWidget {
  final bool? itemsAdded;

  const MenuScreen({super.key, this.itemsAdded});

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  final ProductCategoryController productCategoryController =Get.put(ProductCategoryController());
  String errorMessage = '';
   final TextEditingController _searchController = TextEditingController();
  final CategoryController categoryController = Get.put(CategoryController());
  bool isLoading = true;
  String searchTerm = '';
  String imageUrl = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        i = 0;
      });

      Provider.of<MenuPagenations>(context, listen: false)
          .clearData()
          .then((value) {
        Provider.of<MenuPagenations>(context, listen: false)
            .fetchMenuData(search: searchTerm);
      });
    });

    // Add listener to handle pagination requests

    if (widget.itemsAdded != null && widget.itemsAdded == true) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showNotification("Item added successfully!");
      });
    }
  }

  final HashTagCategoryController hashTagCategoryController =Get.put(HashTagCategoryController());
  final ImageUploader imageUploader = Get.put(ImageUploader());

  // Future<void> _pickImage(BuildContext context, StateSetter setState) async {
  //   final pickedFile =
  //       await ImagePicker().pickImage(source: ImageSource.gallery);
  //   if (pickedFile != null) {
  //     _pickedImage = File(pickedFile.path);
  //     await imageUploader.uploadImage(file: _pickedImage!);
  //     setState(() {
  //       errorMessage = '';
  //     }); // Update the state to reflect the picked image
  //   }
  // }
  Future<void> _pickImage(BuildContext context, StateSetter setState) async {
  final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

  if (pickedFile != null) {
    final fileExtension = pickedFile.path.split('.').last.toLowerCase();

    if (fileExtension == 'jpg' || fileExtension == 'jpeg' || fileExtension == 'png') {
      _pickedImage = File(pickedFile.path);

      await imageUploader.uploadImage(file: _pickedImage!);

      setState(() {
        errorMessage = '';
      });
    } else {
      setState(() {
        _pickedImage = null;
        errorMessage = 'Only JPG and PNG images are allowed.';
      });
    }
  }
}

  //final TextEditingController _searchController = TextEditingController();
  final TextEditingController _categoryNameCont = TextEditingController();
  File? _pickedImage; // State variable to hold the picked image
  //final ImagePicker _picker = ImagePicker();

  final List<String> categories = [
    'Recommended',
    'Biryani',
    'Chicken',
    'Mutton',
    'Ice Cream',
    'Juices'
  ];

  void _showNotification(String message) {
    final overlay = Overlay.of(context);
    final overlayEntry = OverlayEntry(
      builder: (context) => CustomSnackBar(message: message),
    );

    overlay.insert(overlayEntry);

    Future.delayed(const Duration(seconds: 2), () {
      overlayEntry.remove();
    });
  }



  @override
  Widget build(BuildContext context) {
    var categoryProvider = Provider.of<MenuPagenations>(context);

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) =>
                const RestaurentBottomNavigation(initialIndex: 0),
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
                  builder: (context) =>
                      const RestaurentBottomNavigation(initialIndex: 0),
                ),
              );
            },
          ),
          title: CustomText(
            text: 'Menu',
            style: CustomTextStyle.mediumGreyText,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   // height: MediaQuery.of(context).size.height / 10.h,
              //   decoration: BoxDecorationsFun.searchDecoraton(),
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 8),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         SizedBox(
              //           height: 25,
              //           width: 25,
              //           child: Image.asset('assets/images/searchbar.png'),
              //         ),
              //         SizedBox(
              //           width: MediaQuery.of(context).size.width / 2,
              //           child: TextFormField(
              //             onChanged: (value) {
              //               setState(() {
              //                 searchTerm = value.trim();
              //                 context.read<MenuPagenations>().clearData().whenComplete(() => context.read<MenuPagenations>().fetchMenuData(search: searchTerm,),
              //                     );
              //               });
              //             },
              //             decoration: InputDecoration(
              //               hintText: 'Search for Menu',
              //               hintStyle: CustomTextStyle.searchGreyText,
              //               labelStyle: CustomTextStyle.searchGreyText,
              //               border: InputBorder.none,
              //               floatingLabelBehavior: FloatingLabelBehavior.never,
              //             ),
              //           ),
              //         ),
              //         const SizedBox(width: 20),
              //         SizedBox(
              //           height: 40,
              //           width: 40,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
//               Container(
//   decoration: BoxDecorationsFun.searchDecoraton(),
//   child: Padding(
//     padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
//     child: Stack(
//       alignment: Alignment.centerRight,
//       children: [
//         Row(
//           children: [
//             SizedBox(
//               height: 25,
//               width: 25,
//               child: Image.asset('assets/images/searchbar.png'),
//             ),
//             const SizedBox(width: 10),
//             Expanded(
//               child: TextFormField(
//                 controller: _searchController,
//                 onChanged: (value) {
//                   setState(() {
//                     searchTerm = value.trim();
//                     context.read<MenuPagenations>().clearData().whenComplete(() {
//                       context.read<MenuPagenations>().fetchMenuData(search: searchTerm);
//                     });
//                   });
//                 },
//                 decoration: InputDecoration(
//                   hintText: 'Search for Menu',
//                   hintStyle: CustomTextStyle.searchGreyText,
//                   border: InputBorder.none,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         if (_searchController.text.isNotEmpty)
//           Positioned(
//             right: 0,
//             child: IconButton(
//               icon: const Icon(Icons.close, size: 20, color: Colors.grey),
//               onPressed: () {
//                 _searchController.clear();
//                 FocusScope.of(context).unfocus();
//                 setState(() {
//                   searchTerm = '';
//                 });
//                 context.read<MenuPagenations>().clearData().whenComplete(() {
//                   context.read<MenuPagenations>().fetchMenuData(search: '');
//                 });
//               },
//             ),
//           ),
//       ],
//     ),
//   ),
// ),
Container(
  decoration: BoxDecorationsFun.searchDecoraton(),
  child: Padding(
    padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
    child: Stack(
      alignment: Alignment.centerRight,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.center, // Ensures vertical centering
          children: [
            SizedBox(
              height: 20,
              width: 20,
              child: Image.asset('assets/images/searchbar.png'),
            ),
            const SizedBox(width: 30),
            Expanded(
              child: TextFormField(
                controller: _searchController,
                style: const TextStyle(fontSize: 14),
                textAlignVertical: TextAlignVertical.center, // Align text vertically
                onChanged: (value) {
                  setState(() {
                    searchTerm = value.trim();
                    context.read<MenuPagenations>().clearData().whenComplete(() {
                      context.read<MenuPagenations>().fetchMenuData(search: searchTerm);
                    });
                  });
                },
                decoration: InputDecoration(
                  isDense: true, // Compact layout
                  contentPadding: const EdgeInsets.symmetric(vertical: 10), // Ensures center alignment
                  hintText: 'Search for Menu',
                  hintStyle: CustomTextStyle.searchGreyText,
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
        if (_searchController.text.isNotEmpty)
          Positioned(
            right: 0,
            child: IconButton(
              icon: const Icon(Icons.close, size: 18, color: Colors.grey),
              onPressed: () {
                _searchController.clear();
                FocusScope.of(context).unfocus();
                setState(() {
                  searchTerm = '';
                });
                context.read<MenuPagenations>().clearData().whenComplete(() {
                  context.read<MenuPagenations>().fetchMenuData(search: '');
                });
              },
            ),
          ),
      ],
    ),
  ),
),


              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 10.0),
                child: CustomText(
                  text: 'Category List',
                  style: CustomTextStyle.categoryBlackText,
                ),
              ),
              const SizedBox(height: 20),
              //     Padding(
              //   padding: const EdgeInsets.only(left: 10.0),
              //   child: InkWell(
              //     onTap: () {
              //       categorymethod(context);
              //     },
              //     child: Row(
              //       children: [
              //         SizedBox(
              //           height: 25,
              //           width: 25,
              //           child: Image.asset('assets/images/add.png'),
              //         ),
              //         GradientText(
              //           text: 'Add Category',
              //           style: CustomTextStyle.smallOrangeText,
              //           gradient: const LinearGradient(
              //             begin: Alignment.topCenter,
              //             end: Alignment.bottomCenter,
              //             colors: [
              //               Color(0xFFF98322),
              //               Color(0xFFEE4C46),
              //             ],
              //           ),
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              Padding(
  padding: const EdgeInsets.symmetric(horizontal: 8),
  child: InkWell(
    onTap: () => categorymethod(context),
    borderRadius: BorderRadius.circular(8),
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
      decoration: BoxDecoration(
        color: const Color(0xFFFFE5D0), // Light orange background
        border: Border.all(color: 
  
 Color(0xFF623089)
), // Orange border
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/add.png',
            height: 20,
            width: 20,
            color:  Color(0xFF623089),
          ),
          const SizedBox(width: 6),
          Text(
            'Add Category',
            style: CustomTextStyle.mediumOrangeText,
          ),
        ],
      ),
    ),
  ),
),
SizedBox(height: 10,),

              Expanded(
                child: NotificationListener<ScrollNotification>(
                  onNotification: (ScrollNotification notification) {
                    if (notification is ScrollEndNotification) {
                      if (categoryProvider.totalCount != null &&categoryProvider.fetchCount != null &&categoryProvider.fetchedDatas.length !=categoryProvider.totalCount) {
                        setState(() {
                          i = i + 1;
                        });

                        Provider.of<MenuPagenations>(context, listen: false).fetchMenuData(search: searchTerm, offset: i);
                      }
                    }
                    return true;
                  },
                  child: Consumer<MenuPagenations>(
                    builder: (context, value, child) {
                      if (value.isLoading) {
                        return const Center(child: CupertinoActivityIndicator());
                      } else if (value.fetchedDatas.isEmpty) {
                        return dataEmptyDesign();
                      } else {
                        return ListView.builder(
                          itemCount: value.moreDataLoading
                              ? value.fetchedDatas.length + 1
                              : value.fetchedDatas.length,
                          itemBuilder: (context, index) {
                            if (index >= value.fetchedDatas.length) {
                              return const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(16.0),
                                  child: CupertinoActivityIndicator(),
                                ),
                              );
                            }

                            final foodCatName =value.fetchedDatas[index]['foodCateName'] ?? '';
                            final foodImage = value.fetchedDatas[index]['foodCateImage'] ??'';
                            final id = value.fetchedDatas[index]['_id'] ?? '';

                            return Padding(
                              padding: const EdgeInsets.only(left: 10.0, right: 10.0, top: 10),
                              child: Column(
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => CategoryScreen(
                                            foodCatId: '$id',
                                            foodCategory: '$foodCatName',
                                          ),
                                        ),
                                      );
                                    },
                                    child: CustomContainer(
                                      height:MediaQuery.of(context).size.height /14,
                                      child: Padding(
                                        padding: const EdgeInsets.all(3.0),
                                        child: Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          children: [
                                            Row(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:BorderRadius.circular(10),
                                                    image: DecorationImage(
                                                      image: foodImage.isNotEmpty
                                                          ? NetworkImage('$baseImageUrl${foodImage.startsWith('/') ? foodImage.substring(1) : foodImage}')
                                                          : const AssetImage('assets/images/nonveg.png')as ImageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  height: 50,
                                                  width: 50,
                                                ),
                                                const SizedBox(width: 10),
                                                SizedBox(
                                                  width: MediaQuery.of(context).size.width /2,
                                                  child: CustomText(
                                                    text: foodCatName,
                                                    maxLines: 2,
                                                    overflow:TextOverflow.ellipsis,
                                                    style: CustomTextStyle.categoryBlackText,
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Row(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    categorymethod(context,fetchedDatas:value.fetchedDatas[index]);
                                                  },
                                                  child: SizedBox(
                                                    height: 30,
                                                    width: 22,
                                                    child: Image.asset('assets/images/edit.png'),
                                                  ),
                                                ),
                                                const SizedBox(width: 15),
                                                SizedBox(
                                                  height: 20,
                                                  width: 20,
                                                  child: Icon(
                                                    MdiIcons.chevronRight,
                                                    color: Colors.grey.shade600,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 10),
                                  DottedLine(dashColor: Colors.grey.shade400),
                                ],
                              ),
                            );
                          },
                        );
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  bool isMatchedCategory = false;

Future<dynamic> categorymethod(BuildContext context, {dynamic fetchedDatas}) {
  return showDialog(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext context) {
      final formKey = GlobalKey<FormState>();
      bool isEditMode = fetchedDatas != null;

      if (isEditMode) {
        _categoryNameCont.text = fetchedDatas?['foodCateName'] ?? '';
        if (fetchedDatas?['foodCateImage'] != null &&
            fetchedDatas?['foodCateImage'].isNotEmpty) {
          imageUrl = fetchedDatas?['foodCateImage'] ?? '';
        }
      }

      return Theme(
        data: ThemeData(
       //   dialogTheme: DialogTheme(backgroundColor: Customcolors.decorationWhite),
        ),
        child: StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            bool isFormValid = (_pickedImage != null || imageUrl.isNotEmpty) &&
                _categoryNameCont.text.trim().isNotEmpty;

            void validateForm() {
              isFormValid = (_pickedImage != null || imageUrl.isNotEmpty) &&
                  _categoryNameCont.text.trim().isNotEmpty;
              setState(() {});
            }

            return Dialog(
              surfaceTintColor: Customcolors.decorationWhite,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Form(
                    key: formKey,
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 15.0, left: 15, right: 15),
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                IconButton(
                                  onPressed: () {
                                    _categoryNameCont.clear();
                                    _pickedImage = null;
                                    imageUrl = "";
                                    errorMessage = '';
                                    hashTagCategoryController.restProfile.clear();
                                    Navigator.of(context).pop();
                                  },
                                  icon: SizedBox(
                                    height: 40,
                                    width: 30,
                                    child: Icon(Icons.close),
                                  ),
                                ),
                              ],
                            ),
                            Center(
                              child: Text(
                                isEditMode ? "Update custom category" : "Create custom category?",
                                style: CustomTextStyle.settleText,
                              ),
                            ),
                            const SizedBox(height: 5),
                            Text(
                              isEditMode
                                  ? "Update Your Category Details by Uploading a New Image and Modifying the Category Name!"
                                  : "Ready to Create a Custom Category? Upload the Image and Add Category Name to begin!",
                              style: CustomTextStyle.timeText,
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 10),
                            Row(
                              children: [
                                CustomText(
                                  text: 'Category Image',
                                  style: CustomTextStyle.medDarkGreyText,
                                ),
                                const SizedBox(width: 5),
                                CustomText(
                                  text: '*',
                                  style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 17,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            GestureDetector(
                              onTap: () async {
                                final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);

                                if (pickedFile != null) {
                                  final fileExtension = pickedFile.path.split('.').last.toLowerCase();

                                  if (fileExtension == 'jpg' || fileExtension == 'jpeg' || fileExtension == 'png') {
                                    _pickedImage = File(pickedFile.path);
                                    await imageUploader.uploadImage(file: _pickedImage!);
                                    errorMessage = '';
                                  } else {
                                    _pickedImage = null;
                                    errorMessage = 'Only JPG and PNG images are allowed.';
                                  }
                                }

                                validateForm();
                              },
                              child: SizedBox(
                                height: MediaQuery.of(context).size.height / 17,
                                width: MediaQuery.of(context).size.width / 6,
                                child: _pickedImage != null
                                    ? ClipRRect(
                                        borderRadius: BorderRadius.circular(5),
                                        child: Image.file(
                                          _pickedImage!,
                                          fit: BoxFit.cover,
                                        ),
                                      )
                                    : imageUrl.isNotEmpty
                                        ? ClipRRect(
                                            borderRadius: BorderRadius.circular(5),
                                            child: Image.network(
                                              '$baseImageUrl${imageUrl.startsWith('/') ? imageUrl.substring(1) : imageUrl}',
                                              fit: BoxFit.cover,
                                            ),
                                          )
                                        : DottedBorder(
                                            color: Colors.grey,
                                            strokeWidth: 2,
                                            borderType: BorderType.RRect,
                                            radius: const Radius.circular(5),
                                            dashPattern: const [6, 3],
                                            child: Padding(
                                              padding: const EdgeInsets.all(10.0),
                                              child: Center(
                                                child: SizedBox(
                                                  height: 40,
                                                  width: 40,
                                                  child: Image.asset('assets/images/upload.png'),
                                                ),
                                              ),
                                            ),
                                          ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            if (errorMessage.isNotEmpty)
                              Text(
                                errorMessage,
                                style: const TextStyle(
                                  color: Color.fromARGB(255, 203, 22, 9),
                                  fontSize: 10,
                                ),
                              ),
                            const SizedBox(height: 8),
                            CreateCategoryTextFormField(
                              autovalidateMode: AutovalidateMode.onUserInteraction,
                              style: const TextStyle(color: Colors.black),
                              controller: _categoryNameCont,
                              onChanged: (value) {
                                validateForm();
                                if (value.trim().isEmpty) {
                                  hashTagCategoryController.restProfile.clear();
                                  hashTagCategoryController.searchTerm.value = '';
                                } else {
                                  hashTagCategoryController.getHashtagCat(value);
                                  hashTagCategoryController.searchTerm.value = value;
                                }
                              },
                              onfieldsubmitted: (value) {
                                final typed = value.trim();
                                _categoryNameCont.text = typed;
                               hashTagCategoryController.restProfile.clear();
                               validateForm();
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Category name cannot be empty';
                                }
                                return null;
                              },
                              label: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text: 'Category Name',
                                      style: CustomTextStyle.greyTextFormFieldText,
                                    ),
                                    const TextSpan(
                                      text: ' ⁕',
                                      style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 17,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            const SizedBox(height: 15),
                            // Obx(() {
                            //   if (hashTagCategoryController.restProfile.isNotEmpty) {
                            //     return SizedBox(
                            //       height: hashTagCategoryController.restProfile.length * 50,
                            //       child: ListView.builder(
                            //         shrinkWrap: true,
                            //         physics: const NeverScrollableScrollPhysics(),
                            //         itemCount: hashTagCategoryController.restProfile.length,
                            //         itemBuilder: (context, index) {
                            //           final hashtag = hashTagCategoryController.restProfile[index];
                            //           return ListTile(
                            //             title: Text(hashtag['hashtagName'] ?? 'No Categories Found'),
                            //             onTap: () {
                            //               _categoryNameCont.text = hashtag['hashtagName'] ?? '';
                            //               hashTagCategoryController.restProfile.clear();
                            //               validateForm();
                            //             },
                            //           );
                            //         },
                            //       ),
                            //     );
                            //   } else {
                            //     return const SizedBox.shrink();
                            //   }
                            // }),
                            Obx(() {
  if (hashTagCategoryController.restProfile.isNotEmpty) {
    final typed = _categoryNameCont.text.trim().toLowerCase();

    return SizedBox(
      height: hashTagCategoryController.restProfile.length * 50,
      child: ListView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        itemCount: hashTagCategoryController.restProfile.length,
        itemBuilder: (context, index) {
          final hashtag = hashTagCategoryController.restProfile[index];
          final name = (hashtag['hashtagName'] ?? '').toString();
          final isMatched = name.toLowerCase() == typed;

          return ListTile(
            title: Row(
              children: [
                Expanded(child: Text(name.isNotEmpty ? name : 'No Categories Found')),
                if (isMatched)
                  const Padding(
                    padding: EdgeInsets.only(left: 8.0),
                    child: Icon(Icons.check_circle, color: Colors.green),
                  ),
              ],
            ),
            onTap: () {
              _categoryNameCont.text = name;
              hashTagCategoryController.restProfile.clear();
              validateForm();
            },
          );
        },
      ),
    );
  } else {
    return const SizedBox.shrink();
  }
})
,
                            const SizedBox(height: 15),
                            Center(
                              child: Opacity(
                                opacity: isFormValid ? 1.0 : 0.5,
                                child: CategorycustomButton(
                                  borderRadius: BorderRadius.circular(20),
                                  height: MediaQuery.of(context).size.height / 23,
                                  width: MediaQuery.of(context).size.width / 3,
                                  onPressed: isFormValid
                                      ? () {
                                          final finalImageUrl = imageUploader.imageURL.value.isNotEmpty
                                              ? imageUploader.imageURL.value
                                              : imageUrl;

                                          if (finalImageUrl.isEmpty) {
                                            errorMessage = 'Image upload failed. Please upload a valid JPG or PNG image.';
                                            validateForm();
                                            return;
                                          }

                                          if (isEditMode) {
                                            categoryController.categoryUpdate(
                                              productTypeToFilter: catres,
                                              thumbUrl: finalImageUrl,
                                              mediumUrl: finalImageUrl,
                                              foodCategoryName: _categoryNameCont.text,
                                              foodCategoryImage: finalImageUrl,
                                              foodcateid: fetchedDatas["_id"],
                                              restaurantId: fetchedDatas["restaurantId"],
                                            );
                                          } else {
                                            hashTagCategoryController.hashCreate(
                                            isfromaddingredients: false,
                                              hashtagName: _categoryNameCont.text,
                                              hastagtype: "category"
                                            );

                                            print("BBBUUUTTT");

                                            print("BBBUUUTTT  $catres");
                                            categoryController.categoryCreate(
                                                productTypeToFilter: catres,
                                              thumbUrl: finalImageUrl,
                                              mediumUrl: finalImageUrl,
                                              foodCategoryName: _categoryNameCont.text,
                                              foodCategoryImage: finalImageUrl,
                                              productCateId: prodCatId,
                                            );
                                          }

                                          _categoryNameCont.clear();
                                          _pickedImage = null;
                                          imageUrl = "";
                                          imageUploader.imageURL.value = '';
                                          errorMessage = '';
                                          Navigator.pop(context);
                                        }
                                      : null,
                                  enabled: isFormValid,
                                  child: CustomText(
                                    text: isEditMode ? "Update" : 'Create',
                                    style: CustomTextStyle.mediumWhiteText,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      );
    },
  );
}

//   Future<dynamic> categorymethod(BuildContext context, {dynamic fetchedDatas}) {
//     return showDialog(
//       context: context,
//       barrierDismissible: false, // Allows tapping outside to close
//       builder: (BuildContext context) {
//         final formKey = GlobalKey<FormState>();
//         bool isEditMode = fetchedDatas != null; // Check if updating or creating

//         if (isEditMode) {
//           _categoryNameCont.text = fetchedDatas?['foodCateName'] ?? '';

//           // Check if image exists
//           if ("fetchedDatas?['foodCateImage']" != null &&
//               fetchedDatas?['foodCateImage'].isNotEmpty) {
//             imageUrl =fetchedDatas?['foodCateImage'] ?? ''; // Store the image URL
//           }
//         }

//         return Theme(
//           data: ThemeData(dialogTheme:DialogTheme(backgroundColor: Customcolors.decorationWhite),),
//           child: StatefulBuilder(
//             builder: (BuildContext context, StateSetter setState) {
//               return Dialog(
//                 surfaceTintColor: Customcolors.decorationWhite,
//                 child: Stack(
//                   clipBehavior: Clip.none, // Prevent clipping of the close icon
//                   children: [
//                     Form(
//                       key: formKey,
//                       child: Padding(
//                         padding: const EdgeInsets.only(bottom: 15.0, left: 15, right: 15),
//                         child: SingleChildScrollView(
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment: MainAxisAlignment.end,
//                                 children: [
//                                   IconButton(
//                                     onPressed: () {
//                                       _categoryNameCont.clear();
//                                       _pickedImage = null;
//                                       imageUrl = "";
//                                       hashTagCategoryController.restProfile.clear();
//                                       print('CLICKED');
//                                       // Reset error message
//                                       errorMessage = '';
//                                       Navigator.of(context).pop(); // Close the dialog
//                                     },
//                                     icon: SizedBox(
//                                       height: 40,
//                                       width: 30,
//                                       child: Icon(Icons.close),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               Center(
//                                 child: Text(
//                                   isEditMode? "Update custom category": "Create custom category?",
//                                   style: CustomTextStyle.settleText,
//                                 ),
//                               ),
//                               const SizedBox(height: 5),
//                               Text(
//                                 isEditMode
//                                     ? "Update Your Category Details by Uploading a New Image and Modifying the Category Name!"
//                                     : "Ready to Create a Custom Category? Upload the Image and Add Category Name to begin!",
//                                 style: CustomTextStyle.timeText,
//                                 textAlign: TextAlign.center,
//                               ),
//                               const SizedBox(height: 10),
//                               Row(
//                                 children: [
//                                   CustomText(
//                                     text: 'Category Image',
//                                     style: CustomTextStyle.medDarkGreyText,
//                                   ),
//                                   const SizedBox(width: 5),
//                                   CustomText(
//                                     text: '*',
//                                     style: const TextStyle(
//                                       color: Colors.red,
//                                       fontSize: 17,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               const SizedBox(height: 10),
//                               GestureDetector(
//                                 onTap: () => _pickImage(context, setState),
//                                 child: SizedBox(
//                                   height:MediaQuery.of(context).size.height / 17,
//                                   width: MediaQuery.of(context).size.width / 6,
//                                   child: _pickedImage != null
//                                       ? ClipRRect(
//                                           borderRadius:BorderRadius.circular(5),
//                                           child: Image.file(
//                                             _pickedImage!,
//                                             fit: BoxFit.cover,
//                                           ),
//                                         )
//                                       : imageUrl.isNotEmpty
//                                           ? ClipRRect(
//                                               borderRadius:BorderRadius.circular(5),
//                                               child: Image.network('$baseImageUrl${imageUrl.startsWith('/') ? imageUrl.substring(1) : imageUrl}',
//                                               fit: BoxFit.cover,
//                                               ),
//                                             )
//                                           : DottedBorder(
//                                               color: Colors.grey,
//                                               strokeWidth: 2,
//                                               borderType: BorderType.RRect,
//                                               radius: const Radius.circular(5),
//                                               dashPattern: const [6, 3],
//                                               child: Padding(
//                                                 padding:const EdgeInsets.all(10.0),
//                                                 child: Center(
//                                                   child: SizedBox(
//                                                     height: 40,
//                                                     width: 40,
//                                                     child: Image.asset('assets/images/upload.png'),
//                                                   ),
//                                                 ),
//                                               ),
//                                             ),
//                                 ),
//                               ),
//                               const SizedBox(height: 8),
//                               if (errorMessage.isNotEmpty)
//                                 Text(
//                                   errorMessage,
//                                   style: const TextStyle(
//                                     color: Color.fromARGB(255, 203, 22, 9),
//                                     fontSize: 10,
//                                   ),
//                                 ),
//                               const SizedBox(height: 8),
//                               Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   CustomPriceTextFormField(
//                                     autovalidateMode:AutovalidateMode.onUserInteraction,
//                                     style: const TextStyle(color: Colors.black),
//                                     controller: _categoryNameCont,
//                                     onChanged: (value) {
//                                       print("TextFormField value: $value");
//                                       if (value.trim().isEmpty) {
//                                         hashTagCategoryController.restProfile.clear();
//                                         hashTagCategoryController.searchTerm.value = '';
//                                         print("Cleared restProfile");
//                                       } else {
//                                         hashTagCategoryController.getHashtagCat(value);
//                                         hashTagCategoryController.searchTerm.value = value;
//                                       }
//                                     },
//                                     validator: (value) {
//                                       if (value == null || value.isEmpty) {
//                                         return 'Category name cannot be empty';
//                                       } 
//                                       // else if (value.length < 3) {
//                                       //   return 'Category name must be at least 3 characters long';
//                                       // } 
//                                       // else if (value.length > 20) {
//                                       //   return 'Category name cannot be more than 20 characters long';
//                                       // }
//                                       return null;
//                                     },
//                                     label: RichText(
//                                       text: TextSpan(
//                                         children: [
//                                           TextSpan(
//                                             text: 'Category Name',
//                                             style: CustomTextStyle.greyTextFormFieldText,
//                                           ),
//                                           const TextSpan(
//                                             text: ' ⁕',
//                                             style: TextStyle(
//                                               color: Colors.red,
//                                               fontSize: 17,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                                     ),
//                                   ),
//                                   const SizedBox(height: 15),
//                                 ],
//                               ),
//                               const SizedBox(height: 15),
//                               Obx(() {
//                                 if (hashTagCategoryController.restProfile.isNotEmpty) {
//                                   return SizedBox(
//                                     height: hashTagCategoryController.restProfile.length *50,
//                                     child: ListView.builder(
//                                       shrinkWrap: true,
//                                       physics:const NeverScrollableScrollPhysics(),
//                                       itemCount: hashTagCategoryController.restProfile.length,
//                                       itemBuilder: (context, index) {
//                                         final hashtag =hashTagCategoryController.restProfile[index];
//                                         return ListTile(
//                                           title: Text(hashtag['hashtagName'] ??'No Categories Found'),
//                                           onTap: () {
//                                             _categoryNameCont.text =hashtag['hashtagName'] ?? '';
//                                             hashTagCategoryController.restProfile.clear();
//                                           },
//                                         );
//                                       },
//                                     ),
//                                   );
//                                 } else {
//                                   return const SizedBox.shrink();
//                                 }
//                               }),
//                               const SizedBox(height: 15),
//                               Center(
//                                 child: CustomButton(
//                                   borderRadius: BorderRadius.circular(20),
//                                   height:MediaQuery.of(context).size.height / 23,
//                                   width: MediaQuery.of(context).size.width / 3,
//                                   // onPressed: () {
//                                   //   setState(() {
//                                   //     if (formKey.currentState!.validate() &&
//                                   //         (_pickedImage != null ||imageUrl != null)) {
//                                   //       String finalImageUrl = imageUploader.imageURL.value.isNotEmpty
//                                   //           ? imageUploader.imageURL.value // Use newly uploaded image URL if available
//                                   //           : imageUrl;
//                                   //       if (isEditMode) {
//                                   //         categoryController.categoryUpdate(
//                                   //           thumbUrl: finalImageUrl,
//                                   //           mediumUrl: finalImageUrl,
//                                   //           foodCategoryName:_categoryNameCont.text,
//                                   //           foodCategoryImage: finalImageUrl,
//                                   //           foodcateid: fetchedDatas["_id"],
//                                   //           restaurantId:fetchedDatas["restaurantId"],
//                                   //         );
//                                   //       } else {
//                                   //         print('PROD CAT ID $prodCatId');
//                                   //         print("prod cate id ${productCategoryController.productCategory.first["_id"]}");
//                                   //         hashTagCategoryController.hashCreate(
//                                   //           hashtagName: _categoryNameCont.text,
//                                   //         );
//                                   //         categoryController.categoryCreate(
//                                   //           thumbUrl: finalImageUrl,
//                                   //           mediumUrl: finalImageUrl,
//                                   //           foodCategoryName:_categoryNameCont.text,
//                                   //           foodCategoryImage: finalImageUrl,
//                                   //           productCateId: prodCatId,
//                                   //         );
//                                   //       }
//                                   //       _categoryNameCont.clear();
//                                   //       _pickedImage = null;
//                                   //       imageUrl = "";
//                                   //       imageUploader.imageURL.value = '';
//                                   //       // Reset error message
//                                   //       errorMessage = '';
//                                   //     } else {
//                                   //       if (_pickedImage == null ||imageUrl != null) {
//                                   //         errorMessage ='Please pick an image for the category.';
//                                   //       } else {
//                                   //         errorMessage = '';
//                                   //       }
//                                   //       formKey.currentState?.validate();
//                                   //     }
//                                   //   });
//                                   // },
//                                   onPressed: () {
//   setState(() {
//     if (formKey.currentState!.validate() &&
//         (_pickedImage != null || imageUrl.isNotEmpty)) {
//       String finalImageUrl = imageUploader.imageURL.value.isNotEmpty
//           ? imageUploader.imageURL.value
//           : imageUrl;

//       if (finalImageUrl.isEmpty) {
//         errorMessage = 'Image upload failed. Please upload a valid JPG or PNG image.';
//         return;
//       }

//       if (isEditMode) {
//         categoryController.categoryUpdate(
//           thumbUrl: finalImageUrl,
//           mediumUrl: finalImageUrl,
//           foodCategoryName: _categoryNameCont.text,
//           foodCategoryImage: finalImageUrl,
//           foodcateid: fetchedDatas["_id"],
//           restaurantId: fetchedDatas["restaurantId"],
//         );
//       } else {
//         hashTagCategoryController.hashCreate(
//           hashtagName: _categoryNameCont.text,
//         );
//         categoryController.categoryCreate(
//           thumbUrl: finalImageUrl,
//           mediumUrl: finalImageUrl,
//           foodCategoryName: _categoryNameCont.text,
//           foodCategoryImage: finalImageUrl,
//           productCateId: prodCatId,
//         );
//       }

//       _categoryNameCont.clear();
//       _pickedImage = null;
//       imageUrl = "";
//       imageUploader.imageURL.value = '';
//       errorMessage = '';
//     } else {
//       if (_pickedImage == null && imageUrl.isEmpty) {
//         errorMessage = 'Please pick an image for the category.';
//       } else {
//         errorMessage = '';
//       }
//       formKey.currentState?.validate();
//     }
//   });
// }
// ,
//                                   child: CustomText(
//                                     text: isEditMode ? "Update" : 'Create',
//                                     style: CustomTextStyle.mediumWhiteText,
//                                   ),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }

  Center dataEmptyDesign() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 180, // Adjust as needed
            width: 180, // Adjust as needed
            child: Image.asset(
              'assets/images/nofoodavailable.gif',
              fit: BoxFit.cover, // Ensure proper scaling
            ),
          ),
          SizedBox(
            height: 10,
          ),
          CustomText(
            text: 'Add menu, boost orders!',
            style:TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.bold,
      color: Color(0xFF623089),
      fontFamily: 'Poppins-Regular'),
          ),
        ],
      ),
    );
  }

  int i = 0;
}

class MenuPagenations with ChangeNotifier {
  bool isLoading = false;

  bool moreDataLoading = false;

  int limit = 7;
  List fetchedDatas = [];

  dynamic totalCount;
  dynamic fetchCount;

  Future<void> clearData() async {
    fetchedDatas.clear();
    totalCount = 0;
    fetchCount = 0;
    isLoading = false;
    notifyListeners();
  }

  Future<void> fetchMenuData({int offset = 0, search}) async {
    try {
      moreDataLoading = true;
      notifyListeners();

      if (offset == 0) {
        isLoading = true;
        fetchedDatas.clear(); // Clear data if refreshing
        notifyListeners();
      }

      var response = await http.get(
        Uri.parse(
            '${API.categoryListApi}/pagination?restaurantId=$userId&limit=$limit&offset=$offset&value=$search'),
        headers: {
          'Authorization': 'Bearer $usertoken',
          'Content-Type': 'application/json',
          'userId': userId,
        },
      );

      print(
          'AAAAAA  ${API.categoryListApi}/pagination?restaurantId=$userId&limit=$limit&offset=$offset&value=$search');
      print("category *********************************************");
      print(userId);
      print(usertoken);
      print(response.statusCode);
      print(" RRRRRR  ${response.body}");

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        totalCount = result['data']['totalCount'];
        fetchCount = result['data']['fetchCount'];

        final newItems = result['data']['data'] ?? [];

        /// Get existing item IDs
        final existingItemIds = fetchedDatas.map((item) => item['_id']).toSet();

        /// Filter out duplicates
        final filteredNewItems = newItems
            .where((item) =>
                item['_id'] != null && !existingItemIds.contains(item['_id']))
            .toList();

        fetchedDatas.addAll(filteredNewItems);
        notifyListeners();

        if (fetchedDatas.isNotEmpty) {
          isLoading = false;
          notifyListeners();
        }

        for (int i = 0; i < fetchedDatas.length; i++) {
          print(
              '${fetchedDatas[i]['_id']}  === = =>> $totalCount  $fetchCount');
        }
      } else {
        if (fetchedDatas.isEmpty) {
          isLoading = false;
          notifyListeners();
        }
      }
    } catch (e) {
      print('Its an Exception Error $e');
    } finally {
      moreDataLoading = false;
      notifyListeners();
    }
  }
}
