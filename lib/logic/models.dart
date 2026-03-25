import 'dart:ui';

class QuizQuestion {
  final String prompt;
  final List<String> choices;
  const QuizQuestion(this.prompt, this.choices);

}

class HistoryEntry {
  final String distro;
  final String emoji;
  final Color color;
  final DateTime timestamp;

  HistoryEntry({
    required this.distro,
    required this.emoji,
    required this.color,
    required this.timestamp,
  });
}
