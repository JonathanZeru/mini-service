import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/service_form_controller.dart';

class ServiceFormFields extends StatelessWidget {
  final ServiceFormController controller;

  const ServiceFormFields({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Category dropdown
        DropdownButtonFormField<String>(
          decoration: InputDecoration(
            labelText: 'service_category'.tr,
            hintText: 'select_category'.tr,
            prefixIcon: const Icon(Icons.category),
            border: const OutlineInputBorder(),
          ),
          value: controller.selectedCategory.value?.id,
          items: controller.categories.map((category) {
            return DropdownMenuItem<String>(
              value: category.id,
              child: Text(category.name),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              final category = controller.categories.firstWhere((c) => c.id == value);
              controller.setSelectedCategory(category);
            }
          },
          validator: (_) => controller.validateCategory(),
        ),
        const SizedBox(height: 16),
        
        // Service name
        TextFormField(
          controller: controller.nameController,
          decoration: InputDecoration(
            labelText: 'service_name'.tr,
            hintText: 'enter_service_name'.tr,
            prefixIcon: const Icon(Icons.home_repair_service),
            border: const OutlineInputBorder(),
          ),
          validator: (value) => controller.validateNotEmpty(value, 'service_name'.tr),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        
        // Price
        TextFormField(
          controller: controller.priceController,
          decoration: InputDecoration(
            labelText: 'service_price'.tr,
            hintText: 'enter_price'.tr,
            prefixIcon: const Icon(Icons.attach_money),
            border: const OutlineInputBorder(),
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
          ],
          validator: (value) => controller.validateNumeric(value, 'service_price'.tr),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        
        // Duration
        TextFormField(
          controller: controller.durationController,
          decoration: InputDecoration(
            labelText: 'service_duration'.tr,
            hintText: 'enter_duration_minutes'.tr,
            prefixIcon: const Icon(Icons.access_time),
            border: const OutlineInputBorder(),
            suffixText: 'minutes'.tr,
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [
            FilteringTextInputFormatter.digitsOnly,
          ],
          validator: (value) => controller.validateInteger(value, 'service_duration'.tr),
          textInputAction: TextInputAction.next,
        ),
        const SizedBox(height: 16),
        
        // Rating
        TextFormField(
          controller: controller.ratingController,
          decoration: InputDecoration(
            labelText: 'service_rating'.tr,
            hintText: 'enter_rating'.tr,
            prefixIcon: const Icon(Icons.star),
            border: const OutlineInputBorder(),
            suffixText: '/ 5',
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
          ],
          validator: controller.validateRating,
          textInputAction: TextInputAction.next,
        ),
      ],
    );
  }
}
