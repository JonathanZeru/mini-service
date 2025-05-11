import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/core/local/hive_manager.dart';
import 'package:service_booking_app/core/theme/app_theme.dart';

class LanguageController extends GetxController {
  final RxString currentLanguage = 'en'.obs;

  @override
  void onInit() {
    super.onInit();
    loadLanguage();
  }

  Future<void> loadLanguage() async {
    final savedLanguage = await HiveManager.getLanguage();
    changeLanguage(savedLanguage);
  }

  void changeLanguage(String languageCode) {
    currentLanguage.value = languageCode;
    Get.updateLocale(Locale(languageCode));
    HiveManager.saveLanguage(languageCode);

    // Show a notification to inform the user
    Get.snackbar(
      'language'.tr,
      'Language changed to ${getLanguageName(languageCode)}',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: AppTheme.primaryColor.withOpacity(0.2),
      colorText: AppTheme.primaryColor,
      duration: const Duration(seconds: 2),
    );
  }

  String getLanguageName(String code) {
    switch (code) {
      case 'en':
        return 'English';
      case 'am':
        return 'አማርኛ';
      default:
        return 'English';
    }
  }

  List<Map<String, String>> get availableLanguages => [
    {'code': 'en', 'name': 'English'},
    {'code': 'am', 'name': 'አማርኛ'},
  ];
}
