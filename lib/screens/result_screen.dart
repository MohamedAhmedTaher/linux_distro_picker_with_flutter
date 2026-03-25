import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../widgets/shared_widgets.dart';

class ResultScreen extends StatelessWidget {
  final String distro;
  final String emoji;
  final Color accentColor;
  final String description;
  final VoidCallback onRestart;

  const ResultScreen({
    super.key,
    required this.distro,
    required this.emoji,
    required this.accentColor,
    required this.description,
    required this.onRestart,
  });

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
            // ── Label ────────────────────────────────────────────────────────
            Text(
              'Your distro is...',
              style: GoogleFonts.jetBrainsMono(
                fontSize: 13.sp,
                color: cs.onSurface.withValues(alpha: 0.5),
              ),
            ),

            SizedBox(height: 16.h),

            // ── Hero card ─────────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(24.w),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    accentColor.withValues(alpha: isDark ? 0.25 : 0.12),
                    accentColor.withValues(alpha: isDark ? 0.08 : 0.04),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16.r),
                border: Border.all(
                  color: accentColor.withValues(alpha: 0.5),
                  width: 1.5,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(emoji, style: TextStyle(fontSize: 48.sp)),
                  SizedBox(height: 12.h),
                  Text(
                    distro,
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 32.sp,
                      fontWeight: FontWeight.w800,
                      color: accentColor,
                      height: 1.1,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 24.h),

            // ── Description card ───────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(18.w),
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF141914) : Colors.white,
                borderRadius: BorderRadius.circular(12.r),
                border: Border.all(
                  color: cs.outline.withValues(alpha: 0.2),
                ),
              ),
              child: Text(
                description,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 13.sp,
                  height: 1.7,
                  color: cs.onSurface.withValues(alpha: 0.8),
                ),
              ),
            ),

            SizedBox(height: 24.h),

            // ── Terminal output ────────────────────────────────────────────
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: isDark
                    ? const Color(0xFF0C0F0C)
                    : const Color(0xFFF0F4F0),
                borderRadius: BorderRadius.circular(10.r),
                border:
                Border.all(color: accentColor.withValues(alpha: 0.3)),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TerminalLine(
                      r'$ sudo apt-get install happiness', accentColor),
                  SizedBox(height: 4.h),
                  TerminalLine(
                    'Recommendation: $distro $emoji',
                    cs.onSurface.withValues(alpha: 0.6),
                  ),
                  TerminalLine('Status: MATCH FOUND ✓', accentColor),
                ],
              ),
            ),

            SizedBox(height: 36.h),

            // ── Restart button ─────────────────────────────────────────────
            SizedBox(
              width: double.infinity,
              height: 52.h,
              child: ElevatedButton(
                onPressed: onRestart,
                style: ElevatedButton.styleFrom(
                  backgroundColor: accentColor,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                ),
                child: Text(
                  'Try Again ↺',
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