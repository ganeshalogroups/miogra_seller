// ignore_for_file: avoid_print, depend_on_referenced_packages, unnecessary_string_interpolations, must_be_immutable
import 'dart:async';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/Controllers/OrdersController/updateorderstatuscontroller.dart';
import 'package:miogra_seller/Controllers/ProfileController/profileget.dart';
import 'package:miogra_seller/Model/pickedupmodel.dart';
import 'package:miogra_seller/Screens/Home/bottomnavigation.dart';
import 'package:miogra_seller/Screens/OrdersScreen/Order_Controller/OrderfetchController.dart';
import 'package:miogra_seller/Screens/OrdersScreen/Order_Controller/neworderscontroller.dart';
import 'package:miogra_seller/Screens/OrdersScreen/Ordesviewscreen.dart';
import 'package:miogra_seller/Shimmer/ordersshimmer.dart';
import 'package:miogra_seller/Widgets/custom_colors.dart';
import 'package:miogra_seller/Widgets/custom_container.dart';
import 'package:miogra_seller/Widgets/custom_text.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:audioplayers/audioplayers.dart';
// Declare this outside widget so it's persistent across screen reloads
// final Set<String> _shownOrderIds = {};
final Set<String> _shownOrderIds = {}; // Sounded
final Set<String> _shownDialogOrderIds = {}; // Dialog shown

class NewOrdersScreen extends StatefulWidget {
  const NewOrdersScreen({super.key});

  @override
  State<NewOrdersScreen> createState() => _NewOrdersScreenState();
}


class _NewOrdersScreenState extends State<NewOrdersScreen> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  final OrderStatusController orderStatusController = Get.put(OrderStatusController());
  NewordersController neworders = Get.put(NewordersController());
  final Orderfetchcontroller orderfetchorders = Get.put(Orderfetchcontroller());
   final ProfilScreeenController profilScreeenController = Get.put(ProfilScreeenController());
  final ScrollController _scrollController = ScrollController();
  // final Set<String> _shownOrderIds = {};
  late DateTime _appLaunchTime;

  int? previousTotalCount;
  int? lastSoundedTotalCount;
  bool _firstTimeLoaded = true;
  bool _isDialogOpen = false;
  List<dynamic> _currentOrdersInDialog = [];
  StateSetter? _dialogSetState;
final Set<String> _rejectedOrderIds = {};
final Map<String, TextEditingController> _rejectControllers = {};

  bool _isActive = true;
  @override
void initState() {
  super.initState();
  _appLaunchTime = DateTime.now();
  startOrderPolling();
}


  @override
  void dispose() {
    _isActive = false;
    _scrollController.dispose();
    // neworders.neworderpagingcontroller.dispose();
    for (var controller in _rejectControllers.values) {
  controller.dispose();
}

    super.dispose();
  }

  void startOrderPolling() async {
    while (_isActive) {
      await fetchAndShowOrders();
      await Future.delayed(Duration(seconds: 10));
    }
  }
