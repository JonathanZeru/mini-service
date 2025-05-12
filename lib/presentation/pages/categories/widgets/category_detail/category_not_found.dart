import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/widgets/custom_button.dart';

class CategoryNotFound extends StatelessWidget {
  const CategoryNotFound({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
          const SizedBox(height: 16),
          Text(
            'category_not_found'.tr,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 24),
          CustomButton(
            text: 'go_back'.tr,
            onPressed: () => Get.back(),
            isOutlined: true,
          ),
        ],
      ),
    );
  }
}
