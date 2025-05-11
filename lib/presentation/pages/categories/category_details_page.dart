import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/category_controller.dart';
import 'package:service_booking_app/presentation/pages/categories/widgets/category_detail/category_header.dart';
import 'package:service_booking_app/presentation/pages/categories/widgets/category_detail/category_not_found.dart';
import 'package:service_booking_app/presentation/pages/categories/widgets/category_detail/category_services_header.dart';
import 'package:service_booking_app/presentation/pages/categories/widgets/category_detail/category_services_list.dart';
import 'package:service_booking_app/presentation/widgets/loading_indicator.dart';

class CategoryDetailsPage extends GetView<CategoryController> {
  const CategoryDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: _buildBody(),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Obx(() => controller.isLoading.value ? const Text('') :  Text(controller.category.value!.name ?? '')),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: controller.refreshCategory,
          tooltip: 'refresh'.tr,
        ),
       IconButton(
                icon: const Icon(Icons.edit),
                onPressed: controller.goToEditCategory,
                tooltip: 'edit'.tr,
              ),
        IconButton(
                icon: const Icon(Icons.delete),
                onPressed: controller.confirmDelete,
                tooltip: 'delete'.tr,
              )
      ],
    );
  }

  Widget _buildBody() {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: LoadingIndicator());
      }

      final category = controller.category.value;
      if (category == null) {
        return const CategoryNotFound();
      }

      return SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category header
            CategoryHeader(category: category),
            const SizedBox(height: 24),
            
            // Services in this category header
            CategoryServicesHeader(controller: controller),
            const SizedBox(height: 16),
            
            // Services list
            CategoryServicesList(controller: controller),
          ],
        ),
      );
    });
  }
}
