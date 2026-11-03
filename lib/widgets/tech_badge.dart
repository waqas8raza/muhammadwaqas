import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/theme/app_theme.dart';

class TechBadge extends StatelessWidget {
  final String label;
  final IconData? icon;
  final bool isAccent;

  const TechBadge({
    super.key,
    required this.label,
    this.icon,
    this.isAccent = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: isAccent ? AppTheme.accentLight : AppTheme.surfaceSubtle,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(
          color: isAccent ? AppTheme.accentBorder : AppTheme.border,
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 13,
              color: isAccent ? AppTheme.accent : AppTheme.textSecondary,
            ),
            const SizedBox(width: 5),
          ],
          Flexible(
            child: Text(
              label,
              overflow: TextOverflow.ellipsis,
              style: GoogleFonts.jetBrainsMono(
                color: isAccent ? AppTheme.accentDark : AppTheme.textPrimary,
                fontSize: 11.5,
                fontWeight: FontWeight.w500,
                letterSpacing: -0.2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
