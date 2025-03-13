import 'dart:convert';

class GifResponse {
  String id;
  String title;
  String path;

  GifResponse({
    required this.id,
    required this.title,
    required this.path,
  });

  GifResponse copyWith({
    String? id,
    String? title,
    String? path,
  }) =>
      GifResponse(
        id: id ?? this.id,
        title: title ?? this.title,
        path: path ?? this.path,
      );

  factory GifResponse.fromRawJson(String str) =>
      GifResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory GifResponse.fromJson(Map<String, dynamic> json) => GifResponse(
        id: json["id"],
        title: json["title"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "path": path,
      };

 List<GifResponse> parseGifResponse(String jsonString) {
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((item) => GifResponse.fromJson(item)).toList();
  }

  static String listToJson(List<GifResponse> items) =>
      json.encode(List<dynamic>.from(items.map((x) => x.toJson())));
}
