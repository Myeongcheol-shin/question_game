class Question {
  final String category, type, difficulty, question, correct_answer;
  final List<dynamic> incorrect_answers;

  Question({
    required this.category,
    required this.correct_answer,
    required this.difficulty,
    required this.incorrect_answers,
    required this.question,
    required this.type,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
        category: json['category'],
        correct_answer: json['correct_answer'],
        difficulty: json['difficulty'],
        incorrect_answers: json['incorrect_answers'],
        question: json['question'],
        type: json['type']);
  }
}
