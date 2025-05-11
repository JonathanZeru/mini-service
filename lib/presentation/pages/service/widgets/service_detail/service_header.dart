import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:service_booking_app/core/theme/app_theme.dart';
import 'package:service_booking_app/data/models/service_model.dart';
import 'package:service_booking_app/presentation/controllers/service_controller.dart';
import 'package:shimmer/shimmer.dart';

class ServiceHeader extends StatelessWidget {
  final ServiceModel service;
  final ServiceController controller;

  const ServiceHeader({
    super.key,
    required this.service,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    
    return SliverAppBar(
      expandedHeight: 250,
      pinned: true,
      flexibleSpace: FlexibleSpaceBar(
        background: Hero(
          tag: 'service-${service.id}',
          child: CachedNetworkImage(
            imageUrl: service.imageUrl ?? "",
            fit: BoxFit.cover,
            placeholder: (context, url) => Shimmer.fromColors(
              baseColor: isDarkMode ? Colors.grey[800]! : Colors.grey[300]!,
              highlightColor: isDarkMode ? Colors.grey[700]! : Colors.grey[100]!,
              child: Container(
                color: Colors.white,
              ),
            ),
            errorWidget: (context, url, error) => Container(
              color: isDarkMode ? Colors.grey[800] : Colors.grey[200],
              child: const Center(
                child: Icon(Icons.image_not_supported, size: 40),
              ),
            ),
          ),
        ),
      ),
      actions:  [
              IconButton(
                icon: const Icon(Icons.edit,
            color: AppTheme.primaryColor),
                onPressed: controller.goToEditService,
                tooltip: 'edit'.tr,
              ),
              IconButton(
                icon: const Icon(Icons.delete,
            color: AppTheme.primaryColor),
                onPressed: controller.confirmDelete,
                tooltip: 'delete'.tr,
              ),
            ]
    );
  }
}
