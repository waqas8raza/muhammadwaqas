import 'package:flutter/material.dart';

class HoverItem extends StatefulWidget {
  final Widget Function(BuildContext context, bool isHovered) builder;
  final double scale;
  final Offset offset;
  final Duration duration;

  const HoverItem({
    super.key,
    required this.builder,
    this.scale = 1.015,
    this.offset = const Offset(0, -3),
    this.duration = const Duration(milliseconds: 200),
  });

  @override
  State<HoverItem> createState() => _HoverItemState();
}

class _HoverItemState extends State<HoverItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.maybeOf(context)?.disableAnimations ?? false;

    final matrix = Matrix4.identity();
    if (!reduceMotion && _isHovered) {
      matrix.translateByDouble(widget.offset.dx, widget.offset.dy, 0.0, 1.0);
      matrix.scaleByDouble(widget.scale, widget.scale, 1.0, 1.0);
    }

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: reduceMotion ? Duration.zero : widget.duration,
        curve: Curves.easeOutCubic,
        transform: matrix,
        child: widget.builder(context, _isHovered),
      ),
    );
  }
}
