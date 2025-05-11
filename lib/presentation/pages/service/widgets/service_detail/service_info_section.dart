import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/core/theme/app_theme.dart';
import 'package:service_booking_app/data/models/service_model.dart';
import 'package:service_booking_app/presentation/controllers/service_controller.dart';

class ServiceInfoSection extends StatelessWidget {
  final ServiceModel service;
  final ServiceController controller;

  const ServiceInfoSection({
    super.key,
    required this.service,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Service name and price
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                service.name,
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Text(
                '\$${service.price.toStringAsFixed(2)}',
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        
        // Category, availability, rating, duration
        _buildServiceTags(context),
        const SizedBox(height: 24),
        
        // Description
        Text(
          'description'.tr,
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          'This is a detailed description of the ${service.name} service. It includes information about what the service entails, what customers can expect, and any other relevant details.',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      ],
    );
  }

  Widget _buildServiceTags(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: [
        
        // Availability
        Chip(
          label: Text(
            service.availability ? 'available'.tr : 'unavailable'.tr,
          ),
          avatar: Icon(
            service.availability ? Icons.check_circle : Icons.cancel,
            size: 16,
            color: service.availability ? Colors.green : Colors.red,
          ),
          backgroundColor: service.availability
              ? Colors.green.withOpacity(0.1)
              : Colors.red.withOpacity(0.1),
          labelStyle: TextStyle(
            color: service.availability ? Colors.green[700] : Colors.red[700],
          ),
        ),
        
        // Rating
        Chip(
          label: Text(service.rating.toString()),
          avatar: const Icon(Icons.star, size: 16, color: Colors.amber),
          backgroundColor: Colors.amber.withOpacity(0.1),
          labelStyle: TextStyle(
            color: Colors.amber[700],
          ),
        ),
        
        // Duration
        Chip(
          label: Text('${service.duration} ${'minutes'.tr}'),
          avatar: const Icon(Icons.access_time, size: 16),
          backgroundColor: Colors.blue.withOpacity(0.1),
          labelStyle: TextStyle(
            color: Colors.blue[700],
          ),
        ),
      ],
    );
  }
}
