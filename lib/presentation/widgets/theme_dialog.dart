import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/settings_controller.dart';

class ThemeDialog extends StatelessWidget {
  final SettingsController controller;

  const ThemeDialog({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('theme_settings'.tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text('light_mode'.tr),
            trailing: Obx(
              () => Radio<ThemeMode>(
                value: ThemeMode.light,
                groupValue: controller.themeController.themeMode.value,
                onChanged: (value) {
                  if (value != null) {
                    controller.changeThemeMode(value);
                    Navigator.pop(context);
                  }
                },
              ),
            ),
            onTap: () {
              controller.changeThemeMode(ThemeMode.light);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('dark_mode'.tr),
            trailing: Obx(
              () => Radio<ThemeMode>(
                value: ThemeMode.dark,
                groupValue: controller.themeController.themeMode.value,
                onChanged: (value) {
                  if (value != null) {
                    controller.changeThemeMode(value);
                    Navigator.pop(context);
                  }
                },
              ),
            ),
            onTap: () {
              controller.changeThemeMode(ThemeMode.dark);
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('system_theme'.tr),
            trailing: Obx(
              () => Radio<ThemeMode>(
                value: ThemeMode.system,
                groupValue: controller.themeController.themeMode.value,
                onChanged: (value) {
                  if (value != null) {
                    controller.changeThemeMode(value);
                    Navigator.pop(context);
                  }
                },
              ),
            ),
            onTap: () {
              controller.changeThemeMode(ThemeMode.system);
              Navigator.pop(context);
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('cancel'.tr),
        ),
      ],
    );
  }
}
