import 'package:flicker_mail/core/l10n/translate_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MailDetailsSection extends StatelessWidget {
  const MailDetailsSection({Key? key, required this.title, required this.value}) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: value));
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(
                  Icons.check_outlined,
                  color: Colors.green,
                ),
                const SizedBox(width: 4),
                Text(
                  context.l10n.copiedToYourClipboard,
                ),
              ],
            ),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: RichText(
        text: TextSpan(
          text: title,
          style: Theme.of(context).textTheme.titleSmall!,
          children: [
            TextSpan(
              text: " $value",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
