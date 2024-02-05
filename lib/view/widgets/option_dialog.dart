import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OptionDialog extends StatelessWidget {
  const OptionDialog({Key? key, this.title, required this.content}) : super(key: key);

  final String? title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? "Are you sure?"),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => context.pop(false),
          child: Text(
            "Cancel",
          ),
        ),
        TextButton(
          onPressed: () => context.pop(true),
          child: Text(
            "Confirm",
          ),
        ),
      ],
    );
  }
}
