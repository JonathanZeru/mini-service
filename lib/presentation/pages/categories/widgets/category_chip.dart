import 'package:flutter/material.dart';
import 'package:service_booking_app/core/theme/app_theme.dart';

class CategoryChip extends StatelessWidget {
  final String label;
  final bool isSelected;
  final Function(bool) onSelected;

  const CategoryChip({
    super.key,
    required this.label,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      label: Text(label),
      selected: isSelected,
      onSelected: onSelected,
      checkmarkColor: Colors.white,
      selectedColor: AppTheme.primaryColor,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? Colors.grey[800]
          : Colors.grey[200],
      labelStyle: TextStyle(
        color: isSelected ? Colors.white : null,
        fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
      ),
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: isSelected ? 2 : 0,
      shadowColor: isSelected ? AppTheme.primaryColor.withOpacity(0.5) : null,
    );
  }
}
