import 'dart:convert';

class GoalResponse {
  String id;
  String title;
  String price;
  String description;
  String credit;
  String image;
  String stripelink;

  GoalResponse({
    required this.id,
    required this.title,
    required this.price,
    required this.description,
    required this.credit,
    required this.image,
    required this.stripelink,
  });

  GoalResponse copyWith({
    String? id,
    String? title,
    String? price,
    String? description,
    String? credit,
    String? image,
    String? stripelink,
  }) =>
      GoalResponse(
        id: id ?? this.id,
        title: title ?? this.title,
        price: price ?? this.price,
        description: description ?? this.description,
        credit: credit ?? this.credit,
        image: image ?? this.image,
        stripelink: stripelink ?? this.stripelink,
      );

  factory GoalResponse.fromRawJson(String str) =>
      GoalResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GoalResponse.fromJson(Map<String, dynamic> json) => GoalResponse(
        id: json["id"] ?? "",
        title: json["title"] ?? "",
        price: json["price"] ?? "",
        description: json["description"] ?? "",
        credit: json["credits_awarded"] ?? "",
        image: json["image"] ?? "",
        stripelink: json["stripe_link"] ?? "",
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "price": price,
        "description": description,
        "credit": credit,
        "image": image,
        "stripelink": stripelink,
      };
}
