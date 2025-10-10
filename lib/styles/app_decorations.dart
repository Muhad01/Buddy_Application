import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppDecorations {
  // Card Decorations
  static BoxDecoration card = BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadowLight,
        blurRadius: 10,
        offset: const Offset(0, 2),
      ),
    ],
  );

  static BoxDecoration cardLarge = BoxDecoration(
    color: AppColors.surface,
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: AppColors.shadowLight,
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
    ],
  );

  // Button Decorations
  static BoxDecoration primaryButton = BoxDecoration(
    color: AppColors.primary,
    borderRadius: BorderRadius.circular(12),
  );

  static BoxDecoration secondaryButton = BoxDecoration(
    color: AppColors.surfaceVariant,
    borderRadius: BorderRadius.circular(12),
  );

  // Input Decorations
  static InputDecoration textField = InputDecoration(
    border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  );

  // Container Decorations
  static BoxDecoration gradientCard = BoxDecoration(
    gradient: const LinearGradient(
      colors: AppColors.primaryGradient,
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    ),
    borderRadius: BorderRadius.circular(20),
    boxShadow: [
      BoxShadow(
        color: AppColors.primary.withOpacity(0.3),
        blurRadius: 20,
        offset: const Offset(0, 10),
      ),
    ],
  );

  static BoxDecoration iconContainer = BoxDecoration(
    color: AppColors.primary.withOpacity(0.1),
    borderRadius: BorderRadius.circular(12),
  );

  static BoxDecoration streakBadge = BoxDecoration(
    color: AppColors.warning.withOpacity(0.1),
    borderRadius: BorderRadius.circular(20),
  );

  static BoxDecoration categoryBadge = BoxDecoration(
    color: AppColors.primary.withOpacity(0.1),
    borderRadius: BorderRadius.circular(12),
  );

  // Priority Indicators
  static BoxDecoration highPriorityIndicator = BoxDecoration(
    color: AppColors.highPriority,
    borderRadius: BorderRadius.circular(2),
  );

  static BoxDecoration mediumPriorityIndicator = BoxDecoration(
    color: AppColors.mediumPriority,
    borderRadius: BorderRadius.circular(2),
  );

  static BoxDecoration lowPriorityIndicator = BoxDecoration(
    color: AppColors.lowPriority,
    borderRadius: BorderRadius.circular(2),
  );

  // Progress Indicators
  static BoxDecoration progressBar = BoxDecoration(
    color: AppColors.surfaceVariant,
    borderRadius: BorderRadius.circular(4),
  );

  // Bottom Navigation
  static BoxDecoration bottomNavBar = BoxDecoration(
    color: AppColors.surface,
    boxShadow: [
      BoxShadow(
        color: AppColors.shadowLight,
        blurRadius: 10,
        offset: const Offset(0, -2),
      ),
    ],
  );

  // Tab Bar
  static BoxDecoration tabBar = BoxDecoration(
    color: AppColors.surfaceVariant,
    borderRadius: BorderRadius.circular(12),
  );

  static BoxDecoration tabIndicator = BoxDecoration(
    color: AppColors.primary,
    borderRadius: BorderRadius.circular(12),
  );

  // Modal Bottom Sheet
  static BoxDecoration modalBottomSheet = BoxDecoration(
    color: AppColors.surface,
    borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
  );

  // Profile Picture
  static BoxDecoration profilePicture = BoxDecoration(
    color: Colors.white.withOpacity(0.2),
    shape: BoxShape.circle,
  );

  static BoxDecoration profilePictureEdit = BoxDecoration(
    color: Colors.white,
    shape: BoxShape.circle,
  );

  // Color Options
  static BoxDecoration colorOption(Color color, bool isSelected) {
    return BoxDecoration(
      color: color,
      shape: BoxShape.circle,
      border: isSelected ? Border.all(color: Colors.white, width: 3) : null,
      boxShadow: isSelected
          ? [BoxShadow(color: color.withOpacity(0.5), blurRadius: 8)]
          : null,
    );
  }
}
