// ignore_for_file: non_constant_identifier_names

import 'dart:convert';

List<QuestionsModel> QuestionsModelFromJson(String str) =>
    List<QuestionsModel>.from(
        json.decode(str).map((x) => QuestionsModel.fromJson(x)));

String QuestionsModelToJson(List<QuestionsModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class QuestionsModel {
  final String? id;
  final String? pathway_id;
  final String question;
  final String question_number;
  final String correct_answer;

  QuestionsModel({
    required this.id,
    required this.pathway_id,
    required this.question,
    required this.question_number,
    required this.correct_answer,
  });

  factory QuestionsModel.fromJson(Map<String, dynamic> json) => QuestionsModel(
        id: json["id"],
        pathway_id: json["pathway_id"],
        question: json["question"],
        question_number: json["question_number"],
        correct_answer: json["correct_answer"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "pathway_id": pathway_id,
        "question": question,
        "question_number": question_number,
        "correct_answer": correct_answer,
      };
}
