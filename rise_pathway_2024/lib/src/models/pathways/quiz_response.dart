import 'dart:convert';

class QuizResponse {
  String pathwayId;
  String question;
  String id;
  String questionNumber;
  String correctAnswer;

  QuizResponse({
    required this.pathwayId,
    required this.question,
    required this.id,
    required this.questionNumber,
    required this.correctAnswer,
  });

  QuizResponse copyWith({
    String? pathwayId,
    String? question,
    String? id,
    String? questionNumber,
    String? correctAnswer,
  }) =>
      QuizResponse(
        pathwayId: pathwayId ?? this.pathwayId,
        question: question ?? this.question,
        id: id ?? this.id,
        questionNumber: questionNumber ?? this.questionNumber,
        correctAnswer: correctAnswer ?? this.correctAnswer,
      );

  factory QuizResponse.fromRawJson(String str) =>
      QuizResponse.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory QuizResponse.fromJson(Map<String, dynamic> json) => QuizResponse(
        pathwayId: json["pathway_id"],
        question: json["question"],
        id: json["id"],
        questionNumber: json["question_number"],
        correctAnswer: json["correct_answer"],
      );

  Map<String, dynamic> toJson() => {
        "pathway_id": pathwayId,
        "question": question,
        "id": id,
        "question_number": questionNumber,
        "correct_answer": correctAnswer,
      };
}
