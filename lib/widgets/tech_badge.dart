import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

class TechBadge extends StatelessWidget {
  final String label;
  final IconData? icon;

  const TechBadge({
    super.key,
    required this.label,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: AppTheme.primaryEmerald.withOpacity(0.08),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(
          color: AppTheme.primaryEmerald.withOpacity(0.25),
          width: 1,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              size: 14,
              color: AppTheme.accentEmerald,
            ),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: const TextStyle(
              color: AppTheme.textPrimary,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.2,
            ),
          ),
        ],
      ),
    );
  }
}
