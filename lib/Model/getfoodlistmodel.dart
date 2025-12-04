// To parse this JSON data, do
//
//     final foodList = foodListFromJson(jsonString);

import 'dart:convert';

FoodList foodListFromJson(String str) => FoodList.fromJson(json.decode(str));

String foodListToJson(FoodList data) => json.encode(data.toJson());

class FoodList {
    int code;
    bool status;
    String message;
    Data data;

    FoodList({
     required   this.code,
     required   this.status,
      required  this.message,
      required  this.data,
    });

    factory FoodList.fromJson(Map<String, dynamic> json) => FoodList(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    int totalCount;
    int fetchCount;
    List<Datum> data;

    Data({
      required  this.totalCount,
      required  this.fetchCount,
       required this.data,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        totalCount: json["totalCount"],
        fetchCount: json["fetchCount"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "totalCount": totalCount,
        "fetchCount": fetchCount,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
    };
}

class Datum {
    String? id;
    String? foodName;
    dynamic foodCategoryName;
    dynamic foodRestaurantName;
    String? foodImgUrl;
    List<String>? additionalImage;
    String? foodType;
    String? foodDiscription;
    String? foodCategoryId;
    String? foodCusineTypeId;
    String? restaurantId;
    List<String>? ingredients;
    bool? status;
    bool? iscustomizable;
    List<AvailableTiming>? availableTimings;
    String? preparationTime;
    Food? food;
    CustomizedFood? customizedFood;
    bool? isRecommended;
    FoodCategoryDetails? foodCategoryDetails;
    FoodCusineDetails? foodCusineDetails;

    Datum({
        this.id,
        this.foodName,
        this.foodCategoryName,
        this.foodRestaurantName,
        this.foodImgUrl,
        this.additionalImage,
        this.foodType,
        this.foodDiscription,
        this.foodCategoryId,
        this.foodCusineTypeId,
        this.restaurantId,
        this.ingredients,
        this.status,
        this.iscustomizable,
        this.availableTimings,
        this.preparationTime,
        this.food,
        this.customizedFood,
        this.isRecommended,
        this.foodCategoryDetails,
        this.foodCusineDetails,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        foodName: json["foodName"],
        foodCategoryName: json["foodCategoryName"],
        foodRestaurantName: json["foodRestaurantName"],
        foodImgUrl: json["foodImgUrl"],
        additionalImage: List<String>.from(json["additionalImage"].map((x) => x)),
        foodType: json["foodType"],
        foodDiscription: json["foodDiscription"],
        foodCategoryId: json["foodCategoryId"],
        foodCusineTypeId: json["foodCusineTypeId"],
        restaurantId: json["restaurantId"],
        ingredients: List<String>.from(json["ingredients"].map((x) => x)),
        status: json["status"],
        iscustomizable: json["iscustomizable"],
        availableTimings: List<AvailableTiming>.from(json["availableTimings"].map((x) => AvailableTiming.fromJson(x))),
        preparationTime: json["preparationTime"],
        food: Food.fromJson(json["food"]),
        customizedFood: CustomizedFood.fromJson(json["customizedFood"]),
        isRecommended: json["isRecommended"],
        foodCategoryDetails: json["foodCategoryDetails"] == null
        ? null
        : FoodCategoryDetails.fromJson(json["foodCategoryDetails"]),
         foodCusineDetails: json["foodCusineDetails"] == null
        ? null
        : FoodCusineDetails.fromJson(json["foodCusineDetails"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "foodName": foodName,
        "foodCategoryName": foodCategoryName,
        "foodRestaurantName": foodRestaurantName,
        "foodImgUrl": foodImgUrl,
        "additionalImage": List<dynamic>.from(additionalImage!.map((x) => x)),
        "foodType": foodType,
        "foodDiscription": foodDiscription,
        "foodCategoryId": foodCategoryId,
        "foodCusineTypeId": foodCusineTypeId,
        "restaurantId": restaurantId,
        "ingredients": List<dynamic>.from(ingredients!.map((x) => x)),
        "status": status,
        "iscustomizable": iscustomizable,
        "availableTimings": List<dynamic>.from(availableTimings!.map((x) => x.toJson())),
        "preparationTime": preparationTime,
        "food": food!.toJson(),
        "customizedFood": customizedFood!.toJson(),
        "isRecommended": isRecommended,
        "foodCategoryDetails": foodCategoryDetails!.toJson(),
        "foodCusineDetails": foodCusineDetails!.toJson(),
    };
}

class AvailableTiming {
    String? type;
    String? from;
    String? to;
    bool? checked;

    AvailableTiming({
        this.type,
        this.from,
        this.to,
        this.checked,
    });

    factory AvailableTiming.fromJson(Map<String, dynamic> json) => AvailableTiming(
        type: json["type"]  as String,
        from: json["from"] as String,
        to: json["to"]as String,
        checked: json["checked"] as bool
    );

    Map<String, dynamic> toJson() => {
        "type": type,
        "from": from,
        "to": to,
        "checked": checked,
    };
}

class CustomizedFood {
    List<AddVariant>? addVariants;
    List<AddOn>? addOns;

    CustomizedFood({
        this.addVariants,
        this.addOns,
    });

    factory CustomizedFood.fromJson(Map<String, dynamic> json) => CustomizedFood(
        addVariants: List<AddVariant>.from(json["addVariants"].map((x) => AddVariant.fromJson(x))),
        addOns: List<AddOn>.from(json["addOns"].map((x) => AddOn.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "addVariants": List<dynamic>.from(addVariants!.map((x) => x.toJson())),
        "addOns": List<dynamic>.from(addOns!.map((x) => x.toJson())),
    };
}

class AddOn {
    String? addOnsGroupName;
    List<Type>? addOnsType;
    String? id;

    AddOn({
        this.addOnsGroupName,
        this.addOnsType,
        this.id,
    });

    factory AddOn.fromJson(Map<String, dynamic> json) => AddOn(
        addOnsGroupName: json["addOnsGroupName"],
        addOnsType: List<Type>.from(json["addOnsType"].map((x) => Type.fromJson(x))),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "addOnsGroupName": addOnsGroupName,
        "addOnsType": List<dynamic>.from(addOnsType!.map((x) => x.toJson())),
        "_id": id,
    };
}

class Type {
    String? variantName;
    String? variantImage;
    List<String>? additionalImage;
    String? type;
    int? basePrice;
    int? customerPrice;
    int? totalPrice;
    bool? deleted;
    bool? status;
    String? id;

    Type({
        this.variantName,
        this.variantImage,
        this.additionalImage,
        this.type,
        this.basePrice,
        this.customerPrice,
        this.totalPrice,
        this.deleted,
        this.status,
        this.id,
    });

    factory Type.fromJson(Map<String, dynamic> json) => Type(
        variantName: json["variantName"],
        variantImage: json["variantImage"],
        additionalImage: List<String>.from(json["additionalImage"].map((x) => x)),
        type: json["type"],
        basePrice: json["basePrice"],
        customerPrice: json["customerPrice"],
        totalPrice: json["totalPrice"],
        deleted: json["deleted"],
        status: json["status"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "variantName": variantName,
        "variantImage": variantImage,
        "additionalImage": List<dynamic>.from(additionalImage!.map((x) => x)),
        "type": type,
        "basePrice": basePrice,
        "customerPrice": customerPrice,
        "totalPrice": totalPrice,
        "deleted": deleted,
        "status": status,
        "_id": id,
    };
}

class AddVariant {
    String? variantGroupName;
    List<Type>? variantType;
    String? id;

    AddVariant({
        this.variantGroupName,
        this.variantType,
        this.id,
    });

    factory AddVariant.fromJson(Map<String, dynamic> json) => AddVariant(
        variantGroupName: json["variantGroupName"],
        variantType: List<Type>.from(json["variantType"].map((x) => Type.fromJson(x))),
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "variantGroupName": variantGroupName,
        "variantType": List<dynamic>.from(variantType!.map((x) => x.toJson())),
        "_id": id,
    };
}

class Food {
    String? unit;
    int? basePrice;
    int? customerPrice;
    int? packagingCharge;
    int? totalPrice;
    String? discount;
    String? gst;
    String? sgst;
    String? cgst;

    Food({
        this.unit,
        this.basePrice,
        this.customerPrice,
        this.packagingCharge,
        this.totalPrice,
        this.discount,
        this.gst,
        this.sgst,
        this.cgst,
    });

    factory Food.fromJson(Map<String, dynamic> json) => Food(
        unit: json["unit"],
        basePrice: json["basePrice"],
        customerPrice: json["customerPrice"],
        packagingCharge: json["packagingCharge"],
        totalPrice: json["totalPrice"],
        discount: json["discount"],
        gst: json["GST"],
        sgst: json["SGST"],
        cgst: json["CGST"],
    );

    Map<String, dynamic> toJson() => {
        "unit": unit,
        "basePrice": basePrice,
        "customerPrice": customerPrice,
        "packagingCharge": packagingCharge,
        "totalPrice": totalPrice,
        "discount": discount,
        "GST": gst,
        "SGST": sgst,
        "CGST": cgst,
    };
}

class FoodCategoryDetails {
    String? id;
    String? foodCateName;
    String? foodCateImage;
    List<dynamic>? foodCateAdditionalImg;
    dynamic foodCateTitle;
    dynamic foodCateDescription;
    bool? status;
    bool? deleted;

    FoodCategoryDetails({
        this.id,
        this.foodCateName,
        this.foodCateImage,
        this.foodCateAdditionalImg,
        this.foodCateTitle,
        this.foodCateDescription,
        this.status,
        this.deleted,
    });

    factory FoodCategoryDetails.fromJson(Map<String, dynamic> json) => FoodCategoryDetails(
        id: json["_id"],
        foodCateName: json["foodCateName"],
        foodCateImage: json["foodCateImage"],
        foodCateAdditionalImg: List<dynamic>.from(json["foodCateAdditionalImg"].map((x) => x)),
        foodCateTitle: json["foodCateTitle"],
        foodCateDescription: json["foodCateDescription"],
        status: json["status"],
        deleted: json["deleted"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "foodCateName": foodCateName,
        "foodCateImage": foodCateImage,
        "foodCateAdditionalImg": List<dynamic>.from(foodCateAdditionalImg!.map((x) => x)),
        "foodCateTitle": foodCateTitle,
        "foodCateDescription": foodCateDescription,
        "status": status,
        "deleted": deleted,
    };
}
class FoodCusineDetails {
    String? id;
    String? foodCusineName;
    String? foodCusineImage;

    FoodCusineDetails({
        this.id,
        this.foodCusineName,
        this.foodCusineImage,
    });

    factory FoodCusineDetails.fromJson(Map<String, dynamic> json) => FoodCusineDetails(
        id: json["_id"],
        foodCusineName: json["foodCusineName"],
        foodCusineImage: json["foodCusineImage"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "foodCusineName": foodCusineName,
        "foodCusineImage": foodCusineImage,
    };
}

