import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'logic/quiz_engine.dart';
import 'screens/quiz_shell.dart';

void main() {
  runApp(const DistroQuizApp());
}

class DistroQuizApp extends StatefulWidget {
  const DistroQuizApp({super.key});

  @override
  State<DistroQuizApp> createState() => _DistroQuizAppState();
}

class _DistroQuizAppState extends State<DistroQuizApp> {
  ThemeMode _themeMode = ThemeMode.dark;

  void _toggleTheme() => setState(() {
    _themeMode =
    _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  });

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, __) => MaterialApp(
        title: 'Distro Finder',
        debugShowCheckedModeBanner: false,
        themeMode: _themeMode,
        theme: lightTheme(),
        darkTheme: darkTheme(),
        home: QuizShell(
          isDark: _themeMode == ThemeMode.dark,
          onToggleTheme: _toggleTheme,
        ),
      ),
    );
  }
}