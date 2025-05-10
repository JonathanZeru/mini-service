import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/home_controller.dart';
import 'package:service_booking_app/presentation/pages/home/widgets/filter_drawer.dart';
import 'package:service_booking_app/presentation/pages/home/widgets/service_card.dart';

class HomePage extends GetView<HomeController> {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Service Booking App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.category),
            onPressed: controller.goToCategories,
            tooltip: 'Manage Categories',
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.refreshServices,
            tooltip: 'Refresh',
          ),
        ],
      ),
      drawer: FilterDrawer(controller: controller),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                TextField(
                  decoration: const InputDecoration(
                    hintText: 'Search services...',
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                  ),
                  onChanged: controller.updateSearchQuery,
                ),
                const SizedBox(height: 16),
                Obx(() => SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      FilterChip(
                        label: const Text('All'),
                        selected: controller.selectedCategoryId.value == 'All',
                        onSelected: (selected) {
                          if (selected) {
                            controller.updateSelectedCategory('All');
                          }
                        },
                      ),
                      const SizedBox(width: 8),
                      ...controller.categories.map((category) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: FilterChip(
                            label: Text(category.name),
                            selected: controller.selectedCategoryId.value == category.id,
                            onSelected: (selected) {
                              if (selected) {
                                controller.updateSelectedCategory(category.id!);
                              }
                            },
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                )),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Obx(() => FilterChip(
                      label: const Text('Available Only'),
                      selected: controller.filterAvailableOnly.value,
                      onSelected: (selected) {
                        controller.updateAvailabilityFilter(selected);
                      },
                    )),
                    const Spacer(),
                    // Use Builder to get a context that's a child of Scaffold
                    Builder(
                      builder: (context) => TextButton.icon(
                        onPressed: () {
                          Scaffold.of(context).openDrawer();
                        },
                        icon: const Icon(Icons.filter_list),
                        label: const Text('More Filters'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }
              
              if (controller.filteredServices.isEmpty) {
                return const Center(
                  child: Text('No services found. Try different filters.'),
                );
              }
              
              return RefreshIndicator(
                onRefresh: controller.fetchServices,
                child: ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: controller.filteredServices.length,
                  itemBuilder: (context, index) {
                    final service = controller.filteredServices[index];
                    // Find category name
                    final category = controller.categories
                        .firstWhereOrNull((c) => c.id == service.categoryId);
                    final categoryName = category?.name ?? 'Unknown';
                    
                    return ServiceCard(
                      service: service,
                      categoryName: categoryName,
                      onTap: () => controller.goToServiceDetails(service.id!),
                    );
                  },
                ),
              );
            }),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: controller.goToCreateService,
        child: const Icon(Icons.add),
      ),
    );
  }
}
