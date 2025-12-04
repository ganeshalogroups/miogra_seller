// To parse this JSON data, do
//
//     final pickedUp = pickedUpFromJson(jsonString);

import 'dart:convert';

PickedUp pickedUpFromJson(String str) => PickedUp.fromJson(json.decode(str));

String pickedUpToJson(PickedUp data) => json.encode(data.toJson());

class PickedUp {
    int code;
    bool status;
    String message;
    Data data;

    PickedUp({
      required  this.code,
       required this.status,
       required this.message,
       required this.data,
    });

    factory PickedUp.fromJson(Map<String, dynamic> json) => PickedUp(
        code: json["code"],
        status: json["status"],
        message: json["message"],
        data: Data.fromJson(json["data"] ),
    );

    Map<String, dynamic> toJson() => {
        "code": code,
        "status": status,
        "message": message,
        "data": data.toJson(),
    };
}

class Data {
    dynamic totalCount;
    dynamic fetchCount;
    List<Datum> data;

    Data({
      required  this.totalCount,
      required  this.fetchCount,
      required  this.data,
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
    dynamic id;
    dynamic name;
    dynamic deliveryType;
    dynamic selectedPackage;
    dynamic shareUserIds;
    dynamic pickupAddress;
    dynamic dropAddress;
    dynamic orderStatus;
    dynamic orderCode;
    dynamic userId;
    dynamic subAdminId;
    dynamic subAdminType;
    dynamic vendorAdminId;
    dynamic productCategoryId;
    dynamic assignedToId;
    dynamic createdById;
    dynamic cartId;
    dynamic couponId;
    dynamic type;
    dynamic paymentMethod;
    dynamic payType;
    dynamic ordersDetails;
    dynamic parcelDetails;
    dynamic amountDetails;
    dynamic newAt;
    dynamic assignedAt;
    dynamic inProgressAt;
    dynamic pickUpedAt;
    dynamic deliverymanReachedDoorAt;
    dynamic roundTripStartedAt;
    dynamic deliveredAt;
    dynamic cancelledAt;
    dynamic rejectedAt;
    dynamic discountAmount;
    dynamic totalKms;
    dynamic baseKm;
    bool? deleted;
    bool? billGenerated;
    dynamic invoicePath;
    dynamic files;
    dynamic instructions;
    dynamic additionalInstructions;
    dynamic createdAt;
    dynamic updatedAt;
    dynamic v;
    dynamic assigneeDetails;
    dynamic paymentDetails;
    dynamic ratings;

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
        this.roundTripStartedAt,
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
        this.assigneeDetails,
        this.paymentDetails,
        this.ratings,
    });

    factory Datum.fromJson(Map<String, dynamic> json) => Datum(
   id: json["_id"] ?? "",
      name: json["name"] ?? "",
      deliveryType: json["deliveryType"] ?? "",
      selectedPackage: List<dynamic>.from(json["selectedPackage"]?.map((x) => x) ?? []),
      shareUserIds: List<String>.from(json["shareUserIds"]?.map((x) => x) ?? []),
      pickupAddress: List<PAddress>.from(json["pickupAddress"]?.map((x) => PAddress.fromJson(x)) ?? []),
      dropAddress: List<PAddress>.from(json["dropAddress"]?.map((x) => PAddress.fromJson(x)) ?? []),
      orderStatus: json["orderStatus"] ?? "",
      orderCode: json["orderCode"] ?? "",
      userId: json["userId"] ?? "",
      subAdminId: json["subAdminId"] ?? "",
      subAdminType: json["subAdminType"] ?? "",
      vendorAdminId: json["vendorAdminId"] ?? "",
      productCategoryId: json["productCategoryId"] ?? "",
      assignedToId: json["assignedToId"] ?? "",
      createdById: json["createdById"] ?? "",
      cartId: List<dynamic>.from(json["cartId"]?.map((x) => x) ?? []),
      couponId: json["couponId"],
      type: json["type"] ?? "",
      paymentMethod: json["paymentMethod"] ?? "",
      payType: json["payType"] ?? "",
      ordersDetails: List<OrdersDetail>.from(json["ordersDetails"]?.map((x) => OrdersDetail.fromJson(x)) ?? []),
      parcelDetails: json["parcelDetails"] != null ? ParcelDetails.fromJson(json["parcelDetails"]) : null,
      amountDetails: json["amountDetails"] != null ? AmountDetails.fromJson(json["amountDetails"]) : null,
      newAt: json["newAt"] != null ? DateTime.parse(json["newAt"]) : null,
      assignedAt: json["assignedAt"] != null ? DateTime.parse(json["assignedAt"]) : null,
      inProgressAt: json["inProgressAt"],
      pickUpedAt: json["pickUpedAt"] != null ? DateTime.parse(json["pickUpedAt"]) : null,
      deliverymanReachedDoorAt: json["deliverymanReachedDoorAt"],
      roundTripStartedAt: json["roundTripStartedAt"],
      deliveredAt: json["deliveredAt"] != null ? DateTime.parse(json["deliveredAt"]) : null,
      cancelledAt: json["cancelledAt"],
      rejectedAt: json["rejectedAt"],
      discountAmount: json["discountAmount"],
      totalKms: json["totalKms"] != null ? json["totalKms"].toDouble() : 0.0,
      baseKm: json["baseKm"] ?? 0,
      deleted: json["deleted"] ?? false,
      billGenerated: json["billGenerated"] ?? false,
      invoicePath: json["invoicePath"] ?? "",
      files: List<dynamic>.from(json["files"]?.map((x) => x) ?? []),
      instructions: List<dynamic>.from(json["instructions"]?.map((x) => x) ?? []),
      additionalInstructions: json["additionalInstructions"] ?? "",
      createdAt: json["createdAt"] != null ? DateTime.parse(json["createdAt"]) : null,
      updatedAt: json["updatedAt"] != null ? DateTime.parse(json["updatedAt"]) : null,
      v: json["__v"] ?? 0,
      assigneeDetails: json["assigneeDetails"] != null ? AssigneeDetails.fromJson(json["assigneeDetails"]) : null,
      paymentDetails: json["paymentDetails"] != null ? PaymentDetails.fromJson(json["paymentDetails"]) : null,
      ratings: List<dynamic>.from(json["ratings"]?.map((x) => x) ?? []),
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
        "assignedAt": assignedAt!.toIso8601String(),
        "inProgressAt": inProgressAt,
        "pickUpedAt": pickUpedAt!.toIso8601String(),
        "deliverymanReachedDoorAt": deliverymanReachedDoorAt,
        "roundTripStartedAt": roundTripStartedAt,
        "deliveredAt": deliveredAt!.toIso8601String(),
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
        "assigneeDetails": assigneeDetails!.toJson(),
        "paymentDetails": paymentDetails!.toJson(),
        "ratings": List<dynamic>.from(ratings!.map((x) => x)),
    };
}

