import 'package:flutter/material.dart';

class ErrorCard extends StatelessWidget {
  final String? errMssg;
  final VoidCallback onRetry;

  const ErrorCard({super.key, required this.onRetry, this.errMssg});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          errMssg ?? "Failed to load",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),

        const SizedBox(height: 10),

        Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          child: InkWell(
            onTap: onRetry,
            borderRadius: BorderRadius.circular(12),
            child: Ink(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF0066FF),
                    Color(0xFF3B82F6),
                    Color(0xFF60A5FA),
                  ],
                ),
                borderRadius: BorderRadius.all(Radius.circular(12)),
              ),
              child: const Text(
                "Retry",
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
