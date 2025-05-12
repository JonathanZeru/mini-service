import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/widgets/custom_button.dart';

class ServiceActionButtons extends StatelessWidget {
  const ServiceActionButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Book now button
        CustomButton(
          text: 'book_now'.tr,
          onPressed: () {
            // Implement booking functionality
            Get.snackbar(
              'info'.tr,
              'booking_not_implemented'.tr,
              snackPosition: SnackPosition.BOTTOM,
            );
          },
          width: double.infinity,
        ),
        const SizedBox(height: 16),

        // Contact provider button
        CustomButton(
          text: 'contact_provider'.tr,
          onPressed: () {
            // Implement contact functionality
            Get.snackbar(
              'info'.tr,
              'contact_not_implemented'.tr,
              snackPosition: SnackPosition.BOTTOM,
            );
          },
          width: double.infinity,
          isOutlined: true,
        ),
      ],
    );
  }
}
