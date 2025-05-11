import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/core/theme/app_theme.dart';
import 'package:service_booking_app/presentation/controllers/login_controller.dart';
import 'package:service_booking_app/presentation/widgets/custom_button.dart';
import 'package:service_booking_app/presentation/controllers/language_controller.dart';
import 'package:service_booking_app/presentation/widgets/language_selector.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('login'.tr),
        centerTitle: true,
        backgroundColor: AppTheme.primaryColor,
        actions: [
          // Language selector
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
                  // App logo
                  Center(
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: const BoxDecoration(
                        color: AppTheme.primaryColor,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.home_repair_service,
                        size: 50,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  
                  // App name
                  Center(
                    child: Text(
                      'app_name'.tr,
                      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 48),
                  
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
                    textInputAction: TextInputAction.done,
                    onFieldSubmitted: (_) => controller.login(),
                  )),
                  const SizedBox(height: 8),
                  
                  // Remember me checkbox
                  Row(
                    children: [
                      Obx(() => Checkbox(
                        value: controller.rememberMe.value,
                        onChanged: controller.toggleRememberMe,
                        activeColor: AppTheme.primaryColor,
                      )),
                      Text('Remember me'.tr),
                      const Spacer(),
                      TextButton(
                        onPressed: controller.goToForgotPassword,
                        child: Text('forgot_password'.tr),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  
                  // Login button - Updated with isEnabled property
                  Obx(() => CustomButton(
                    text: 'login'.tr,
                    isLoading: controller.authController.isLoading.value,
                    onPressed: controller.login,
                    isEnabled: controller.isFormValid, // Add this line
                    width: double.infinity,
                  )),
                  const SizedBox(height: 16),
                  
                  // Register link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('dont_have_account'.tr),
                      TextButton(
                        onPressed: controller.goToRegister,
                        child: Text('register'.tr),
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
