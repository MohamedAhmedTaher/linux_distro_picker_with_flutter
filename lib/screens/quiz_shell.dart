import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../logic/models.dart';
import '../logic/quiz_data.dart';
import '../logic/quiz_engine.dart';
import '../screens/welcome_screen.dart';
import '../screens/question_screen.dart';
import '../screens/result_screen.dart';
import '../widgets/history_drawer.dart';
import '../widgets/shared_widgets.dart';

enum _Screen { welcome, question, result }

class QuizShell extends StatefulWidget {
  final bool isDark;
  final VoidCallback onToggleTheme;

  const QuizShell({
    super.key,
    required this.isDark,
    required this.onToggleTheme,
  });

  @override
  State<QuizShell> createState() => _QuizShellState();
}

class _QuizShellState extends State<QuizShell> {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  _Screen _screen = _Screen.welcome;
  int _qIndex = 0;
  final List<int> _answers = [];
  String _resultDistro = '';
  int _resultDistroIdx = 0;
  final List<HistoryEntry> _history = [];

  // ── Navigation helpers ────────────────────────────────────────────────────

  void _startQuiz() => setState(() {
    _screen = _Screen.question;
    _qIndex = 0;
    _answers.clear();
  });

  void _onAnswer(int choice) {
    _answers.add(choice);
    if (_qIndex < questions.length - 1) {
      setState(() => _qIndex++);
    } else {
      final name = recommend(_answers);
      final idx = distroNames.indexOf(name);
      setState(() {
        _resultDistro = name;
        _resultDistroIdx = idx;
        _screen = _Screen.result;
        _history.insert(
          0,
          HistoryEntry(
            distro: name,
            emoji: distroEmojis[idx],
            color: distroColors[idx],
            timestamp: DateTime.now(),
          ),
        );
      });
    }
  }

  void _restart() => setState(() {
    _screen = _Screen.welcome;
    _qIndex = 0;
    _answers.clear();
  });

  // ── Build ─────────────────────────────────────────────────────────────────

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Scaffold(
      key: _scaffoldKey,
      drawer: HistoryDrawer(history: _history, onRestart: _restart),
      appBar: _buildAppBar(cs),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 280),
        switchInCurve: Curves.easeOut,
        switchOutCurve: Curves.easeIn,
        transitionBuilder: (child, anim) => FadeTransition(
          opacity: anim,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.04),
              end: Offset.zero,
            ).animate(anim),
            child: child,
          ),
        ),
        child: _buildBody(),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ColorScheme cs) {
    return AppBar(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      leadingWidth: 56.w,
      leading: IconButton(
        icon: Icon(Icons.terminal_rounded, size: 22.sp, color: cs.primary),
        tooltip: 'History',
        onPressed: () => _scaffoldKey.currentState?.openDrawer(),
      ),
      title: Text(
        '~/distro-finder',
        style: GoogleFonts.jetBrainsMono(
          fontSize: 15.sp,
          fontWeight: FontWeight.w700,
          color: cs.primary,
          letterSpacing: -0.5,
        ),
      ),
      actions: [
        if (_screen == _Screen.question)
          Center(
            child: Padding(
              padding: EdgeInsets.only(right: 8.w),
              child: ProgressDots(
                current: _qIndex,
                total: questions.length,
                activeColor: cs.primary,
                inactiveColor: cs.outline.withValues(alpha: 0.3),
              ),
            ),
          ),
        IconButton(
          icon: Icon(
            widget.isDark ? Icons.light_mode_rounded : Icons.dark_mode_rounded,
            size: 20.sp,
          ),
          tooltip: 'Toggle theme',
          onPressed: widget.onToggleTheme,
        ),
        SizedBox(width: 4.w),
      ],
    );
  }

  Widget _buildBody() {
    switch (_screen) {
      case _Screen.welcome:
        return WelcomeScreen(
          key: const ValueKey('welcome'),
          onStart: _startQuiz,
        );
      case _Screen.question:
        return QuestionScreen(
          key: ValueKey('question_$_qIndex'),
          qIndex: _qIndex,
          question: questions[_qIndex],
          onAnswer: _onAnswer,
        );
      case _Screen.result:
        return ResultScreen(
          key: const ValueKey('result'),
          distro: _resultDistro,
          emoji: distroEmojis[_resultDistroIdx],
          accentColor: distroColors[_resultDistroIdx],
          description: distroDescriptions[_resultDistroIdx],
          onRestart: _restart,
        );
    }
  }
}