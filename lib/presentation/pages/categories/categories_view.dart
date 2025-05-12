import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/core/theme/app_theme.dart';
import 'package:service_booking_app/presentation/controllers/home_controller.dart';
import 'package:service_booking_app/presentation/pages/categories/widgets/categories_list.dart';
import 'package:service_booking_app/presentation/pages/categories/widgets/categories_search_bar.dart';

class CategoriesView extends GetView<HomeController> {
  const CategoriesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('categories'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.refreshCategories,
            tooltip: 'refresh'.tr,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search bar
          CategoriesSearchBar(controller: controller),

          // Categories list
          Expanded(child: CategoriesList(controller: controller)),
        ],
      ),
    );
  }
}
