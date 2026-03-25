import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../logic/models.dart';
import '../logic/quiz_data.dart';
import '../widgets/shared_widgets.dart';

class QuestionScreen extends StatelessWidget {
  final int qIndex;
  final QuizQuestion question;
  final ValueChanged<int> onAnswer;

  const QuestionScreen({
    super.key,
    required this.qIndex,
    required this.question,
    required this.onAnswer,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Question number badge ────────────────────────────────────────
            Container(
              padding:
              EdgeInsets.symmetric(horizontal: 10.w, vertical: 4.h),
              decoration: BoxDecoration(
                color: cs.primary.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(6.r),
              ),
              child: Text(
                'Q${qIndex + 1} of ${questions.length}',
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 11.sp,
                  fontWeight: FontWeight.w700,
                  color: cs.primary,
                ),
              ),
            ),

            SizedBox(height: 20.h),

            // ── Question prompt ──────────────────────────────────────────────
            Text(
              question.prompt,
              style: GoogleFonts.jetBrainsMono(
                fontSize: 20.sp,
                fontWeight: FontWeight.w700,
                height: 1.35,
                color: cs.onSurface,
              ),
            ),

            SizedBox(height: 32.h),

            // ── Answer options ───────────────────────────────────────────────
            Expanded(
              child: ListView.separated(
                itemCount: question.choices.length,
                separatorBuilder: (_, __) => SizedBox(height: 12.h),
                itemBuilder: (_, i) => ChoiceCard(
                  label: question.choices[i],
                  isDark: isDark,
                  accentColor: cs.primary,
                  onTap: () => onAnswer(i),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}