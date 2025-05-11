import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/settings_controller.dart';

class LanguageDialog extends StatelessWidget {
  final SettingsController controller;

  const LanguageDialog({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('language_settings'.tr),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: controller.languageController.availableLanguages
            .map((language) => ListTile(
                  title: Text(language['name']!),
                  trailing: Obx(() => Radio<String>(
                        value: language['code']!,
                        groupValue:
                            controller.languageController.currentLanguage.value,
                        onChanged: (value) {
                          if (value != null) {
                            controller.changeLanguage(value);
                            Navigator.pop(context);
                          }
                        },
                      )),
                  onTap: () {
                    controller.changeLanguage(language['code']!);
                    Navigator.pop(context);
                  },
                ))
            .toList(),
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