class AssigneeDetails {
    dynamic id;
    dynamic name;
    dynamic email;
    dynamic parentAdminUserId;
    dynamic jobType;
    dynamic mobileNo;
    dynamic aditionalContactNumber;
    dynamic gstNo;
    dynamic uuid;
    dynamic fcmToken;
    dynamic noOfOrdersPerMonth;
    dynamic activeStatus;
    bool? isVerified;
    bool? status;
    dynamic imgUrl;
    dynamic lastSeen;
    dynamic address;
    dynamic vehicleDetails;
    dynamic instructions;
    dynamic shareUserDetails;
    dynamic createdAt;
    dynamic updatedAt;

    AssigneeDetails({
        this.id,
        this.name,
        this.email,
        this.parentAdminUserId,
        this.jobType,
        this.mobileNo,
        this.aditionalContactNumber,
        this.gstNo,
        this.uuid,
        this.fcmToken,
        this.noOfOrdersPerMonth,
        this.activeStatus,
        this.isVerified,
        this.status,
        this.imgUrl,
        this.lastSeen,
        this.address,
        this.vehicleDetails,
        this.instructions,
        this.shareUserDetails,
        this.createdAt,
        this.updatedAt,
    });

    factory AssigneeDetails.fromJson(Map<String, dynamic> json) => AssigneeDetails(
        id: json["_id"],
        name: json["name"],
        email: json["email"],
        parentAdminUserId: json["parentAdminUserId"],
        jobType: json["jobType"],
        mobileNo: json["mobileNo"],
        aditionalContactNumber: json["aditionalContactNumber"],
        gstNo: json["gstNo"],
        uuid: json["uuid"],
        fcmToken: json["fcmToken"],
        noOfOrdersPerMonth: json["noOfOrdersPerMonth"],
        activeStatus: json["activeStatus"],
        isVerified: json["isVerified"],
        status: json["status"],
        imgUrl: json["imgUrl"],
        lastSeen: DateTime.parse(json["lastSeen"]),
        address: Address.fromJson(json["address"]),
        vehicleDetails: VehicleDetails.fromJson(json["vehicleDetails"]),
        instructions: json["instructions"],
        shareUserDetails: ShareUserDetails.fromJson(json["shareUserDetails"]),
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
    );

    Map<String, dynamic> toJson() => {
        "_id": id,
        "name": name,
        "email": email,
        "parentAdminUserId": parentAdminUserId,
        "jobType": jobType,
        "mobileNo": mobileNo,
        "aditionalContactNumber": aditionalContactNumber,
        "gstNo": gstNo,
        "uuid": uuid,
        "fcmToken": fcmToken,
        "noOfOrdersPerMonth": noOfOrdersPerMonth,
        "activeStatus": activeStatus,
        "isVerified": isVerified,
        "status": status,
        "imgUrl": imgUrl,
        "lastSeen": lastSeen!.toIso8601String(),
        "address": address!.toJson(),
        "vehicleDetails": vehicleDetails!.toJson(),
        "instructions": instructions,
        "shareUserDetails": shareUserDetails!.toJson(),
        "createdAt": createdAt!.toIso8601String(),
        "updatedAt": updatedAt!.toIso8601String(),
    };
}

