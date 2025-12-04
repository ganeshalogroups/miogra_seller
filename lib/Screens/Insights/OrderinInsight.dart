// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/widgets.dart';
// import 'package:miogra_seller/Widgets/custom_container.dart';
// import 'package:miogra_seller/Widgets/custom_text.dart';
// import 'package:miogra_seller/Widgets/custom_textstyle.dart';

// class OrdersinInsight extends StatefulWidget {
// dynamic data;
//  OrdersinInsight({super.key,required this.data});

//   @override
//   State<OrdersinInsight> createState() => _OrdersinInsightState();
// }

// class _OrdersinInsightState extends State<OrdersinInsight> {
//   @override
//   Widget build(BuildContext context) {
//    return Padding(
//                 padding: const EdgeInsets.all(8.0),
//                 child: CustomContainer(
//                   borderRadius: BorderRadius.circular(15),
//                   backgroundColor: Colors.white,
//                   width: MediaQuery.of(context).size.width / 1.1,
//                   child: Column(
//                     children: [
//                       CustomContainer(
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Column(
//                             crossAxisAlignment: CrossAxisAlignment.start,
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   CustomText(
//                                     text: 'Order ID: #$orderCode',
//                                     style: CustomTextStyle.smallMedBlueText,
//                                   ),
//                                   Row(
//                                     children: [
//                                       CustomText(
//                                         text: 'Completed',
//                                         style: CustomTextStyle.greenText,
//                                       ),
//                                       InkWell(
//                                         onTap: () {
//                                           setState(() {
//                                             _isExpanded[index] =
//                                                 !_isExpanded[index];
//                                           });
//                                         },
//                                         child: Icon(
//                                           _isExpanded[index]
//                                               ? MdiIcons.chevronUp
//                                               : MdiIcons.chevronDown,
//                                           color: Colors.grey.shade600,
//                                         ),
//                                       ),
//                                     ],
//                                   ),
//                                 ],
//                               ),
//                               CustomText(
//                                 text: formatDate(dateStr: createdAt.toString()),
//                                 style: CustomTextStyle.smallGreyText,
//                               ),
//                               const SizedBox(height: 10),
//                               CustomText(
//                                 text: 'Ordered by: $orderedBy',
//                                 style: CustomTextStyle.mediumGreyText,
//                               ),
//                               if (_isExpanded[index]) ...[
//                                 Column(
//                                   children: [
//                                     const SizedBox(height: 10),
//                                     for (var i = 0;
//                                         i < orderDetails.length;
//                                         i++) ...[
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(left: 10.0),
//                                         child: Row(
//                                           mainAxisAlignment:
//                                               MainAxisAlignment.spaceBetween,
//                                           children: [
//                                             Row(
//                                               children: [
//                                                 SizedBox(
//                                                   height: 20,
//                                                   width: 20,
//                                                   child: Image.asset(
//                                                       'assets/images/nonveg.png'),
//                                                 ),
//                                                 const SizedBox(width: 15),
//                                                 Column(
//                                                   crossAxisAlignment:
//                                                       CrossAxisAlignment.start,
//                                                   children: [
//                                                     SizedBox(
//                                                       width:
//                                                           MediaQuery.of(context)
//                                                                   .size
//                                                                   .width /
//                                                               1.6,
//                                                       child: Text(
//                                                         '${orderDetails[i]['foodName'] ?? ''} x${orderDetails[i]['quantity'] ?? ''}',
//                                                         overflow:
//                                                             TextOverflow.clip,
//                                                       ),
//                                                     ),
//                                                     const SizedBox(height: 5),
//                                                     Text(
//                                                       '₹${orderDetails[i]['foodPrice'] ?? ''}',
//                                                       style: CustomTextStyle
//                                                           .smallGreyText,
//                                                     ),
//                                                   ],
//                                                 ),
//                                               ],
//                                             ),
//                                           ],
//                                         ),
//                                       ),
//                                       if (i < orderDetails.length - 1) ...[
//                                         const SizedBox(height: 10),
//                                         const DottedLine(
//                                             dashColor: Colors.grey),
//                                         const SizedBox(height: 10),
//                                       ],
//                                     ],
//                                     if (_isFurtherExpanded[index])
//                                       Padding(
//                                         padding:
//                                             const EdgeInsets.only(top: 10.0),
//                                         child: Column(
//                                           children: [
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 CustomText(
//                                                   text: 'Item Total',
//                                                   style: CustomTextStyle
//                                                       .mediumGreyText,
//                                                 ),
//                                                 CustomText(
//                                                   text:
//                                                       '₹${order['amountDetails']['cartFoodAmountWithoutCoupon'].toStringAsFixed(2)}',
//                                                   style: CustomTextStyle
//                                                       .mediumGreyText,
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(
//                                               height: 7,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 CustomText(
//                                                   text: 'GST',
//                                                   style: CustomTextStyle
//                                                       .mediumGreyText,
//                                                 ),
//                                                 CustomText(
//                                                   text: '₹${gst.toStringAsFixed(2)}',
//                                                   style: CustomTextStyle
//                                                       .mediumGreyText,
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(
//                                               height: 7,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 CustomText(
//                                                   text: 'Packaging Charge',
//                                                   style: CustomTextStyle
//                                                       .mediumGreyText,
//                                                 ),
//                                                 CustomText(
//                                                   text:
//                                                       '₹${order["amountDetails"]?["packingCharges"].toStringAsFixed(2)}',
//                                                   style: CustomTextStyle
//                                                       .mediumGreyText,
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(
//                                               height: 7,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 CustomText(
//                                                   text:
//                                                       'Delivery partner fee(up to ${order['totalKms']} km)',
//                                                   style: CustomTextStyle
//                                                       .mediumGreyText,
//                                                 ),
//                                                 CustomText(
//                                                   text:
//                                                       '₹${order['amountDetails']['deliveryCharges'].toStringAsFixed(2)}',
//                                                   style: CustomTextStyle
//                                                       .mediumGreyText,
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(
//                                               height: 7,
//                                             ),
//                                              Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 CustomText(
//                                                   text:
//                                                       'PlatForm Fee',
//                                                   style: CustomTextStyle
//                                                       .mediumGreyText,
//                                                 ),
//                                                 CustomText(
//                                                   text:
//                                                       '₹${order['amountDetails']['platformFee'].toStringAsFixed(2)}',
//                                                   style: CustomTextStyle
//                                                       .mediumGreyText,
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(
//                                               height: 7,
//                                             ),
//                                             tips != null
//                                                 ? Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceBetween,
//                                                     children: [
//                                                       CustomText(
//                                                         text: 'Delivery Tip',
//                                                         style: CustomTextStyle
//                                                             .mediumGreyText,
//                                                       ),
//                                                       CustomText(
//                                                         text: '₹${tips.toStringAsFixed(2)}',
//                                                         style: CustomTextStyle
//                                                             .mediumGreyText,
//                                                       ),
//                                                     ],
//                                                   )
//                                                 : Row(
//                                                     mainAxisAlignment:
//                                                         MainAxisAlignment
//                                                             .spaceBetween,
//                                                     children: [
//                                                       CustomText(
//                                                         text: 'Delivery Tip',
//                                                         style: CustomTextStyle
//                                                             .mediumGreyText,
//                                                       ),
//                                                       CustomText(
//                                                         text: '₹0.00',
//                                                         style: CustomTextStyle
//                                                             .mediumGreyText,
//                                                       ),
//                                                     ],
//                                                   ),
//                                             const SizedBox(
//                                               height: 7,
//                                             ),
//                                             Row(
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment
//                                                       .spaceBetween,
//                                               children: [
//                                                 CustomText(
//                                                   text: 'Coupon Discount',
//                                                   style: CustomTextStyle
//                                                       .mediumGreyText,
//                                                 ),
//                                                 CustomText(
//                                                   text:
//                                                       '${order['amountDetails']['couponType'] == 'percentage' ? '%' : '₹'} $couponAmount',
//                                                   style: CustomTextStyle
//                                                       .greencolorText,
//                                                 ),
//                                               ],
//                                             ),
//                                             const SizedBox(height: 20),
//                                           ],
//                                         ),
//                                       ),
//                                     SizedBox(height: 20),
//                                     DottedLine(
//                                       dashColor: Colors.grey,
//                                     ),
//                                     SizedBox(height: 20),
//                                     Row(
//                                       mainAxisAlignment:
//                                           MainAxisAlignment.spaceBetween,
//                                       children: [
//                                         CustomText(
//                                           text: 'Total Bill',
//                                           style: CustomTextStyle.mediumGreyText,
//                                         ),
//                                         Row(
//                                           children: [
//                                             CustomText(
//                                               text:
//                                                   '₹${totalAmount.toStringAsFixed(2)}',
//                                               style: CustomTextStyle
//                                                   .mediumGreyText,
//                                             ),
//                                             InkWell(
//                                               onTap: () {
//                                                 setState(() {
//                                                   _isFurtherExpanded[index] =
//                                                       !_isFurtherExpanded[
//                                                           index];
//                                                 });
//                                               },
//                                               child: Icon(
//                                                 _isFurtherExpanded[index]
//                                                     ? MdiIcons.chevronUp
//                                                     : MdiIcons.chevronDown,
//                                                 color: Colors.grey.shade600,
//                                               ),
//                                             ),
//                                           ],
//                                         ),
//                                       ],
//                                     ),
//                                     Divider(
//                                       color: Colors.grey.shade300,
//                                     ),
//                                     const SizedBox(
//                                       height: 10,
//                                     ),
//                                   ],
//                                 ),
//                               ],
//                             ],
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//              }
// }