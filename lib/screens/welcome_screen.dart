import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../logic/quiz_data.dart';
import '../widgets/shared_widgets.dart';

class WelcomeScreen extends StatelessWidget {
  final VoidCallback onStart;

  const WelcomeScreen({super.key, required this.onStart});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 32.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Terminal header card ────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(20.w),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF141914) : Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: cs.primary.withValues(alpha: 0.4),
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TerminalLine(r'$ ./distro-finder --start', cs.primary),
                  SizedBox(height: 8.h),
                  TerminalLine('Initializing quiz engine...', cs.outline),
                  TerminalLine(
                      'Loaded ${questions.length} questions.', cs.outline),
                  TerminalLine(
                      'Loaded ${distroNames.length} distros.', cs.outline),
                  SizedBox(height: 4.h),
                  TerminalLine('Ready. Awaiting user input ▌', cs.primary),
                ],
              ),
            ),

            SizedBox(height: 32.h),

            // ── Headline ────────────────────────────────────────────────────
            Text(
              'Find your\nperfect distro.',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 28.sp,
                fontWeight: FontWeight.w800,
                height: 1.15,
                color: cs.onSurface,
              ),
            ),

            SizedBox(height: 12.h),

            Text(
              'Answer ${questions.length} quick questions and we\'ll match\nyou with the Linux distro that fits your style.',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 13.sp,
                height: 1.6,
                color: cs.onSurface.withValues(alpha: 0.6),
              ),
            ),

            SizedBox(height: 40.h),

            // ── Distro badges preview ────────────────────────────────────────
            Wrap(
              spacing: 8.w,
              runSpacing: 8.h,
              children: List.generate(distroNames.length, (i) {
                return Container(
                  padding: EdgeInsets.symmetric(
                      horizontal: 10.w, vertical: 5.h),
                  decoration: BoxDecoration(
                    color: distroColors[i].withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6.r),
                    border: Border.all(
                      color: distroColors[i].withValues(alpha: 0.35),
                    ),
                  ),
                  child: Text(
                    '${distroEmojis[i]} ${distroNames[i]}',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 11.sp,
                      fontWeight: FontWeight.w600,
                      color: distroColors[i],
                    ),
                  ),
                );
              }),
            ),

            SizedBox(height: 48.h),

            // ── CTA button ──────────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: onStart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: cs.primary,
                  foregroundColor: cs.onPrimary,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  'Start Quiz →',
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 15.sp,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}