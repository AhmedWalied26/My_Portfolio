import 'package:flutter/material.dart';

class AppColors {
  static const Color background = Color(0xFF090D16);
  static const Color surface = Color(0xFF0F172A);
  static const Color surfaceVariant = Color(0xFF131D33);
  static const Color cardBg = Color(0x99111C35);
  static const Color cardHoverBg = Color(0xCC162344);

  static const Color primary = Color(0xFF00D2FF);
  static const Color primaryDark = Color(0xFF0099CC);
  static const Color secondary = Color(0xFF3B82F6);
  static const Color accentPurple = Color(0xFF8B5CF6);
  static const Color accentGreen = Color(0xFF10B981);
  static const Color accentAmber = Color(0xFFF59E0B);

  static const Color border = Color(0xFF1E293B);
  static const Color borderLight = Color(0xFF334155);
  static const Color borderActive = Color(0x6600D2FF);

  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFFB1BFD2);
  static const Color textMuted = Color(0xFF93A5BC);

  static const LinearGradient primaryGradient = LinearGradient(
    colors: [Color(0xFF00D2FF), Color(0xFF3B82F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient purpleGradient = LinearGradient(
    colors: [Color(0xFF8B5CF6), Color(0xFF3B82F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient cardBorderGradient = LinearGradient(
    colors: [Color(0x5500D2FF), Color(0x113B82F6), Color(0x228B5CF6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const RadialGradient heroGlowGradient = RadialGradient(
    colors: [Color(0x2200D2FF), Color(0x00090D16)],
    radius: 0.8,
  );
}
