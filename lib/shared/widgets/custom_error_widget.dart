import 'package:flutter/material.dart';

class CustomErrorWidget extends StatelessWidget {
  final String title;
  final String errorMessage;
  final VoidCallback? onOkay;

  const CustomErrorWidget({
    super.key,
    this.title = 'Uh-oh',
    required this.errorMessage,
    this.onOkay,
  });

  static void show(
    BuildContext context, {
    String title = 'Uh-oh',
    required String errorMessage,
    VoidCallback? onOkay,
  }) {
    showDialog(
      context: context,
      builder: (_) => CustomErrorWidget(
        title: title,
        errorMessage: errorMessage,
        onOkay: onOkay,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Row(
        children: [
          const Icon(Icons.error_outline, color: Colors.redAccent),
          const SizedBox(width: 8),
          Expanded(child: Text(title)),
        ],
      ),
      content: Text(errorMessage, style: const TextStyle(fontSize: 16)),
      actions: [
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
            onOkay?.call();
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.redAccent,
            foregroundColor: Colors.white,
          ),
          child: const Text('Okay'),
        ),
      ],
    );
  }
}
