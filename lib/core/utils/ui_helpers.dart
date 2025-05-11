import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UIHelpers {
  static void showSnackbar({
    required String title,
    required String message,
    required bool isError,
  }) {
    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: isError ? Colors.red[100] : Colors.green[100],
      colorText: isError ? Colors.red[900] : Colors.green[900],
      margin: const EdgeInsets.all(16),
      duration: const Duration(seconds: 3),
      borderRadius: 8,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }

  static void showConfirmationDialog({
    required String title,
    required String message,
    required String confirmText,
    required VoidCallback onConfirm,
    String cancelText = 'Cancel',
  }) {
    Get.dialog(
      AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: Text(cancelText),
          ),
          TextButton(
            onPressed: () {
              Get.back();
              onConfirm();
            },
            child: Text(
              confirmText,
              style: TextStyle(
                color: confirmText.toLowerCase() == 'delete' ? Colors.red : null,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
