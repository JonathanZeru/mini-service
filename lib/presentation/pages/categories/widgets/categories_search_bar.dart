import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/home_controller.dart';
import 'package:service_booking_app/presentation/widgets/animated_search_bar.dart';

class CategoriesSearchBar extends StatelessWidget {
  final HomeController controller;

  const CategoriesSearchBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: AnimatedSearchBar(
        onChanged: controller.updateCategorySearchQuery,
        hintText: 'search_categories'.tr,
      ),
    );
  }
}