class Address {
    dynamic district;
    dynamic companyName;
    dynamic fullAddress;
    dynamic street;
    dynamic state;
    dynamic country;
    dynamic postalCode;
    dynamic contactPerson;
    dynamic contactPersonNumber;
    dynamic addressType;
    dynamic latitude;
    dynamic longitude;
    dynamic region;
    dynamic city;
    dynamic houseNo;
    dynamic landMark;

    Address({
        this.district,
        this.companyName,
        this.fullAddress,
        this.street,
        this.state,
        this.country,
        this.postalCode,
        this.contactPerson,
        this.contactPersonNumber,
        this.addressType,
        this.latitude,
        this.longitude,
        this.region,
        this.city,
        this.houseNo,
        this.landMark,
    });

    factory Address.fromJson(Map<String, dynamic> json) => Address(
        district: json["district"],
        companyName: json["companyName"],
        fullAddress: json["fullAddress"],
        street: json["street"],
        state: json["state"],
        country: json["country"],
        postalCode: json["postalCode"],
        contactPerson: json["contactPerson"],
        contactPersonNumber: json["contactPersonNumber"],
        addressType: json["addressType"],
        latitude: json["latitude"],
        longitude: json["longitude"],
        region: json["region"],
        city: json["city"],
        houseNo: json["houseNo"],
        landMark: json["landMark"],
    );

    Map<String, dynamic> toJson() => {
        "district": district,
        "companyName": companyName,
        "fullAddress": fullAddress,
        "street": street,
        "state": state,
        "country": country,
        "postalCode": postalCode,
        "contactPerson": contactPerson,
        "contactPersonNumber": contactPersonNumber,
        "addressType": addressType,
        "latitude": latitude,
        "longitude": longitude,
        "region": region,
        "city": city,
        "houseNo": houseNo,
        "landMark": landMark,
    };
}

class ShareUserDetails {
    dynamic receiverName;
    dynamic receiverNumber;

    ShareUserDetails({
        this.receiverName,
        this.receiverNumber,
    });

    factory ShareUserDetails.fromJson(Map<String, dynamic> json) => ShareUserDetails(
        receiverName: json["receiverName"],
        receiverNumber: json["receiverNumber"],
    );

    Map<String, dynamic> toJson() => {
        "receiverName": receiverName,
        "receiverNumber": receiverNumber,
    };
}

class VehicleDetails {
    dynamic vehicleNumber;
    dynamic vehicleName;

    VehicleDetails({
        this.vehicleNumber,
        this.vehicleName,
    });

    factory VehicleDetails.fromJson(Map<String, dynamic> json) => VehicleDetails(
        vehicleNumber: json["vehicleNumber"],
        vehicleName: json["vehicleName"],
    );

    Map<String, dynamic> toJson() => {
        "vehicleNumber": vehicleNumber,
        "vehicleName": vehicleName,
    };
}

class PAddress {
    dynamic name;
    dynamic addressId;
    dynamic userType;
    dynamic houseNo;
    dynamic locality;
    dynamic landMark;
    dynamic fullAddress;
    dynamic street;
    dynamic city;
    dynamic district;
    dynamic state;
    dynamic country;
    dynamic postalCode;
    dynamic contactType;
    dynamic contactPerson;
    dynamic contactPersonNumber;
    dynamic addressType;
    dynamic latitude;
    dynamic longitude;
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
    dynamic productType;
    dynamic description;
    dynamic foodId;
    dynamic foodName;
    dynamic foodType;
    dynamic foodImage;
    dynamic quantity;
    dynamic foodPrice;
    dynamic totalPrice;
    dynamic id;

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

class ParcelDetails {
    dynamic value;
    dynamic packageType;
    dynamic otherType;
    dynamic packageImage;
    dynamic parcelTripType;

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
    dynamic id;
    dynamic orderId;
    dynamic cartId;
    dynamic subscriptionId;
    dynamic paymentStatus;
    dynamic paymentAmount;
    dynamic currency;
    dynamic paymentMode;
    dynamic paymentFrom;
    dynamic copCompletedAt;
    dynamic codCompletedAt;
    dynamic razorPayPaymentId;
    dynamic razorPayRefundId;
    dynamic razorpayOrderId;
    dynamic razorpaySignature;
    dynamic createdAt;
    dynamic updatedAt;
    dynamic v;

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
        paymentAmount: json["paymentAmount"].toDouble(),
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
