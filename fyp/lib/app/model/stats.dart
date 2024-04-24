import 'dart:convert';

Stats statsFromJson(String str) => Stats.fromJson(json.decode(str));

String statsToJson(Stats data) => json.encode(data.toJson());

class Stats {
  final String? totalIncome;
  final String? totalUsers;
  final String? totalOrders;
  final String? totalProducts;
  final String? totalFeedbacks;
  final String? totalSubscriptions;

  Stats({
    this.totalIncome,
    this.totalUsers,
    this.totalOrders,
    this.totalProducts,
    this.totalFeedbacks,
    this.totalSubscriptions,
  });

  factory Stats.fromJson(Map<String, dynamic> json) => Stats(
        totalIncome: json["total_income"],
        totalUsers: json["total_users"],
        totalOrders: json["total_orders"],
        totalProducts: json["total_products"],
        totalFeedbacks: json["total_feedbacks"],
        totalSubscriptions: json["total_subscriptions"],
      );

  Map<String, dynamic> toJson() => {
        "total_income": totalIncome,
        "total_users": totalUsers,
        "total_orders": totalOrders,
        "total_products": totalProducts,
        "total_feedbacks": totalFeedbacks,
        "total_subscriptions": totalSubscriptions,
      };
}
