import 'package:flicker_mail/core/l10n/translate_extension.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class OptionDialog extends StatelessWidget {
  const OptionDialog({Key? key, this.title, required this.content, this.confirmLabel}) : super(key: key);

  final String? title;
  final String content;
  final String? confirmLabel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title ?? context.l10n.confirmAction,
      ),
      content: Text(content),
      actions: [
        TextButton(
          onPressed: () => context.pop(false),
          child: Text(
            context.l10n.cancel,
          ),
        ),
        TextButton(
          onPressed: () => context.pop(true),
          child: Text(
            confirmLabel ?? context.l10n.confirm,
          ),
        ),
      ],
    );
  }
}
