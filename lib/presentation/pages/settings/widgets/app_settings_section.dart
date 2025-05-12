import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/settings_controller.dart';
import 'package:service_booking_app/presentation/widgets/language_dialog.dart';
import 'package:service_booking_app/presentation/widgets/settings_tile.dart';
import 'package:service_booking_app/presentation/widgets/theme_dialog.dart';

class AppSettingsSection extends StatelessWidget {
  final SettingsController controller;

  const AppSettingsSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'app_settings'.tr,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: [
              // Language settings
              SettingsTile(
                title: 'language'.tr,
                icon: Icons.language,
                trailing: Obx(
                  () => Text(
                    controller.languageController.getLanguageName(
                      controller.languageController.currentLanguage.value,
                    ),
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder:
                        (context) => LanguageDialog(controller: controller),
                  );
                },
              ),
              const Divider(height: 1),

              // Theme settings
              SettingsTile(
                title: 'theme'.tr,
                icon: Icons.brightness_6,
                trailing: Obx(() {
                  String themeName;
                  switch (controller.themeController.themeMode.value) {
                    case ThemeMode.light:
                      themeName = 'light_mode'.tr;
                      break;
                    case ThemeMode.dark:
                      themeName = 'dark_mode'.tr;
                      break;
                    default:
                      themeName = 'system_theme'.tr;
                  }
                  return Text(
                    themeName,
                    style: Theme.of(context).textTheme.bodyMedium,
                  );
                }),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) => ThemeDialog(controller: controller),
                  );
                },
              ),
              const Divider(height: 1),

              // Notifications
              SettingsTile(
                title: 'notifications'.tr,
                icon: Icons.notifications,
                onTap: () {
                  // Navigate to notifications settings page
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
