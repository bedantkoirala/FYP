// To parse this JSON data, do
//
//     final subscriptionResponse = subscriptionResponseFromJson(jsonString);

import 'dart:convert';

SubscriptionResponse subscriptionResponseFromJson(String str) =>
    SubscriptionResponse.fromJson(json.decode(str));

String subscriptionResponseToJson(SubscriptionResponse data) =>
    json.encode(data.toJson());

class SubscriptionResponse {
  final bool? success;
  final String? message;
  final List<Subscription>? subscriptions;

  SubscriptionResponse({
    this.success,
    this.message,
    this.subscriptions,
  });

  factory SubscriptionResponse.fromJson(Map<String, dynamic> json) =>
      SubscriptionResponse(
        success: json["success"],
        message: json["message"],
        subscriptions: json["subscriptions"] == null
            ? []
            : List<Subscription>.from(
                json["subscriptions"]!.map((x) => Subscription.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "subscriptions": subscriptions == null
            ? []
            : List<dynamic>.from(subscriptions!.map((x) => x.toJson())),
      };
}

class Subscription {
  final String? subscriptionId;
  final String? userId;
  final String? membershipId;
  final DateTime? startDate;
  final DateTime? expirationDate;
  final String? status;
  final String? paymentId;
  final String? name;
  final String? description;
  final String? discountPercentage;
  final String? price;
  final String? durationMonths;
  final dynamic orderId;
  final String? amount;
  final String? otherData;
  final String? fullName;
  final String? email;

  Subscription({
    this.subscriptionId,
    this.userId,
    this.membershipId,
    this.startDate,
    this.expirationDate,
    this.status,
    this.paymentId,
    this.name,
    this.description,
    this.discountPercentage,
    this.price,
    this.durationMonths,
    this.orderId,
    this.amount,
    this.otherData,
    this.fullName,
    this.email,
  });

  factory Subscription.fromJson(Map<String, dynamic> json) => Subscription(
        subscriptionId: json["subscription_id"],
        userId: json["user_id"],
        membershipId: json["membership_id"],
        startDate: json["start_date"] == null
            ? null
            : DateTime.parse(json["start_date"]),
        expirationDate: json["expiration_date"] == null
            ? null
            : DateTime.parse(json["expiration_date"]),
        status: json["status"],
        paymentId: json["payment_id"],
        name: json["name"],
        description: json["description"],
        discountPercentage: json["discount_percentage"],
        price: json["price"],
        durationMonths: json["duration_months"],
        orderId: json["order_id"],
        amount: json["amount"],
        otherData: json["other_data"],
        fullName: json["full_name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "subscription_id": subscriptionId,
        "user_id": userId,
        "membership_id": membershipId,
        "start_date": startDate?.toIso8601String(),
        "expiration_date":
            "${expirationDate!.year.toString().padLeft(4, '0')}-${expirationDate!.month.toString().padLeft(2, '0')}-${expirationDate!.day.toString().padLeft(2, '0')}",
        "status": status,
        "payment_id": paymentId,
        "name": name,
        "description": description,
        "discount_percentage": discountPercentage,
        "price": price,
        "duration_months": durationMonths,
        "order_id": orderId,
        "amount": amount,
        "other_data": otherData,
        "full_name": fullName,
        "email": email,
      };
}
