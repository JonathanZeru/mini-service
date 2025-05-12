import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/core/theme/app_theme.dart';
import 'package:service_booking_app/presentation/controllers/home_controller.dart';
import 'package:service_booking_app/presentation/pages/categories/widgets/category_filter_list.dart';
import 'package:service_booking_app/presentation/widgets/animated_search_bar.dart';

class SearchFilterSection extends StatelessWidget {
  final HomeController controller;

  const SearchFilterSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        children: [
          // Animated search bar
          AnimatedSearchBar(
            onChanged: controller.updateSearchQuery,
            hintText: 'search_services'.tr,
          ),
          const SizedBox(height: 16),

          // Category filters
          CategoryFilterList(controller: controller),

          // Quick filters
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              children: [
                Obx(
                  () => FilterChip(
                    label: Text('available_only'.tr),
                    selected: controller.filterAvailableOnly.value,
                    onSelected: controller.updateAvailabilityFilter,
                    checkmarkColor: Colors.white,
                    selectedColor: AppTheme.primaryColor,
                    labelStyle: TextStyle(
                      color:
                          controller.filterAvailableOnly.value
                              ? Colors.white
                              : null,
                    ),
                  ),
                ),
                const Spacer(),
                // More filters button
                Builder(
                  builder:
                      (context) => TextButton.icon(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: const Icon(Icons.filter_list),
                        label: Text('more_filters'.tr),
                        style: TextButton.styleFrom(
                          foregroundColor: AppTheme.primaryColor,
                        ),
                      ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
