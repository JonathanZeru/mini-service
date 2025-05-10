import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/presentation/controllers/service_form_controller.dart';

class ServiceFormPage extends GetView<ServiceFormController> {
  final bool isEditing;

  const ServiceFormPage({super.key, required this.isEditing});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(isEditing ? 'Edit Service' : 'Create Service'),
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
                // Image selection
                Center(
                  child: GestureDetector(
                    onTap: controller.showImageSourceDialog,
                    child: Container(
                      width: 200,
                      height: 200,
                      decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Obx(() {
                        if (controller.imageFile.value != null) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.file(
                              controller.imageFile.value!,
                              fit: BoxFit.cover,
                            ),
                          );
                        } else if (controller.imageUrl.value.isNotEmpty) {
                          return ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.network(
                              controller.imageUrl.value,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Center(
                                  child: Icon(Icons.image_not_supported, size: 50),
                                );
                              },
                            ),
                          );
                        } else {
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(Icons.add_a_photo, size: 50),
                                SizedBox(height: 8),
                                Text('Tap to add image'),
                              ],
                            ),
                          );
                        }
                      }),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                
                // Category dropdown
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(
                    labelText: 'Category',
                    hintText: 'Select a category',
                  ),
                  value: controller.selectedCategory.value?.id,
                  items: controller.categories.map((category) {
                    return DropdownMenuItem<String>(
                      value: category.id,
                      child: Text(category.name),
                    );
                  }).toList(),
                  onChanged: (value) {
                    if (value != null) {
                      final category = controller.categories.firstWhere((c) => c.id == value);
                      controller.setSelectedCategory(category);
                    }
                  },
                  validator: (_) => controller.validateCategory(),
                ),
                const SizedBox(height: 16),
                
                // Service name
                TextFormField(
                  controller: controller.nameController,
                  decoration: const InputDecoration(
                    labelText: 'Service Name',
                    hintText: 'Enter service name',
                  ),
                  validator: (value) => controller.validateNotEmpty(value, 'Service name'),
                ),
                const SizedBox(height: 16),
                
                // Price
                TextFormField(
                  controller: controller.priceController,
                  decoration: const InputDecoration(
                    labelText: 'Price (\$)',
                    hintText: 'Enter price',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
                  ],
                  validator: (value) => controller.validateNumeric(value, 'Price'),
                ),
                const SizedBox(height: 16),
                
                // Duration
                TextFormField(
                  controller: controller.durationController,
                  decoration: const InputDecoration(
                    labelText: 'Duration (minutes)',
                    hintText: 'Enter duration in minutes',
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  validator: (value) => controller.validateInteger(value, 'Duration'),
                ),
                const SizedBox(height: 16),
                
                // Rating
                TextFormField(
                  controller: controller.ratingController,
                  decoration: const InputDecoration(
                    labelText: 'Rating (0-5)',
                    hintText: 'Enter rating',
                  ),
                  keyboardType: const TextInputType.numberWithOptions(decimal: true),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,1}')),
                  ],
                  validator: controller.validateRating,
                ),
                const SizedBox(height: 16),
                
                // Availability
                Row(
                  children: [
                    const Text('Availability: '),
                    const SizedBox(width: 8),
                    Obx(() => Switch(
                      value: controller.availability.value,
                      onChanged: (value) => controller.availability.value = value,
                    )),
                    Text(
                      controller.availability.value ? 'Available' : 'Unavailable',
                      style: TextStyle(
                        color: controller.availability.value
                            ? Colors.green[800]
                            : Colors.red[800],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                
                // Submit button
                SizedBox(
                  width: double.infinity,
                  child: Obx(() => ElevatedButton(
                    onPressed: controller.isSaving.value
                        ? null
                        : controller.saveService,
                    child: Padding(
                      padding: const EdgeInsets.all(12),
                      child: controller.isSaving.value
                          ? const CircularProgressIndicator()
                          : Text(isEditing ? 'Update Service' : 'Create Service'),
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
