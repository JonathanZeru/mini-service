import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/core/local/hive_manager.dart';
import 'package:service_booking_app/core/utils/ui_helpers.dart';
import 'package:service_booking_app/presentation/controllers/auth_controller.dart';
import 'package:service_booking_app/presentation/controllers/language_controller.dart';
import 'package:service_booking_app/presentation/controllers/theme_controller.dart';

class SettingsController extends GetxController {
  final AuthController authController;
  final LanguageController languageController;
  final ThemeController themeController;

  SettingsController({
    required this.authController,
    required this.languageController,
    required this.themeController,
  });

  final RxBool isLoading = false.obs;

  void changeLanguage(String languageCode) {
    languageController.changeLanguage(languageCode);
    UIHelpers.showSnackbar(
      title: 'success'.tr,
      message: 'Language changed successfully'.tr,
      isError: false,
    );
  }

  void changeThemeMode(ThemeMode mode) {
    themeController.setThemeMode(mode);
    UIHelpers.showSnackbar(
      title: 'success'.tr,
      message: 'Theme changed successfully'.tr,
      isError: false,
    );
  }

  Future<void> clearCache() async {
    isLoading.value = true;
    
    try {
      await HiveManager.clearAll();
      UIHelpers.showSnackbar(
        title: 'success'.tr,
        message: 'cache_cleared'.tr,
        isError: false,
      );
    } catch (e) {
      UIHelpers.showSnackbar(
        title: 'error'.tr,
        message: e.toString(),
        isError: true,
      );
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> logout() async {
    UIHelpers.showConfirmationDialog(
      title: 'logout'.tr,
      message: 'Are you sure you want to logout?'.tr,
      confirmText: 'logout'.tr,
      onConfirm: () => authController.logoutUser(),
    );
  }
}
