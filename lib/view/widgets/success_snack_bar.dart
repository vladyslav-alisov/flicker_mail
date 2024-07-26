import 'package:flutter/material.dart';

class SuccessSnackBarContent extends StatelessWidget {
  const SuccessSnackBarContent({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return SnackBar(
      content: Row(
        children: [
          const Icon(
            Icons.check_outlined,
            color: Colors.green,
          ),
          const SizedBox(width: 4),
          Text(text),
        ],
      ),
    );
  }
}