Future<void> fetchAndShowOrders() async {
  try {
    await orderfetchorders.orderFetch();
    if (!mounted) return;

    final model = orderfetchorders.orderfetchmodel;
    final player = AudioPlayer();
    final DateTime now = DateTime.now();

    if (model['status'] != true || model['data'] == null) {
      if (_isDialogOpen && Navigator.canPop(context)) {
        Navigator.pop(context);
        _isDialogOpen = false;
        _dialogSetState = null;
        _currentOrdersInDialog.clear();
        neworders.neworderpagingcontroller.refresh();
      }
      previousTotalCount = 0;
      return;
    }

    final dataNode = model['data'];
    final List<dynamic> allOrders = dataNode is Map && dataNode['data'] is List ? dataNode['data'] : [];
    final int totalCount = dataNode is Map && dataNode['totalCount'] is int ? dataNode['totalCount'] : 0;

    // 🔄 Clean old orders from dialog
    final latestOrderIds = allOrders.map((o) => o['_id']).toSet();
    if (_isDialogOpen && _dialogSetState != null) {
      try {
        _dialogSetState?.call(() {
          _currentOrdersInDialog.removeWhere((order) => !latestOrderIds.contains(order['_id']));
        });
      } catch (e) {
        print("setState after dispose prevented: $e");
      }
    }

    if (_currentOrdersInDialog.isEmpty && _isDialogOpen && Navigator.of(context, rootNavigator: true).canPop()) {
      Navigator.of(context, rootNavigator: true).pop();
      _isDialogOpen = false;
      _dialogSetState = null;
    }

    if (allOrders.isEmpty && _isDialogOpen) {
      if (Navigator.canPop(context)) {
        Navigator.pop(context);
      }
      _isDialogOpen = false;
      _dialogSetState = null;
      _currentOrdersInDialog.clear();
      return;
    }

    final List<dynamic> freshOrders = allOrders.where((order) {
      final dynamic id = order['_id'];
      final dynamic createdAtStr = order['createdAt'];
      final DateTime? createdAt = DateTime.tryParse(createdAtStr ?? '');
      return !_shownOrderIds.contains(id) &&
             createdAt != null &&
             createdAt.isAfter(_appLaunchTime);
    }).toList();

    final List<dynamic> unseenDialogOrders = freshOrders.where((o) => !_shownDialogOrderIds.contains(o['_id'])).toList();

    if (_firstTimeLoaded) {
      _firstTimeLoaded = false;
      previousTotalCount = totalCount;
      lastSoundedTotalCount = totalCount;

      if (unseenDialogOrders.isNotEmpty) {
     //   await player.play(AssetSource('sounds/clock_alarm.mp3'));
        neworders.neworderpagingcontroller.refresh();

        _currentOrdersInDialog = unseenDialogOrders;
        _showOrderDialog();

        for (var order in unseenDialogOrders) {
          _shownOrderIds.add(order['_id']);
          _shownDialogOrderIds.add(order['_id']);
        }
      }
      return;
    }

    if (unseenDialogOrders.isNotEmpty) {
    //  await player.play(AssetSource('sounds/clock_alarm.mp3'));
      lastSoundedTotalCount = totalCount;
      neworders.neworderpagingcontroller.refresh();

      if (_isDialogOpen && _dialogSetState != null) {
        try {
          _dialogSetState?.call(() {
            _currentOrdersInDialog.addAll(unseenDialogOrders);
          });
        } catch (e) {
          print("Safe dialog setState failed: $e");
        }
      } else {
        _currentOrdersInDialog = unseenDialogOrders;
        _showOrderDialog();
      }

      for (var order in unseenDialogOrders) {
        _shownOrderIds.add(order['_id']);
        _shownDialogOrderIds.add(order['_id']);
      }
    }

    previousTotalCount = totalCount;
  } catch (e) {
    print("Error in fetchAndShowOrders: $e");
  }
}

  // Future<void> fetchAndShowOrders() async {
  //   try {
  //     await orderfetchorders.orderFetch();
  //     if (!mounted) return;

  //     final model = orderfetchorders.orderfetchmodel;
  //     final player = AudioPlayer();
  //     final DateTime now = DateTime.now();

  //     if (model['status'] != true || model['data'] == null) {
  //       if (_isDialogOpen) {
  //         if (Navigator.canPop(context)) {
  //           Navigator.pop(context);
  //         }
  //         _isDialogOpen = false;
  //         _dialogSetState = null;
  //         _currentOrdersInDialog.clear();
  //         neworders.neworderpagingcontroller.refresh();
  //       }
  //       previousTotalCount = 0;
  //       return;
  //     }

  //     final dataNode = model['data'];
  //     final List<dynamic> allOrders = dataNode is Map && dataNode['data'] is List ? dataNode['data'] : [];
  //     final int totalCount = dataNode is Map && dataNode['totalCount'] is int ? dataNode['totalCount'] : 0;
  //        // 🔄 Remove orders that no longer exist
  //   final latestOrderIds = allOrders.map((o) => o['_id']).toSet();
  //   if (_isDialogOpen && _dialogSetState != null) {
  //     try {
  //       _dialogSetState?.call(() {
  //         _currentOrdersInDialog.removeWhere((order) => !latestOrderIds.contains(order['_id']));
  //       });
  //     } catch (e) {
  //       print("setState after dispose prevented: $e");
  //     }
  //   }
  //     if (_currentOrdersInDialog.isEmpty && _isDialogOpen && Navigator.of(context, rootNavigator: true).canPop()) {
  //       Navigator.of(context, rootNavigator: true).pop();
  //       _isDialogOpen = false;
  //       _dialogSetState = null;
  //     }

  //     if (allOrders.isEmpty && _isDialogOpen) {
  //       if (Navigator.canPop(context)) {
  //         Navigator.pop(context);
  //       }
  //       _isDialogOpen = false;
  //       _dialogSetState = null;
  //       _currentOrdersInDialog.clear();
  //       return;
  //     }

  //     final List<dynamic> freshOrders = allOrders.where((order) {
  //       final dynamic id = order['_id'];
  //       final dynamic createdAtStr = order['createdAt'];
  //       final DateTime? createdAt = DateTime.tryParse(createdAtStr ?? '');
  //       return !_shownOrderIds.contains(id) &&
  //           createdAt != null &&
  //           createdAt.isAfter(_appLaunchTime);
  //     }).toList();
  //      if (_firstTimeLoaded) {
  //     _firstTimeLoaded = false;
  //     previousTotalCount = totalCount;
  //     lastSoundedTotalCount = totalCount;

  //     if (freshOrders.isNotEmpty) {
  //       await player.play(AssetSource('sounds/notification.mp3'));
  //        neworders.neworderpagingcontroller.refresh(); // 👈 Refresh list
  //       _currentOrdersInDialog = freshOrders;
  //       _showOrderDialog();
  //       for (var order in freshOrders) {
  //         _shownOrderIds.add(order['_id']);
  //       }
  //     }
  //     return;
  //   }

  //   // 🔄 New orders arrived later
  //   if (freshOrders.isNotEmpty) {
  //     await player.play(AssetSource('sounds/notification.mp3'));
  //     lastSoundedTotalCount = totalCount;
  //     neworders.neworderpagingcontroller.refresh();

  //     if (_isDialogOpen && _dialogSetState != null) {
  //       try {
  //         _dialogSetState?.call(() {
  //           _currentOrdersInDialog.addAll(freshOrders);
  //         });
  //       } catch (e) {
  //         print("Safe dialog setState failed: $e");
  //       }
  //     } else {
  //       _currentOrdersInDialog = freshOrders;
  //       _showOrderDialog();
  //     }

  //     for (var order in freshOrders) {
  //       _shownOrderIds.add(order['_id']);
  //     }
  //   }

  //     previousTotalCount = totalCount;
  //   } catch (e) {
  //     print("Error in fetchAndShowOrders: $e");
  //   }
  // }
 
  Future<void> _showOrderDialog() async {
  if (_isDialogOpen || !mounted) return;
  _isDialogOpen = true;
  // Store this to prevent double dialog during async delay
  final currentDialogOrders = List<dynamic>.from(_currentOrdersInDialog);
  await showDialog(
    context: context,
    barrierDismissible: false,
    barrierColor: Colors.black.withOpacity(0.4),
    builder: (_) {
      return StatefulBuilder(
        builder: (context, setState) {
          _dialogSetState = setState;

          return AlertDialog(
            backgroundColor: Colors.white,
            surfaceTintColor: Colors.transparent,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Text(
                    'Total Orders: ${orderfetchorders.orderfetchmodel['data']['totalCount'] ?? 0}',
                    style: CustomTextStyle.mediumGreyText,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('🛒 New Orders: ${_currentOrdersInDialog.length}',
                        style: CustomTextStyle.dateBlackText),
                    IconButton(
                      icon: Icon(Icons.cancel, color: Colors.red),
                      onPressed: () {
                        // ✅ Cleanly pop all dialogs just in case one stacked
                        if (Navigator.of(context, rootNavigator: true).canPop()) {
                          Navigator.of(context, rootNavigator: true).maybePop();
                        }
                        _isDialogOpen = false;
                        _dialogSetState = null;
                      },
                    ),
                  ],
                ),
                // if (_currentOrdersInDialog.length > 1) ...[
                //   const SizedBox(height: 4),
                //   Align(
                //     alignment: Alignment.centerRight,
                //     child: Text(
                //       'Scroll to view all orders >>',
                //       style: CustomTextStyle.redText,
                //     ),
                //   ),
                // ],
              ],
            ),
            content: SizedBox(
              width: MediaQuery.of(context).size.width * 0.76,
              height: 200,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _currentOrdersInDialog.length,
                separatorBuilder: (_, __) => SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final order = _currentOrdersInDialog[index];
                  final orderId = order['_id'];
                  final isRejected = _rejectedOrderIds.contains(orderId);
                  final rejectNoteController =
                      _rejectControllers.putIfAbsent(orderId, () => TextEditingController());
print("ORDER SAMBAVAM  $_currentOrdersInDialog");
                  // your existing card design...
                  return SizedBox(
                    
                    width: MediaQuery.of(context).size.width * 0.70,
                    child: SingleChildScrollView(
                      child: Container(
                        // height: 180,
                        padding: EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: const [
                            BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildOrderInfoText("Order Code: ", order['orderCode'] ?? ''),
                            SizedBox(height: 6),
                            _buildOrderInfoText("Order Time: ",
                                DateTime.tryParse(order['createdAt'] ?? '')?.toLocal().toString().split('.')[0] ?? ''),
                            // SizedBox(height: 6),
                            // _buildOrderInfoText("Customer: ", (order['customer_name'] ?? 'Unknown').toString().capitalizeFirst ?? ''),
                            // SizedBox(height: 6),
                            // _buildOrderInfoText("Delivery Address: ",
                            //     (order['customer_address'] is List)
                            //         ? order['customer_address'].join(', ')
                            //         : order['customer_address']?.toString() ?? '',
                            //     maxLines: 5),
                            // SizedBox(height: 6),
                            // _buildOrderInfoText("Total: ₹", order['finalAmount'].toString()),
                            // SizedBox(height: 6),
                            // _buildOrderInfoText("Customer No: ", order['customer_mobile'] ?? ''),
                            SizedBox(height: 6),
                            ListView.builder(
                              shrinkWrap: true,
                              physics: NeverScrollableScrollPhysics(),
                            itemCount: (order['ordersDetails'] as List?)?.length ?? 0,
                              itemBuilder:( context ,foodIndex){
                                
                                                       return    _buildOrderInfoText("${order['ordersDetails'][foodIndex]["foodName"]}  x "??"", order['ordersDetails'][foodIndex]["quantity"]?? '');}),


                            // Text("${orderfetchorders.foodList[index]["foodName"]}",
                  //  'Food Name: ${orderfetchorders.orderfetchmodel['data']['data'][0]["ordersDetails"][0][ "foodName"] ??""}',
                 //   style: CustomTextStyle.mediumblackText,
                 // ),
                  //            SizedBox(height: 6),
                  //            Text(
                  //   'Food Name: ${orderfetchorders.orderfetchmodel['data']['data'][0]["ordersDetails"][0][ "quantity"] ??0}',
                  //   style: CustomTextStyle.grey12
                  // ),
                   SizedBox(height: 10),

                            Row(
                              children: [
                                GestureDetector(
                                  onTap: isRejected ? null : () async {
                                    var profileData = profilScreeenController.restProfile.first;
                                    if (profileData['activeStatus'] == "offline") {
                                      Get.snackbar('Inactive', 'You are currently offline. Please go online to accept orders.',
                                        snackPosition: SnackPosition.BOTTOM,
                                        backgroundColor: Colors.redAccent,
                                        colorText: Colors.white,
                                      );
                                      return;
                                    }

                                    await orderStatusController.updateOrderStatusdialog(
                                      context: context,
                                      orderStatus: 'new',
                                      id: orderId,
                                      resid: "",
                                      rejectedNote: "",
                                    );

                                    final response = orderStatusController.orderUpdateDatadialog;
                                    if (response != null) {
                                      final message = response['message']?.toString().toLowerCase() ?? '';
                                      if (message.contains('already') || message.contains('trip')) {
                                        Get.snackbar('Already Processed', 'This order was already accepted or started by someone else.',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.orange,
                                          colorText: Colors.white,
                                        );
                                      }

                                      neworders.neworderpagingcontroller.refresh();
                                      _dialogSetState?.call(() {
                                        _currentOrdersInDialog.removeWhere((o) => o['_id'] == orderId);
                                      });

                                      if (_currentOrdersInDialog.isEmpty &&
                                          Navigator.of(context, rootNavigator: true).canPop()) {
                                        Navigator.of(context, rootNavigator: true).maybePop();
                                        _isDialogOpen = false;
                                        _dialogSetState = null;
                                      }
                                    }
                                  },
                                  child: Opacity(
                                    opacity: isRejected ? 0.5 : 1,
                                    child: CustomContainer(
                                      backgroundColor: Colors.green,
                                      borderRadius: BorderRadius.circular(15),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                        child: Text('Accept', style: CustomTextStyle.mediumWhiteText),
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(width: 15),
                                GestureDetector(
                                  onTap: isRejected
                                      ? null
                                      : () {
                                          setState(() {
                                            _rejectedOrderIds.add(orderId);
                                          });
                                        },
                                  child: Opacity(
                                    opacity: isRejected ? 0.5 : 1,
                                    child: CustomContainer(
                                      border: Border.all(color: Colors.red),
                                      borderRadius: BorderRadius.circular(15),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                                        child: Text('Reject', style: CustomTextStyle.reddytextmedium),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            if (isRejected) ...[
                              SizedBox(height: 10),
                              SizedBox(
                                width: 240,
                                child: TextFormField(
                                  controller: rejectNoteController,
                                  maxLines: 3,
                                  decoration: InputDecoration(
                                    hintText: "Type your reason here...",
                                    border: OutlineInputBorder(),
                                  ),
                                ),
                              ),
                              SizedBox(height: 10),
                              Row(
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        _rejectedOrderIds.remove(orderId);
                                        rejectNoteController.clear();
                                      });
                                    },
                                    child: CustomContainer(
                                      border: Border.all(color: Colors.grey),
                                      borderRadius: BorderRadius.circular(20),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        child: Text('Cancel', style: CustomTextStyle.mediumGreyText),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: 10),
                                  GestureDetector(
                                    onTap: () async {
                                      var profileData = profilScreeenController.restProfile.first;
                                      if (profileData['activeStatus'] == "offline") {
                                        Get.snackbar('Inactive', 'You are currently offline. Please go online to reject orders.',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.redAccent,
                                          colorText: Colors.white,
                                        );
                                        return;
                                      }

                                      final note = rejectNoteController.text.trim();
                                      if (note.isEmpty) {
                                        Get.snackbar('Required', 'Please enter a reason for rejection.',
                                          snackPosition: SnackPosition.BOTTOM,
                                          backgroundColor: Colors.orange,
                                          colorText: Colors.white,
                                        );
                                        return;
                                      }

                                      await orderStatusController.updateOrderStatusdialog(
                                        context: context,
                                        orderStatus: 'rejected',
                                        id: orderId,
                                        resid: userId,
                                        rejectedNote: note,
                                      );

                                      final response = orderStatusController.orderUpdateDatadialog;
                                      if (response != null) {
                                        final message = response['message']?.toString().toLowerCase() ?? '';
                                        if (message.contains('already')) {
                                          Get.snackbar('Already Processed', 'This order was already rejected by someone else.',
                                            snackPosition: SnackPosition.BOTTOM,
                                            backgroundColor: Colors.orange,
                                            colorText: Colors.white,
                                          );
                                        }

                                        neworders.neworderpagingcontroller.refresh();
                                        setState(() {
                                          _rejectedOrderIds.remove(orderId);
                                          rejectNoteController.clear();
                                        });

                                        _dialogSetState?.call(() {
                                          _currentOrdersInDialog.removeWhere((o) => o['_id'] == orderId);
                                        });

                                        if (_currentOrdersInDialog.isEmpty &&
                                            Navigator.of(context, rootNavigator: true).canPop()) {
                                          Navigator.of(context, rootNavigator: true).maybePop();
                                          _isDialogOpen = false;
                                          _dialogSetState = null;
                                        }
                                      }
                                    },
                                    child: CustomContainer(
                                      backgroundColor: Colors.red,
                                      borderRadius: BorderRadius.circular(20),
                                      child: Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                                        child: Text('Submit', style: CustomTextStyle.mediumWhiteText),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ]
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          );
        },
      );
    },
  );

  // ✅ Dialog dismissed
  _isDialogOpen = false;
  _dialogSetState = null;
   _currentOrdersInDialog.clear(); // ✅ clear after dialog
}

// void _showOrderDialog() {
//   if (_isDialogOpen || !mounted) return; // ✅ Prevent multiple dialogs
//   _isDialogOpen = true;

//   showDialog(
//     context: context,
//     barrierDismissible: false, // Prevents closing by tapping outside
//     barrierColor: Colors.black.withOpacity(0.4), // Optional: reduce darkness
//     builder: (_) {
//       return StatefulBuilder(
//         builder: (context, setState) {
//           _dialogSetState = setState;

//           return AlertDialog(
//             backgroundColor: Colors.white,
//             surfaceTintColor: Colors.transparent,
//             shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//             title: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: [
//                 Center(
//                   child: Text(
//                     'Total Orders: ${orderfetchorders.orderfetchmodel['data']['totalCount'] ?? 0}',
//                     style: CustomTextStyle.mediumGreyText,
//                   ),
//                 ),
//                 const SizedBox(height: 8),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text('🛒 New Orders: ${_currentOrdersInDialog.length}',
//                         style: CustomTextStyle.dateBlackText),
//                     IconButton(
//                       icon: Icon(Icons.cancel, color: Colors.red),
//                       onPressed: () {
//                         if (_isDialogOpen &&
//                             Navigator.of(context, rootNavigator: true).canPop()) {
//                           Navigator.of(context, rootNavigator: true).maybePop();
//                           _isDialogOpen = false;
//                           _dialogSetState = null;
//                         }
//                       },
//                     ),
//                   ],
//                 ),
//                 if (_currentOrdersInDialog.length > 1) ...[
//                   const SizedBox(height: 4),
//                   Align(
//                     alignment: Alignment.centerRight,
//                     child: Text(
//                       'Scroll to view all orders >>',
//                       style: CustomTextStyle.redText,
//                     ),
//                   ),
//                 ],
//               ],
//             ),
//             content: SizedBox(
//               width: MediaQuery.of(context).size.width * 0.76,
//               height: 300,
//               child: ListView.separated(
//                 scrollDirection: Axis.horizontal,
//                 itemCount: _currentOrdersInDialog.length,
//                 separatorBuilder: (_, __) => SizedBox(width: 16),
//                 itemBuilder: (context, index) {
//                   // your existing order card builder
//                   final order = _currentOrdersInDialog[index];
//                   final orderCode = order['orderCode'] ?? '';
//                   final customerName = order['customer_name'] ?? 'Unknown';
//                   final address = order['customer_address'] ?? 'N/A';
//                   final addressString = (address is List)
//                       ? address.join(', ')
//                       : (address is String ? address : 'N/A');
//                   final total = order['finalAmount'].toString();
//                   final phone = order['customer_mobile'] ?? 'N/A';
//                   final payment = order['paymentMethod'] ?? 'N/A';
//                   final orderTimeRaw = order['createdAt'] ?? '';
//                   final orderTime = DateTime.tryParse(orderTimeRaw);
//                   final formattedTime = orderTime != null
//                       ? '${orderTime.toLocal().toString().split('.')[0]}'
//                       : 'Unknown';
//                   final orderId = order['_id'];

//                   final isRejected = _rejectedOrderIds.contains(orderId);
//                   final rejectNoteController =
//                       _rejectControllers.putIfAbsent(orderId, () => TextEditingController());

//                   return SizedBox(
//                     // width: 250,
//                     width: MediaQuery.of(context).size.width * 0.70,
//                     child: SingleChildScrollView(
//                       child: Container(
//                         padding: EdgeInsets.all(16),
//                         decoration: BoxDecoration(
//                           color: Colors.grey[100],
//                           borderRadius: BorderRadius.circular(12),
//                           boxShadow: const [
//                             BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
//                           ],
//                         ),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             _buildOrderInfoText("Order Code: ", orderCode),
//                             SizedBox(height: 6),
//                             _buildOrderInfoText("Order Time: ", formattedTime),
//                             SizedBox(height: 6),
//                             _buildOrderInfoText("Customer: ", customerName.toString().capitalizeFirst.toString()),
//                             SizedBox(height: 6),
//                             _buildOrderInfoText("Delivery Address: ", addressString, maxLines: 5),
//                             SizedBox(height: 6),
//                             _buildOrderInfoText("Total: ₹", total),
//                             SizedBox(height: 6),
//                             _buildOrderInfoText("Customer No: ", phone),
//                             SizedBox(height: 6),
//                             _buildOrderInfoText("Payment: ", payment),
//                             SizedBox(height: 12),

//                             Row(
//                               children: [
//                                 GestureDetector(
//                                   onTap: isRejected
//                                       ? null
//                                       : () async {
//                                           var profileData = profilScreeenController.restProfile.first;
//                                           if (profileData['activeStatus'] == "offline") {
//                                             Get.snackbar(
//                                               'Inactive',
//                                               'You are currently offline. Please go online to accept orders.',
//                                               snackPosition: SnackPosition.BOTTOM,
//                                               backgroundColor: Colors.redAccent,
//                                               colorText: Colors.white,
//                                             );
//                                             return;
//                                           }

//                                           final orderId = order['_id'];
//                                           await orderStatusController.updateOrderStatusdialog(
//                                             context: context,
//                                             orderStatus: 'new',
//                                             id: orderId,
//                                             resid: "",
//                                             rejectedNote: "",
//                                           );

//                                           final response = orderStatusController.orderUpdateDatadialog;
//                                           if (response != null) {
//                                             final message = response['message']?.toString().toLowerCase() ?? '';
//                                             if (message.contains('already') || message.contains('trip')) {
//                                               Get.snackbar(
//                                                 'Already Processed',
//                                                 'This order was already accepted or started by someone else.',
//                                                 snackPosition: SnackPosition.BOTTOM,
//                                                 backgroundColor: Colors.orange,
//                                                 colorText: Colors.white,
//                                               );
//                                             }

//                                             neworders.neworderpagingcontroller.refresh();
//                                             _dialogSetState?.call(() {
//                                               _currentOrdersInDialog
//                                                   .removeWhere((o) => o['_id'] == orderId);
//                                             });

//                                             if (_currentOrdersInDialog.isEmpty &&
//                                                 Navigator.of(context, rootNavigator: true).canPop()) {
//                                               Navigator.of(context, rootNavigator: true).maybePop();
//                                               _isDialogOpen = false;
//                                               _dialogSetState = null;
//                                             }
//                                           }
//                                         },
//                                   child: Opacity(
//                                     opacity: isRejected ? 0.5 : 1,
//                                     child: CustomContainer(
//                                       backgroundColor: Colors.green,
//                                       borderRadius: BorderRadius.circular(15),
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//                                         child: Text('Accept', style: CustomTextStyle.mediumWhiteText),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                                 SizedBox(width: 15),
//                                 GestureDetector(
//                                   onTap: isRejected
//                                       ? null
//                                       : () {
//                                           setState(() {
//                                             _rejectedOrderIds.add(orderId);
//                                           });
//                                         },
//                                   child: Opacity(
//                                     opacity: isRejected ? 0.5 : 1,
//                                     child: CustomContainer(
//                                       border: Border.all(color: Colors.red),
//                                       borderRadius: BorderRadius.circular(15),
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
//                                         child: Text('Reject', style: CustomTextStyle.reddytextmedium),
//                                       ),
//                                     ),
//                                   ),
//                                 ),
//                               ],
//                             ),

//                             if (isRejected) ...[
//                               SizedBox(height: 10),
//                               SizedBox(
//                                 width: 240,
//                                 child: TextFormField(
//                                   controller: rejectNoteController,
//                                   maxLines: 3,
//                                   decoration: InputDecoration(
//                                     hintText: "Type your reason here...",
//                                     border: OutlineInputBorder(),
//                                   ),
//                                 ),
//                               ),
//                               SizedBox(height: 10),
//                               Row(
//                                 children: [
//                                   GestureDetector(
//                                     onTap: () {
//                                       setState(() {
//                                         _rejectedOrderIds.remove(orderId);
//                                         rejectNoteController.clear();
//                                       });
//                                     },
//                                     child: CustomContainer(
//                                       border: Border.all(color: Colors.grey),
//                                       borderRadius: BorderRadius.circular(20),
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//                                         child: Text('Cancel', style: CustomTextStyle.mediumGreyText),
//                                       ),
//                                     ),
//                                   ),
//                                   SizedBox(width: 10),
//                                   GestureDetector(
//                                     onTap: () async {
//                                       var profileData = profilScreeenController.restProfile.first;
//                                       if (profileData['activeStatus'] == "offline") {
//                                         Get.snackbar(
//                                           'Inactive',
//                                           'You are currently offline. Please go online to reject orders.',
//                                           snackPosition: SnackPosition.BOTTOM,
//                                           backgroundColor: Colors.redAccent,
//                                           colorText: Colors.white,
//                                         );
//                                         return;
//                                       }

//                                       final note = rejectNoteController.text.trim();
//                                       if (note.isEmpty) {
//                                         Get.snackbar(
//                                           'Required',
//                                           'Please enter a reason for rejection.',
//                                           snackPosition: SnackPosition.BOTTOM,
//                                           backgroundColor: Colors.orange,
//                                           colorText: Colors.white,
//                                         );
//                                         return;
//                                       }

//                                       await orderStatusController.updateOrderStatusdialog(
//                                         context: context,
//                                         orderStatus: 'rejected',
//                                         id: orderId,
//                                         resid: userId,
//                                         rejectedNote: note,
//                                       );

//                                       final response = orderStatusController.orderUpdateDatadialog;
//                                       if (response != null) {
//                                         final message = response['message']?.toString().toLowerCase() ?? '';
//                                         if (message.contains('already')) {
//                                           Get.snackbar(
//                                             'Already Processed',
//                                             'This order was already rejected by someone else.',
//                                             snackPosition: SnackPosition.BOTTOM,
//                                             backgroundColor: Colors.orange,
//                                             colorText: Colors.white,
//                                           );
//                                         }

//                                         neworders.neworderpagingcontroller.refresh();
//                                         setState(() {
//                                           _rejectedOrderIds.remove(orderId);
//                                           rejectNoteController.clear();
//                                         });

//                                         _dialogSetState?.call(() {
//                                           _currentOrdersInDialog.removeWhere((o) => o['_id'] == orderId);
//                                         });

//                                         if (_currentOrdersInDialog.isEmpty &&
//                                             Navigator.of(context, rootNavigator: true).canPop()) {
//                                           Navigator.of(context, rootNavigator: true).maybePop();
//                                           _isDialogOpen = false;
//                                           _dialogSetState = null;
//                                         }
//                                       }
//                                     },
//                                     child: CustomContainer(
//                                       backgroundColor: Colors.red,
//                                       borderRadius: BorderRadius.circular(20),
//                                       child: Padding(
//                                         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//                                         child: Text('Submit', style: CustomTextStyle.mediumWhiteText),
//                                       ),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ]
//                           ],
//                         ),
//                       ),
//                     ),
//                   );
//                 },
//               ),
//             ),
//           );
//         },
//       );
//     },
//   ).then((_) {
//     neworders.neworderpagingcontroller.refresh();
//     _isDialogOpen = false;
//     _dialogSetState = null;
//   });
// }

//   void _showOrderDialog() {
//     _isDialogOpen = true;

//     showDialog(
//       context: context,
//       barrierDismissible: false,
//       builder: (_) {
//         return StatefulBuilder(
//           builder: (context, setState) {
//             _dialogSetState = setState;

//             return AlertDialog(
//               backgroundColor: Colors.white,
//               surfaceTintColor: Colors.transparent,
//               shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
//               title: Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   Center(
//                     child: Text(
//                       'Total Orders: ${orderfetchorders.orderfetchmodel['data']['totalCount'] ?? 0}',
//                       style: CustomTextStyle.mediumGreyText,
//                     ),
//                   ),
//                   const SizedBox(height: 8),
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                     children: [
//                       Text('🛒 New Orders: ${_currentOrdersInDialog.length}', style: CustomTextStyle.dateBlackText),
//                       IconButton(
//                         icon: Icon(Icons.cancel, color: Colors.red),
//                         onPressed: () {
//                           Navigator.pop(context);
//                           _isDialogOpen = false;
//                           _dialogSetState = null;
//                         },
//                       ),
//                     ],
//                   ),
//                    if (_currentOrdersInDialog.length > 1) ...[
//       const SizedBox(height: 4),
//       Align(
//         alignment: Alignment.centerRight,
//         child: Text(
//           'Scroll to view all orders >>',
//           style: CustomTextStyle.redText,
//         ),
//       ),
//     ],
//                 ],
//               ),
//               content: SizedBox(
//                 width: MediaQuery.of(context).size.width * 0.76,
//                 height: 300,
//                 child: ListView.separated(
//                   scrollDirection: Axis.horizontal,
//                   itemCount: _currentOrdersInDialog.length,
//                   separatorBuilder: (_, __) => SizedBox(width: 16),
//                   itemBuilder: (context, index) {
//                     final order = _currentOrdersInDialog[index];
//                     final orderCode = order['orderCode'] ?? '';
//                     final customerName = order['customer_name'] ?? 'Unknown';
//                     final address = order['customer_address'] ?? 'N/A';
//                     final addressString = (address is List) ? address.join(', ') : (address is String ? address : 'N/A');
//                     final total = order['finalAmount'].toString();
//                     final phone = order['customer_mobile'] ?? 'N/A';
//                     final payment = order['paymentMethod'] ?? 'N/A';
//                     final orderTimeRaw = order['createdAt'] ?? '';
//                     final orderTime = DateTime.tryParse(orderTimeRaw);
//                     final formattedTime = orderTime != null
//                         ? '${orderTime.toLocal().toString().split('.')[0]}'
//                         : 'Unknown';
//                         final orderId = order['_id'];

//                          final isRejected = _rejectedOrderIds.contains(orderId);
//           final rejectNoteController = _rejectControllers.putIfAbsent(orderId, () => TextEditingController());

//                     return SizedBox(
//   width: 250,
//   child: SingleChildScrollView( // allows vertical scroll inside each horizontal item
//     child: Container(
//       padding: EdgeInsets.all(16),
//       decoration: BoxDecoration(
//         color: Colors.grey[100],
//         borderRadius: BorderRadius.circular(12),
//         boxShadow: [
//           BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2)),
//         ],
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           _buildOrderInfoText("Order Code: ", orderCode),
//           SizedBox(height: 6),
//           _buildOrderInfoText("Order Time: ", formattedTime),
//           SizedBox(height: 6),
//           _buildOrderInfoText("Customer: ", customerName.toString().capitalizeFirst.toString()),
//           SizedBox(height: 6),
//           _buildOrderInfoText("Delivery Address: ", addressString,maxLines: 5),
//           SizedBox(height: 6),
//           _buildOrderInfoText("Total: ₹", total),
//           SizedBox(height: 6),
//           _buildOrderInfoText("Customer No: ", phone),
//           SizedBox(height: 6),
//           _buildOrderInfoText("Payment: ", payment),
//           SizedBox(height: 12),

//           Row(
//             // mainAxisAlignment: MainAxisAlignment.spaceAround,
//             children: [
//               // Accept Button
//               GestureDetector(
//                 onTap:  isRejected ? null :() async {
//                  var profileData = profilScreeenController.restProfile.first;
//                   if (profileData['activeStatus'] == "offline") {
//                    Get.snackbar('Inactive', 'You are currently offline. Please go online to accept orders.',
//                    snackPosition: SnackPosition.BOTTOM,
//                    backgroundColor: Colors.redAccent,
//                    colorText: Colors.white);
//                    return;}
//                    final orderId = order['_id'];
//                     await orderStatusController.updateOrderStatusdialog(context: context,orderStatus: 'new',id: orderId,resid: "",rejectedNote: "",);
//                      if (orderStatusController.orderUpdateDatadialog != null) {
//                        neworders.neworderpagingcontroller.refresh();
//                       _dialogSetState?.call(() {
//                         _currentOrdersInDialog.removeWhere((o) => o['_id'] == orderId);});
                                
//                          if (_currentOrdersInDialog.isEmpty &&
//                            Navigator.of(context, rootNavigator: true).canPop()) {
//                            Navigator.of(context, rootNavigator: true).pop();
//                             _isDialogOpen = false;
//                             _dialogSetState = null;
//                             }
//                             // scrollToOrder(orderCode);
//                       }
//                 },
//                 child: Opacity(
//                 opacity: isRejected ? 0.5 : 1,
//                   child: CustomContainer(
//                     backgroundColor: Colors.green,
//                     borderRadius: BorderRadius.circular(20),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//                       child: Text('Accept', style: CustomTextStyle.mediumWhiteText),
//                     ),
//                   ),
//                 ),
//               ),
//               SizedBox(width: 15,),
//               // Reject Button
//               GestureDetector(
//                 onTap: isRejected
//                     ? null
//                     : () {
//                         setState(() {
//                           _rejectedOrderIds.add(orderId);
//                         });
//                       },
//                 child: Opacity(
//                   opacity: isRejected ? 0.5 : 1,
//                   child: CustomContainer(
//                     border: Border.all(color: Colors.red),
//                     borderRadius: BorderRadius.circular(20),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//                       child: Text('Reject', style: CustomTextStyle.reddytextmedium),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),

//           if (isRejected) ...[
//             SizedBox(height: 10),
//             SizedBox(
//             width: 240,
//               child: TextFormField(
//                 controller: rejectNoteController,
//                 maxLines: 3,
//                 decoration: InputDecoration(
//                   hintText: "Type your reason here...",
//                   border: OutlineInputBorder(),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             Row(
//               children: [
//                 GestureDetector(
//                   onTap: () {
//                     setState(() {
//                       _rejectedOrderIds.remove(orderId);
//                       rejectNoteController.clear();
//                     });
//                   },
//                   child: CustomContainer(
//                     border: Border.all(color: Colors.grey),
//                     borderRadius: BorderRadius.circular(20),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//                       child: Text('Cancel', style: CustomTextStyle.mediumGreyText),
//                     ),
//                   ),
//                 ),
//                 SizedBox(width: 10),
//                 GestureDetector(
//                   onTap: () async {
//                   var profileData = profilScreeenController.restProfile.first;
//                   if (profileData['activeStatus'] == "offline") {
//                     Get.snackbar('Inactive', 'You are currently offline. Please go online to reject orders.',
//                         snackPosition: SnackPosition.BOTTOM,
//                         backgroundColor: Colors.redAccent,
//                         colorText: Colors.white);
//                     return;
//                   }
                
//                   final note = rejectNoteController.text.trim();
//                   if (note.isEmpty) {
//                     Get.snackbar('Required', 'Please enter a reason for rejection.',
//                         snackPosition: SnackPosition.BOTTOM,
//                         backgroundColor: Colors.orange,
//                         colorText: Colors.white);
//                     return;
//                   }
                
//                   final orderId = order['_id'];
                
//                   await orderStatusController.updateOrderStatusdialog(
//                     context: context,
//                     orderStatus: 'rejected',
//                     id: orderId,
//                     resid:userId,
//                     rejectedNote: note,
//                   );
                
//                   if (orderStatusController.orderUpdateDatadialog != null) {
//                   neworders.neworderpagingcontroller.refresh();
//                     setState(() {
//                       _rejectedOrderIds.remove(orderId);
//                       rejectNoteController.clear();
//                     });
                
//                     _dialogSetState?.call(() {
//                       _currentOrdersInDialog.removeWhere((o) => o['_id'] == orderId);
//                     });
                
//                     /// 🔁 Same logic to auto-close dialog if no orders left
//                     if (_currentOrdersInDialog.isEmpty &&
//                         Navigator.of(context, rootNavigator: true).canPop()) {
//                       Navigator.of(context, rootNavigator: true).pop();
//                       _isDialogOpen = false;
//                       _dialogSetState = null;
//                     }
//                     // scrollToOrder(orderCode);
//                   }
//                 }
//                 ,
//                   child: CustomContainer(
//                     backgroundColor: Colors.red,
//                     borderRadius: BorderRadius.circular(20),
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
//                       child: Text('Submit', style: CustomTextStyle.mediumWhiteText),
//                     ),
//                   ),
//                 ),
//               ],
//             )
//           ]
//         ],
//       ),
//     ),
//   ),
// );

//                   },
//                 ),
//               ),
            
//             );
//           },
//         );
//       },
//     ).then((_) {
//       neworders.neworderpagingcontroller.refresh();
//       _isDialogOpen = false;
//       _dialogSetState = null;
      
//     });
//   }

  Widget _buildOrderInfoText(String label, String value, {int maxLines = 1}) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(text: label, style: CustomTextStyle.mediumblackText),
          TextSpan(text: value, style: CustomTextStyle.grey12),
        ],
      ),
      maxLines: maxLines,
      // overflow: TextOverflow.ellipsis,
    );
  }
 forrefresh() {

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        neworders.neworderpagingcontroller.refresh();
      });
    }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return RefreshIndicator(
    color: Colors.deepPurpleAccent,
       onRefresh: () async {
       await Future.delayed(Duration(seconds: 2), () {
        return forrefresh();
                  },
                );
             },
      child: Scaffold(
        body: Column(
          children: [
            const SizedBox(height: 20),
            Expanded(
              child: PagedListView<int, dynamic>(
                pagingController: neworders.neworderpagingcontroller,
                builderDelegate: PagedChildBuilderDelegate<dynamic>(
                  itemBuilder: (context, order, index) {
  return OrderPaginationCardDesign(
    index: index,
    order: order,
  );
}
,
                  firstPageProgressIndicatorBuilder: (_) => OrderShimmer(),
                  newPageProgressIndicatorBuilder: (_) => OrderShimmer(),
                  noItemsFoundIndicatorBuilder: (_) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 4,
                          child: Image.asset('assets/images/noorders.png'),
                        ),
                        const SizedBox(height: 20),
                        Obx(() {
  if (profilScreeenController.dataLoading.value) {
    return SizedBox(
      height: 20,
      width: 20,
      child: CupertinoActivityIndicator(),
    );
  }

  final profileList = profilScreeenController.restProfile;

  if (profileList.isEmpty) {
    return SizedBox(); // or a default text like 'Status unavailable'
  }

  final profileData = profileList.first;

  return CustomText(
    text: profileData['activeStatus'] == "offline"
        ? 'You are offline'
        : 'You are online',
    style: CustomTextStyle.mediumBlackText,
  );
}),

                        // Obx(() => CustomText(
                        //     // text: _activeStatusUpdatecontroller.activeStatus.value == 'online'
                        //     //     ? 'You are Online'
                        //     //     : 'You are Offline',
                        //     text: profileData['activeStatus'] =="offline"
                        //      ? 'You are offline'
                        //      : 'You are Online',
                        //     style: CustomTextStyle.mediumBlackText)),
                        CustomText(
                          text: 'Waiting for new orders',
                          style: CustomTextStyle.mediumGreyText,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  }


class OrderPaginationCardDesign extends StatefulWidget {
  dynamic order;
  final int index;
  OrderPaginationCardDesign(
      {super.key,  required this.order, required this.index});

  @override
  State<OrderPaginationCardDesign> createState() =>_OrderPaginationCardDesignState();
}

class _OrderPaginationCardDesignState extends State<OrderPaginationCardDesign> {
  final OrderStatusController orderStatusController =Get.put(OrderStatusController());
  NewordersController neworders = Get.put(NewordersController());
  final ProfilScreeenController profilScreeenController =Get.put(ProfilScreeenController());
  final int defaultPageSize = 7;
  String errorMessage = '';
 Map<int, int?> _customisationExpandedIndex = {};
  final List<Datum> notifications = [];
  bool isExpanded = false;
  bool isExpandedHint = false;
  @override
  void initState() {
    super.initState();
    final updatedAt = widget.order["updatedAt"];
    String formattedTime = "N/A";
    if (updatedAt != null) {
      try {
        final dateTime = DateTime.parse(updatedAt.toString());
        formattedTime =
            DateFormat('h:mm a').format(dateTime); // e.g., "5:00 PM"
      } catch (e) {
        formattedTime = "Invalid Date";
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final orderCode = widget.order["orderCode"] ?? 'N/A';
    final orderBy = widget.order["dropAddress"]?[0]["name"] ?? 'N/A';
    final contactPersNum =
        widget.order["dropAddress"]?[0]["contactPersonNumber"] ?? 'N/A';
    final orderDetails =widget.order["ordersDetails"] ?? []; // Corrected key here
    final amountDetails = widget.order["amountDetails"]!["finalAmount"] ?? '';
    var couponAmount = widget.order["amountDetails"]!["couponsAmount"] ?? '';
    final orderId = widget.order["_id"] ?? 'N/A';
    var deliverytip = widget.order['amountDetails']['tips'];
    var restid = widget.order['subAdminDetails']['_id'];
    String formatDate({required String dateStr}) {
      DateTime dateTime = DateTime.parse(dateStr);
      dateTime = dateTime.add(Duration(hours: 5, minutes: 30));
      String formattedDate =
          DateFormat("d MMM yyyy 'at' h:mma").format(dateTime).toLowerCase();

      return formattedDate;
    }
     dynamic _calculateTotalPrice(orderItem) {
                      // dynamic foodPrice = int.tryParse(orderItem["foodPrice"]?.toString() ?? '0') ??0;
                      dynamic foodPrice = orderItem["foodPrice"] ?? '0';
                      dynamic quantity = int.tryParse(orderItem["quantity"]?.toString() ?? '0') ??0;
                      return foodPrice * quantity;
                    }

    return InkWell(
      // onTap: () {
      //   // Navigator.push(context, MaterialPageRoute( builder: (context) =>Ordersviewscreen(orderId: orderId,isfromneworderscreen: true,) ));
      //   Get.to(
      //       () => Ordersviewscreen(
      //             orderId: orderId,
      //             isFromOrderPaginationCard: true,
      //           ),
      //       preventDuplicates: false);
      // },
      child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CustomContainer(
              backgroundColor: Colors.white,
            decoration: BoxDecoration(
            border: Border.all(color: Customcolors.decorationLightGrey,width:0.8),
            borderRadius: BorderRadius.circular(20),),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                CustomText(
                                  text: 'Order ID : $orderCode',
                                  style: CustomTextStyle.smallBlueText,
                                ),
                                SizedBox(height: 5,),
                                Text(
                                  "${formatDate(dateStr: widget.order["createdAt"].toString())}",
                                  style: CustomTextStyle.smallGreyText,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // CustomText(
                                //   text: widget.order["orderStatus"]=="initiated"?"New": widget.order["orderStatus"].toString(),
                                //   style: CustomTextStyle.yellowtext,
                                // ),
                                 Container(
                                 padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                                 decoration: BoxDecoration(
                                  color: Color(0xFF623089),
                                  borderRadius: BorderRadius.circular(8),),
                                  child: Text( widget.order["orderStatus"]=="initiated"?"New": widget.order["orderStatus"].toString(),
                                   style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),),),
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      isExpanded = !isExpanded;
                                    });
                                  },
                                  child: Icon(
                                    isExpanded
                                        ? MdiIcons.chevronUp
                                        : MdiIcons.chevronDown,
                                    color: Colors.grey.shade600,
                                  ),
                                )
                              ],
                            ),
                          ],
                        ),
                        SizedBox(height: 10,),
                        Row(
                          children: [
                            InkWell(
                              child: CustomText(
                                text: 'Ordered by: ${orderBy.toString().capitalizeFirst}',
                                style: CustomTextStyle.mediumGreyText,
                              ),
                            ),
                            // const SizedBox(width: 20),
                            // IconButton(
                            //     onPressed: () async {
                            //       final Uri url =
                            //           Uri.parse('tel:$contactPersNum');
                            //       if (await canLaunchUrl(url)) {
                            //         await launchUrl(url);
                            //       } else {
                            //         throw 'Could not launch $url';
                            //       }
                            //     },
                            //     icon: Icon(
                            //       Icons.phone,
                            //       color: Colors.blue,
                            //       size: 20,
                            //     )),
                          ],
                        ),
                        if (isExpanded)
                          Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Divider(
                                  color: Colors.grey.shade300,
                                ),
                                const SizedBox(height: 5),
                                if (widget
                                    .order["ordersDetails"].isNotEmpty) ...[
                                  ListView.builder(
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
  itemCount: widget.order["ordersDetails"].length,
  itemBuilder: (context, i) {
    var orderItem = widget.order["ordersDetails"][i];
    var selectedVariant = orderItem['selectedVariant'];
    var selectedAddOns = orderItem['selectedAddOns'] ?? [];
    var quantity = orderItem['quantity'] ?? "";
    var foodType = orderItem['foodType'];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                SizedBox(
                  height: 20,
                  width: 20,
                  child: foodType == 'veg'
                      ? iconfun(imageName: "assets/images/veg.png")
                      : foodType == 'nonveg'
                          ? iconfun(imageName: "assets/images/nonveg.png")
                          : iconfun(imageName: "assets/images/egg.jpg"),
                ),
                const SizedBox(width: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width / 1.8,
                  child: CustomText(
                    text: '${orderItem["foodName"] ?? ''} x$quantity',
                    style: CustomTextStyle.mediumBoldBlackText,
                  ),
                ),
              ],
            ),
            CustomText(
              text: '₹${_calculateTotalPrice(orderItem).toStringAsFixed(2)}',
              style: CustomTextStyle.mediumGreyText,
            ),
          ],
        ),
        const SizedBox(height: 10),

        // View Customisation Button
        if (selectedVariant != null || selectedAddOns.isNotEmpty)
          GestureDetector(
            onTap: () {
              setState(() {
                // Toggle customisation view for this order + item index
                if (_customisationExpandedIndex[widget.index] == i) {
                  _customisationExpandedIndex[widget.index] = null;
                } else {
                  _customisationExpandedIndex[widget.index] = i;
                }
              });
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: Colors.green.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.tune, size: 16, color: Colors.green),
                  const SizedBox(width: 6),
                  Text(
                    "View Customisation",
                    style: TextStyle(
                      color: Colors.green.shade800,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Icon(
                    _customisationExpandedIndex[widget.index] == i
                        ? Icons.expand_less
                        : Icons.expand_more,
                    size: 16,
                    color: Colors.green,
                  ),
                ],
              ),
            ),
          ),

        // Expanded Customisation View
        if (_customisationExpandedIndex[widget.index] == i)
          Padding(
            padding: const EdgeInsets.only(left: 8, top: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (selectedVariant != null) ...[
                  SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "Variants",
                      style: CustomTextStyle.smallRedText,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${selectedVariant["variantType"]['variantName']}",
                          style: CustomTextStyle.timeText,
                        ),
                        Text(
                          "x$quantity ₹${selectedVariant["variantType"]['customerPrice']}",
                          style: CustomTextStyle.timeText,
                        ),
                      ],
                    ),
                  ),
                ],
                if (selectedAddOns.isNotEmpty) ...[
                  SizedBox(height: 10),
                  Container(
                    margin: const EdgeInsets.only(bottom: 6),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Text(
                      "Addons",
                      style: CustomTextStyle.smallRedText,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: selectedAddOns.map<Widget>((addonGroup) {
                      var addOns = addonGroup['addOns'];
                      var addOnsTypeList = addOns['addOnsType'] as List<dynamic>;

                      return Padding(
                        padding: const EdgeInsets.only(bottom: 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: addOnsTypeList.map<Widget>((addon) {
                            return Padding(
                              padding: const EdgeInsets.only(left: 8, top: 2, right: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text("${addon['variantName']}",
                                      style: CustomTextStyle.timeText),
                                  Text("x$quantity ₹${addon['customerPrice']}",
                                      style: CustomTextStyle.timeText),
                                ],
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ],
            ),
          ),
      ],
    );
  },
)

                                              ] else
                                  Center(child: Text('No orders found.'),),
                                const SizedBox(height: 10),
                                DottedLine(dashColor: Colors.grey.shade300,),
                                const SizedBox(height: 10),
                                if (isExpandedHint)
                                  Padding(
                                    padding: const EdgeInsets.only(top: 5.0),
                                    child: Column(
                                      children: [
                                        Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              text: 'Item Total',
                                              style: CustomTextStyle.mediumGreyText,
                                            ),
                                            CustomText(
                                              text:'₹${widget.order['amountDetails']['cartFoodAmountWithoutCoupon'].toStringAsFixed(2)}',
                                              style: CustomTextStyle.mediumGreyText,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 7),
                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              text: 'GST and Other Charges',
                                              style: CustomTextStyle.mediumGreyText,
                                            ),
                                            CustomText(
                                           //   text:'₹${(widget.order["amountDetails"]?["tax"]??0)+(widget.order["amountDetails"]?["otherCharges"]??0).toStringAsFixed(2)}', // gst should be fetched from your data source
                                            text: '₹${(((widget.order["amountDetails"]?["tax"] ?? 0) +
        (widget.order["amountDetails"]?["otherCharges"] ?? 0))
        .toStringAsFixed(2))}',

                                              style: CustomTextStyle.mediumGreyText,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 7),
                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              text: 'Packaging Charge',
                                              style: CustomTextStyle.mediumGreyText,
                                            ),
                                            CustomText(
                                              text:'₹${widget.order["amountDetails"]?["packingCharges"].toStringAsFixed(2)}', // packagingcharge should be fetched
                                              style: CustomTextStyle.mediumGreyText,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 7),
                                        widget.order["amountDetails"]?["commissionAmount"]!=0?
                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              text: 'Commission',
                                              style: CustomTextStyle.mediumGreyText,
                                            ),
                                            CustomText(
                                              text:'₹${widget.order["amountDetails"]?["commissionAmount"].toStringAsFixed(2)}', // packagingcharge should be fetched
                                              style: CustomTextStyle.mediumGreyText,
                                            ),
                                          ],
                                        ):SizedBox.shrink(),
                                          widget.order["amountDetails"]?["commissionAmount"]!=0?
                                        const SizedBox(height: 7):SizedBox.shrink(),
                                        Row(
                                          mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              text: 'platForm Fee',
                                              style: CustomTextStyle.mediumGreyText,
                                            ),
                                            CustomText(
                                              text:'₹${widget.order["amountDetails"]?["platformFee"].toStringAsFixed(2)}', // packagingcharge should be fetched
                                              style: CustomTextStyle.mediumGreyText,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 7),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              text:'Delivery partner fee(up to ${widget.order['totalKms']} km)',
                                              style: TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
     // color: Colors.grey.shade600,
      fontFamily: 'Poppins-Regular')
                                            ),
                                            CustomText(
                                              text:'₹${widget.order['amountDetails']['deliveryCharges'].toStringAsFixed(2)}',
                                              style: CustomTextStyle.mediumGreyText,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 7),
                                     //   deliverytip != null
                                        deliverytip != 0
                                            ? Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                                children: [
                                                  CustomText(
                                                    text: 'Delivery Tip',
                                                    style: CustomTextStyle.mediumGreyText,
                                                  ),
                                                  CustomText(
                                                    text: '₹${deliverytip.toStringAsFixed(2)}',
                                                    style: CustomTextStyle.mediumGreyText,
                                                  ),
                                                ],
                                              )
                                              :
                                            // : Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                            //     children: [
                                            //       CustomText(
                                            //         text: 'Delivery Tip',
                                            //         style: CustomTextStyle.mediumGreyText,
                                            //       ),
                                            //       CustomText(
                                            //         text: '₹0.00',
                                            //         style: CustomTextStyle.mediumGreyText,
                                            //       ),
                                            //     ],
                                            //   ),
                                            SizedBox.shrink(),
                                              deliverytip != 0?
                                        const SizedBox(height: 7):   SizedBox.shrink(),
                                        couponAmount!=0?
                                        Row(mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                          children: [
                                            CustomText(
                                              text: 'Coupon Discount',
                                              style: CustomTextStyle.mediumGreyText,
                                            ),
                                            CustomText(
                                              text:'${widget.order['amountDetails']['couponType'] == 'percentage' ? '%' : '₹'} $couponAmount',
                                              style: CustomTextStyle.greencolorText,
                                            ),
                                          ],
                                        ):  SizedBox.shrink(),
                                         couponAmount!=0?
                                        const SizedBox(height: 8): SizedBox(height: 5,),
                                      ],
                                    ),
                                  ),
                                // Row(
                                //   mainAxisAlignment:MainAxisAlignment.spaceBetween,
                                //   children: [
                                //     CustomText(
                                //       text: 'Total Bill',
                                //       style: CustomTextStyle.mediumGreyText,
                                //     ),
                                //     Row(
                                //       children: [
                                //         CustomText(
                                //           text:'₹${amountDetails.toStringAsFixed(2)}',
                                //           style: CustomTextStyle.mediumGreyText,
                                //         ),
                                //         // InkWell(
                                //         //   onTap: () {
                                //         //     setState(() {
                                //         //       isExpandedHint = !isExpandedHint;
                                //         //     });
                                //         //   },
                                //         //   child: Icon(
                                //         //     isExpanded
                                //         //         ? MdiIcons.chevronUp
                                //         //         : MdiIcons.chevronDown,
                                //         //     color: Colors.grey.shade600,
                                //         //   ),
                                //         // ),
                                //       ],
                                //     ),
                                //   ],
                                // ),
                                // Divider(
                                //   color: Colors.grey.shade300,
                                // ),
                               const SizedBox(height: 13),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Flexible(
                                      child: GestureDetector(
                                        onTap: () {
                                          showRejectDialog(context, orderId, restid);
                                        },

                                        child: CustomContainer(
                                          height: MediaQuery.of(context).size.height /28,
                                          borderRadius:BorderRadius.circular(15),
                                          border: Border.all(color: Colors.red),
                                          child: Center(child: Text(
                                            'Reject',
                                            style:CustomTextStyle.mediumRedText,
                                          )),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(width: 10),
                                    Flexible(
                                      child: GestureDetector(
                                        // onTap: () {
                                        //   var profileData =profilScreeenController.restProfile.first;
                                        //   if (profileData['activeStatus'] =="offline") {
                                        //     Get.snackbar(
                                        //       'Inactive',
                                        //       'You are currently offline. Please go online to accept orders.',
                                        //       snackPosition:SnackPosition.BOTTOM,
                                        //       backgroundColor: Colors.redAccent,
                                        //       colorText: Colors.white,
                                        //     );
                                        //     return;
                                        //   }
                                        //     if (orderStatusController.orderUpdateData != null) {
                                                   
                                        //   orderStatusController
                                        //       .updateOrderStatus(
                                        //           context: context,
                                        //           orderStatus: 'new',
                                        //           id: orderId,
                                        //           resid: "",
                                        //           rejectedNote: "");
                                        //          neworders.neworderpagingcontroller.refresh();
                                        //        }else{  Get.snackbar(
                                        //       'Oops!',
                                        //       'Your order has been already Accepted',
                                        //       snackPosition:SnackPosition.TOP,
                                        //       backgroundColor: Colors.redAccent,
                                        //       colorText: Colors.white,
                                        //     );
                                        //     return;}
                                        // },
                                        onTap: () async {
  var profileData = profilScreeenController.restProfile.first;

  if (profileData['activeStatus'] == "offline") {
    Get.snackbar(
      'Inactive',
      'You are currently offline. Please go online to accept orders.',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: Colors.redAccent,
      colorText: Colors.white,
    );
    return;
  }

  bool success = await orderStatusController.updateOrderStatus(
    context: context,
    orderStatus: 'new',
    id: orderId,
  );

  if (success) {
    neworders.neworderpagingcontroller.refresh();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) =>RestaurentBottomNavigation(initialIndex: 0, initialTabInOrders: 1),
      ),
    );
  }
}
,
                                        child: CustomContainer(
                                          height: MediaQuery.of(context).size.height /28,
                                          borderRadius:BorderRadius.circular(20),
                                          backgroundColor:const Color(0xFF2DC304),
                                          child: Center(child: Text('Accept',style:CustomTextStyle.mediumWhiteText,)),
                                        ),
                                      ),
                                    ),
                                  
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ]),
                ),
              ],
            ),
          )),
    );
  }

  void showRejectDialog(BuildContext context, String orderId, String restId) {
    TextEditingController rejectNoteController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Theme(
          data: ThemeData(
             // dialogTheme: DialogTheme(backgroundColor: Colors.white)
              ),
          child: AlertDialog(
            surfaceTintColor: Colors.white,
            title: Text(
              "Reject Order",
              style: CustomTextStyle.restaurentNameText,
            ),
            content: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    "Please provide a reason for rejecting this order",
                    style: CustomTextStyle.chipgrey,
                  ),
                  const SizedBox(height: 10),
                  TextFormField(
                    cursorColor: Customcolors.decorationGrey,
                    cursorWidth: 2.0, // Set the cursor width
                    cursorRadius: Radius.circular(5.0),
                    controller: rejectNoteController,
                    maxLines: 3,
                    decoration: InputDecoration(
                      hintText: "Type your reason here...",
                      hintStyle: CustomTextStyle.fieldgrey,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Customcolors.decorationGrey, width: 1.5),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Customcolors.decorationDarkGrey, width: 1.5),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return "Reason cannot be empty";
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Close dialog
                },
                child: Text(
                  "Cancel",
                  style: CustomTextStyle.categoryBlackText,
                ),
              ),
              ElevatedButton(
                // onPressed: () {
                //  if (orderStatusController.orderUpdateData != null) {
                //   if (formKey.currentState!.validate()) {
                //     String reason = rejectNoteController.text.trim();
                //     orderStatusController.updateOrderStatus(
                //       context: context,
                //       orderStatus: 'rejected',
                //       id: orderId,
                //       resid: restId,
                //       rejectedNote: reason,
                //     );
                //   }
                //    }else{  Get.snackbar('Oops!','Your order has been already Rejected',
                //     snackPosition:SnackPosition.TOP,
                //     backgroundColor: Colors.redAccent,
                //     colorText: Colors.white,);
                //     return;}
                // },
                onPressed: () async {
  if (formKey.currentState!.validate()) {
    String reason = rejectNoteController.text.trim();

    bool success = await orderStatusController.updateOrderStatus(
      context: context,
      orderStatus: 'rejected',
      id: orderId,
      resid: restId,
      rejectedNote: reason,
    );

    if (success) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => RestaurentBottomNavigation(
            initialIndex: 0,
            initialTabInOrders: 2, // Go to Rejected tab
          ),
        ),
      );
    }
    // If not successful, snackbar is already shown in controller
  }
}
,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                ),
                child: Text(
                  "Reject",
                  style: CustomTextStyle.mediumWhiteText,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}









































































