import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/core/theme/app_theme.dart';
import 'package:service_booking_app/presentation/controllers/register_controller.dart';
import 'package:service_booking_app/presentation/widgets/custom_button.dart';
import 'package:service_booking_app/presentation/controllers/language_controller.dart';
import 'package:service_booking_app/presentation/widgets/language_selector.dart';

class RegisterPage extends GetView<RegisterController> {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('register'.tr),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
        actions: [
          const LanguageSelector(),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: controller.formKey,
              // Add onChanged callback to validate form when any field changes
              onChanged: controller.validateForm,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // Username field
                  TextFormField(
                    controller: controller.usernameController,
                    decoration: InputDecoration(
                      labelText: 'username'.tr,
                      prefixIcon: const Icon(Icons.person),
                      border: const OutlineInputBorder(),
                    ),
                    validator: controller.validateUsername,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  
                  // Email field
                  TextFormField(
                    controller: controller.emailController,
                    decoration: InputDecoration(
                      labelText: 'email'.tr,
                      prefixIcon: const Icon(Icons.email),
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                    validator: controller.validateEmail,
                    textInputAction: TextInputAction.next,
                  ),
                  const SizedBox(height: 16),
                  
                  // Password field
                  Obx(() => TextFormField(
                    controller: controller.passwordController,
                    decoration: InputDecoration(
                      labelText: 'password'.tr,
                      prefixIcon: const Icon(Icons.lock),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isPasswordVisible.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: controller.togglePasswordVisibility,
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    obscureText: !controller.isPasswordVisible.value,
                    validator: controller.validatePassword,
                    textInputAction: TextInputAction.next,
                  )),
                  const SizedBox(height: 16),
                  
                  // Confirm password field
                  Obx(() => TextFormField(
                    controller: controller.confirmPasswordController,
                    decoration: InputDecoration(
                      labelText: 'confirm_password'.tr,
                      prefixIcon: const Icon(Icons.lock_outline),
                      suffixIcon: IconButton(
                        icon: Icon(
                          controller.isConfirmPasswordVisible.value
                              ? Icons.visibility_off
                              : Icons.visibility,
                        ),
                        onPressed: controller.toggleConfirmPasswordVisibility,
                      ),
                      border: const OutlineInputBorder(),
                    ),
                    obscureText: !controller.isConfirmPasswordVisible.value,
                    validator: controller.validateConfirmPassword,
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => controller.register(),
                  )),
                  const SizedBox(height: 16),
                  
                  // Terms and conditions checkbox
                  Row(
                    children: [
                      Obx(() => Checkbox(
                        value: controller.agreeToTerms.value,
                        onChanged: controller.toggleAgreeToTerms,
                        activeColor: AppTheme.primaryColor,
                      )),
                      Expanded(
                        child: Text(
                          'I agree to the Terms and Conditions'.tr,
                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Register button - Updated with isEnabled property
                  Obx(() => CustomButton(
                    text: 'register'.tr,
                    isLoading: controller.authController.isLoading.value,
                    onPressed: controller.register,
                    isEnabled: controller.isFormValid, // Add this line
                    width: double.infinity,
                  )),
                  const SizedBox(height: 16),
                  
                  // Login link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('already_have_account'.tr),
                      TextButton(
                        onPressed: controller.goToLogin,
                        child: Text('login'.tr),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
