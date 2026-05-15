import 'package:flutter/material.dart';

/// Premium Neumorphic Color Palette for SwapSkill
class AppColors {
  // Primary Brand
  static const Color primary = Color(0xFF6C5CE7);        // Vibrant Purple
  static const Color primaryDark = Color(0xFF5648C4);
  static const Color primaryLight = Color(0xFF8E7EFA);

  // Secondary
  static const Color secondary = Color(0xFFFF6B9D);      // Pink
  static const Color secondaryDark = Color(0xFFE85590);
  static const Color accent = Color(0xFF00D9A3);         // Mint Green
  static const Color highlight = Color(0xFFFFB627);      // Golden

  // Neumorphism Surface (Light)
  static const Color neuBg = Color(0xFFE8ECF4);          // Soft grey-blue
  static const Color neuSurface = Color(0xFFEEF1F8);
  static const Color neuShadowDark = Color(0xFFA3B1C6);
  static const Color neuShadowLight = Color(0xFFFFFFFF);

  // Neumorphism Surface (Dark)
  static const Color neuBgDark = Color(0xFF1E2235);
  static const Color neuSurfaceDark = Color(0xFF252A40);
  static const Color neuShadowDarkD = Color(0xFF14172A);
  static const Color neuShadowLightD = Color(0xFF2C314D);

  // Text
  static const Color textPrimary = Color(0xFF1A1D2B);
  static const Color textSecondary = Color(0xFF5C667D);
  static const Color textHint = Color(0xFF8E97AB);
  static const Color textDarkPrimary = Color(0xFFEAECF5);
  static const Color textDarkSecondary = Color(0xFFA8B0C7);

  // Status
  static const Color success = Color(0xFF22C55E);
  static const Color error = Color(0xFFEF4444);
  static const Color warning = Color(0xFFF59E0B);
  static const Color info = Color(0xFF3B82F6);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF6C5CE7), Color(0xFF8E7EFA)],
    begin: Alignment.topLeft, end: Alignment.bottomRight,
  );

  static const LinearGradient sunsetGradient = LinearGradient(
    colors: [Color(0xFFFF6B9D), Color(0xFFFFB627)],
    begin: Alignment.topLeft, end: Alignment.bottomRight,
  );

  static const LinearGradient mintGradient = LinearGradient(
    colors: [Color(0xFF00D9A3), Color(0xFF6C5CE7)],
    begin: Alignment.topLeft, end: Alignment.bottomRight,
  );

  static const LinearGradient cardGradient = LinearGradient(
    colors: [Color(0xFFEEF1F8), Color(0xFFE0E5F2)],
    begin: Alignment.topLeft, end: Alignment.bottomRight,
  );

  // Skill Category Colors
  static const Map<String, Color> categoryColors = {
    'tech': Color(0xFF3B82F6),
    'language': Color(0xFFEC4899),
    'music': Color(0xFFA855F7),
    'art': Color(0xFFF59E0B),
    'cooking': Color(0xFFEF4444),
    'fitness': Color(0xFF22C55E),
    'business': Color(0xFF6366F1),
    'lifestyle': Color(0xFF14B8A6),
    'academic': Color(0xFF8B5CF6),
    'craft': Color(0xFFD97706),
    'photography': Color(0xFF0EA5E9),
    'dance': Color(0xFFF43F5E),
  };
}
