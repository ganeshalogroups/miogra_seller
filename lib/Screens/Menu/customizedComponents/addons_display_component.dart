import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miogra_seller/Controllers/CategoryController/variantaddonscontroller.dart';
import 'package:miogra_seller/Widgets/custom_container.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';

// class AddonsDisplayComponent extends StatelessWidget {
//   const AddonsDisplayComponent({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final VariantsController variantsController = Get.put(VariantsController());

//     return Obx(() {
//       if (variantsController.addOns.isEmpty) {
//         return SizedBox.shrink();
//       }

//       return CustomContainer(
//         backgroundColor: Colors.white,
//         borderRadius: BorderRadius.circular(10),
//         width: MediaQuery.of(context).size.width,
//         child: Padding(
//           padding: const EdgeInsets.all(5.0),
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Padding(
//                 padding: const EdgeInsets.all(7.0),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     Text(
//                       'Add-ons',
//                       style: CustomTextStyle.mediumBoldBlackText,
//                     ),
//                     GestureDetector(
//                       onTap: variantsController.toggleAddonsExpanded,
//                       child: Icon(
//                         variantsController.isAddonsExpanded.value
//                             ? Icons.expand_less
//                             : Icons.expand_more,
//                         color: Colors.grey.shade600,
//                         size: 32,
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//               if (variantsController.isAddonsExpanded.value)
//                 ListView.builder(
//                   shrinkWrap: true,
//                   physics: NeverScrollableScrollPhysics(),
//                   itemCount: variantsController.addOns.length,
//                   itemBuilder: (context, index) {
//                     final addOn = variantsController.addOns[index];
//                     return Padding(
//                       padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
//                       child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                          Text(
//                              addOn['addOnsGroupName'],
//                             style: CustomTextStyle.addonText,
//                           ),
//                           SizedBox(height: 5,),
//                           ListView.separated(
//                           separatorBuilder: (context, index) {
//                             return SizedBox(height: 10,);
//                           },
//                           shrinkWrap: true,
//                           itemCount: addOn["addOnsType"].length,
//                           physics: NeverScrollableScrollPhysics(),
//                             itemBuilder: ( context,  indextwo) { 
//                             final addOntypeindex = addOn["addOnsType"][indextwo];
//                             return  Row(
//                               children: [
//                                 Image.asset(
//                                 addOntypeindex['type'] == 'veg'? 'assets/images/veg.png': addOntypeindex['type'] == 'egg'? 'assets/images/egg.jpg': 'assets/images/nonveg.png',
//                                  width: 20,
//                                   height: 20,),
      
//                                 SizedBox(width: 20),
//                                 // Text(
//                                 //   addOntypeindex['variantName'],
//                                 //   style: CustomTextStyle.categoryBlackText,
//                                 // ),
//                                 // Spacer(),
//                                  // Wrap Text with Flexible to prevent overflow
//                                   SizedBox(
//                                   width: MediaQuery.of(context).size.width/2,
//                                   child: Text(
//                                   addOntypeindex['variantName'],
//                                   style: CustomTextStyle.categoryBlackText,
//                                    overflow: TextOverflow.clip,),),
//                                   Spacer(),
      
//                                 Text(
//                                   addOntypeindex['customerPrice'].toString(),
//                                   style: CustomTextStyle.categoryBlackText,
//                                 ),
//                               ],
//                             );
                         
//                              },
//                             ),
//                         ],
//                       ),
//                     );
//                   },
//                 ),
//             ],
//           ),
//         ),
//       );
//     });
//   }
// }


class AddonsDisplayComponent extends StatefulWidget {
  const AddonsDisplayComponent({super.key});

  @override
  State<AddonsDisplayComponent> createState() => _AddonsDisplayComponentState();
}

class _AddonsDisplayComponentState extends State<AddonsDisplayComponent> {
 final VariantsController variantsController = Get.put(VariantsController());

@override
  void initState() {
    super.initState();
    variantsController.isAddonsExpanded.value = true; // Always open initially
  }
  @override
  Widget build(BuildContext context) {
      return Obx(() {
      if (variantsController.addOns.isEmpty) {
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
                      'Add-ons',
                      style: CustomTextStyle.mediumBoldBlackText,
                    ),
                    GestureDetector(
                      onTap: variantsController.toggleAddonsExpanded,
                      child: Icon(
                        variantsController.isAddonsExpanded.value
                            ? Icons.expand_less
                            : Icons.expand_more,
                        color: Colors.grey.shade600,
                        size: 32,
                      ),
                    ),
                  ],
                ),
              ),
              if (variantsController.isAddonsExpanded.value)
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: variantsController.addOns.length,
                  itemBuilder: (context, index) {
                    final addOn = variantsController.addOns[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                      child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                         Text(
                             addOn['addOnsGroupName'],
                            style: CustomTextStyle.mediumBoldBlackText,
                          ),
                          SizedBox(height: 5,),
                          ListView.separated(
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 10,);
                          },
                          shrinkWrap: true,
                          itemCount: addOn["addOnsType"].length,
                          physics: NeverScrollableScrollPhysics(),
                            itemBuilder: ( context,  indextwo) { 
                            final addOntypeindex = addOn["addOnsType"][indextwo];
                            return  Row(
                              children: [
                                Image.asset(
                                addOntypeindex['type'] == 'veg'? 'assets/images/veg.png': addOntypeindex['type'] == 'egg'? 'assets/images/egg.jpg': 'assets/images/nonveg.png',
                                 width: 20,
                                  height: 20,),
      
                                SizedBox(width: 20),
                                // Text(
                                //   addOntypeindex['variantName'],
                                //   style: CustomTextStyle.categoryBlackText,
                                // ),
                                // Spacer(),
                                 // Wrap Text with Flexible to prevent overflow
                                  SizedBox(
                                  width: MediaQuery.of(context).size.width/2,
                                  child: Text(
                                  addOntypeindex['variantName'],
                                  style: CustomTextStyle.categoryBlackText,
                                   overflow: TextOverflow.clip,),),
                                  Spacer(),
      
                                Text(
                                  addOntypeindex['basePrice'].toString(),
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
  
  }
}