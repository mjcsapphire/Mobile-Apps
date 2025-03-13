import 'dart:convert';

class VideoResponse {
  String id;
  String title;
  String path;

  VideoResponse({
    required this.id,
    required this.title,
    required this.path,
  });

  VideoResponse copyWith({
    String? id,
    String? title,
    String? path,
  }) =>
      VideoResponse(
        id: id ?? this.id,
        title: title ?? this.title,
        path: path ?? this.path,
      );

  factory VideoResponse.fromRawJson(String str) =>
      VideoResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory VideoResponse.fromJson(Map<String, dynamic> json) => VideoResponse(
        id: json["id"],
        title: json["title"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "path": path,
      };

 List<VideoResponse> parseVideoResponse(String jsonString) {
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((item) => VideoResponse.fromJson(item)).toList();
  }

  static String listToJson(List<VideoResponse> items) =>
      json.encode(List<dynamic>.from(items.map((x) => x.toJson())));
}
