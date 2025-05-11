import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/widgets/settings_tile.dart';

class AccountSettingsSection extends StatelessWidget {
  const AccountSettingsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'account_settings'.tr,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: [
              SettingsTile(
                title: 'edit_profile'.tr,
                icon: Icons.person,
                onTap: () {
                  // Navigate to edit profile page
                },
              ),
              const Divider(height: 1),
              SettingsTile(
                title: 'change_password'.tr,
                icon: Icons.lock,
                onTap: () {
                  // Navigate to change password page
                },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
