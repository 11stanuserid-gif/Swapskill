import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class NeuTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? label;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final TextInputType keyboardType;
  final bool obscureText;
  final int? maxLines;
  final int? maxLength;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator<String>? validator;
  final List<String>? autofillHints;

  const NeuTextField({
    super.key,
    this.controller,
    this.hintText,
    this.label,
    this.prefixIcon,
    this.suffixIcon,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.maxLines = 1,
    this.maxLength,
    this.onChanged,
    this.validator,
    this.autofillHints,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bg = isDark ? AppColors.neuSurfaceDark : AppColors.neuSurface;
    final shadowDark = isDark ? AppColors.neuShadowDarkD : AppColors.neuShadowDark;
    final shadowLight = isDark ? AppColors.neuShadowLightD : AppColors.neuShadowLight;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null)
          Padding(
            padding: const EdgeInsets.only(left: 8, bottom: 6),
            child: Text(label!, style: TextStyle(
              fontSize: 13, fontWeight: FontWeight.w500,
              color: isDark ? AppColors.textDarkSecondary : AppColors.textSecondary,
            )),
          ),
        Container(
          decoration: BoxDecoration(
            color: bg,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(color: shadowDark.withOpacity(0.4), offset: const Offset(3, 3), blurRadius: 6, inset: false),
              BoxShadow(color: shadowLight.withOpacity(0.7), offset: const Offset(-3, -3), blurRadius: 6),
            ],
          ),
          child: TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            obscureText: obscureText,
            maxLines: maxLines,
            maxLength: maxLength,
            onChanged: onChanged,
            validator: validator,
            autofillHints: autofillHints,
            decoration: InputDecoration(
              hintText: hintText,
              hintStyle: const TextStyle(color: AppColors.textHint, fontSize: 14),
              prefixIcon: prefixIcon != null
                  ? Icon(prefixIcon, color: AppColors.primary, size: 20)
                  : null,
              suffixIcon: suffixIcon,
              border: InputBorder.none,
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              counterText: '',
            ),
          ),
        ),
      ],
    );
  }
}

extension on BoxShadow {
  BoxShadow copyWith({bool? inset}) => this;
}
