// ignore_for_file: prefer_final_fields, avoid_print, no_leading_underscores_for_local_identifiers, unnecessary_string_interpolations, prefer_const_declarations

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:intl/intl.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:miogra_seller/Constants/const_variables.dart';
import 'package:miogra_seller/Controllers/ProfileController/activestatuscontroller.dart';
import 'package:miogra_seller/Controllers/ProfileController/profileget.dart';
import 'package:miogra_seller/Model/pickedupmodel.dart';
import 'package:miogra_seller/Screens/OrdersScreen/Order_Controller/PickedupOrdercontroller.dart';
import 'package:miogra_seller/Screens/OrdersScreen/Ordesviewscreen.dart';
import 'package:miogra_seller/Shimmer/ordersshimmer.dart';
import 'package:miogra_seller/Widgets/custom_colors.dart';
import 'package:miogra_seller/Widgets/custom_container.dart';
import 'package:miogra_seller/Widgets/custom_text.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';
import 'package:url_launcher/url_launcher.dart';

class PickedUpScreen extends StatefulWidget {
  const PickedUpScreen({super.key});

  @override
  State<PickedUpScreen> createState() => _PickedUpScreenState();
}

class _PickedUpScreenState extends State<PickedUpScreen> {
  final ActiveStatusController _activeStatusUpdatecontroller =
      Get.put(ActiveStatusController());
final ProfilScreeenController profilScreeenController = Get.put(ProfilScreeenController());
  List<bool> _isExpanded = [];
  List<bool> _isFurtherExpanded = [];
  bool isLoading = true;

