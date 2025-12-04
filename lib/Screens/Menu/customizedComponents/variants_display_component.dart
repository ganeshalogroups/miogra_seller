
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miogra_seller/Widgets/custom_container.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';
import '../../../Controllers/CategoryController/variantaddonscontroller.dart';

class VariantDisplayContainer extends StatefulWidget {
  const VariantDisplayContainer({super.key});

  @override
  State<VariantDisplayContainer> createState() =>
      _VariantDisplayContainerState();
}

class _VariantDisplayContainerState extends State<VariantDisplayContainer> {
    final VariantsController variantsController = Get.put(VariantsController());
     @override
  void initState() {
    super.initState();
    variantsController.isVariantExpanded.value = true; // Always open initially
  }
  @override
  Widget build(BuildContext context) {
   return Obx(() {
      if (variantsController.variantList.isEmpty) {
        return SizedBox.shrink();
      }

      return CustomContainer(
        backgroundColor: Colors.white,
        borderRadius: BorderRadius.circular(10),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(7.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Variants',
                      style: CustomTextStyle.mediumBoldBlackText,
                    ),
                    GestureDetector(
                    onTap: () {
                      variantsController.toggleVariantExpanded();
                    },
                      child: Icon(
                        variantsController.isVariantExpanded.value
                            ? Icons.expand_less
                            : Icons.expand_more,
                        color: Colors.grey.shade600,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
              if (variantsController.isVariantExpanded.value)
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: variantsController.variantList.length,
                  itemBuilder: (context, index) {
                    final variantList = variantsController.variantList[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      // mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                        //  Text(
                        //      variantList['variantGroupName'],
                        //     style: CustomTextStyle.addonText,
                        //   ),
                          SizedBox(height: 5,),
                          ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10,);
                          },
                          shrinkWrap: true,
                          itemCount: variantList["variantType"].length,
                          physics: NeverScrollableScrollPhysics(),
                            itemBuilder: ( context,  indextwo) { 
                            final variantListtypeindex = variantList["variantType"][indextwo];
                            return  Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            //  crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                width: MediaQuery.of(context).size.width/2,
                                  child: Text(
                                    variantListtypeindex['variantName'],
                                    style: CustomTextStyle.categoryBlackText,
                                    overflow: TextOverflow.clip,
                                  ),
                                ),
                                Spacer(),
                                Text(
                                  variantListtypeindex['basePrice'].toString(),
                                  style: CustomTextStyle.categoryBlackText,
                                ),
                              ],
                            );
                         
                             },
                            ),
                        ],
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      );
    });
 
    // return Obx(() {
    //   return variantsController.variantList.isNotEmpty
    //       ? GestureDetector(
    //           onTap: variantsController.toggleVariantExpanded,
    //           child: CustomContainer(
    //             backgroundColor: Colors.white,
    //             borderRadius: BorderRadius.circular(10),
    //             // height: variantsController.isVariantExpanded.value
    //             //     ? null // Automatically adjust based on content
    //             //     : MediaQuery.of(context).size.height / 17,
    //             width: MediaQuery.of(context).size.width,
    //             child: Padding(
    //               padding: const EdgeInsets.all(5.0),
    //               child: Column(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: [
    //                   Padding(
    //                     padding: const EdgeInsets.all(7.0),
    //                     child: Row(
    //                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                       children: [
    //                         Text(
    //                           'Variants',
    //                           style: CustomTextStyle.mediumBoldBlackText,
    //                         ),
    //                         Icon(
    //                           variantsController.isVariantExpanded.value
    //                               ? Icons.expand_less
    //                               : Icons.expand_more,
    //                           color: Colors.grey.shade600,
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                   if (variantsController.isVariantExpanded.value)
    //                     SizedBox(
    //                     height: 400,
    //                       child: ListView.builder(
    //                       shrinkWrap: true,
    //                         physics: NeverScrollableScrollPhysics(),
    //                         itemCount: variantsController.variantList.length,
    //                         itemBuilder: (context, index) {
    //                           final variant =
    //                               variantsController.variantList[index];
    //                           return Padding(
    //                             padding: const EdgeInsets.all(8.0),
    //                             child: Row(
    //                               children: [
    //                                 Text(
    //                                   variant['variantGroupName'],
    //                                   style: CustomTextStyle.categoryBlackText,
    //                                 ),
    //                                  SizedBox(height: 5,),
    //                         ListView.separated(
    //                         separatorBuilder: (context, index) {
    //                           return SizedBox(height: 10,);
    //                         },
    //                         shrinkWrap: true,
    //                         itemCount: variant["variantType"].length,
    //                         physics: NeverScrollableScrollPhysics(),
    //                           itemBuilder: ( context,  indextwo) { 
    //                           final varianttypeindex = variant["variantType"][indextwo];
    //                           return  Row(
    //                             children: [
    //                               Text(
    //                                 varianttypeindex['variantName'],
    //                                 style: CustomTextStyle.categoryBlackText,
    //                               ),
    //                               Spacer(),
    //                               Text(
    //                                 varianttypeindex['customerPrice'].toString(),
    //                                 style: CustomTextStyle.categoryBlackText,
    //                               ),
    //                             ],
    //                           );
                           
    //                            },
    //                           ),
                                                   
    //                               ],
    //                             ),
    //                           );
    //                         },
    //                       ),
    //                     ),
                    
    //                 ],
    //               ),
    //             ),
    //           ),
    //         )
    //       : SizedBox.shrink();
    // });
  
  }
}
