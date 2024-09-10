import 'dart:convert';

List<JournalModel> JournalModelFromJson(String str) =>
    List<JournalModel>.from(
        json.decode(str).map((x) => JournalModel.fromJson(x)));

String JournalModelToJson(List<JournalModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class JournalModel{
  final String? id;
  final String? title;
  final String? entry;
  final String? date;

  JournalModel({
    required this.id,
    required this.title,
    required this.entry,
    required this.date
  });

  factory JournalModel.fromJson(Map<String, dynamic> json) => JournalModel(
    id: json["id"],
    title: json["title"],
    entry: json["entry"],
    date: json["date"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "title": title,
    "entry": entry,
    "date": date,
  };

}