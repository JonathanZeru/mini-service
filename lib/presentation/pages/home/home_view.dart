import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/core/theme/app_theme.dart';
import 'package:service_booking_app/presentation/controllers/home_controller.dart';
import 'package:service_booking_app/presentation/pages/home/widgets/search_filter_section.dart';
import 'package:service_booking_app/presentation/pages/home/widgets/services_list.dart';
import 'package:service_booking_app/presentation/pages/home/widgets/filter_drawer.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('services'.tr),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.refreshServices,
            tooltip: 'refresh'.tr,
          ),
        ],
      ),
      drawer: FilterDrawer(controller: controller),
      body: RefreshIndicator(
        onRefresh: () async => controller.refreshServices(),
        color: AppTheme.primaryColor,
        child: Column(
          children: [
            // Search and filter section
            SearchFilterSection(controller: controller),

            // Services list
            Expanded(child: ServicesList(controller: controller)),
          ],
        ),
      ),
    );
  }
}
