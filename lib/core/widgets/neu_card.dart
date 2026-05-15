import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class NeuCard extends StatelessWidget {
  final Widget child;
  final EdgeInsets padding;
  final double borderRadius;
  final double depth;
  final Color? color;
  final bool inset;
  final VoidCallback? onTap;
  final double? width;
  final double? height;

  const NeuCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(16),
    this.borderRadius = 20,
    this.depth = 10,
    this.color,
    this.inset = false,
    this.onTap,
    this.width,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = color ?? (isDark ? AppColors.neuSurfaceDark : AppColors.neuSurface);
    final shadowDark = isDark ? AppColors.neuShadowDarkD : AppColors.neuShadowDark;
    final shadowLight = isDark ? AppColors.neuShadowLightD : AppColors.neuShadowLight;

    final widget = Container(
      width: width,
      height: height,
      padding: padding,
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(borderRadius),
        boxShadow: inset
            ? null
            : [
                BoxShadow(color: shadowDark.withOpacity(0.5), offset: Offset(depth / 2, depth / 2), blurRadius: depth),
                BoxShadow(color: shadowLight, offset: Offset(-depth / 2, -depth / 2), blurRadius: depth),
              ],
        gradient: inset
            ? LinearGradient(
                colors: [shadowDark.withOpacity(0.15), shadowLight.withOpacity(0.5)],
                begin: Alignment.topLeft, end: Alignment.bottomRight,
              )
            : null,
      ),
      child: child,
    );

    return onTap != null ? GestureDetector(onTap: onTap, child: widget) : widget;
  }
}
