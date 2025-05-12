import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/settings_controller.dart';
import 'package:service_booking_app/presentation/widgets/settings_tile.dart';

class OtherSettingsSection extends StatelessWidget {
  final SettingsController controller;

  const OtherSettingsSection({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Other'.tr,
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: [
              SettingsTile(
                title: 'about'.tr,
                icon: Icons.info,
                onTap: () {
                  // Navigate to about page
                },
              ),
              const Divider(height: 1),
              SettingsTile(
                title: 'help'.tr,
                icon: Icons.help,
                onTap: () {
                  // Navigate to help page
                },
              ),
              const Divider(height: 1),
              SettingsTile(
                title: 'terms'.tr,
                icon: Icons.description,
                onTap: () {
                  // Navigate to terms page
                },
              ),
              const Divider(height: 1),
              SettingsTile(
                title: 'privacy'.tr,
                icon: Icons.privacy_tip,
                onTap: () {
                  // Navigate to privacy policy page
                },
              ),
              const Divider(height: 1),
              SettingsTile(
                title: 'clear_cache'.tr,
                icon: Icons.cleaning_services,
                onTap: controller.clearCache,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