  // final PagingController<int, Datum> pagingController =
  //     PagingController(firstPageKey: 0);
  final PageController pickpagecontroller = PageController(initialPage: 0);
  final int defaultPageSize = 7;
  String usertoken = getStorage.read("usertoken") ?? '';
  String userId = getStorage.read("userId") ?? '';
  Pickedupcontroller pickedup = Get.put(Pickedupcontroller());
  final List<Datum> notifications = [];
  Map<int, int?> _customisationExpandedIndex = {};
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pickedup.pickPagingController.refresh();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          // const SizedBox(height: 20),
          Expanded(
            child: PagedListView<int, dynamic>(
                pagingController: pickedup.pickPagingController,
                builderDelegate: PagedChildBuilderDelegate<dynamic>(
                  itemBuilder: (context, order, index) {
                    final orderCode = order["orderCode"] ?? 'N/A';
                    final orderBy = order["dropAddress"][0]["name"] ?? 'N/A';
                    final contactPersNum = order["dropAddress"]?[0]["contactPersonNumber"] ??'N/A';
                    // final orderDetails =
                    //     order["ordersDetails"] ?? []; // Corrected key here
                    final amountDetails =order["amountDetails"]!["finalAmount"] ?? '';
                    final orderId = order["_id"] ?? 'N/A';
                    // var gst = order["amountDetails"]?["tax"] ?? '';
                        final gst = (order['amountDetails']['tax'] ?? 0.0) 
          + (order['amountDetails']['otherCharges'] ?? 0.0);
                    var packagingcharge =order["amountDetails"]?["packingCharges"] ?? '';
                    var commission =order["amountDetails"]?["commissionAmount"] ?? '';
                    var couponAmount =order["amountDetails"]?["couponsAmount"] ?? '';
                    var delPartnername =order["assigneeDetails"]?["name"] ?? '';
                    var delPartnerContact =order["assigneeDetails"]?["mobileNo"] ?? '';
                    var orderStatus = order["orderStatus"] ?? '';
                    var delManImage = order["assigneeDetails"]?["imgUrl"];
                    var deliverytip = order['amountDetails']['tips'];
                    dynamic _calculateTotalPrice(orderItem) {
                      // dynamic foodPrice = int.tryParse(orderItem["foodPrice"]?.toString() ?? '0') ??0;
                      dynamic foodPrice = orderItem["foodPrice"] ?? '0';
                      dynamic quantity = int.tryParse(orderItem["quantity"]?.toString() ?? '0') ??0;
                      return foodPrice * quantity;
                    }
    
                    // Adjust the size of `_isExpanded` and `_isFurtherExpanded`
                    if (_isExpanded.length <= index) {
                      _isExpanded.add(false);
                      _isFurtherExpanded.add(false);
                    }
                    final Map<String, String> orderStatusMap = {
                      'orderAssigned': 'Progress',
                      'orderPickedUped': 'Picked Up',
                      'deliverymanReachedDoor': 'Out for Delivery',
                      'delivered': 'Delivered',
                      'rejected': 'Rejected',
                      'cancelled': 'Cancelled',
                      'roundTripStarted': 'RoundTripStarted',
                    };
                    final statusText = orderStatusMap[orderStatus] ?? '';
                    Color statusColor;
    
                  switch (orderStatus) {
                   case 'orderAssigned':
                   case 'orderPickedUped':
                   case 'deliverymanReachedDoor':
                  statusColor = Colors.blue;
                   break;
                   case 'delivered':
                   statusColor = Colors.green;
                   break;
                   case 'rejected':
                   case 'cancelled':
                   statusColor = Colors.red;
                   break;
                  default:statusColor = Colors.grey; // fallback
                  }
    
                    bool isAssigned = order["assigneeDetails"] != null;
                    bool isRejectedOrCancelled = orderStatus == 'rejected' || orderStatus == 'cancelled';
                    String formatDate({required String dateStr}) {
                      DateTime dateTime = DateTime.parse(dateStr);
                      dateTime = dateTime.add(Duration(hours: 5, minutes: 30));
                      String formattedDate = DateFormat("d MMM yyyy 'at' h:mma")
                          .format(dateTime)
                          .toLowerCase();
    
                      return formattedDate;
                    }
    
                    return MediaQuery.removePadding(
                    removeTop: true,
                    context: context,
                      child: InkWell(
                        // onTap: () {
                         
                         
                        //   Get.to(
                        //       () => Ordersviewscreen(
                        //             orderId: orderId,
                        //             isFromOrderPaginationCard: false,
                        //           ),
                        //       preventDuplicates: false);
                        // },
                        child: Padding(
                          padding: const EdgeInsets.all(4.0),
                          child: CustomContainer(
                            backgroundColor: Colors.white,
                                  decoration: BoxDecoration(
                                  border: Border.all(color: Customcolors.decorationLightGrey,width:0.8),
                                  borderRadius: BorderRadius.circular(20),),
                            width: MediaQuery.of(context).size.width / 1.1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Column(crossAxisAlignment:CrossAxisAlignment.start,
                                            mainAxisAlignment:MainAxisAlignment.start,
                                            children: [
                                              CustomText(
                                                text: 'Order ID : $orderCode',
                                                style:CustomTextStyle.smallBlueText,
                                              ),
                                              SizedBox(height: 5,),
                                              Text(
                                                "${formatDate(dateStr: order["createdAt"].toString())}",
                                                style:CustomTextStyle.smallGreyText,
                                              ),
                                            ],
                                          ),
                                          Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                            decoration: BoxDecoration(
                              color: statusColor,
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              statusText,
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                          const SizedBox(width: 5),
                          InkWell(
                            onTap: () {
                              setState(() {
                                _isExpanded[index] = !_isExpanded[index];
                                if (!_isExpanded[index]) {
                                  _isFurtherExpanded[index] = false;
                                }
                              });
                            },
                            child: Icon(
                              _isExpanded[index] ? MdiIcons.chevronUp : MdiIcons.chevronDown,
                              color: Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ),
                                        ],
                                      ),
                                      const SizedBox(height: 15),
                                      Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              print(orderId);
                                            },
                                            child: CustomText(
                                              text: 'Ordered by: ${orderBy.toString().capitalizeFirst}',
                                              style:
                                                  CustomTextStyle.mediumGreyText,
                                            ),
                                          ),
                                        //  const SizedBox(width: 20),
                                          // GestureDetector(
                                          //   onTap: () async {
                                          //     final Uri url = Uri.parse(
                                          //         'tel:$contactPersNum');
                                          //     if (await canLaunchUrl(url)) {
                                          //       await launchUrl(url);
                                          //     } else {
                                          //       throw 'Could not launch $url';
                                          //     }
                                          //   },
                                          //   child: SizedBox(
                                          //       height: 15,
                                          //       width: 15,
                                          //       child: Icon(
                                          //         Icons.phone,
                                          //         color: Colors.blue,
                                          //         size: 20,
                                          //       )),
                                          // ),
                                        ],
                                      ),
                                      if (_isExpanded[index])
                                        Padding(
                                          padding:
                                              const EdgeInsets.only(top: 4.0),
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Divider(
                                                color: Colors.grey.shade300,
                                              ),
                                              const SizedBox(height: 3),
                                              if (order["ordersDetails"].isNotEmpty) ...[
                                                ListView.builder(
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
  itemCount: order["ordersDetails"].length,
  itemBuilder: (context, i) {
    var orderItem = order["ordersDetails"][i];
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
                if (_customisationExpandedIndex[index] == i) {
                  _customisationExpandedIndex[index] = null;
                } else {
                  _customisationExpandedIndex[index] = i;
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
                    _customisationExpandedIndex[index] == i
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
        if (_customisationExpandedIndex[index] == i)
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
                                                Center(
                                                  child: Text('No orders found.'),
                                                ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              DottedLine(
                                                dashColor: Colors.grey.shade300,
                                              ),
                                              const SizedBox(
                                                height: 8,
                                              ),
                                              if (_isFurtherExpanded[index])
                                                Padding(
                                                  padding: const EdgeInsets.only(
                                                      top: 5.0),
                                                  child: Column(
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          CustomText(
                                                            text: 'Item Total',
                                                            style: CustomTextStyle
                                                                .mediumGreyText,
                                                          ),
                                                          CustomText(
                                                            text:
                                                                '₹${order['amountDetails']['cartFoodAmountWithoutCoupon'].toStringAsFixed(2)}',
                                                            style: CustomTextStyle
                                                                .mediumGreyText,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 7,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          CustomText(
                                                            text: 'GST and Other Charges',
                                                            style: CustomTextStyle
                                                                .mediumGreyText,
                                                          ),
                                                          CustomText(
                                                            text: '₹${gst.toStringAsFixed(2)}',
                                                            style: CustomTextStyle
                                                                .mediumGreyText,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 7,
                                                      ),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          CustomText(
                                                            text:
                                                                'Packaging Charge',
                                                            style: CustomTextStyle
                                                                .mediumGreyText,
                                                          ),
                                                          CustomText(
                                                            text:
                                                                '₹${packagingcharge.toStringAsFixed(2)}',
                                                            style: CustomTextStyle
                                                                .mediumGreyText,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 7,
                                                      ),
                                                      commission!=0?
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          CustomText(
                                                            text:
                                                                'Commission',
                                                            style: CustomTextStyle
                                                                .mediumGreyText,
                                                          ),
                                                          CustomText(
                                                            text:
                                                                '₹${commission.toStringAsFixed(2)}',
                                                            style: CustomTextStyle
                                                                .mediumGreyText,
                                                          ),
                                                        ],
                                                      ):SizedBox.square(),
                                                       commission!=0?
                                                      const SizedBox(
                                                        height: 7,
                                                      ):SizedBox.square(),
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          CustomText(
                                                            text:
                                                                'Delivery partner fee(up to ${order['totalKms']} km)',
                                                            style:  TextStyle(
      fontSize: 13.sp,
      fontWeight: FontWeight.w600,
      color: Colors.black,
     // color: Colors.grey.shade600,
      fontFamily: 'Poppins-Regular')
                                                            // style: CustomTextStyle
                                                            //     .mediumGreyText,
                                                          ),
                                                          CustomText(
                                                            text:
                                                                '₹${order['amountDetails']['deliveryCharges'].toStringAsFixed(2)}',
                                                            style: CustomTextStyle
                                                                .mediumGreyText,
                                                          ),
                                                        ],
                                                      ),
                                                      const SizedBox(
                                                        height: 7,
                                                      ),
                                                       Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          CustomText(
                            text: "Platform Fee",
                            style: CustomTextStyle.mediumGreyText,
                          ),
                          CustomText(
                            text: '₹${(order['amountDetails']?['platformFee'] ?? 0).toDouble().toStringAsFixed(2)}',
                            style: CustomTextStyle.mediumGreyText,
                          ),
                        ],
                      ),
                      
                                                      const SizedBox(
                                                        height: 7,
                                                      ),
                                                      deliverytip != 0
                                                          ? Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .spaceBetween,
                                                              children: [
                                                                CustomText(
                                                                  text:
                                                                      'Delivery Tip',
                                                                  style: CustomTextStyle
                                                                      .mediumGreyText,
                                                                ),
                                                                CustomText(
                                                                  text:
                                                                      '₹${deliverytip.toStringAsFixed(2)}',
                                                                  style: CustomTextStyle
                                                                      .mediumGreyText,
                                                                ),
                                                              ],
                                                            )
                                                          // : Row(
                                                          //     mainAxisAlignment:
                                                          //         MainAxisAlignment
                                                          //             .spaceBetween,
                                                          //     children: [
                                                          //       CustomText(
                                                          //         text:
                                                          //             'Delivery Tip',
                                                          //         style: CustomTextStyle
                                                          //             .mediumGreyText,
                                                          //       ),
                                                          //       CustomText(
                                                          //         text: '₹0.00',
                                                          //         style: CustomTextStyle
                                                          //             .mediumGreyText,
                                                          //       ),
                                                          //     ],
                                                          //   ),
                                                          :SizedBox.shrink(),
                                                             deliverytip != 0?
                                                      const SizedBox(
                                                        height: 7,
                                                      ) :SizedBox.shrink(),

                                                      couponAmount!=0?
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          CustomText(
                                                            text:
                                                                'Coupon Discount',
                                                            style: CustomTextStyle
                                                                .mediumGreyText,
                                                          ),
                                                          CustomText(
                                                            text:
                                                                '${order['amountDetails']['couponType'] == 'percentage' ? '%' : '₹'} $couponAmount',
                                                            style: CustomTextStyle
                                                                .greencolorText,
                                                          ),
                                                        ],
                                                      ):SizedBox.shrink(),
                                                      const SizedBox(height: 8),
                                                    ],
                                                  ),
                                                ),
                                              // Row(
                                              //   mainAxisAlignment:
                                              //       MainAxisAlignment
                                              //           .spaceBetween,
                                              //   children: [
                                              //     CustomText(
                                              //       text: 'Total Bill',
                                              //       style: CustomTextStyle
                                              //           .mediumGreyText,
                                              //     ),
                                                  // Row(
                                                  //   children: [
                                                  //     CustomText(
                                                  //       text:
                                                  //           '₹${amountDetails.toStringAsFixed(2)}',
                                                  //       style: CustomTextStyle
                                                  //           .mediumGreyText,
                                                  //     ),
                                                  //     // InkWell(
                                                  //     //   onTap: () {
                                                  //     //     setState(() {
                                                  //     //       _isFurtherExpanded[
                                                  //     //               index] =
                                                  //     //           !_isFurtherExpanded[
                                                  //     //               index];
                                                  //     //     });
                                                  //     //   },
                                                  //     //   child: Icon(
                                                  //     //     _isFurtherExpanded[
                                                  //     //             index]
                                                  //     //         ? MdiIcons.chevronUp
                                                  //     //         : MdiIcons
                                                  //     //             .chevronDown,
                                                  //     //     color: Colors
                                                  //     //         .grey.shade600,
                                                  //     //   ),
                                                  //     // ),
                                                  //   ],
                                                  // ),
                                              //   ],
                                              // ),
                                              // Divider(
                                              //   color: Colors.grey.shade300,
                                              // ),
                                              isAssigned
                                                  ? (isRejectedOrCancelled
                                                      ? const SizedBox() // Hide delivery details if rejected or cancelled
                                                      : Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .spaceBetween,
                                                          children: [
                                                            // Delivery Partner Details
                                                            Row(
                                                              children: [
                                                                InkWell(
                                                                onTap: () {
                                                                  print("${delManImage}");
                                                                },
                                                                  child: SizedBox(
                                                                    height: 35,
                                                                    width: 35,
                                                                    child: delManImage !=null  &&delManImage.isNotEmpty
                                                                        ? Image.network( "$baseImageUrl$delManImage",
                                                                            fit: BoxFit
                                                                                .cover)
                                                                        : Image.asset(
                                                                            'assets/images/deliveryprofile.png',
                                                                            fit: BoxFit
                                                                                .cover),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                Column(
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    CustomText(
                                                                      text:
                                                                          '${delPartnername.toString().capitalizeFirst}',
                                                                      style: CustomTextStyle
                                                                          .mediumBoldBlackText,
                                                                    ),
                                                                    CustomText(
                                                                      text:
                                                                          'Delivery Partner',
                                                                      style: CustomTextStyle
                                                                          .delGreyText,
                                                                    ),
                                                                  ],
                                                                ),
                                                              ],
                                                            ),
                                                            // Call and Message Buttons
                                                            Row(
                                                              children: [
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    final Uri
                                                                        url =
                                                                        Uri.parse(
                                                                            'tel:$delPartnerContact');
                                                                    if (await canLaunchUrl(
                                                                        url)) {
                                                                      await launchUrl(
                                                                          url);
                                                                    } else {
                                                                      throw 'Could not launch $url';
                                                                    }
                                                                  },
                                                                  child: SizedBox(
                                                                    height: 22,
                                                                    width: 22,
                                                                    child: Image
                                                                        .asset(
                                                                            'assets/images/orangephone.png',color: Color(0xFF623089),),
                                                                  ),
                                                                ),
                                                                const SizedBox(
                                                                    width: 10),
                                                                GestureDetector(
                                                                  onTap:
                                                                      () async {
                                                                    final String
                                                                        phoneNumber =
                                                                        "$delPartnerContact";
                                                                    final String
                                                                        message =
                                                                        "Your Order Has Been Picked Up!";
                                                                    makeSms(
                                                                        phoneNumber:
                                                                            phoneNumber,
                                                                        message:
                                                                            message);
                                                                  },
                                                                  child: SizedBox(
                                                                    height: 22,
                                                                    width: 22,
                                                                    child: Image
                                                                        .asset(
                                                                            'assets/images/orangemessage.png',color: Color(0xFF623089),),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        ))
                                                  : const SizedBox()
                                            ],
                                          ),
                                        ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  firstPageProgressIndicatorBuilder: (_) => isLoading
                      ? OrderShimmer()
                      : Container(color: Colors.blue),
                  newPageProgressIndicatorBuilder: (_) => Container(),
                  noItemsFoundIndicatorBuilder: (_) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 4,
                          child: Image.asset('assets/images/noorders.png'),
                        ),
                        const SizedBox(height: 20),
                        // Obx(() => CustomText(
                        //       text: _activeStatusUpdatecontroller
                        //                   .activeStatus.value ==
                        //               'online'
                        //           ? 'You are Online'
                        //           : 'You are Offline',
                        //       style: CustomTextStyle.mediumBlackText,
                        //     )),
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
                        
                        CustomText(
                          text: 'Waiting for new orders',
                          style: CustomTextStyle.mediumGreyText,
                        ),
                      ],
                    ),
                  ),
                  firstPageErrorIndicatorBuilder: (_) => Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 4,
                          child: Image.asset('assets/images/noorders.png'),
                        ),
                        const SizedBox(height: 20),
                        Obx(() => CustomText(
                              text: _activeStatusUpdatecontroller
                                          .activeStatus.value ==
                                      'online'
                                  ? 'You are Online'
                                  : 'You are Offline',
                              style: CustomTextStyle.mediumBlackText,
                            )),
                        CustomText(
                          text: 'Waiting for new orders',
                          style: CustomTextStyle.mediumGreyText,
                        ),
                      ],
                    ),
                  ),
                  newPageErrorIndicatorBuilder: (_) => SizedBox(),
                  noMoreItemsIndicatorBuilder: (_) =>SizedBox(),
                )),
          ),
        ],
      ),
    );
  }

  Future<void> makeSms(
      {required String phoneNumber, required String message}) async {
    final Uri launchUri = Uri(
      scheme: 'sms',
      path: phoneNumber,
      query: 'body=${Uri.encodeComponent(message)}',
    );

    if (await canLaunchUrl(launchUri)) {
      await launchUrl(launchUri);
    } else {
      throw 'Could not launch SMS';
    }
  }
}
