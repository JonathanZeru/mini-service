import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/home_controller.dart';

class FilterDrawer extends StatelessWidget {
  final HomeController controller;

  const FilterDrawer({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Filters',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  TextButton(
                    onPressed: () {
                      controller.resetFilters();
                      Navigator.pop(context);
                    },
                    child: const Text('Reset All'),
                  ),
                ],
              ),
              const Divider(),
              const SizedBox(height: 16),
              
              // Price Range
              Text(
                'Price Range',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Obx(() => RangeSlider(
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
                onChanged: (values) {
                  controller.updatePriceRange(values.start, values.end);
                },
              )),
              Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('\$${controller.selectedMinPrice.value.toStringAsFixed(0)}'),
                    Text('\$${controller.selectedMaxPrice.value.toStringAsFixed(0)}'),
                  ],
                ),
              )),
              const SizedBox(height: 24),
              
              // Rating
              Text(
                'Minimum Rating',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Obx(() => Slider(
                min: 0,
                max: 5,
                divisions: 10,
                value: controller.selectedRating.value,
                label: controller.selectedRating.value.toStringAsFixed(1),
                onChanged: (value) {
                  controller.updateRatingFilter(value);
                },
              )),
              Obx(() => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('0'),
                    Row(
                      children: [
                        Text('${controller.selectedRating.value.toStringAsFixed(1)} '),
                        const Icon(Icons.star, color: Colors.amber, size: 16),
                      ],
                    ),
                    const Text('5'),
                  ],
                ),
              )),
              const SizedBox(height: 24),
              
              // Availability
              Text(
                'Availability',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Obx(() => SwitchListTile(
                title: const Text('Show Available Only'),
                value: controller.filterAvailableOnly.value,
                onChanged: (value) {
                  controller.updateAvailabilityFilter(value);
                },
              )),
              const Spacer(),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Apply Filters'),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
