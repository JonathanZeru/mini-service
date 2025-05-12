import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:service_booking_app/core/theme/app_theme.dart';
import 'package:service_booking_app/presentation/controllers/home_controller.dart';
import 'package:service_booking_app/presentation/pages/categories/widgets/category_form/category_card.dart';
import 'package:service_booking_app/presentation/widgets/empty_state.dart';
import 'package:service_booking_app/presentation/widgets/loading_indicator.dart';

class CategoriesList extends StatelessWidget {
  final HomeController controller;

  const CategoriesList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isCategoriesLoading.value) {
        return Center(
          child: Lottie.asset(
            'assets/animations/loading.json',
            width: 200,
            height: 200,
          ),
        );
      }

      if (controller.filteredCategories.isEmpty) {
        return EmptyState(
          icon: Icons.category_outlined,
          title: 'no_categories_found'.tr,
          message: 'try_different_search'.tr,
          buttonText:
              controller.categorySearchQuery.value.isNotEmpty
                  ? 'clear_search'.tr
                  : 'add_category'.tr,
          onButtonPressed:
              controller.categorySearchQuery.value.isNotEmpty
                  ? () => controller.updateCategorySearchQuery('')
                  : controller.goToCreateCategory,
        );
      }

      return RefreshIndicator(
        onRefresh: () async => controller.refreshCategories(),
        color: AppTheme.primaryColor,
        child: NotificationListener<ScrollNotification>(
          onNotification: (ScrollNotification scrollInfo) {
            if (scrollInfo.metrics.pixels ==
                    scrollInfo.metrics.maxScrollExtent &&
                !controller.isLoadingMoreCategories.value &&
                controller.hasMoreCategories.value) {
              controller.loadMoreCategories();
            }
            return false;
          },
          child: AnimationLimiter(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount:
                  controller.filteredCategories.length +
                  (controller.isLoadingMoreCategories.value ||
                          controller.hasMoreCategories.value
                      ? 1
                      : 0),
              itemBuilder: (context, index) {
                // Show loading indicator at the bottom
                if (index == controller.filteredCategories.length) {
                  return _buildLoadMoreIndicator();
                }

                return _buildCategoryItem(index);
              },
            ),
          ),
        ),
      );
    });
  }

  Widget _buildLoadMoreIndicator() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: Center(
        child:
            controller.isLoadingMoreCategories.value
                ? const LoadingIndicator(size: 50)
                : TextButton(
                  onPressed: controller.loadMoreCategories,
                  child: Text('load_more'.tr),
                ),
      ),
    );
  }

  Widget _buildCategoryItem(int index) {
    final category = controller.filteredCategories[index];
    return AnimationConfiguration.staggeredList(
      position: index,
      duration: const Duration(milliseconds: 375),
      child: SlideAnimation(
        verticalOffset: 50.0,
        child: FadeInAnimation(
          child: Hero(
            tag: 'category-${category.id}',
            child: CategoryCard(
              category: category,
              onTap: () => controller.goToCategoryDetails(category.id!),
              onDelete: () => controller.confirmDeleteCategory(category.id!),
            ),
          ),
        ),
      ),
    );
  }
}
