import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/language_controller.dart';

class LanguageSelector extends StatelessWidget {
  final Color? iconColor;

  const LanguageSelector({super.key, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: Icon(Icons.language, color: iconColor ?? Colors.white),
      tooltip: 'language'.tr,
      onSelected: (String languageCode) {
        final languageController = Get.find<LanguageController>();
        languageController.changeLanguage(languageCode);
      },
      itemBuilder: (BuildContext context) {
        final languageController = Get.find<LanguageController>();
        return languageController.availableLanguages.map((language) {
          return PopupMenuItem<String>(
            value: language['code'],
            child: Row(
              children: [
                Obx(
                  () => Radio<String>(
                    value: language['code']!,
                    groupValue: languageController.currentLanguage.value,
                    onChanged: null,
                  ),
                ),
                const SizedBox(width: 8),
                Text(language['name']!),
              ],
            ),
          );
        }).toList();
      },
    );
  }
}
