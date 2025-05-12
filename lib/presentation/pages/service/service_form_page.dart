import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/service_form_controller.dart';
import 'package:service_booking_app/presentation/pages/service/widgets/service_detail/availability_toggle.dart';
import 'package:service_booking_app/presentation/pages/service/widgets/service_detail/image_picker_section.dart';
import 'package:service_booking_app/presentation/pages/service/widgets/service_form/service_form_buttons.dart';
import 'package:service_booking_app/presentation/pages/service/widgets/service_form/service_form_fields.dart';
import 'package:service_booking_app/presentation/widgets/loading_indicator.dart';

class ServiceFormPage extends GetView<ServiceFormController> {
  final bool isEditing;

  const ServiceFormPage({super.key, required this.isEditing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'edit_service'.tr : 'add_service'.tr),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: LoadingIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Image selection
                ImagePickerSection(controller: controller),
                const SizedBox(height: 24),

                // Form fields
                ServiceFormFields(controller: controller),
                const SizedBox(height: 16),

                // Availability toggle
                AvailabilityToggle(controller: controller),
                const SizedBox(height: 32),

                // Form buttons
                ServiceFormButtons(
                  controller: controller,
                  isEditing: isEditing,
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        );
      }),
    );
  }
}
