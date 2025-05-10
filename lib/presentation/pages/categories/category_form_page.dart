import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/category_form_controller.dart';

class CategoryFormPage extends GetView<CategoryFormController> {
  final bool isEditing;

  const CategoryFormPage({super.key, required this.isEditing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Category' : 'Create Category'),
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: controller.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextFormField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(
                    labelText: 'Category Name',
                    hintText: 'Enter category name',
                  ),
                  validator: (value) => controller.validateNotEmpty(value, 'Category name'),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: controller.descriptionController,
                  decoration: const InputDecoration(
                    labelText: 'Description',
                    hintText: 'Enter category description',
                  ),
                  maxLines: 3,
                  validator: (value) => controller.validateNotEmpty(value, 'Description'),
                ),
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: Obx(() => ElevatedButton(
                    onPressed: controller.isSaving.value
                        ? null
                        : controller.saveCategory,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: controller.isSaving.value
                          ? const CircularProgressIndicator()
                          : Text(isEditing ? 'Update Category' : 'Create Category'),
                    ),
                  )),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
