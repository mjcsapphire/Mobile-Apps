import 'dart:convert';

class PathwayResponse {
  String title;
  String colour;
  String id;
  String description;
  String userScore;

  PathwayResponse({
    required this.title,
    required this.colour,
    required this.id,
    required this.description,
    required this.userScore,
  });

  PathwayResponse copyWith({
    String? title,
    String? colour,
    String? id,
    String? description,
    String? userScore,
  }) =>
      PathwayResponse(
        title: title ?? this.title,
        colour: colour ?? this.colour,
        id: id ?? this.id,
        description: description ?? this.description,
        userScore: userScore ?? this.userScore,
      );

  factory PathwayResponse.fromRawJson(String str) =>
      PathwayResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory PathwayResponse.fromJson(Map<String, dynamic> json) =>
      PathwayResponse(
        title: json["title"],
        colour: json["colour"],
        id: json["id"],
        description: json["description"],
        userScore: json["user_score"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "colour": colour,
        "id": id,
        "description": description,
        "user_score": userScore,
      };
}
