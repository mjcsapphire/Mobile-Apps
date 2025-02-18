import 'dart:convert';

class AudioResponse {
  String id;
  String title;
  String path;

  AudioResponse({
    required this.id,
    required this.title,
    required this.path,
  });

  AudioResponse copyWith({
    String? id,
    String? title,
    String? path,
  }) =>
      AudioResponse(
        id: id ?? this.id,
        title: title ?? this.title,
        path: path ?? this.path,
      );

  factory AudioResponse.fromRawJson(String str) => AudioResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory AudioResponse.fromJson(Map<String, dynamic> json) => AudioResponse(
        id: json["id"],
        title: json["title"],
        path: json["path"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "path": path,
      };

 List<AudioResponse> parseAudioResponse(String jsonString) {
    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((item) => AudioResponse.fromJson(item)).toList();
  }

  static String listToJson(List<AudioResponse> items) => 
      json.encode(List<dynamic>.from(items.map((x) => x.toJson())));
}
