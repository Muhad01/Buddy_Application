# Flutter Styling System

This directory contains centralized styling for the Buddy app, similar to CSS but using Flutter's approach.

## Files Structure

- `app_colors.dart` - All color definitions
- `app_text_styles.dart` - All text styles and typography
- `app_decorations.dart` - Box decorations, borders, shadows
- `app_spacing.dart` - Spacing, padding, margins, sizes

## Usage Examples

### Colors
```dart
import '../styles/app_colors.dart';

// Instead of: Color(0xFF6366F1)
Container(
  color: AppColors.primary,
  child: Text('Hello', style: TextStyle(color: AppColors.textPrimary)),
)
```

### Text Styles
```dart
import '../styles/app_text_styles.dart';

// Instead of: TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Color(0xFF1E293B))
Text('Title', style: AppTextStyles.h1)
Text('Subtitle', style: AppTextStyles.bodyMedium)
```

### Decorations
```dart
import '../styles/app_decorations.dart';

// Instead of: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), ...)
Container(
  decoration: AppDecorations.card,
  child: Text('Card content'),
)
```

### Spacing
```dart
import '../styles/app_spacing.dart';

// Instead of: EdgeInsets.all(20)
Padding(
  padding: const EdgeInsets.all(AppSpacing.paddingXL),
  child: Text('Content'),
)
```

## Benefits

1. **Consistency** - All styling is centralized
2. **Maintainability** - Easy to update colors/styles globally
3. **Reusability** - No duplicate styling code
4. **Type Safety** - Compile-time checking for style properties
5. **Performance** - Styles are defined once and reused

## Migration Guide

To migrate existing screens:

1. Import the style files at the top
2. Replace hardcoded colors with `AppColors.*`
3. Replace hardcoded text styles with `AppTextStyles.*`
4. Replace hardcoded decorations with `AppDecorations.*`
5. Replace hardcoded spacing with `AppSpacing.*`

Example migration:
```dart
// Before
Container(
  padding: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    color: Colors.white,
    borderRadius: BorderRadius.circular(16),
    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10)],
  ),
  child: Text(
    'Title',
    style: TextStyle(
      fontSize: 28,
      fontWeight: FontWeight.bold,
      color: Color(0xFF1E293B),
    ),
  ),
)

// After
Container(
  padding: const EdgeInsets.all(AppSpacing.paddingXL),
  decoration: AppDecorations.card,
  child: Text('Title', style: AppTextStyles.h1),
)
```
