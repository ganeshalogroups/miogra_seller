import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:miogra_seller/Screens/Menu/variantsscreen.dart';

class VariantsController extends GetxController {
  // Reactive Observables
  var variants = <Map<String, dynamic>>[].obs; // For single variants
  var groupVariants = <List<Map<String, dynamic>>>[].obs; // For grouped variants
  var addongroupNames = <String>[].obs; // For group names
  var isVariantExpanded = false.obs; // To track if the variant list is expanded
  var isAddonsExpanded = false.obs; // To track if the add-ons list is expanded
  var addOns = <Map<String, dynamic>>[].obs;
  var variantList = <Map<String, dynamic>>[].obs;
  // Initialize controller with data from arguments
 void initialize({
  required List<Variant>? initialVariants,
  required List<List<Map<String, String>>>? initialGroupVariants,
  required List<String>? initialGroupNames,
  
}) {
     WidgetsBinding.instance.addPostFrameCallback((_) {
    if (initialVariants != null) {
      // Create a new list to store updated variants
      List<Map<String, dynamic>> updatedVariants = [];

      for (var variant in initialVariants) {
        updatedVariants.add({
          'name': variant.name,
          'price': variant.price.toString(),
        });
      }

      // Replace the entire variants list with updated values
      variants.assignAll(updatedVariants);
      print("updated variants: ${updatedVariants}");
    }

    // Add grouped variants only if they are not already in the list
    if (initialGroupVariants != null) {
      groupVariants.clear(); // Reset all to avoid duplication
      for (var group in initialGroupVariants) {
        if (!groupVariants.contains(group)) {
          groupVariants.add(group.cast<Map<String, dynamic>>());
        }
      }
      print("initialGroupVariants:${initialGroupVariants}");
    }
    // Add group names only if they are not already in the list
    if (initialGroupNames != null) {
      addongroupNames.clear(); // Reset all to avoid duplication
      for (var groupName in initialGroupNames) {
        if (!addongroupNames.contains(groupName)) {
          addongroupNames.add(groupName);
        }
      }
        print("addongroupNames in : VariantsController:${addongroupNames}");
    }
  });
}
// **New AddOns Method**
 void initializeAddOns(dynamic initialAddOns) { 
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (initialAddOns != null && initialAddOns.isNotEmpty) {
      addOns.assignAll(initialAddOns);
      print("initialAddOns: ${initialAddOns}");
    }
  });
}

// **New Variant Method**
 void initializevariant(dynamic initialvariant) { 
  WidgetsBinding.instance.addPostFrameCallback((_) {
    if (initialvariant != null && initialvariant.isNotEmpty) {
      variantList.assignAll(initialvariant);
      print("initialvariants: ${initialvariant}");
    }
  });
}

  // Toggle expansion
  void toggleVariantExpanded() {
    isVariantExpanded.value = !isVariantExpanded.value;
  }

  void toggleAddonsExpanded() {
    isAddonsExpanded.value = !isAddonsExpanded.value;
  }
}
