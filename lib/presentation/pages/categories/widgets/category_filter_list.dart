import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/home_controller.dart';
import 'package:service_booking_app/presentation/pages/categories/widgets/category_chip.dart';

class CategoryFilterList extends StatelessWidget {
  final HomeController controller;

  const CategoryFilterList({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Obx(() {
        final selectedId = controller.selectedCategoryId.value;
        return AnimationLimiter(
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: controller.categories.length + 1, // +1 for "All" option
            itemBuilder: (context, index) {
              final isAll = index == 0;
              final isSelected =
                  isAll
                      ? selectedId == null
                      : controller.categories[index - 1].id == selectedId;

              return AnimationConfiguration.staggeredList(
                position: index,
                duration: const Duration(milliseconds: 375),
                child: SlideAnimation(
                  horizontalOffset: 50.0,
                  child: FadeInAnimation(
                    child: Padding(
                      padding: EdgeInsets.only(
                        left: index == 0 ? 0 : 8,
                        right: 8,
                      ),
                      child: CategoryChip(
                        label:
                            isAll
                                ? 'all'.tr
                                : controller.categories[index - 1].name,
                        isSelected: isSelected,
                        onSelected: (_) {
                          controller.updateSelectedCategory(
                            isAll ? null : controller.categories[index - 1].id,
                          );
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }
}
