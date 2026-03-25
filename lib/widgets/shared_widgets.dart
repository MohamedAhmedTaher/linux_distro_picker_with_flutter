import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

// ── ChoiceCard ────────────────────────────────────────────────────────────────

class ChoiceCard extends StatefulWidget {
  final String label;
  final bool isDark;
  final Color accentColor;
  final VoidCallback onTap;

  const ChoiceCard({
    super.key,
    required this.label,
    required this.isDark,
    required this.accentColor,
    required this.onTap,
  });

  @override
  State<ChoiceCard> createState() => _ChoiceCardState();
}

class _ChoiceCardState extends State<ChoiceCard> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 16.h),
        decoration: BoxDecoration(
          color: _pressed
              ? widget.accentColor.withValues(alpha: 0.12)
              : widget.isDark
              ? const Color(0xFF141914)
              : Colors.white,
          borderRadius: BorderRadius.circular(12.r),
          border: Border.all(
            color: _pressed
                ? widget.accentColor
                : cs.outline.withValues(alpha: 0.25),
            width: _pressed ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.label,
                style: GoogleFonts.jetBrainsMono(
                  fontSize: 13.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
                  color: _pressed
                      ? widget.accentColor
                      : cs.onSurface.withValues(alpha: 0.85),
                ),
              ),
            ),
            SizedBox(width: 8.w),
            Icon(
              Icons.chevron_right_rounded,
              size: 18.sp,
              color: _pressed
                  ? widget.accentColor
                  : cs.outline.withValues(alpha: 0.4),
            ),
          ],
        ),
      ),
    );
  }
}

// ── TerminalLine ──────────────────────────────────────────────────────────────

class TerminalLine extends StatelessWidget {
  final String text;
  final Color color;
  const TerminalLine(this.text, this.color, {super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 2.h),
      child: Text(
        text,
        style: GoogleFonts.jetBrainsMono(
          fontSize: 12.sp,
          color: color,
          height: 1.5,
        ),
      ),
    );
  }
}

// ── ProgressDots ──────────────────────────────────────────────────────────────

class ProgressDots extends StatelessWidget {
  final int current;
  final int total;
  final Color activeColor;
  final Color inactiveColor;

  const ProgressDots({
    super.key,
    required this.current,
    required this.total,
    required this.activeColor,
    required this.inactiveColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(total, (i) {
        final active = i <= current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          margin: EdgeInsets.symmetric(horizontal: 2.w),
          width: active ? 16.w : 6.w,
          height: 6.h,
          decoration: BoxDecoration(
            color: active ? activeColor : inactiveColor,
            borderRadius: BorderRadius.circular(3.r),
          ),
        );
      }),
    );
  }
}