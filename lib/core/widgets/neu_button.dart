import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

/// Premium Neumorphic Button — soft 3D look
class NeuButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final double borderRadius;
  final EdgeInsets padding;
  final Color? color;
  final double depth;
  final bool gradient;
  final Gradient? customGradient;
  final double? width;
  final double? height;

  const NeuButton({
    super.key,
    required this.child,
    this.onPressed,
    this.borderRadius = 18,
    this.padding = const EdgeInsets.symmetric(horizontal: 24, vertical: 14),
    this.color,
    this.depth = 8,
    this.gradient = false,
    this.customGradient,
    this.width,
    this.height,
  });

  @override
  State<NeuButton> createState() => _NeuButtonState();
}

class _NeuButtonState extends State<NeuButton> {
  bool _isPressed = false;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = widget.color ?? (isDark ? AppColors.neuSurfaceDark : AppColors.neuSurface);
    final shadowDark = isDark ? AppColors.neuShadowDarkD : AppColors.neuShadowDark;
    final shadowLight = isDark ? AppColors.neuShadowLightD : AppColors.neuShadowLight;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onPressed?.call();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        width: widget.width,
        height: widget.height,
        padding: widget.padding,
        decoration: BoxDecoration(
          color: widget.gradient ? null : bg,
          gradient: widget.gradient ? (widget.customGradient ?? AppColors.primaryGradient) : null,
          borderRadius: BorderRadius.circular(widget.borderRadius),
          boxShadow: _isPressed
              ? [
                  BoxShadow(color: shadowDark.withOpacity(0.4), offset: const Offset(2, 2), blurRadius: 4),
                  BoxShadow(color: shadowLight.withOpacity(0.4), offset: const Offset(-2, -2), blurRadius: 4),
                ]
              : [
                  BoxShadow(color: shadowDark.withOpacity(0.6), offset: Offset(widget.depth / 2, widget.depth / 2), blurRadius: widget.depth),
                  BoxShadow(color: shadowLight, offset: Offset(-widget.depth / 2, -widget.depth / 2), blurRadius: widget.depth),
                ],
        ),
        child: Center(child: widget.child),
      ),
    );
  }
}
