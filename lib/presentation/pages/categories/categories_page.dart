import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/categories_controller.dart';
import 'package:service_booking_app/presentation/pages/categories/widgets/category_card.dart';

class CategoriesPage extends GetView<CategoriesController> {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Categories'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.refreshCategories,
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              decoration: const InputDecoration(
                hintText: 'Search categories...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(),
              ),
              onChanged: controller.updateSearchQuery,
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (controller.filteredCategories.isEmpty) {
                return const Center(
                  child: Text('No categories found. Try a different search.'),
                );
              }
              
              return RefreshIndicator(
                onRefresh: controller.fetchCategories,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.filteredCategories.length,
                  itemBuilder: (context, index) {
                    final category = controller.filteredCategories[index];
                    return CategoryCard(
                      category: category,
                      onTap: () => controller.goToCategoryDetails(category.id!),
                      onDelete: () => controller.confirmDeleteCategory(category.id!),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.goToCreateCategory,
        child: const Icon(Icons.add),
      ),
    );
  }
}
