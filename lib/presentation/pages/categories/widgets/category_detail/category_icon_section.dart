import 'package:flutter/material.dart';
import 'package:service_booking_app/core/theme/app_theme.dart';

class CategoryIconSection extends StatelessWidget {
  const CategoryIconSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.2),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Icon(Icons.category, size: 50, color: AppTheme.primaryColor),
      ),
    );
  }
}
