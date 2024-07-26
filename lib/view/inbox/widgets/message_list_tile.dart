import 'package:flicker_mail/models/email_message/email_message.dart';
import 'package:flicker_mail/view/inbox/widgets/custom_circular_avatar.dart';
import 'package:flutter/material.dart';

class MessageListTile extends StatelessWidget {
  const MessageListTile({super.key, required this.emailMessage, required this.onPress, required this.onIconPress});

  final EmailMessage emailMessage;
  final ValueChanged<EmailMessage> onPress;
  final ValueChanged<int> onIconPress;

  TextStyle _titleTextStyle(BuildContext context) =>
      emailMessage.didRead ? Theme.of(context).textTheme.bodyLarge! : Theme.of(context).textTheme.titleMedium!;

  TextStyle _subtitleTextStyle(BuildContext context) =>
      emailMessage.didRead ? Theme.of(context).textTheme.bodyMedium! : Theme.of(context).textTheme.titleSmall!;

  TextStyle _dateTextStyle(BuildContext context) =>
      emailMessage.didRead ? Theme.of(context).textTheme.bodySmall! : Theme.of(context).textTheme.labelMedium!;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onPress(emailMessage),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCircularAvatar(name: emailMessage.from),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          emailMessage.from,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: _titleTextStyle(context),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        emailMessage.formattedDate,
                        maxLines: 1,
                        style: _dateTextStyle(context),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  if (emailMessage.subject.trim().isNotEmpty)
                    Text(
                      emailMessage.subject,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: _subtitleTextStyle(context),
                    ),
                  if (emailMessage.textBody.trim().isNotEmpty)
                    Text(
                      emailMessage.textBody,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: Theme.of(context).hintColor,
                          ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
