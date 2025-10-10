import 'package:flutter/material.dart';

class AppColors {
  // Primary Colors
  static const Color primary = Color(0xFF6366F1);
  static const Color primaryLight = Color(0xFF8B5CF6);
  static const Color primaryDark = Color(0xFF4F46E5);

  // Background Colors
  static const Color background = Color(0xFFF8FAFC);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF1F5F9);

  // Text Colors
  static const Color textPrimary = Color(0xFF1E293B);
  static const Color textSecondary = Color(0xFF64748B);
  static const Color textTertiary = Color(0xFF94A3B8);

  // Status Colors
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFF59E0B);
  static const Color error = Color(0xFFEF4444);
  static const Color info = Color(0xFF3B82F6);

  // Category Colors
  static const Color work = Color(0xFF6366F1);
  static const Color health = Color(0xFF10B981);
  static const Color personal = Color(0xFF8B5CF6);
  static const Color learning = Color(0xFFF59E0B);
  static const Color neutral = Color(0xFF6B7280);

  // Habit Colors
  static const Color water = Color(0xFF3B82F6);
  static const Color exercise = Color(0xFFF59E0B);
  static const Color meditation = Color(0xFF8B5CF6);
  static const Color sleep = Color(0xFF06B6D4);
  static const Color reading = Color(0xFF10B981);

  // Priority Colors
  static const Color highPriority = Color(0xFFEF4444);
  static const Color mediumPriority = Color(0xFFF59E0B);
  static const Color lowPriority = Color(0xFF10B981);

  // Gradient Colors
  static const List<Color> primaryGradient = [primary, primaryLight];
  static const List<Color> successGradient = [
    Color(0xFF10B981),
    Color(0xFF059669),
  ];
  static const List<Color> warningGradient = [
    Color(0xFFF59E0B),
    Color(0xFFD97706),
  ];

  // Shadow Colors
  static Color shadowLight = Colors.black.withOpacity(0.05);
  static Color shadowMedium = Colors.black.withOpacity(0.1);
  static Color shadowDark = Colors.black.withOpacity(0.2);
}
