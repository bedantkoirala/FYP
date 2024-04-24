// To parse this JSON data, do
//
//     final reviewsResponse = reviewsResponseFromJson(jsonString);

import 'dart:convert';

ReviewsResponse reviewsResponseFromJson(String str) =>
    ReviewsResponse.fromJson(json.decode(str));

String reviewsResponseToJson(ReviewsResponse data) =>
    json.encode(data.toJson());

class ReviewsResponse {
  final bool? success;
  final String? message;
  final List<Review>? reviews;
  final String? rating;

  ReviewsResponse({
    this.success,
    this.message,
    this.reviews,
    this.rating,
  });

  factory ReviewsResponse.fromJson(Map<String, dynamic> json) =>
      ReviewsResponse(
        success: json["success"],
        message: json["message"],
        reviews: json["reviews"] == null
            ? []
            : List<Review>.from(
                json["reviews"]!.map((x) => Review.fromJson(x))),
        rating: json["rating"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "reviews": reviews == null
            ? []
            : List<dynamic>.from(reviews!.map((x) => x.toJson())),
        "rating": rating,
      };
}

class Review {
  final String? ratingId;
  final String? rating;
  final String? review;
  final String? userId;
  final String? productId;
  final String? fullName;
  final String? email;

  Review({
    this.ratingId,
    this.rating,
    this.review,
    this.userId,
    this.productId,
    this.fullName,
    this.email,
  });

  factory Review.fromJson(Map<String, dynamic> json) => Review(
        ratingId: json["rating_id"],
        rating: json["rating"],
        review: json["review"],
        userId: json["user_id"],
        productId: json["product_id"],
        fullName: json["full_name"],
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "rating_id": ratingId,
        "rating": rating,
        "review": review,
        "user_id": userId,
        "product_id": productId,
        "full_name": fullName,
        "email": email,
      };
}
