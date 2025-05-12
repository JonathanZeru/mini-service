import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/core/theme/app_theme.dart';
import 'package:service_booking_app/presentation/controllers/home_controller.dart';
import 'package:service_booking_app/presentation/widgets/custom_button.dart';

class FilterDrawer extends StatelessWidget {
  final HomeController controller;

  const FilterDrawer({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'filters'.tr,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primaryColor,
                    ),
                  ),
                  TextButton.icon(
                    onPressed: () {
                      controller.resetFilters();
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.refresh),
                    label: Text('reset_filters'.tr),
                    style: TextButton.styleFrom(foregroundColor: Colors.red),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 16),

              // Price Range
              Text(
                'price_range'.tr,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Obx(
                () => RangeSlider(
                  min: controller.minPrice.value,
                  max: controller.maxPrice.value,
                  values: RangeValues(
                    controller.selectedMinPrice.value,
                    controller.selectedMaxPrice.value,
                  ),
                  divisions: 20,
                  labels: RangeLabels(
                    '\$${controller.selectedMinPrice.value.toStringAsFixed(0)}',
                    '\$${controller.selectedMaxPrice.value.toStringAsFixed(0)}',
                  ),
                  activeColor: AppTheme.primaryColor,
                  inactiveColor: AppTheme.primaryColor.withOpacity(0.2),
                  onChanged: (values) {
                    controller.updatePriceRange(values.start, values.end);
                  },
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '\$${controller.selectedMinPrice.value.toStringAsFixed(0)}',
                      ),
                      Text(
                        '\$${controller.selectedMaxPrice.value.toStringAsFixed(0)}',
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Rating
              Text(
                'min_rating'.tr,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Obx(
                () => Slider(
                  min: 0,
                  max: 5,
                  divisions: 10,
                  value: controller.selectedRating.value,
                  label: controller.selectedRating.value.toStringAsFixed(1),
                  activeColor: AppTheme.primaryColor,
                  inactiveColor: AppTheme.primaryColor.withOpacity(0.2),
                  onChanged: (value) {
                    controller.updateRatingFilter(value);
                  },
                ),
              ),
              Obx(
                () => Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('0'),
                      Row(
                        children: [
                          Text(
                            '${controller.selectedRating.value.toStringAsFixed(1)} ',
                          ),
                          const Icon(Icons.star, color: Colors.amber, size: 16),
                        ],
                      ),
                      const Text('5'),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 24),

              // Availability
              Text(
                'availability'.tr,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Obx(
                () => SwitchListTile(
                  title: Text('available_only'.tr),
                  value: controller.filterAvailableOnly.value,
                  onChanged: (value) {
                    controller.updateAvailabilityFilter(value);
                  },
                  activeColor: AppTheme.primaryColor,
                ),
              ),

              const Spacer(),

              // Apply button
              CustomButton(
                text: 'apply_filters'.tr,
                onPressed: () {
                  Navigator.pop(context);
                },
                width: double.infinity,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
