import 'package:flutter/material.dart';

class HoverItem extends StatefulWidget {
  final Widget Function(BuildContext context, bool isHovered) builder;
  final double scale;
  final Offset offset;

  const HoverItem({
    super.key,
    required this.builder,
    this.scale = 1.03,
    this.offset = const Offset(0, -4),
  });

  @override
  State<HoverItem> createState() => _HoverItemState();
}

class _HoverItemState extends State<HoverItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      cursor: SystemMouseCursors.click,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 250),
        curve: Curves.easeOutCubic,
        transform: _isHovered
            ? (Matrix4.identity()
              ..translate(widget.offset.dx, widget.offset.dy)
              ..scale(widget.scale))
            : Matrix4.identity(),
        child: widget.builder(context, _isHovered),
      ),
    );
  }
}
