import 'package:flutter/material.dart';

class AlertDialogWidget extends StatelessWidget {
  final String headingText;
  final String contentText;
  final VoidCallback confirmFunction;
  final VoidCallback declineFunction;

  const AlertDialogWidget({
    super.key,
    required this.headingText,
    required this.contentText,
    required this.confirmFunction,
    required this.declineFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: AlertDialog(
        title: Text(
          headingText,
          textAlign: TextAlign.center,
          style: const TextStyle(
            fontSize: 21,
            fontWeight: FontWeight.bold,
          ),
        ),
        content: Text(
          contentText,
        ),
        actions: [
          TextButton(
            onPressed: declineFunction,
            child: const Text("نەخێر"),
          ),
          TextButton(
            onPressed: confirmFunction,
            child: const Text("بەڵێ"),
          ),
        ],
      ),
    );
  }
}
