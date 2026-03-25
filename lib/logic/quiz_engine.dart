import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'quiz_data.dart';

// ── Scoring ───────────────────────────────────────────────────────────────────

/// Returns the best-matching distro name for the given list of answer indices.
String recommend(List<int> answers) {
  final totals = List<int>.filled(distroNames.length, 0);
  for (int q = 0; q < answers.length; q++) {
    final row = scores[q][answers[q]];
    for (int d = 0; d < totals.length; d++) {
      totals[d] += row[d];
    }
  }
  int best = 0;
  for (int i = 1; i < totals.length; i++) {
    if (totals[i] > totals[best]) best = i;
  }
  return distroNames[best];
}

// ── Theme ─────────────────────────────────────────────────────────────────────

TextTheme _monoTextTheme(Brightness b) =>
    GoogleFonts.jetBrainsMonoTextTheme(ThemeData(brightness: b).textTheme);

ThemeData lightTheme() => ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF00875A),
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: const Color(0xFFF0F4F0),
  textTheme: _monoTextTheme(Brightness.light),
  cardColor: Colors.white,
  dividerColor: const Color(0xFFCDD5CD),
);

ThemeData darkTheme() => ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color(0xFF00D474),
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: const Color(0xFF0C0F0C),
  textTheme: _monoTextTheme(Brightness.dark),
  cardColor: const Color(0xFF141914),
  dividerColor: const Color(0xFF2A322A),
);