import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miogra_seller/Screens/Menu/additemscreen.dart';
import 'package:miogra_seller/Screens/Menu/addonsscreen.dart';
import 'package:miogra_seller/Screens/Menu/editItemScreen.dart';
import 'package:miogra_seller/Screens/Menu/variantsscreen.dart';
import 'package:miogra_seller/Widgets/custom_gradienttext.dart';
import 'package:miogra_seller/Widgets/custom_textstyle.dart';

class CustomizationScreen extends StatefulWidget {
  final dynamic foodsListIndex;
  final String? FoodCatid;
  final String? FoodCat;
   final String? variantCateName;
  final bool isEdit;
  final List<Variant>? variants;
  final List<Map<String, dynamic>>? updatedvariants;
   final List<Map<String, dynamic>>? updatedaddOns;
  const CustomizationScreen({
    super.key,
      this.updatedvariants,
      this.updatedaddOns,
    this.foodsListIndex,
    this.isEdit = false,
    this.FoodCatid,
    this.FoodCat,  this.variants, this.variantCateName,
  });

  @override
  State<CustomizationScreen> createState() => _CustomizationScreenState();
}

class _CustomizationScreenState extends State<CustomizationScreen> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
       if (widget.isEdit == true){
        Get.off(
        EditItemScreen(
        isFromAddonscreen: false,
        isFromVariantscreen: false,
           variantGroupName: widget.variantCateName,
            foodCateId: widget.FoodCatid,
            foodCat: widget.FoodCat,
            foodsListIndex: widget.foodsListIndex,
            updatedvariants: widget.updatedvariants,
            updatedAddOns: widget.updatedaddOns,
          ));
       }else{
         Get.off(
       AddItemScreen(
            FoodCat: widget.FoodCat,
            FoodCatid: widget.FoodCatid,
            foodsListIndex: widget.foodsListIndex,
             updatedvariants: widget.updatedvariants,
             updatedAddOns: widget.updatedaddOns,
          ));
       }
     
    },
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          appBar: AppBar(
          centerTitle: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.grey.shade600),
              onPressed: () {
               print("bjhsbvgs ${widget.variantCateName}");
                   if (widget.isEdit == true) {
                   print("bjhsbvgs ${widget.variantCateName}");
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => EditItemScreen(
          isFromAddonscreen: false,
           variantGroupName: widget.variantCateName,
            foodCateId: widget.FoodCatid,
            foodCat: widget.FoodCat,
            foodsListIndex: widget.foodsListIndex,
            updatedvariants: widget.updatedvariants,
            updatedAddOns: widget.updatedaddOns,
          ),
        ),
      );
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => AddItemScreen(
            FoodCat: widget.FoodCat,
            FoodCatid: widget.FoodCatid,
            foodsListIndex: widget.foodsListIndex,
           updatedvariants: widget.updatedvariants,
           updatedAddOns: widget.updatedaddOns,
          ),
        ),
      );
    }
              },
            ),
            title: InkWell(
            onTap: (){
             print("bjhsbvgs ${widget.variantCateName}");
            },
              child: GradientText(
                text: 'Customization',
                style: CustomTextStyle.smallOrangeText,
                gradient: const LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    Color(0xFFF98322), // Start color
                    Color(0xFFEE4C46), // End color
                  ],
                ),
              ),
            ),
          ),
          body: Column(
            children: [
              TabBar(
                tabs: const [
                  Tab(text: 'Variants'),
                  Tab(text: 'Add-Ons'),
                ],
                indicator: UnderlineTabIndicator(
                  borderSide: const BorderSide(
                    color: Color(0xFFF98322), // Indicator color
                    width: 2.0,
                  ),
                  insets: EdgeInsets.symmetric(horizontal: screenWidth / 4),
                ),
                labelColor: Colors.black,
                unselectedLabelColor: Colors.grey,
              ),
              const SizedBox(height: 10),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildVariantsTab(),
                    _buildAddOnsTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildVariantsTab() {
    return VariantsScreen(
    returnedupdatedaddons: widget.updatedaddOns,
    returnedupdatedvariants: widget.updatedvariants,
      foodsListIndex: widget.foodsListIndex,
      foodCatid: widget.FoodCatid,
      foodCat: widget.FoodCat,
      isEdit: widget.isEdit,
      variants:widget.variants,
    );
  }

  Widget _buildAddOnsTab() {
    return AddOnsScreen(
    returnedupdatedvariants:widget.updatedvariants ,
    returnedupdatedaddons: widget.updatedaddOns,
    variantGroupName:widget.variantCateName,
      foodsListIndex: widget.foodsListIndex,
      foodCatid: widget.FoodCatid,
      foodCat: widget.FoodCat,
      isEdit: widget.isEdit,
      variants:widget.variants,
    );
  }
}
