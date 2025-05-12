import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/core/theme/app_theme.dart';
import 'package:service_booking_app/presentation/controllers/category_controller.dart';

class CategoryServicesHeader extends StatelessWidget {
  final CategoryController controller;

  const CategoryServicesHeader({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'services_in_category'.tr,
          style: Theme.of(
            context,
          ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        Obx(
          () =>
              controller.isAdmin
                  ? TextButton.icon(
                    onPressed: controller.goToCreateService,
                    icon: const Icon(Icons.add),
                    label: Text('add_service'.tr),
                    style: TextButton.styleFrom(
                      foregroundColor: AppTheme.primaryColor,
                    ),
                  )
                  : const SizedBox.shrink(),
        ),
      ],
    );
  }
}
