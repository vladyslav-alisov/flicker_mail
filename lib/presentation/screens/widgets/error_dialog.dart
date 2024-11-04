import 'package:flicker_mail/core/l10n/translate_extension.dart';
import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  const ErrorDialog({Key? key, this.title, required this.content}) : super(key: key);

  final String? title;
  final String content;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title ?? context.l10n.error),
      content: Text(content),
    );
  }
}
