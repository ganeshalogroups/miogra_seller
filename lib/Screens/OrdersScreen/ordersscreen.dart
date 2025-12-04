// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/Controllers/CategoryController/productcateget.dart';
import 'package:miogra_seller/Controllers/ProfileController/activestatuscontroller.dart';
import 'package:miogra_seller/Controllers/ProfileController/profileget.dart';
import 'package:miogra_seller/Screens/OrdersScreen/neworders.dart';
import 'package:miogra_seller/Screens/OrdersScreen/pickedup.dart';
import 'package:miogra_seller/Screens/OrdersScreen/preparing.dart';
import 'package:miogra_seller/Widgets/custom_apputil.dart';
import 'package:miogra_seller/Widgets/custom_snackbar.dart';
import 'package:miogra_seller/Widgets/custom_text.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';
import 'package:get/get.dart';

class OrdersScreen extends StatefulWidget {
  final int initialTab;

  const OrdersScreen({super.key, this.initialTab = 0});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
    with SingleTickerProviderStateMixin {
  final ProductCategoryController productCategoryController =
      Get.put(ProductCategoryController());
  final ActiveStatusController _activeStatusUpdatecontroller =
      Get.put(ActiveStatusController());
  final ProfilScreeenController profilScreeenController =
      Get.put(ProfilScreeenController());
  bool _switchValue = false;
  late TabController _tabController; // Declare the TabController
  //final TextEditingController _searchController = TextEditingController();
  DateTime? _lastPressedAt;
  bool _isLoading = false;
  @override
  void initState() {
    super.initState();
    // Initialize TabController
    _tabController =
        TabController(length: 3, vsync: this, initialIndex: widget.initialTab);
    productCategoryController.getProductCategory();
    _fetchActiveStatus(); // Fetch the active status on screen load
  }

  Future<void> _fetchActiveStatus() async {
    try {
      setState(() {
        _isLoading = true; // Start loading
      });

      // Fetch profile API to get the current active status
      await profilScreeenController.getProfile();

      // Assuming `restProfile` contains the profile data after fetching
      if (profilScreeenController.restProfile.isNotEmpty) {
        var profileData = profilScreeenController.restProfile.first;
       
print("HAS FETCHED");
        // Check for the 'activeStatus' key in the profile data
        if (profileData != null && profileData.containsKey('activeStatus')) {
          String activeStatus = profileData['activeStatus'];

          setState(() {
            _switchValue = activeStatus.toLowerCase() == "online";
          });
        } else {
          debugPrint("activeStatus not found in the profile data.");
        }
      } else {
        debugPrint("Profile data is empty.");
      }
    } catch (e) {
      debugPrint('Error fetching active status: $e');
    } finally {
      setState(() {
        _isLoading = false; // End loading
      });
    }
  }

  void _updateActiveStatus(bool status) async {
    String newStatus = status ? "online" : "offline";

    setState(() {
      _isLoading = true; // Start loading
    });

    try {
      await _activeStatusUpdatecontroller.updateindividualStatus(activestatus: newStatus);
      _fetchActiveStatus();
    } catch (e) {
      // Handle errors (e.g., show a Snackbar or alert)
      debugPrint('Error updating status: $e');
    } finally {
      setState(() {
        _isLoading = false; // End loading
      });
    }
  }

  @override
  void dispose() {
    _tabController.dispose(); // Dispose TabController to free resources
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return PopScope(
      canPop: false,
      onPopInvoked: (bool didPop) async {
        DateTime now = DateTime.now();
        if (_lastPressedAt == null ||
            now.difference(_lastPressedAt!) > Duration(seconds: 2)) {
          _lastPressedAt = now;
          AppUtils.showToast('Press Back again to exit');

          return; // Don't close the app yet
        }

        SystemNavigator.pop(); // This will close the app
        return;
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    text: 'Hello, Welcome",',
                    style: CustomTextStyle.smallBlackText,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 1.5,
                    child: CustomText(
                      text: username.toString(),
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyle.restaurentNameText,
                    ),
                  ),
                ],
              ),
             
              GestureDetector(
                onTap: () async {
                  if (_isLoading) return; // Prevent multiple taps during loading
                  setState(() {
                    _switchValue = !_switchValue;
                  });
                  _updateActiveStatus(_switchValue);
                },
                child: AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  width: 80,
                  height: 30,
                  decoration: BoxDecoration(
                    color: _switchValue ? Colors.green : Colors.grey,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Stack(
                    children: [
                      Align(
                        alignment: _switchValue
                            ? Alignment.centerRight
                            : Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: Container(
                            width: 20,
                            height: 20,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: _switchValue ? 8 : 27,
                        right: _switchValue ? 27 : 8,
                        top: 4,
                        bottom: 4,
                        child: Center(
                          child: _isLoading
                              ? SizedBox(
                                  height: 10,
                                  width: 10,
                                  child: CircularProgressIndicator(
                                    valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white),
                                    strokeWidth: 1.5,
                                  ),
                                )
                              : CustomText(
                                  text: _switchValue ? 'Online' : 'Offline',
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 8,
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
        ),
        body: Padding(
          padding: const EdgeInsets.all(13.0),
          child: Column(
            children: [
              SizedBox(height: 10), // Spacing between search bar and tabs
              TabBar(
                controller: _tabController, // Use TabController here
                tabs: const [
                  Tab(text: 'NewOrders'),
                  Tab(text: 'Pending'),
                  Tab(text: 'Picked Up'),
                ],
                indicator: GradientUnderlineTabIndicator(
                  gradient: LinearGradient(
                    colors: const [
                   
   Color(0xFFAE62E8),
 Color(0xFF623089)

                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderSideWidth: 2.0,
                  insets: EdgeInsets.symmetric(horizontal: screenWidth / 4.3),
                ),
                labelColor: Colors.black,
                labelStyle: TextStyle(
                  fontSize: 12.h,
                  fontFamily: 'Poppins-Regular',
                ),
                unselectedLabelColor: Colors.grey,
              ),
              SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  controller: _tabController, // Use TabController here
                  children: [
                    _buildNewOrdersTab(),
                    _buildPreparingTab(),
                    _buildPickedUpTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNewOrdersTab() {
    return NewOrdersScreen();
  }

  Widget _buildPreparingTab() {
    return const PreparingScreen();
  }

  Widget _buildPickedUpTab() {
    return const PickedUpScreen();
  }
}
