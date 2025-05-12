import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/category_controller.dart';
import 'package:service_booking_app/presentation/pages/home/widgets/service_card.dart';
import 'package:service_booking_app/presentation/widgets/custom_button.dart';
import 'package:service_booking_app/presentation/widgets/loading_indicator.dart';

class CategoryServicesList extends StatelessWidget {
  final CategoryController controller;

  const CategoryServicesList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoadingServices.value) {
        return const Center(
          child: Padding(
            padding: EdgeInsets.all(32.0),
            child: CircularProgressIndicator(),
          ),
        );
      }

      if (controller.categoryServices.isEmpty) {
        return _buildEmptyState(context);
      }

      return AnimationLimiter(
        child: ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: controller.categoryServices.length,
          itemBuilder: (context, index) {
            return _buildServiceItem(index);
          },
        ),
      );
    });
  }

  Widget _buildEmptyState(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              'no_services_in_category'.tr,
              style: Theme.of(context).textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 24),
            if (controller.isAdmin)
              CustomButton(
                text: 'add_service'.tr,
                onPressed: controller.goToCreateService,
                isOutlined: true,
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceItem(int index) {
    final service = controller.categoryServices[index];
    final categoryName = controller.category.value?.name ?? '';

    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: ServiceCard(
            service: service,
            categoryName: categoryName,
            onTap: () => controller.goToServiceDetails(service.id!),
          ),
        ),
      ),
    );
  }
}
