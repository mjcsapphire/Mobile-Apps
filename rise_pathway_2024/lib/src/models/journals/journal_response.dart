import 'dart:convert';

class JournalEntriesResponse {
  String title;
  String id;
  String entry;
  String date;

  JournalEntriesResponse({
    required this.title,
    required this.id,
    required this.entry,
    required this.date,
  });

  JournalEntriesResponse copyWith({
    String? title,
    String? id,
    String? entry,
    String? date,
  }) =>
      JournalEntriesResponse(
        title: title ?? this.title,
        id: id ?? this.id,
        entry: entry ?? this.entry,
        date: date ?? this.date,
      );

  factory JournalEntriesResponse.fromRawJson(String str) =>
      JournalEntriesResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory JournalEntriesResponse.fromJson(Map<String, dynamic> json) =>
      JournalEntriesResponse(
        title: json["title"],
        id: json["id"],
        entry: json["entry"],
        date: json["date"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "id": id,
        "entry": entry,
        "date": date,
      };
}
