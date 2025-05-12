import 'package:flutter/material.dart';
import 'package:service_booking_app/core/theme/app_theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final bool isOutlined;
  final Color? backgroundColor;
  final Color? textColor;
  final double? width;
  final double? height;
  final EdgeInsetsGeometry? padding;
  final BorderRadius? borderRadius;
  final bool isEnabled; // <-- Add this

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.isOutlined = false,
    this.backgroundColor,
    this.textColor,
    this.width,
    this.height,
    this.padding,
    this.borderRadius,
    this.isEnabled = true, // <-- Default to enabled
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child:
          isOutlined
              ? OutlinedButton(
                onPressed: !isEnabled ? null : onPressed, // <-- Use it here
                style: OutlinedButton.styleFrom(
                  side: BorderSide(
                    color: backgroundColor ?? AppTheme.primaryColor,
                  ),
                  padding:
                      padding ??
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(8),
                  ),
                ),
                child: _buildChild(context),
              )
              : ElevatedButton(
                onPressed: !isEnabled ? null : onPressed, // <-- And here
                style: ElevatedButton.styleFrom(
                  backgroundColor: backgroundColor ?? AppTheme.primaryColor,
                  foregroundColor: textColor ?? Colors.white,
                  padding:
                      padding ??
                      const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  shape: RoundedRectangleBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(8),
                  ),
                ),
                child: _buildChild(context),
              ),
    );
  }

  Widget _buildChild(BuildContext context) {
    return isLoading
        ? SizedBox(
          height: 20,
          width: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(
              isOutlined ? AppTheme.primaryColor : Colors.white,
            ),
          ),
        )
        : Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color:
                isOutlined
                    ? (textColor ?? AppTheme.primaryColor)
                    : (textColor ?? Colors.white),
          ),
        );
  }
}
