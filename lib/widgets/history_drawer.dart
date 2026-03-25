import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

import '../logic/models.dart';

class HistoryDrawer extends StatelessWidget {
  final List<HistoryEntry> history;
  final VoidCallback onRestart;

  const HistoryDrawer({
    super.key,
    required this.history,
    required this.onRestart,
  });

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Drawer(
      width: 280.w,
      backgroundColor:
      isDark ? const Color(0xFF0C0F0C) : const Color(0xFFF0F4F0),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header ──────────────────────────────────────────────────────
            Padding(
              padding: EdgeInsets.fromLTRB(20.w, 20.h, 16.w, 8.h),
              child: Row(
                children: [
                  Icon(Icons.history_rounded, size: 18.sp, color: cs.primary),
                  SizedBox(width: 8.w),
                  Text(
                    'History',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w700,
                      color: cs.onSurface,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${history.length} result${history.length == 1 ? '' : 's'}',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 11.sp,
                      color: cs.outline,
                    ),
                  ),
                ],
              ),
            ),

            Divider(
              height: 1,
              color: cs.outline.withValues(alpha: 0.2),
              indent: 20.w,
              endIndent: 16.w,
            ),

            SizedBox(height: 8.h),

            // ── List / Empty state ───────────────────────────────────────────
            if (history.isEmpty)
              Expanded(
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.inbox_rounded,
                        size: 36.sp,
                        color: cs.outline.withValues(alpha: 0.3),
                      ),
                      SizedBox(height: 12.h),
                      Text(
                        'No results yet.\nTake the quiz!',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.jetBrainsMono(
                          fontSize: 12.sp,
                          color: cs.outline.withValues(alpha: 0.5),
                          height: 1.6,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            else
              Expanded(
                child: ListView.builder(
                  padding:
                  EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                  itemCount: history.length,
                  itemBuilder: (_, i) => _HistoryTile(entry: history[i]),
                ),
              ),

            // ── Footer button ─────────────────────────────────────────────
            Divider(
              height: 1,
              color: cs.outline.withValues(alpha: 0.2),
              indent: 12.w,
              endIndent: 12.w,
            ),

            Padding(
              padding: EdgeInsets.all(12.w),
              child: SizedBox(
                width: double.infinity,
                height: 44.h,
                child: OutlinedButton.icon(
                  onPressed: () {
                    Navigator.pop(context);
                    onRestart();
                  },
                  icon: Icon(Icons.refresh_rounded, size: 16.sp),
                  label: Text(
                    'New Quiz',
                    style: GoogleFonts.jetBrainsMono(
                      fontSize: 13.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: cs.primary,
                    side: BorderSide(color: cs.primary.withValues(alpha: 0.5)),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
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

// ── History tile ──────────────────────────────────────────────────────────────

class _HistoryTile extends StatelessWidget {
  final HistoryEntry entry;
  const _HistoryTile({required this.entry});

  String _fmtTime(DateTime dt) {
    final diff = DateTime.now().difference(dt);
    if (diff.inSeconds < 60) return 'just now';
    if (diff.inMinutes < 60) return '${diff.inMinutes}m ago';
    if (diff.inHours < 24) return '${diff.inHours}h ago';
    return '${diff.inDays}d ago';
  }

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;

    return Container(
      margin: EdgeInsets.symmetric(vertical: 4.h),
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: entry.color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: entry.color.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Text(entry.emoji, style: TextStyle(fontSize: 20.sp)),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  entry.distro,
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w700,
                    color: entry.color,
                  ),
                ),
                Text(
                  _fmtTime(entry.timestamp),
                  style: GoogleFonts.jetBrainsMono(
                    fontSize: 10.sp,
                    color: cs.outline,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}