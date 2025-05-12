import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/core/theme/app_theme.dart';
import 'package:service_booking_app/presentation/controllers/home_controller.dart';
import 'package:service_booking_app/presentation/pages/categories/categories_view.dart';
import 'package:service_booking_app/presentation/pages/home/home_view.dart';
import 'package:service_booking_app/presentation/pages/settings/settings_view.dart';

class MainLayoutPage extends GetView<HomeController> {
  const MainLayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
        () => IndexedStack(
          index: controller.currentIndex.value,
          children: const [
            // Main views
            HomeView(),
            CategoriesView(),
            SettingsView(),
          ],
        ),
      ),
      bottomNavigationBar: Obx(
        () => NavigationBar(
          selectedIndex: controller.currentIndex.value,
          onDestinationSelected: controller.changeTab,
          backgroundColor:
              Theme.of(context).brightness == Brightness.dark
                  ? AppTheme.darkSurfaceColor
                  : AppTheme.lightSurfaceColor,
          elevation: 8,
          animationDuration: const Duration(milliseconds: 400),
          destinations: [
            NavigationDestination(
              icon: const Icon(Icons.home_outlined),
              selectedIcon: const Icon(Icons.home),
              label: 'home'.tr,
            ),
            NavigationDestination(
              icon: const Icon(Icons.category_outlined),
              selectedIcon: const Icon(Icons.category),
              label: 'categories'.tr,
            ),
            NavigationDestination(
              icon: const Icon(Icons.settings_outlined),
              selectedIcon: const Icon(Icons.settings),
              label: 'settings'.tr,
            ),
          ],
        ),
      ),
      floatingActionButton: Obx(
        () =>
            // Only show FAB on Home and Categories tabs
            (controller.currentIndex.value == 0 ||
                    controller.currentIndex.value == 1)
                ? FloatingActionButton(
                  onPressed:
                      controller.currentIndex.value == 0
                          ? controller.goToCreateService
                          : controller.goToCreateCategory,
                  backgroundColor: AppTheme.primaryColor,
                  child: const Icon(Icons.add),
                )
                : const SizedBox.shrink(),
      ),
    );
  }
}
