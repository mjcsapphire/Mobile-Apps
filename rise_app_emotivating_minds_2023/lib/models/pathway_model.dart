import 'dart:convert';
import 'dart:ui';

List<PathwayModel> PathwayModelFromJson(String str) =>
    List<PathwayModel>.from(
        json.decode(str).map((x) => PathwayModel.fromJson(x)));

String PathwayModelToJson(List<PathwayModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PathwayModel{
  final String? id;
  final String? title;
  final String colour;
  final String description;
  final String user_score;

  PathwayModel({
    required this.id,
    required this.title,
    required this.colour,
    required this.description,
    required this.user_score,
  });

  factory PathwayModel.fromJson(Map<String, dynamic> json) => PathwayModel(
    id: json["id"],
    title: json["title"],
    colour: json["colour"],
    description: json["description"],
    user_score: json["user_score"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "colour": colour,
    "description": description,
    "user_score": user_score,
  };

}