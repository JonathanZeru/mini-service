import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/auth_controller.dart';
import 'package:service_booking_app/presentation/routes/app_routes.dart';

class RegisterController extends GetxController {
  final AuthController authController;

  RegisterController({required this.authController});

  final formKey = GlobalKey<FormState>();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();
  
  final RxBool isPasswordVisible = false.obs;
  final RxBool isConfirmPasswordVisible = false.obs;
  final RxBool agreeToTerms = false.obs;
  
  // Add this for form validation tracking
  final RxBool _isFormValid = false.obs;
  bool get isFormValid => _isFormValid.value;

  @override
  void onInit() {
    super.onInit();
    
    // Add listeners to text controllers
    usernameController.addListener(checkFormValidity);
    emailController.addListener(checkFormValidity);
    passwordController.addListener(checkFormValidity);
    confirmPasswordController.addListener(checkFormValidity);
    
    // Add reaction to terms checkbox
    ever(agreeToTerms, (_) => checkFormValidity());
  }

  @override
  void onClose() {
    // Remove listeners to prevent memory leaks
    usernameController.removeListener(checkFormValidity);
    emailController.removeListener(checkFormValidity);
    passwordController.removeListener(checkFormValidity);
    confirmPasswordController.removeListener(checkFormValidity);
    
    usernameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.onClose();
  }

  // Add this method to validate the form
  void validateForm() {
    final formValid = formKey.currentState?.validate() ?? false;
    // Form is only valid if all fields are valid AND terms are agreed to
    _isFormValid.value = formValid && agreeToTerms.value;
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

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordVisible.value = !isConfirmPasswordVisible.value;
  }

  void toggleAgreeToTerms(bool? value) {
    if (value != null) {
      agreeToTerms.value = value;
      // Check form validity when terms checkbox changes
      checkFormValidity();
    }
  }

  String? validateUsername(String? value) {
    if (value == null || value.isEmpty) {
      return 'username'.tr + ' ' + 'is required'.tr;
    }
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'email'.tr + ' ' + 'is required'.tr;
    }
    if (!GetUtils.isEmail(value)) {
      return 'Please enter a valid email'.tr;
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

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'confirm_password'.tr + ' ' + 'is required'.tr;
    }
    if (value != passwordController.text) {
      return 'Passwords do not match'.tr;
    }
    return null;
  }

  Future<void> register() async {
    if (!agreeToTerms.value) {
      Get.snackbar(
        'error'.tr,
        'You must agree to the Terms and Conditions'.tr,
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red[100],
        colorText: Colors.red[900],
      );
      return;
    }
    
    if (formKey.currentState?.validate() ?? false) {
      final username = usernameController.text.trim();
      final email = emailController.text.trim();
      final password = passwordController.text.trim();
      
      await authController.registerUser(username, email, password);
    }
  }

  void goToLogin() {
    Get.offAndToNamed(Routes.login);
  }
}
