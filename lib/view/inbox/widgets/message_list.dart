import 'package:flicker_mail/l10n/translate_extension.dart';
import 'package:flicker_mail/models/email_message/email_message.dart';
import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flicker_mail/router/app_routes.dart';
import 'package:flicker_mail/view/inbox/email_message_details_screen.dart';
import 'package:flicker_mail/view/inbox/widgets/message_list_tile.dart';
import 'package:flicker_mail/view/widgets/error_dialog.dart';
import 'package:flicker_mail/view/widgets/option_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MessageList extends StatelessWidget {
  const MessageList({super.key, required this.messages});

  final List<EmailMessage> messages;

  void _onMessagePress(BuildContext context, EmailMessage emailMessage) {
    context.go(AppRoutes.emailMessageDetailsScreen.path, extra: MailScreenArgs(emailMessage));
  }

  Future<bool?> _onSwipe(BuildContext context, DismissDirection direction) async {
    if (direction == DismissDirection.endToStart) {
      return await showDialog(
            context: context,
            builder: (context) => OptionDialog(
              title: context.l10n.confirmDeletion,
              content: "${context.l10n.areYouSureYouWantToDeleteThisEmail} ${context.l10n.thisActionCannotBeUndone}",
            ),
          ) ??
          false;
    } else {
      return true;
    }
  }

  void _onDeletePress(BuildContext context, int dbId) async {
    context.read<EmailProvider>().deleteSafelyMessage(dbId).then(
      (value) {
        if (!value && context.mounted) {
          showDialog(
            context: context,
            builder: (context) => ErrorDialog(
              content: context.l10n.messageNotDeleted,
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 12),
      padding: const EdgeInsets.all(12),
      itemBuilder: (BuildContext context, int index) => Dismissible(
        confirmDismiss: (direction) => _onSwipe(context, direction),
        onDismissed: (direction) => _onDeletePress(context, messages[index].dbId),
        direction: DismissDirection.endToStart,
        background: Container(
          decoration: const BoxDecoration(
            color: Colors.red,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: const Align(
            alignment: Alignment.centerRight,
            child: Icon(Icons.delete, color: Colors.white),
          ),
        ),
        key: Key(messages[index].id.toString()),
        child: MessageListTile(
          emailMessage: messages[index],
          onPress: (value) => _onMessagePress(context, value),
        ),
      ),
      itemCount: messages.length,
    );
  }
}
