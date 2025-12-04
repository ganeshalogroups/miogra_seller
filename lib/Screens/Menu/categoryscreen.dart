// ignore_for_file: depend_on_referenced_packages, avoid_print

import 'dart:async';
import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/Controllers/CategoryController/foodcontroller.dart';
import 'package:miogra_seller/Controllers/CategoryController/foodlistcontroller.dart';
import 'package:miogra_seller/Controllers/CategoryController/variantaddonscontroller.dart';
import 'package:miogra_seller/Model/getfoodlistmodel.dart';
import 'package:miogra_seller/Screens/Home/bottomnavigation.dart';
import 'package:miogra_seller/Screens/Menu/additemscreen.dart';
import 'package:provider/provider.dart';
import 'package:miogra_seller/Screens/Menu/editItemScreen.dart';
import 'package:miogra_seller/UrlList/api.dart';
import 'package:miogra_seller/Widgets/container_decoration.dart';
import 'package:miogra_seller/Widgets/custom_alertdialog.dart';
import 'package:miogra_seller/Widgets/custom_container.dart';
import 'package:miogra_seller/Widgets/custom_gradienttext.dart';
import 'package:miogra_seller/Widgets/custom_text.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';

class CategoryScreen extends StatefulWidget {
  final String? foodCatId;
  final String? foodCategory;

  const CategoryScreen({super.key, this.foodCatId, this.foodCategory});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final FoodListController foodController = Get.put(FoodListController());
  final ScrollController _scrollController = ScrollController();
  final FoodController foodSaveController = Get.put(FoodController());
  final VariantsController variantCon = Get.put(VariantsController());
  final TextEditingController _searchController = TextEditingController();

