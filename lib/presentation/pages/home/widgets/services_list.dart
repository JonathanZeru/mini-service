import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:service_booking_app/presentation/controllers/home_controller.dart';
import 'package:service_booking_app/presentation/pages/home/widgets/service_card.dart';
import 'package:service_booking_app/presentation/widgets/empty_state.dart';
import 'package:service_booking_app/presentation/widgets/loading_indicator.dart';

class ServicesList extends StatelessWidget {
  final HomeController controller;

  const ServicesList({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return Center(
          child: Lottie.asset(
            'assets/animations/loading.json',
            width: 200,
            height: 200,
          ),
        );
      }
      
      if (controller.filteredServices.isEmpty) {
        return EmptyState(
          icon: Icons.search_off_rounded,
          title: 'no_services_found'.tr,
          message: 'try_different_filters'.tr,
          buttonText: 'reset_filters'.tr,
          onButtonPressed: controller.resetFilters,
        );
      }
      
      return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
              !controller.isLoadingMore.value &&
              controller.hasMoreServices.value) {
            controller.loadMoreServices();
          }
          return false;
        },
        child: AnimationLimiter(
          child: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: controller.filteredServices.length + 
                      (controller.isLoadingMore.value || controller.hasMoreServices.value ? 1 : 0),
            itemBuilder: (context, index) {
              // Show loading indicator at the bottom
              if (index == controller.filteredServices.length) {
                return _buildLoadMoreIndicator();
              }
              
              return _buildServiceItem(context, index);
            },
          ),
        ),
      );
    });
  }

  Widget _buildLoadMoreIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child: controller.isLoadingMore.value
            ? const LoadingIndicator(size: 50)
            : TextButton(
                onPressed: controller.loadMoreServices,
                child: Text('load_more'.tr),
              ),
      ),
    );
  }

  Widget _buildServiceItem(BuildContext context, int index) {
    final service = controller.filteredServices[index];
    // Find category name
    final category = controller.categories
        .firstWhereOrNull((c) => c.id == service.categoryId);
    final categoryName = category?.name ?? 'unknown'.tr;
    
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Hero(
            tag: 'service-${service.id}',
            child: ServiceCard(
              service: service,
              categoryName: categoryName,
              onTap: () => controller.goToServiceDetails(service.id!),
            ),
          ),
        ),
      ),
    );
  }
}
