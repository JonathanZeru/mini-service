import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/settings_controller.dart';

class LogoutButton extends StatelessWidget {
  final SettingsController controller;

  const LogoutButton({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: controller.logout,
      icon: const Icon(Icons.logout),
      label: Text('logout'.tr),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.red,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }
}