  //final TextEditingController _searchController = TextEditingController();
  bool isLoading = true;
  String searchTerm = '';
  bool isActive = false;
  bool _switchValue = false;
  int pageOffset = 0;
  final List<Datum> notifications = [];
  clearData() {
    Timer(Duration(seconds: 0), () {
      foodSaveController.clearFoodItem();
      variantCon.variants.clear();
      variantCon.groupVariants.clear();
      variantCon.groupVariants.clear();
      variantCon.addongroupNames.clear();
      variantCon.addOns.clear();
      variantCon.variantList.clear();
      pickedPrimaryImage = null;
    });
    // try {
    //
    // } catch (e) {
    //   print(e.toString());
    // }
  }


  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        i = 0;
      });

      Provider.of<CategoryPaginations>(context, listen: false)
          .clearData()
          .then((value) {
        Provider.of<CategoryPaginations>(context, listen: false)
            .fetchCategoryData(foodcatId: widget.foodCatId, search: searchTerm);
      });
    });

  
 clearData();
    super.initState();
  }

  
   
  


 bool _isLoading = false;


  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var categoryProvider = Provider.of<CategoryPaginations>(context);
    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    const RestaurentBottomNavigation(initialIndex: 1)));
      },
      child: Scaffold(
        appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.grey.shade600),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            const RestaurentBottomNavigation(initialIndex: 1)));
              },
            ),
            title: Center(
                child: CustomText(
              text: '${widget.foodCategory.toString()}      ',
              style: CustomTextStyle.mediumGreyText,
            ))),
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // const SizedBox(
              //   height: 20,
              // ),

              Container(
                decoration: BoxDecorationsFun.searchDecoraton(),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment
                            .center, // Ensures vertical centering
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
                              textAlignVertical: TextAlignVertical
                                  .center, // Align text vertically
                              onChanged: (value) {
                                setState(() {
                                  searchTerm = value.trim();
                                  context
                                      .read<CategoryPaginations>()
                                      .clearData()
                                      .whenComplete(() {
                                    context
                                        .read<CategoryPaginations>()
                                        .fetchCategoryData(
                                            search: searchTerm,
                                            foodcatId: widget.foodCatId);
                                  });
                                });
                              },
                              decoration: InputDecoration(
                                isDense: true, // Compact layout
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 10), // Ensures center alignment
                                hintText: catres=="restaurant"? 'Search for Food' :"Search for Products",
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
                            icon: const Icon(Icons.close,
                                size: 18, color: Colors.grey),
                            onPressed: () {
                              _searchController.clear();
                              FocusScope.of(context).unfocus();
                              setState(() {
                                searchTerm = '';
                              });
                              context
                                  .read<CategoryPaginations>()
                                  .clearData()
                                  .whenComplete(() {
                                context
                                    .read<CategoryPaginations>()
                                    .fetchCategoryData(
                                        search: '',
                                        foodcatId: widget.foodCatId);
                              });
                            },
                          ),
                        ),
                    ],
                  ),
                ),
              ),
              // Container(
              //   // height: MediaQuery.of(context).size.height / 10.h,
              //   decoration: BoxDecorationsFun.searchDecoraton(),
              //   child: Padding(
              //     padding: const EdgeInsets.symmetric(horizontal: 8),
              //     child: Row(
              //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //       children: [
              //         SizedBox(
              //             height: 25,
              //             width: 25,
              //             child: Image.asset('assets/images/searchbar.png')),
              //         SizedBox(
              //           width: MediaQuery.of(context).size.width / 2,
              //           child: TextFormField(
              //             onChanged: (value) {
              //               setState(() {
              //                 searchTerm = value.trim(); // Update search term
              //                 context
              //                     .read<CategoryPaginations>()
              //                     .clearData(); // Clear previous data
              //                 context
              //                     .read<CategoryPaginations>()
              //                     .fetchCategoryData(
              //                         search: searchTerm,
              //                         foodcatId: widget.foodCatId);
              //               });
              //             },
              //             // controller: _searchController,
              //             decoration: InputDecoration(
              //               labelText: 'Search for Food',
              //               labelStyle: CustomTextStyle.searchGreyText,
              //               border: InputBorder.none,
              //               floatingLabelBehavior: FloatingLabelBehavior.never,
              //             ),
              //           ),
              //         ),
              //         const SizedBox(
              //           width: 20,
              //         ),
              //         SizedBox(
              //           height: 40,
              //           width: 40,
              //         ),
              //       ],
              //     ),
              //   ),
              // ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddItemScreen(
                            FoodCatid: widget.foodCatId,
                            FoodCat: widget.foodCategory,
                          ),
                        ));
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
                    decoration: BoxDecoration(
                      color: const Color(0xFFFFE5D0), // Light orange background
                      border:
                          Border.all(color: Color(0xFF623089)), // Orange border
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/images/add.png',
                          height: 20,
                          width: 20,
                          color: Color(0xFF623089),
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Add New Item',
                          style: CustomTextStyle.mediumOrangeText,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              // Padding(
              //   padding: const EdgeInsets.only(left: 10.0),
              //   child: GestureDetector(
              //     onTap: () {
              //       Navigator.push(
              //           context,
              //           MaterialPageRoute(
              //             builder: (context) => AddItemScreen(
              //               FoodCatid: widget.foodCatId,
              //               FoodCat: widget.foodCategory,
              //             ),
              //           ));
              //     },
              //     child: Row(
              //       children: [
              //         SizedBox(
              //             height: 25,
              //             width: 25,
              //             child: Image.asset('assets/images/add.png')),
              //         GradientText(
              //           text: 'Add Item',
              //           style: CustomTextStyle.smallOrangeText,
              //           gradient: const LinearGradient(
              //             begin: Alignment.topCenter,
              //             end: Alignment.bottomCenter,
              //             colors: [
              //               Color(0xFFF98322), // Color code for #F98322
              //               Color(0xFFEE4C46), // End color
              //             ],
              //           ),
              //         )
              //       ],
              //     ),
              //   ),
              // ),
              Expanded(
                child: NotificationListener<ScrollNotification>(
                    onNotification: (ScrollNotification notification) {
                  if (notification is ScrollStartNotification) {
                    print('Scroll started');
                  } else if (notification is ScrollUpdateNotification) {
                    print('Scrolling in progress');
                  } else if (notification is ScrollEndNotification) {
                    if (categoryProvider.totalCount != null &&
                        categoryProvider.fetchCount != null &&
                        categoryProvider.fetchedDatas.length !=
                            categoryProvider.totalCount) {
                      setState(() {
                        i = i + 1;
                      });

                      Provider.of<CategoryPaginations>(context, listen: false)
                          .fetchCategoryData(
                              foodcatId: widget.foodCatId,
                              search: searchTerm,
                              offset: i);

                      print(
                          'No more data to fetch in If Part ${categoryProvider.totalCount}  ${categoryProvider.fetchCount}');
                    } else {
                      print(
                          'No more data to fetch  ${categoryProvider.totalCount}  ${categoryProvider.fetchCount}');
                    }

                    print('Scroll ended $i');
                  }
                  return true;
                }, child: Consumer<CategoryPaginations>(
                  builder: (context, value, child) {
                    if (value.isLoading) {
                      return Center(child: CupertinoActivityIndicator());
                    } else if (value.fetchedDatas.isEmpty) {
                      return emptyDesign();
                    } else {
                      return ListView.builder(
                        itemCount: value.moreDataLoading
                            ? value.fetchedDatas.length + 1
                            : value.fetchedDatas.length,
                        itemBuilder: (context, index) {
                          if (index >= value.fetchedDatas.length) {
                            return Center(
                                child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: CupertinoActivityIndicator(),
                            ));
                          }

                          final foodname =
                              value.fetchedDatas[index]['foodName'] ?? "";
                          var status =
                              value.fetchedDatas[index]['status'] ?? false;

                          final totalPrice = value.fetchedDatas[index]['food']
                                  ['basePrice'] ??
                              '';

                          final foodImage =
                              value.fetchedDatas[index]['foodImgUrl'] ?? '';
                          final id = value.fetchedDatas[index]['_id'] ?? '';

                          return Padding(
                            padding: const EdgeInsets.only(
                                left: 3.0, right: 3.0, top: 10),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () {
                                    print("bhjbn");
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (_) {
                                          var addVariants = value
                                                  .fetchedDatas[index]
                                              ["customizedFood"]["addVariants"];
                                          return EditItemScreen(
                                              isFromAddonscreen: false,
                                              isFromVariantscreen: false,
                                              variantGroupName: (addVariants !=
                                                          null &&
                                                      addVariants.isNotEmpty)
                                                  ? addVariants[0][
                                                          "variantGroupName"] ??
                                                      ""
                                                  : "",
                                              foodCateId: widget.foodCatId,
                                              foodCat: widget.foodCategory,
                                              foodsListIndex:
                                                  value.fetchedDatas[index]);
                                        },
                                      ),
                                    );
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => AddItemScreen(
                                    //             FoodCatid: widget.foodCatId,
                                    //             FoodCat: widget.foodCategory,
                                    //             foodsListIndex: value
                                    //                 .fetchedDatas[index])));
                                  },
                                  child: CustomContainer(
                                    backgroundColor: Colors.white,
                                    borderRadius: BorderRadius.circular(5),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          SizedBox(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                14,
                                            child: Stack(
                                              children: [
                                                Container(
                                                  decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    image: DecorationImage(
                                                      image: foodImage !=
                                                                  null &&
                                                              foodImage
                                                                  .isNotEmpty
                                                          ? NetworkImage(
                                                              '$baseImageUrl${foodImage.startsWith('/') ? foodImage.substring(1) : foodImage}')
                                                          : AssetImage(
                                                                  'assets/images/upload.png')
                                                              as ImageProvider,
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                  height: 70,
                                                  width: 70,
                                                ),
                                                Builder(
                                                  builder: (context) {
                                                    String foodType =
                                                        value.fetchedDatas[
                                                                    index]
                                                                ["foodType"] ??
                                                            "";
                                                    '';
                                                    String assetPath;

                                                    switch (foodType) {
                                                      case 'nonveg':
                                                        assetPath =
                                                            "assets/images/nonveg.png";
                                                        break;
                                                      case 'veg':
                                                        assetPath =
                                                            "assets/images/veg.png";
                                                        break;
                                                      case 'egg':
                                                        assetPath =
                                                            "assets/images/egg.jpg";
                                                        break;
                                                      default:
                                                        assetPath =
                                                            ''; // Default path or leave it empty if there's no image
                                                    }

                                                    return assetPath.isNotEmpty
                                                        ? Positioned(
                                                            top: 3,
                                                            left: 3,
                                                            child: Image.asset(
                                                              assetPath,
                                                              height: 10,
                                                              width: 10,
                                                            ),
                                                          )
                                                        : SizedBox
                                                            .shrink(); // Return an empty widget if there's no image
                                                  },
                                                ),
                                                // Positioned(
                                                //   top: 3,
                                                //   left: 3,
                                                //   child: Image.asset(
                                                //     'assets/images/nonveg.png',
                                                //     height:
                                                //         10, // Adjust the size of the overlay image as needed
                                                //     width: 10,
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          CustomContainer(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                1.65,
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(4.0),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      SizedBox(
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            2.4,
                                                        child: CustomText(
                                                          text: foodname,
                                                          overflow:
                                                              TextOverflow.clip,
                                                          style: CustomTextStyle
                                                              .mediumBoldBlackText,
                                                        ),
                                                      ),

 

GestureDetector(
  

  onTap: () async {
  if (_isLoading) return; // Prevent multiple taps
  bool newStatus = !status;

  setState(() {
    _isLoading = true;
    value.fetchedDatas[index]['status'] = newStatus;
  });

  try {
    await foodController.foodstatusUpdate(status: newStatus, id: id);
  } catch (e) {
    setState(() {
      value.fetchedDatas[index]['status'] = status; // Revert on error
    });
  } finally {
    setState(() {
      _isLoading = false;
    });
  }
},

  child: AnimatedContainer(
    duration: const Duration(milliseconds: 300),
    width: 60,
    height: 30,
    decoration: BoxDecoration(
      color: status ? Colors.green : Colors.grey,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Stack(
      children: [
        AnimatedAlign(
          duration: const Duration(milliseconds: 300),
          alignment:
              status ? Alignment.centerRight : Alignment.centerLeft,
          child: Padding(
            padding: const EdgeInsets.all(4.0),
            child: Container(
              width: 22,
              height: 22,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
              ),
            ),
          ),
        ),
      ],
    ),
  ),
)

                                                 



                                                      
                                                    ],
                                                  ),
                                                  SizedBox(
                                                    width:
                                                        MediaQuery.of(context)
                                                                .size
                                                                .width /
                                                            2.4,
                                                    child: CustomText(
                                                      text:
                                                          '${value.fetchedDatas[index]['foodDiscription']}',
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      style: CustomTextStyle
                                                          .timeText,
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    height: 8,
                                                  ),
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      CustomText(
                                                        text: '₹$totalPrice',
                                                        style: CustomTextStyle
                                                            .mediumBoldBlackText,
                                                      ),
                                                      Row(
                                                        children: [
                                                          GestureDetector(
                                                            onTap: () {
                                                              showDialog(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (BuildContext
                                                                        context) {
                                                                  return DeleteConfirmationDialog(
                                                                    onConfirm:
                                                                        () {
                                                                      foodController
                                                                          .deleteFood(
                                                                        foodid:
                                                                            id,
                                                                        foodCatid:
                                                                            widget.foodCatId,
                                                                        foodCatname:
                                                                            widget.foodCategory,
                                                                      );
                                                                    },
                                                                  );
                                                                },
                                                              );
                                                            },
                                                            child: SizedBox(
                                                              height: 25,
                                                              width: 25,
                                                              child: Image.asset(
                                                                  'assets/images/trash.png'),
                                                            ),
                                                          ),
                                                          const SizedBox(
                                                              width: 20),
                                                          SizedBox(
                                                              height: 25,
                                                              width: 25,
                                                              child: Image.asset(
                                                                  'assets/images/edit.png')),
                                                        ],
                                                      )
                                                    ],
                                                  ),
                                                ],
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
                      );
                    }
                  },
                )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Center emptyDesign() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          SizedBox(
            height: 200, // Adjust as needed
            width: 200, // Adjust as needed
            child: Image.asset(
              'assets/images/menugif.gif',
              fit: BoxFit.cover, // Ensure proper scaling
            ),
          ),
          const SizedBox(height: 10),
          Center(
            child: CustomText(
              text: 'Add dishes, win hearts!',
              style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF623089),
                  fontFamily: 'Poppins-Regular'),
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  int i = 0;
}

class CategoryPaginations with ChangeNotifier {
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

  Future<void> fetchCategoryData({int offset = 0, foodcatId, search}) async {
    try {
      moreDataLoading = true;
      notifyListeners();

      if (offset == 0) {
        isLoading = true;
        fetchedDatas.clear(); // clear old data on refresh
        notifyListeners();
      }

      var response = await http.get(
        Uri.parse(
            '${API.getFoodlistPagenation}pagination?restaurantId=$userId&foodCategoryId=$foodcatId&limit=$limit&offset=$offset&value=$search'),
        headers: {
          'Authorization': 'Bearer $usertoken',
          'Content-Type': 'application/json',
          'userId': userId,
        },
      );
      print(
          "category ********************For food search*************************");
      print(
          " '${API.getFoodlistPagenation}pagination?restaurantId=$userId&foodCategoryId=$foodcatId&limit=$limit&offset=$offset&value=$search'");
      print(userId);
      print(response.statusCode);

      if (response.statusCode == 200) {
        var result = jsonDecode(response.body);

        totalCount = result['data']['totalCount'];
        fetchCount = result['data']['fetchCount'];

        final newItems = result['data']['data'] ?? [];

        /// Duplicate filtering based on `_id`
        final existingIds = fetchedDatas.map((item) => item['_id']).toSet();
        final filteredNewItems = newItems
            .where((item) =>
                item['_id'] != null && !existingIds.contains(item['_id']))
            .toList();

        fetchedDatas.addAll(filteredNewItems);
        notifyListeners();

        if (fetchedDatas.isNotEmpty) {
          isLoading = false;
          notifyListeners();
        }

        print(response.request);
        print('Total Length ... is ..');

        for (int i = 0; i < fetchedDatas.length; i++) {
          print(
              '${fetchedDatas[i]['_id']}  === = =>> $totalCount  $fetchCount');
        }
      } else {

        print("Get Error");
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
