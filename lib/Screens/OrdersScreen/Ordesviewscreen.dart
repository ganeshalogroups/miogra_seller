// ignore_for_file: dead_code, unnecessary_string_interpolations, must_be_immutable

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:miogra_seller/Controllers/OrdersController/updateorderstatuscontroller.dart';
import 'package:miogra_seller/Controllers/ProfileController/profileget.dart';
import 'package:miogra_seller/Screens/Home/bottomnavigation.dart';
import 'package:miogra_seller/Screens/OrdersScreen/Order_Controller/neworderscontroller.dart';
import 'package:miogra_seller/Widgets/CustomDottedline.dart';
import 'package:miogra_seller/Widgets/custom_colors.dart';
import 'package:miogra_seller/Widgets/custom_container.dart';
import 'package:miogra_seller/Widgets/custom_text.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';
import 'package:url_launcher/url_launcher.dart';

class Ordersviewscreen extends StatefulWidget {
  final bool isFromOrderPaginationCard;
  dynamic orderId;
  Ordersviewscreen({
    super.key,
    this.isFromOrderPaginationCard = false,
    this.orderId,
  });

  @override
  State<Ordersviewscreen> createState() => _OrdersviewscreenState();
}

class _OrdersviewscreenState extends State<Ordersviewscreen> {
  final ProfilScreeenController profilScreeenController =
      Get.put(ProfilScreeenController());
       NewordersController neworders = Get.put(NewordersController());
  OrderStatusController ordeviewget = Get.put(OrderStatusController());

