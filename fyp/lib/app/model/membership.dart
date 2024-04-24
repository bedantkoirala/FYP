// To parse this JSON data, do
//
//     final membershipResponse = membershipResponseFromJson(jsonString);

import 'dart:convert';

MembershipResponse membershipResponseFromJson(String str) =>
    MembershipResponse.fromJson(json.decode(str));

String membershipResponseToJson(MembershipResponse data) =>
    json.encode(data.toJson());

class MembershipResponse {
  final bool? success;
  final String? message;
  final List<Membership>? memberships;

  MembershipResponse({
    this.success,
    this.message,
    this.memberships,
  });

  factory MembershipResponse.fromJson(Map<String, dynamic> json) =>
      MembershipResponse(
        success: json["success"],
        message: json["message"],
        memberships: json["memberships"] == null
            ? []
            : List<Membership>.from(
                json["memberships"]!.map((x) => Membership.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "memberships": memberships == null
            ? []
            : List<dynamic>.from(memberships!.map((x) => x.toJson())),
      };
}

class Membership {
  final String? membershipId;
  final String? name;
  final String? description;
  final String? discountPercentage;
  final String? price;
  final String? durationMonths;

  Membership({
    this.membershipId,
    this.name,
    this.description,
    this.discountPercentage,
    this.price,
    this.durationMonths,
  });

  factory Membership.fromJson(Map<String, dynamic> json) => Membership(
        membershipId: json["membership_id"],
        name: json["name"],
        description: json["description"],
        discountPercentage: json["discount_percentage"],
        price: json["price"],
        durationMonths: json["duration_months"],
      );

  Map<String, dynamic> toJson() => {
        "membership_id": membershipId,
        "name": name,
        "description": description,
        "discount_percentage": discountPercentage,
        "price": price,
        "duration_months": durationMonths,
      };
}
