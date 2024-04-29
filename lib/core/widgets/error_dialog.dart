import 'package:flutter/material.dart';

import '../constants/styles.dart';

class ErrorDialog extends StatelessWidget {
  final String message;

  const ErrorDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        'Error!',
        style: extraLargeTextStyle.copyWith(color: Colors.red),
      ),
      icon: const Icon(
        Icons.error,
        color: Colors.red,
        size: 60,
      ),
      content: Text(
        message,
        style: largeTextStyle.copyWith(color: Colors.black),textAlign: TextAlign.center,
      ),
    );
  }
}