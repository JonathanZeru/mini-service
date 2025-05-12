import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:service_booking_app/core/theme/app_theme.dart';

class LoadingIndicator extends StatelessWidget {
  final double size;
  final String? message;

  const LoadingIndicator({super.key, this.size = 200, this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset(
            'assets/animations/loading.json',
            width: size,
            height: size,
          ),
          if (message != null) ...[
            const SizedBox(height: 16),
            Text(
              message!,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(color: AppTheme.primaryColor),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      ),
    );
  }
}
