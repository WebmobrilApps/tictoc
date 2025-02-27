import 'package:flutter/material.dart';
import 'package:tictoc/utils/custom_widgets.dart';

class ErrorDisplayWidget extends StatelessWidget {
  final String error;
  final int statusCode;
  final VoidCallback onRetry;
  final Color textColor; // Add textColor as a parameter with default value

  const ErrorDisplayWidget({
    super.key,
    required this.error,
    required this.statusCode,
    required this.onRetry,
    this.textColor = const Color(0xff000000), // Default to black
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50.0),
            child:mediumText14 (
              //  context, statusCode == 401 ? error : '$error\n\nClick to refresh.',
                context, statusCode == 0 ? 'Something went wrong \n Unknown error occurred \n\nClick to refresh.' : '$error\n\nClick to refresh.',
                fontSize: 16,
                fontWeight: FontWeight.w500,
                textAlign: TextAlign.center,
                textColor: textColor
            ),
          ),
          IconButton(
            icon:  Icon(Icons.refresh, color: textColor, size: 35),
            onPressed: onRetry, // Retry function to re-fetch data
          ),
        ],
      ),
    );
  }
}