  @override
  // void initState() {
  // ordeviewget.orderviewgetapi(orderid: widget.orderId);
  //   super.initState();
  // }
  @override
  void initState() {
    super.initState();
    // Use addPostFrameCallback to trigger the API call after the build phase
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  void _fetchData() {
    // Ensure the fetch operation doesn't interfere with the build process
    Future.delayed(Duration.zero, () {
      ordeviewget.orderviewgetapi(orderid: widget.orderId);
    });
  }
Set<int> expandedItems = {};  // Track which items are expanded
Future<void> _launchGoogleMapsForDirections(
    double destinationLat, double destinationLng) async {
  final Uri googleMapsUri = Uri.parse(
      'https://www.google.com/maps/dir/?api=1&destination=$destinationLat,$destinationLng');

  try {
    bool launched = await launchUrl(
      googleMapsUri,
      mode: LaunchMode.externalApplication,
    );
    if (!launched) {
      await launchUrl(googleMapsUri, mode: LaunchMode.platformDefault);
    }
  } catch (e) {
    debugPrint('Error launching Google Maps: $e');
  }
}

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        Get.back();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text('Order details ', style: CustomTextStyle.bigGreyText),
          automaticallyImplyLeading: false,
          leading: InkWell(
              onTap: () {
                Get.back();
              },
              child: Icon(Icons.arrow_back_ios_new_outlined)),
        ),
        body: SingleChildScrollView(child: Obx(() {
          if (ordeviewget.isorderviewgetloading.isTrue) {
            return Center(child: CupertinoActivityIndicator());
          } else if (ordeviewget.orderviewget == null ||
              ordeviewget.orderviewget["data"].isEmpty ||
              ordeviewget.orderviewget == "null") {
            return SizedBox();
          } else {
            String formatDate({required String dateStr}) {
              DateTime dateTime = DateTime.parse(dateStr);
              dateTime = dateTime.add(Duration(hours: 5, minutes: 30));
              String formattedDate = DateFormat("d MMM yyyy 'at' h:mma")
                  .format(dateTime)
                  .toLowerCase();

              return formattedDate;
            }

            var orderStatus =
                ordeviewget.orderviewget["data"]["orderStatus"] ?? '';
String _getReadableStatus(String status) {
  const statusMap = {
    'orderAssigned': 'Assigned',
    'orderPickedUped': 'Progress',
    'deliverymanReachedDoor': 'Progress',
    'delivered': 'Delivered',
    'rejected': 'Rejected',
    'cancelled': 'Cancelled',
    'roundTripStarted': 'RoundTripStarted',
    'new': 'Accepted',
    'initiated': 'New',
  };
  return statusMap[status] ?? '';
}
Color _getStatusColor(String status) {
  switch (status) {
    case 'orderAssigned':
    case 'new':
    case 'initiated':
      return  Color(0xFF623089); // Yellow
    case 'orderPickedUped':
    case 'deliverymanReachedDoor':
      return Colors.blue;
    case 'delivered':
      return Colors.green;
    case 'rejected':
    case 'cancelled':
      return Colors.red;
    default:
      return Colors.grey;
  }
}

            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(width: 13),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CustomText(
                            text:
                                'Order ID : ${ordeviewget.orderviewget["data"]["orderCode"]}',
                            style: CustomTextStyle.smallBlueText,
                          ),
                          SizedBox(height: 5),
                          Text(
                            formatDate(dateStr: ordeviewget.orderviewget["data"]["createdAt"].toString()),
                            style: CustomTextStyle.chipgrey,
                          ),
                         
                          SizedBox(height: 5),
                          orderStatus == 'cancelled'
                              ? SizedBox(
                                  width:170, // Ensures text wraps within available space
                                  child: RichText(
                                    maxLines: 3, // Adjust max lines as needed
                                    overflow: TextOverflow.ellipsis, // Truncates with ellipsis (...)
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: 'Cancelled Notes: ',
                                          style: CustomTextStyle.smallGreyText,
                                        ),
                                        TextSpan(
                                          text: ordeviewget.orderviewget["data"]["additionalInstructions"]?.toString().capitalizeFirst ??'',
                                          style: CustomTextStyle.rejectred,
                                        ),
                                      ],
                                    ),
                                  ),
                                )
                              : SizedBox(),
                          orderStatus == 'rejected'&&ordeviewget.orderviewget["data"]['rejectorDetails'] != null
                              ? RichText(
                                  text: TextSpan(
                                    children: [
                                      TextSpan(
                                        text: 'Rejected Notes: ',
                                        style: CustomTextStyle.smallGreyText,
                                      ),
                                      TextSpan(
                                        text: ordeviewget.orderviewget["data"]["rejectedNote"]?.toString().capitalizeFirst ??'',
                                        style: CustomTextStyle.rejectred,
                                      ),
                                    ],
                                  ),
                                )
                              : SizedBox(),
                              
                        ],
                      ),
                      Spacer(),
                      Column( 
                      // crossAxisAlignment: CrossAxisAlignment.start,
                        // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        Container(
  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
  decoration: BoxDecoration(
    color: _getStatusColor(orderStatus),
    borderRadius: BorderRadius.circular(8),
  ),
  child: Text(
    _getReadableStatus(orderStatus),
    style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
  ),
),

                          // Text(
                          //   orderStatus == 'orderAssigned'
                          //       ? 'Assigned'
                          //       : orderStatus == 'orderPickedUped'
                          //           ? 'Progress'
                          //           : orderStatus == 'deliverymanReachedDoor'
                          //               ? 'Progress'
                          //               : orderStatus == 'delivered'
                          //                   ? 'Delivered'
                          //                   : orderStatus == 'rejected'
                          //                       ? 'Rejected'
                          //                       : orderStatus == 'cancelled'
                          //                           ? 'Cancelled'
                          //                           : orderStatus ==
                          //                                   'roundTripStarted'
                          //                               ? 'RoundTripStarted'
                          //                               : orderStatus == "new"
                          //                                   ? "Accepted"
                          //                                   :orderStatus == "initiated"
                          //                                   ? "New":"",
                          //   style: orderStatus == 'rejected' ||
                          //           orderStatus == 'cancelled'
                          //       ? CustomTextStyle
                          //           .reddytext // Red for rejected/cancelled
                          //       : orderStatus == 'deliverymanReachedDoor'
                          //           ? CustomTextStyle
                          //               .bluetext // Blue for deliverymanReachedDoor
                          //           : (orderStatus == "new" ||
                          //                   orderStatus == "Accepted" ||
                          //                   orderStatus == "initiated")
                          //               ? CustomTextStyle
                          //                   .yellowtext // Yellow for Pending/Initiated
                          //               : CustomTextStyle
                          //                   .greenText, // Default green style
                          // ),
                        
                   if (ordeviewget.orderviewget["data"]["orderStatus"]  == 'deliverymanReachedDoor')
                           GestureDetector(
  onTap: () async {
    await _launchGoogleMapsForDirections(
      double.parse(ordeviewget.orderviewget["data"]['dropAddress'][0]['latitude'].toString()),
      double.parse(ordeviewget.orderviewget["data"]['dropAddress'][0]['longitude'].toString()),
    );
  },
  child: Container(
    margin: EdgeInsets.all(5),
    decoration: BoxDecoration(
      border: Border.all(color: Customcolors.decorationOrange),
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
      child: Text(
        "View in Map",
        style: CustomTextStyle.orangeText,
        textAlign: TextAlign.center,
      ),
    ),
  ),
)

                        ],
                      )
                    ],
                  ),
                 // SizedBox(height: 10),
                  // Container(
                  //   width: MediaQuery.of(context).size.width,
                  //   decoration:  BoxDecoration(
                  //     borderRadius: BorderRadius.all(Radius.circular(15)),
                  //     color: Customcolors.decorationWhite,
                  //      border:Border.all(color: Color.fromARGB(255, 224, 221, 221))
                  //   ),
                  //   child: Padding(
                  //     padding: const EdgeInsets.symmetric(
                  //         horizontal: 8, vertical: 15),
                  //     child: Column(
                  //       crossAxisAlignment: CrossAxisAlignment.start,
                  //       children: [
                  //         Padding(
                  //           padding: const EdgeInsets.all(3.0),
                  //           child: Text(
                  //             "Deliver to:",
                  //             style: CustomTextStyle.viewblack,
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.all(3.0),
                  //           child: Text(
                  //             "${ordeviewget.orderviewget["data"]["dropAddress"]?[0]["name"].toString().capitalizeFirst}",
                  //             style: CustomTextStyle.mediumGreyText,
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.all(2.0),
                  //           child: SizedBox(
                  //             child: Text(
                  //               "${ordeviewget.orderviewget["data"]['dropAddress']?[0]['fullAddress']}",
                  //               maxLines: null,
                  //               style: CustomTextStyle.chipgrey,
                  //             ),
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.all(3.0),
                  //           child: Text(
                  //             "Payment Method:",
                  //             style: CustomTextStyle.viewblack,
                  //           ),
                  //         ),
                  //         Padding(
                  //           padding: const EdgeInsets.all(3.0),
                  //           child: Text(
                  //             "${ordeviewget.orderviewget["data"]["paymentMethod"].toString().toUpperCase()}",
                  //             style: CustomTextStyle.chipgrey,
                  //           ),
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                   orderStatus == 'rejected'||orderStatus=="cancelled"?SizedBox.shrink():
                  SizedBox(height: 10,),
                  orderStatus == 'rejected'&&ordeviewget.orderviewget["data"]['rejectorDetails'] != null
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          decoration:  BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(15)),
                            color: Customcolors.decorationWhite,
                             border:Border.all(color: Color.fromARGB(255, 224, 221, 221))
                          ),
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    "Rejected Info:",
                                    style: CustomTextStyle.viewblack,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: Text(
                                    "${ordeviewget.orderviewget["data"]['rejectorDetails']['name'].toString().capitalizeFirst}",
                                    style: CustomTextStyle.mediumGreyText,
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: SizedBox(
                                    child: Text(
                                      "${ordeviewget.orderviewget["data"]['rejectorDetails']['mobileNo'].toString()}",
                                      maxLines: null,
                                      style: CustomTextStyle.chipgrey,
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.all(2.0),
                                  child: SizedBox(
                                    child: Text(
                                      "${ordeviewget.orderviewget["data"]['rejectorDetails']['email'].toString()}",
                                      maxLines: null,
                                      style: CustomTextStyle.chipgrey,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      : SizedBox(),
                  SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12,vertical: 8),
                    decoration: BoxDecoration(
                      color: Customcolors.decorationWhite, // Set your desired background color
                      borderRadius: BorderRadius.circular(10.0),
                      border:Border.all(color: Color.fromARGB(255, 224, 221, 221))
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bill Summary',
                          style: CustomTextStyle.minblacktext,
                        ),
                        SizedBox(height: 10),
                        // Put this in your StatefulWidget class:
                         ListView.builder(
  shrinkWrap: true,
  physics: NeverScrollableScrollPhysics(),
  itemCount: ordeviewget.orderviewget["data"]["ordersDetails"]?.length ?? 0,
  itemBuilder: (context, index) {
    var orderItem = ordeviewget.orderviewget["data"]["ordersDetails"][index];
    var selectedVariant = orderItem['selectedVariant'];
    var selectedAddOns = orderItem['selectedAddOns'] ?? [];
    var quantity = orderItem['quantity'] ?? "";

    bool isExpanded = expandedItems.contains(index);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            orderItem['foodType'] == 'veg'
                ? iconfun(imageName: "assets/images/veg.png")
                : orderItem['foodType'] == 'nonveg'
                    ? iconfun(imageName: "assets/images/nonveg.png")
                    : iconfun(imageName: "assets/images/egg.jpg"),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                "$quantity X ${orderItem['foodName']}",
                style: CustomTextStyle.blackText,
                overflow: TextOverflow.clip,
              ),
            ),
          ],
        ),
      SizedBox(height: 10,),
(selectedVariant != null || selectedAddOns.isNotEmpty)
    ? GestureDetector(
        onTap: () {
          setState(() {
            isExpanded
                ? expandedItems.remove(index)
                : expandedItems.add(index);
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
                isExpanded
                    ? Icons.expand_less
                    : Icons.expand_more,
                size: 16,
                color: Colors.green,
              ),
            ],
          ),
        ),
      )
    : const SizedBox.shrink(),

        if (isExpanded)
          Padding(
            padding: const EdgeInsets.only(left: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (selectedVariant != null) ...[
                SizedBox(height: 10,),
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
                SizedBox(height: 10,),
                if (selectedAddOns.isNotEmpty) ...[
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
                  SizedBox(height: 10,),
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
                                  Text(
                                    "${addon['variantName']}",
                                    style: CustomTextStyle.timeText,
                                  ),
                                  Text(
                                    "x$quantity ₹${addon['customerPrice']}",
                                    style: CustomTextStyle.timeText,
                                  ),
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
,

                        SizedBox(height: 10),
                        CustomDottedContainer(),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            InkWell(
                              child: Text(
                                'Item Total',
                                style: CustomTextStyle.smallBlackBoldText,
                              ),
                            ),
                            Text(
                              "₹ ${ordeviewget.orderviewget["data"]['amountDetails']['cartFoodAmountWithoutCoupon'].toStringAsFixed(2)}",
                              style: CustomTextStyle.smallBlackBoldText,
                            )
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(
                                  right:
                                      16), // Adjust the right padding as needed
                              child: Text(
                                'GST and Other Charges',
                                style: CustomTextStyle.smallBlackBoldText,
                              ),
                            ),
                          Text(
  "₹ ${(
    (ordeviewget.orderviewget["data"]['amountDetails']['tax'] ?? 0) +
    (ordeviewget.orderviewget["data"]['amountDetails']['otherCharges'] ?? 0)
  ).toStringAsFixed(2)}",
  style: CustomTextStyle.smallBlackBoldText,
),

                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Delivery partner fee(up to ${ordeviewget.orderviewget["data"]['totalKms']} km)',
                              style: TextStyle(
      fontSize: 14.sp,
      fontWeight: FontWeight.w500,
      color: Customcolors.decorationBlack,
      fontFamily: 'Poppins-Regular')
                            ),
                            Text(
                              "₹ ${ordeviewget.orderviewget["data"]['amountDetails']['deliveryCharges'].toStringAsFixed(2)}",
                              style: CustomTextStyle.smallBlackBoldText,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Packaging Charge',
                              style: CustomTextStyle.smallBlackBoldText,
                            ),
                            Text(
                              "₹ ${ordeviewget.orderviewget["data"]['amountDetails']['packingCharges'].toStringAsFixed(2)}",
                              style: CustomTextStyle.smallBlackBoldText,
                            ),
                          ],
                        ),
                        SizedBox(height: 10),
                         ordeviewget.orderviewget["data"]['amountDetails']
                                    ['commissionAmount'] !=
                                0
                            ? 
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Commission',
                              style: CustomTextStyle.smallBlackBoldText,
                            ),
                            Text(
                              "₹ ${ordeviewget.orderviewget["data"]['amountDetails']['commissionAmount'].toStringAsFixed(2)}",
                              style: CustomTextStyle.smallBlackBoldText,
                            ),
                          ],
                        ):SizedBox.shrink(),
                         ordeviewget.orderviewget["data"]['amountDetails']
                                    ['commissionAmount'] !=
                                0
                            ?  
                        SizedBox(height: 10):SizedBox.shrink(),
                        Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Platform Fee',
                                    style: CustomTextStyle.smallBlackBoldText,
                                  ),
                                  Text(
                                    '₹ ${( ordeviewget.orderviewget["data"]['amountDetails']?['platformFee'] ?? 0).toDouble().toStringAsFixed(2)}',
                                    style: CustomTextStyle.smallBlackBoldText,
                                  ),
                                ],
                              ),
                        SizedBox(height: 10),
                        ordeviewget.orderviewget["data"]['amountDetails']
                                    ['tips'] !=
                                0
                            ? Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Delivery Tip',
                                    style: CustomTextStyle.smallBlackBoldText,
                                  ),
                                  Text(
                                    "₹ ${ordeviewget.orderviewget["data"]['amountDetails']['tips'].toStringAsFixed(2)}",
                                    style: CustomTextStyle.smallBlackBoldText,
                                  ),
                                ],
                              )
                            // : Row(
                            //     mainAxisAlignment:
                            //         MainAxisAlignment.spaceBetween,
                            //     children: [
                            //       Text(
                            //         'Delivery Tip',
                            //         style: CustomTextStyle.smallBlackBoldText,
                            //       ),
                            //       Text(
                            //         "₹ 0.00",
                            //         style: CustomTextStyle.smallBlackBoldText,
                            //       ),
                            //     ],
                            //   ),
                            :SizedBox.shrink(),
                             ordeviewget.orderviewget["data"]['amountDetails']
                                    ['tips'] !=
                                0
                            ? 
                        SizedBox(height: 10)   :SizedBox.shrink(),
                     ordeviewget.orderviewget["data"]['amountDetails']['couponsAmount']!=0?   
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Coupon Discount',
                              style: CustomTextStyle.smallBlackBoldText,
                            ),
                            Text(
                              "${ordeviewget.orderviewget["data"]['amountDetails']['couponType'] == 'percentage' ? '%' : '₹'} ${ordeviewget.orderviewget["data"]['amountDetails']['couponsAmount']}",
                              style: CustomTextStyle.greencolorText,
                            )
                          ],
                        ) :SizedBox.shrink(),
                        SizedBox(
                          height: 20,
                        ),
                        CustomDottedContainer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Grand Total',
                              style: CustomTextStyle.smallBlackBoldText,
                            ),
                            Text(
                              "₹ ${ordeviewget.orderviewget["data"]['amountDetails']['finalAmount'].toStringAsFixed(2)}",
                              style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                  color: Customcolors.decorationBlack,
                                  fontFamily: 'Poppins-Regular'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 50,
                  ),
                  if (widget.isFromOrderPaginationCard) // Check the flag here
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: GestureDetector(
                            // onTap: () {
                            // ordeviewget.updateOrderStatus(context,widget.orderId, 'rejected',"","");
                            //  ordeviewget.updateOrderStatus(context:context,orderStatus: 'rejected',
                            // id: widget.orderId,resid: "",rejectedNote: "");
                            onTap: () {
                              showRejectDialog(
                                  context,
                                  widget.orderId,
                                  ordeviewget.orderviewget["data"]
                                      ['subAdminDetails']['_id']);
                            },
                            // },
                            child: CustomContainer(
                              height: MediaQuery.of(context).size.height / 28,
                              borderRadius: BorderRadius.circular(15),
                              border: Border.all(color: Colors.red),
                              child: Center(
                                  child: Text(
                                'Reject',
                                style: CustomTextStyle.mediumRedText,
                              )),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Flexible(
                          child: GestureDetector(
                            onTap: () async {
                              var profileData =
                                  profilScreeenController.restProfile.first;
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

                              // If online, proceed with updating order status
                              // ordeviewget.updateOrderStatus(
                              //   context: context,
                              //   orderStatus: 'new',
                              //   id: widget.orderId,
                              //   resid: "",
                              //   rejectedNote: "",
                              // );
                               bool success = await ordeviewget.updateOrderStatus(
    context: context,
    orderStatus: 'new',
    id:  widget.orderId,
  );

  if (success) {
   neworders.neworderpagingcontroller.refresh();
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) =>RestaurentBottomNavigation(initialIndex: 0, initialTabInOrders: 1),
    //   ),
    // );
    Get.off(RestaurentBottomNavigation(initialIndex: 0, initialTabInOrders: 1));
  }else{    Get.off(RestaurentBottomNavigation(initialIndex: 0, initialTabInOrders: 1));}
                            },
                            child: CustomContainer(
                              height: MediaQuery.of(context).size.height / 28,
                              borderRadius: BorderRadius.circular(20),
                              backgroundColor: const Color(0xFF2DC304),
                              child: Center(
                                child: Text(
                                  'Accept',
                                  style: CustomTextStyle.mediumWhiteText,
                                ),
                              ),
                            ),
                          ),
                        ),
                        // Flexible(
                        //   child: GestureDetector(
                        //     onTap: () {
                        //       // ordeviewget.updateOrderStatus(context, widget.orderId, 'new',"","");
                        //       ordeviewget.updateOrderStatus(
                        //           context: context,
                        //           orderStatus: 'new',
                        //           id: widget.orderId,
                        //           resid: "",
                        //           rejectedNote: "");
                        //     },
                        //     child: CustomContainer(
                        //       height: MediaQuery.of(context).size.height / 28,
                        //       borderRadius: BorderRadius.circular(20),
                        //       backgroundColor: const Color(0xFF2DC304),
                        //       child: Center(
                        //           child: Text(
                        //         'Accept',
                        //         style: CustomTextStyle.mediumWhiteText,
                        //       )),
                        //     ),
                        //   ),
                        //    ),
                      ],
                    ),
                ],
              ),
            );
          }
        })),
      ),
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
            //  dialogTheme: DialogTheme(backgroundColor: Colors.white)
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
                onPressed: () async {
                  if (formKey.currentState!.validate()) {
                    String reason = rejectNoteController.text.trim();
                    // ordeviewget.updateOrderStatus(
                    //   context: context,
                    //   orderStatus: 'rejected',
                    //   id: orderId,
                    //   resid: restId,
                    //   rejectedNote: reason,
                    // );
                     neworders.neworderpagingcontroller.refresh();
                     bool success = await ordeviewget.updateOrderStatus(
      context: context,
      orderStatus: 'rejected',
      id: orderId,
      resid: restId,
      rejectedNote: reason,
    );

    if (success) {
    Get.off(RestaurentBottomNavigation(
            initialIndex: 0,
            initialTabInOrders: 2, // Go to Rejected tab
          ));
      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => RestaurentBottomNavigation(
      //       initialIndex: 0,
      //       initialTabInOrders: 2, // Go to Rejected tab
      //     ),
      //   ),
      // );
    }else{ Get.off(RestaurentBottomNavigation(
            initialIndex: 0,
            initialTabInOrders: 2, // Go to Rejected tab
          ));}
                  }
                },
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

Widget iconfun({imageName}) {
  return Image(
    image: AssetImage(
      imageName,
    ),
    height: 15,
    width: 20,
  );
}



 