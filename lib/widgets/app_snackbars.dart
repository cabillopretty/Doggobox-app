import 'package:flutter/material.dart';

/// A utility class for creating styled SnackBars throughout the app
class AppSnackBars {
  /// Creates a success SnackBar with green background and checkmark icon
  static SnackBar success({
    required String message,
    Duration duration = const Duration(seconds: 2),
    VoidCallback? onActionPressed,
    String? actionLabel,
  }) {
    return SnackBar(
      content: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF4CAF50), // Material Design green
      duration: duration,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      action: actionLabel != null && onActionPressed != null
          ? SnackBarAction(
              label: actionLabel,
              textColor: Colors.white,
              onPressed: onActionPressed,
            )
          : null,
    );
  }

  /// Creates an error SnackBar with red background
  static SnackBar error({
    required String message,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onActionPressed,
    String? actionLabel,
  }) {
    return SnackBar(
      content: Row(
        children: [
          const Icon(Icons.error, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFFF44336), // Material Design red
      duration: duration,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      action: actionLabel != null && onActionPressed != null
          ? SnackBarAction(
              label: actionLabel,
              textColor: Colors.white,
              onPressed: onActionPressed,
            )
          : null,
    );
  }

  /// Creates an info SnackBar with blue background
  static SnackBar info({
    required String message,
    Duration duration = const Duration(seconds: 2),
    VoidCallback? onActionPressed,
    String? actionLabel,
  }) {
    return SnackBar(
      content: Row(
        children: [
          const Icon(Icons.info, color: Colors.white, size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
      backgroundColor: const Color(0xFF2196F3), // Material Design blue
      duration: duration,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      action: actionLabel != null && onActionPressed != null
          ? SnackBarAction(
              label: actionLabel,
              textColor: Colors.white,
              onPressed: onActionPressed,
            )
          : null,
    );
  }
}
