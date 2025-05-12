import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/home_controller.dart';
import 'package:service_booking_app/presentation/controllers/settings_controller.dart';
import 'package:service_booking_app/presentation/pages/settings/widgets/account_settings_section.dart';
import 'package:service_booking_app/presentation/pages/settings/widgets/app_settings_section.dart';
import 'package:service_booking_app/presentation/pages/settings/widgets/logout_button.dart';
import 'package:service_booking_app/presentation/pages/settings/widgets/other_settings_section.dart';

class SettingsView extends GetView<HomeController> {
  const SettingsView({super.key});

  @override
  Widget build(BuildContext context) {
    // Get the settings controller
    final settingsController = Get.find<SettingsController>();

    return Scaffold(
      appBar: AppBar(title: Text('settings'.tr)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // Account settings section
          const AccountSettingsSection(),
          const SizedBox(height: 24),

          // App settings section
          AppSettingsSection(controller: settingsController),
          const SizedBox(height: 24),

          // Other settings section
          OtherSettingsSection(controller: settingsController),
          const SizedBox(height: 24),

          // Logout button
          LogoutButton(controller: settingsController),
        ],
      ),
    );
  }
}
