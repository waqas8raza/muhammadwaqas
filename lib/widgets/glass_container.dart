import 'package:flutter/material.dart';
import '../core/theme/app_theme.dart';

/// Editorial surface container replacing blurred glassmorphism with crisp,
/// restrained architectural cards and hairline borders.
class GlassContainer extends StatelessWidget {
  final Widget child;
  final double blur;
  final double opacity;
  final BorderRadius? borderRadius;
  final Color? borderColor;
  final Color? bgColor;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final double? width;
  final double? height;
  final List<BoxShadow>? boxShadow;

  const GlassContainer({
    super.key,
    required this.child,
    this.blur = 0.0,
    this.opacity = 1.0,
    this.borderRadius,
    this.borderColor,
    this.bgColor,
    this.padding,
    this.margin,
    this.width,
    this.height,
    this.boxShadow,
  });

  @override
  Widget build(BuildContext context) {
    final borderRad = borderRadius ?? BorderRadius.circular(10);
    final effectiveBorder = borderColor ?? AppTheme.border;
    final effectiveBg = bgColor ?? AppTheme.surface;

    return Container(
      margin: margin,
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: effectiveBg,
        borderRadius: borderRad,
        border: Border.all(
          color: effectiveBorder,
          width: 1,
        ),
        boxShadow: boxShadow ??
            [
              BoxShadow(
                color: const Color(0xFF141518).withValues(alpha: 0.03),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
      ),
      child: ClipRRect(
        borderRadius: borderRad,
        child: Padding(
          padding: padding ?? EdgeInsets.zero,
          child: child,
        ),
      ),
    );
  }
}
