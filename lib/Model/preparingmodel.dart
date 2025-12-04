// To parse this JSON data, do
//
//     final preparing = preparingFromJson(jsonString);

import 'dart:convert';

Preparing preparingFromJson(String str) => Preparing.fromJson(json.decode(str));

String preparingToJson(Preparing data) => json.encode(data.toJson());

class Preparing {
    int code;
    bool status;
    String message;
    Data data;

    Preparing({
      required  this.code,
      required  this.status,
      required  this.message,
      required  this.data,
    });

    factory Preparing.fromJson(Map<String, dynamic> json) => Preparing(
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
       required this.totalCount,
       required this.fetchCount,
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
    dynamic name;
    String? deliveryType;
    List<dynamic>? selectedPackage;
    List<String>? shareUserIds;
    List<PAddress>? pickupAddress;
    List<PAddress>? dropAddress;
    String? orderStatus;
    String? orderCode;
    String? userId;
    String? subAdminId;
    String? subAdminType;
    String? vendorAdminId;
    String? productCategoryId;
    dynamic assignedToId;
    dynamic createdById;
    List<dynamic>? cartId;
    dynamic couponId;
    String? type;
    String? paymentMethod;
    String? payType;
    List<OrdersDetail>? ordersDetails;
    ParcelDetails? parcelDetails;
    AmountDetails? amountDetails;
    DateTime? newAt;
    dynamic assignedAt;
    dynamic inProgressAt;
    dynamic pickUpedAt;
    dynamic deliverymanReachedDoorAt;
    dynamic deliveredAt;
    dynamic cancelledAt;
    dynamic rejectedAt;
    String? discountAmount;
    double? totalKms;
    String? baseKm;
    bool? deleted;
    bool? billGenerated;
    dynamic invoicePath;
    List<dynamic>? files;
    List<dynamic>? instructions;
    String? additionalInstructions;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;
    PaymentDetails? paymentDetails;
    List<dynamic>? ratings;

    Datum({
        this.id,
        this.name,
        this.deliveryType,
        this.selectedPackage,
        this.shareUserIds,
        this.pickupAddress,
        this.dropAddress,
        this.orderStatus,
        this.orderCode,
        this.userId,
        this.subAdminId,
        this.subAdminType,
        this.vendorAdminId,
        this.productCategoryId,
        this.assignedToId,
        this.createdById,
        this.cartId,
        this.couponId,
        this.type,
        this.paymentMethod,
        this.payType,
        this.ordersDetails,
        this.parcelDetails,
        this.amountDetails,
        this.newAt,
        this.assignedAt,
        this.inProgressAt,
        this.pickUpedAt,
        this.deliverymanReachedDoorAt,
        this.deliveredAt,
        this.cancelledAt,
        this.rejectedAt,
        this.discountAmount,
        this.totalKms,
        this.baseKm,
        this.deleted,
        this.billGenerated,
        this.invoicePath,
        this.files,
        this.instructions,
        this.additionalInstructions,
        this.createdAt,
        this.updatedAt,
        this.v,
        this.paymentDetails,
        this.ratings,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["_id"],
        name: json["name"],
        deliveryType: json["deliveryType"],
        selectedPackage: List<dynamic>.from(json["selectedPackage"].map((x) => x)),
        shareUserIds: List<String>.from(json["shareUserIds"].map((x) => x)),
        pickupAddress: List<PAddress>.from(json["pickupAddress"].map((x) => PAddress.fromJson(x))),
        dropAddress: List<PAddress>.from(json["dropAddress"].map((x) => PAddress.fromJson(x))),
        orderStatus: json["orderStatus"],
        orderCode: json["orderCode"],
        userId: json["userId"],
        subAdminId: json["subAdminId"],
        subAdminType: json["subAdminType"],
        vendorAdminId: json["vendorAdminId"],
        productCategoryId: json["productCategoryId"],
        assignedToId: json["assignedToId"],
        createdById: json["createdById"],
        cartId: List<dynamic>.from(json["cartId"].map((x) => x)),
        couponId: json["couponId"],
        type: json["type"],
        paymentMethod: json["paymentMethod"],
        payType: json["payType"],
        ordersDetails: List<OrdersDetail>.from(json["ordersDetails"].map((x) => OrdersDetail.fromJson(x))),
        parcelDetails: ParcelDetails.fromJson(json["parcelDetails"]),
        amountDetails: AmountDetails.fromJson(json["amountDetails"]),
        newAt: DateTime.parse(json["newAt"]),
        assignedAt: json["assignedAt"],
        inProgressAt: json["inProgressAt"],
        pickUpedAt: json["pickUpedAt"],
        deliverymanReachedDoorAt: json["deliverymanReachedDoorAt"],
        deliveredAt: json["deliveredAt"],
        cancelledAt: json["cancelledAt"],
        rejectedAt: json["rejectedAt"],
        discountAmount: json["discountAmount"],
        totalKms: json["totalKms"].toDouble(),
        baseKm: json["baseKm"],
        deleted: json["deleted"],
        billGenerated: json["billGenerated"],
        invoicePath: json["invoicePath"],
        files: List<dynamic>.from(json["files"].map((x) => x)),
        instructions: List<dynamic>.from(json["instructions"].map((x) => x)),
        additionalInstructions: json["additionalInstructions"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        paymentDetails: PaymentDetails.fromJson(json["paymentDetails"]),
        ratings: List<dynamic>.from(json["ratings"].map((x) => x)),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "deliveryType": deliveryType,
        "selectedPackage": List<dynamic>.from(selectedPackage!.map((x) => x)),
        "shareUserIds": List<dynamic>.from(shareUserIds!.map((x) => x)),
        "pickupAddress": List<dynamic>.from(pickupAddress!.map((x) => x.toJson())),
        "dropAddress": List<dynamic>.from(dropAddress!.map((x) => x.toJson())),
        "orderStatus": orderStatus,
        "orderCode": orderCode,
        "userId": userId,
        "subAdminId": subAdminId,
        "subAdminType": subAdminType,
        "vendorAdminId": vendorAdminId,
        "productCategoryId": productCategoryId,
        "assignedToId": assignedToId,
        "createdById": createdById,
        "cartId": List<dynamic>.from(cartId!.map((x) => x)),
        "couponId": couponId,
        "type": type,
        "paymentMethod": paymentMethod,
        "payType": payType,
        "ordersDetails": List<dynamic>.from(ordersDetails!.map((x) => x.toJson())),
        "parcelDetails": parcelDetails!.toJson(),
        "amountDetails": amountDetails!.toJson(),
        "newAt": newAt!.toIso8601String(),
        "assignedAt": assignedAt,
        "inProgressAt": inProgressAt,
        "pickUpedAt": pickUpedAt,
        "deliverymanReachedDoorAt": deliverymanReachedDoorAt,
        "deliveredAt": deliveredAt,
        "cancelledAt": cancelledAt,
        "rejectedAt": rejectedAt,
        "discountAmount": discountAmount,
        "totalKms": totalKms,
        "baseKm": baseKm,
        "deleted": deleted,
        "billGenerated": billGenerated,
        "invoicePath": invoicePath,
        "files": List<dynamic>.from(files!.map((x) => x)),
        "instructions": List<dynamic>.from(instructions!.map((x) => x)),
        "additionalInstructions": additionalInstructions,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
        "paymentDetails": paymentDetails!.toJson(),
        "ratings": List<dynamic>.from(ratings!.map((x) => x)),
    };
}

class AmountDetails {
   dynamic cartAmount;
    dynamic cartFoodAmount;
      dynamic cartFoodAmountWithoutCoupon;
    dynamic couponsAmount;
      dynamic orderBasicAmount;
    dynamic packingCharges;
      dynamic deliveryCharges;
    dynamic tax;
      dynamic finalAmount;
    dynamic couponType;

    AmountDetails({
   required this.cartAmount,
   required this.cartFoodAmount,
   required   this.cartFoodAmountWithoutCoupon,
   required this.couponsAmount,
    required  this.orderBasicAmount,
   required this.packingCharges,
    required this.deliveryCharges,
   required this.tax,
   required   this.finalAmount,
   required this.couponType
    });

    factory AmountDetails.fromJson(Map<String, dynamic> json) => AmountDetails(
        cartAmount: json["cartAmount"],
        cartFoodAmount: json["cartFoodAmount"],
        cartFoodAmountWithoutCoupon: json["cartFoodAmountWithoutCoupon"],
        couponsAmount: json["couponsAmount"],
        orderBasicAmount: json["orderBasicAmount"],
         packingCharges: json["packingCharges"],
        deliveryCharges: json["deliveryCharges"],
        tax: json["tax"],
        finalAmount: json["finalAmount"],
        couponType: json["couponType"],
    );

    Map<String, dynamic> toJson() => {
        "cartAmount": cartAmount,
        "cartFoodAmount": cartFoodAmount,
        "cartFoodAmountWithoutCoupon": cartFoodAmountWithoutCoupon,
        "couponsAmount": couponsAmount,
        "orderBasicAmount": orderBasicAmount,
         "packingCharges": packingCharges,
        "deliveryCharges": deliveryCharges,
        "tax": tax,
        "finalAmount": finalAmount,
        "couponType": couponType,
    };
}

class PAddress {
    String? name;
    dynamic addressId;
    String? userType;
    String? houseNo;
    String? locality;
    String? landMark;
    String? fullAddress;
    String? street;
    String? city;
    dynamic district;
    String? state;
    String? country;
    String? postalCode;
    String? contactType;
    String? contactPerson;
    String? contactPersonNumber;
    String? addressType;
    double? latitude;
    double? longitude;
    bool? delivered;

    PAddress({
        this.name,
        this.addressId,
        this.userType,
        this.houseNo,
        this.locality,
        this.landMark,
        this.fullAddress,
        this.street,
        this.city,
        this.district,
        this.state,
        this.country,
        this.postalCode,
        this.contactType,
        this.contactPerson,
        this.contactPersonNumber,
        this.addressType,
        this.latitude,
        this.longitude,
        this.delivered,
    });

    factory PAddress.fromJson(Map<String, dynamic> json) => PAddress(
        name: json["name"],
        addressId: json["addressId"],
        userType: json["userType"],
        houseNo: json["houseNo"],
        locality: json["locality"],
        landMark: json["landMark"],
        fullAddress: json["fullAddress"],
        street: json["street"],
        city: json["city"],
        district: json["district"],
        state: json["state"],
        country: json["country"],
        postalCode: json["postalCode"],
        contactType: json["contactType"],
        contactPerson: json["contactPerson"],
        contactPersonNumber: json["contactPersonNumber"],
        addressType: json["addressType"],
        latitude: json["latitude"].toDouble(),
        longitude: json["longitude"].toDouble(),
        delivered: json["delivered"],
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "addressId": addressId,
        "userType": userType,
        "houseNo": houseNo,
        "locality": locality,
        "landMark": landMark,
        "fullAddress": fullAddress,
        "street": street,
        "city": city,
        "district": district,
        "state": state,
        "country": country,
        "postalCode": postalCode,
        "contactType": contactType,
        "contactPerson": contactPerson,
        "contactPersonNumber": contactPersonNumber,
        "addressType": addressType,
        "latitude": latitude,
        "longitude": longitude,
        "delivered": delivered,
    };
}

class OrdersDetail {
    String? productType;
    String? description;
    String? foodId;
    String? foodName;
    String? foodType;
    String? foodImage;
    String? quantity;
    int? foodPrice;
    int? totalPrice;
    String? id;

    OrdersDetail({
        this.productType,
        this.description,
        this.foodId,
        this.foodName,
        this.foodType,
        this.foodImage,
        this.quantity,
        this.foodPrice,
        this.totalPrice,
        this.id,
    });

    factory OrdersDetail.fromJson(Map<String, dynamic> json) => OrdersDetail(
        productType: json["productType"],
        description: json["description"],
        foodId: json["foodId"],
        foodName: json["foodName"],
        foodType: json["foodType"],
        foodImage: json["foodImage"],
        quantity: json["quantity"],
        foodPrice: json["foodPrice"],
        totalPrice: json["totalPrice"],
        id: json["_id"],
    );

    Map<String, dynamic> toJson() => {
        "productType": productType,
        "description": description,
        "foodId": foodId,
        "foodName": foodName,
        "foodType": foodType,
        "foodImage": foodImage,
        "quantity": quantity,
        "foodPrice": foodPrice,
        "totalPrice": totalPrice,
        "_id": id,
    };
}

class ParcelDetails {
    dynamic value;
    dynamic packageType;
    dynamic otherType;
    dynamic packageImage;
    String? parcelTripType;

    ParcelDetails({
        this.value,
        this.packageType,
        this.otherType,
        this.packageImage,
        this.parcelTripType,
    });

    factory ParcelDetails.fromJson(Map<String, dynamic> json) => ParcelDetails(
        value: json["value"],
        packageType: json["packageType"],
        otherType: json["otherType"],
        packageImage: json["packageImage"],
        parcelTripType: json["parcelTripType"],
    );

    Map<String, dynamic> toJson() => {
        "value": value,
        "packageType": packageType,
        "otherType": otherType,
        "packageImage": packageImage,
        "parcelTripType": parcelTripType,
    };
}

class PaymentDetails {
    String? id;
    List<String>? orderId;
    List<dynamic>? cartId;
    dynamic subscriptionId;
    String? paymentStatus;
    int? paymentAmount;
    String? currency;
    String? paymentMode;
    String? paymentFrom;
    dynamic copCompletedAt;
    dynamic codCompletedAt;
    dynamic razorPayPaymentId;
    dynamic razorPayRefundId;
    dynamic razorpayOrderId;
    dynamic razorpaySignature;
    DateTime? createdAt;
    DateTime? updatedAt;
    int? v;

    PaymentDetails({
        this.id,
        this.orderId,
        this.cartId,
        this.subscriptionId,
        this.paymentStatus,
        this.paymentAmount,
        this.currency,
        this.paymentMode,
        this.paymentFrom,
        this.copCompletedAt,
        this.codCompletedAt,
        this.razorPayPaymentId,
        this.razorPayRefundId,
        this.razorpayOrderId,
        this.razorpaySignature,
        this.createdAt,
        this.updatedAt,
        this.v,
    });

    factory PaymentDetails.fromJson(Map<String, dynamic> json) => PaymentDetails(
        id: json["_id"],
        orderId: List<String>.from(json["orderId"].map((x) => x)),
        cartId: List<dynamic>.from(json["cartId"].map((x) => x)),
        subscriptionId: json["subscriptionId"],
        paymentStatus: json["paymentStatus"],
        paymentAmount: json["paymentAmount"],
        currency: json["currency"],
        paymentMode: json["paymentMode"],
        paymentFrom: json["paymentFrom"],
        copCompletedAt: json["copCompletedAt"],
        codCompletedAt: json["codCompletedAt"],
        razorPayPaymentId: json["razorPayPaymentId"],
        razorPayRefundId: json["razorPayRefundId"],
        razorpayOrderId: json["razorpayOrderId"],
        razorpaySignature: json["razorpaySignature"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "orderId": List<dynamic>.from(orderId!.map((x) => x)),
        "cartId": List<dynamic>.from(cartId!.map((x) => x)),
        "subscriptionId": subscriptionId,
        "paymentStatus": paymentStatus,
        "paymentAmount": paymentAmount,
        "currency": currency,
        "paymentMode": paymentMode,
        "paymentFrom": paymentFrom,
        "copCompletedAt": copCompletedAt,
        "codCompletedAt": codCompletedAt,
        "razorPayPaymentId": razorPayPaymentId,
        "razorPayRefundId": razorPayRefundId,
        "razorpayOrderId": razorpayOrderId,
        "razorpaySignature": razorpaySignature,
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
        "__v": v,
    };
}