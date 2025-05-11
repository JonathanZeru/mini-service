import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/core/local/hive_manager.dart';
import 'package:service_booking_app/core/theme/app_theme.dart';

class ThemeController extends GetxController {
  final Rx<ThemeMode> themeMode = ThemeMode.system.obs;

  @override
  void onInit() {
    super.onInit();
    loadThemeMode();
  }

  Future<void> loadThemeMode() async {
    final savedThemeMode = await HiveManager.getThemeMode();
    switch (savedThemeMode) {
      case 'dark':
        setThemeMode(ThemeMode.dark);
        break;
      case 'light':
        setThemeMode(ThemeMode.light);
        break;
      default:
        setThemeMode(ThemeMode.system);
    }
  }

  void setThemeMode(ThemeMode mode) {
    themeMode.value = mode;
    Get.changeThemeMode(mode);
    HiveManager.saveThemeMode(_themeModeToString(mode));
    
    // Update status bar and navigation bar colors
    AppTheme.updateSystemUIOverlayStyle(mode);
  }

  String _themeModeToString(ThemeMode mode) {
    switch (mode) {
      case ThemeMode.dark:
        return 'dark';
      case ThemeMode.light:
        return 'light';
      case ThemeMode.system:
        return 'system';
    }
  }

  bool get isDarkMode {
    if (themeMode.value == ThemeMode.system) {
      return Get.isPlatformDarkMode;
    }
    return themeMode.value == ThemeMode.dark;
  }
}
