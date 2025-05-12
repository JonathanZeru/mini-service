import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/service_controller.dart';
import 'package:service_booking_app/presentation/pages/service/widgets/service_detail/related_services_section.dart';
import 'package:service_booking_app/presentation/pages/service/widgets/service_detail/service_action_buttons.dart';
import 'package:service_booking_app/presentation/pages/service/widgets/service_detail/service_header.dart';
import 'package:service_booking_app/presentation/pages/service/widgets/service_detail/service_info_section.dart';
import 'package:service_booking_app/presentation/pages/service/widgets/service_detail/service_not_found.dart';
import 'package:service_booking_app/presentation/widgets/loading_indicator.dart';

class ServiceDetailsPage extends GetView<ServiceController> {
  const ServiceDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: LoadingIndicator());
        }

        final service = controller.service.value;
        if (service == null) {
          return const ServiceNotFound();
        }

        return CustomScrollView(
          slivers: [
            // App bar with image
            ServiceHeader(service: service, controller: controller),

            // Service details
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Service info section
                    ServiceInfoSection(
                      service: service,
                      controller: controller,
                    ),
                    const SizedBox(height: 32),

                    // Action buttons
                    const ServiceActionButtons(),
                    const SizedBox(height: 32),

                    // Related services
                    const RelatedServicesSection(),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
