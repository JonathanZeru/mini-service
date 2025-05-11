import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/auth_controller.dart';
import 'package:service_booking_app/presentation/routes/app_routes.dart';

class LoginController extends GetxController {
  final AuthController authController;

  LoginController({required this.authController});

  final formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  
  final RxBool isPasswordVisible = false.obs;
  final RxBool rememberMe = false.obs;
  
  // Add this for form validation tracking
  final RxBool _isFormValid = false.obs;
  bool get isFormValid => _isFormValid.value;

  @override
  void onInit() {
    super.onInit();
    
    // Add listeners to text controllers
    usernameController.addListener(checkFormValidity);
    passwordController.addListener(checkFormValidity);
  }

  @override
  void onClose() {
    // Remove listeners to prevent memory leaks
    usernameController.removeListener(checkFormValidity);
    passwordController.removeListener(checkFormValidity);
    
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }

  // Add this method to validate the form
  void validateForm() {
    final formValid = formKey.currentState?.validate() ?? false;
    _isFormValid.value = formValid;
  }

  // Call this method whenever form fields change
  void checkFormValidity() {
    // We need to call this in the next frame because the form state
    // might not be updated yet when the text changes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (formKey.currentState != null) {
        validateForm();
      }
    });
  }

  void togglePasswordVisibility() {
    isPasswordVisible.value = !isPasswordVisible.value;
  }

  void toggleRememberMe(bool? value) {
    if (value != null) {
      rememberMe.value = value;
    }
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'username'.tr + ' ' + 'is required'.tr;
    }
    return null;
  }

  String? validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'password'.tr + ' ' + 'is required'.tr;
    }
    if (value.length < 6) {
      return 'password'.tr + ' ' + 'must be at least 6 characters'.tr;
    }
    return null;
  }

  Future<void> login() async {
    if (formKey.currentState?.validate() ?? false) {
      final username = usernameController.text.trim();
      final password = passwordController.text.trim();
      
      await authController.loginUser(username, password);
    }
  }

  void goToRegister() {
    // Use offAndToNamed instead of toNamed to replace the current screen
    // This ensures proper navigation and controller lifecycle management
    Get.offAndToNamed(Routes.register);
  }

  void goToForgotPassword() {
    // Implement forgot password functionality
    Get.snackbar(
      'info'.tr,
      'This feature is not implemented yet'.tr,
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
