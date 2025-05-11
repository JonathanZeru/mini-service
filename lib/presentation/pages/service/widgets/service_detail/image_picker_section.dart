import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/core/theme/app_theme.dart';
import 'package:service_booking_app/presentation/controllers/service_form_controller.dart';

class ImagePickerSection extends StatelessWidget {
  final ServiceFormController controller;

  const ImagePickerSection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: controller.showImageSourceDialog,
        child: Container(
          width: 200,
          height: 200,
          decoration: BoxDecoration(
            color: Theme.of(context).brightness == Brightness.dark
                ? Colors.grey[800]
                : Colors.grey[200],
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: AppTheme.primaryColor.withOpacity(0.5),
              width: 2,
            ),
          ),
          child: Obx(() {
            if (controller.imageFile.value != null) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.file(
                  controller.imageFile.value!,
                  fit: BoxFit.cover,
                ),
              );
            } else if (controller.imageUrl.value.isNotEmpty) {
              return ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: controller.imageUrl.value,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  errorWidget: (context, url, error) => const Center(
                    child: Icon(Icons.image_not_supported, size: 50),
                  ),
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.add_a_photo,
                      size: 50,
                      color: AppTheme.primaryColor.withOpacity(0.7),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'tap_to_add_image'.tr,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ],
                ),
              );
            }
          }),
        ),
      ),
    );
  }
}
