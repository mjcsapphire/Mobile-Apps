class QuizTestResponse {
   int? score;
  String? feedback;


  QuizTestResponse({
     this.score,
     this.feedback,
  });

  QuizTestResponse copyWith({
    int? score,
    String? feedback,
  }) {
    return QuizTestResponse(
      score: score ?? this.score,
      feedback: feedback ?? this.feedback,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'score': score,
      'feedback': feedback,
    };
  }

  factory QuizTestResponse.fromMap(Map<String, dynamic> map) {
    return QuizTestResponse(
      score: map['score'],
      feedback: map['feedback'],
    );
  }
}
