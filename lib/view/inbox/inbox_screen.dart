import 'dart:async';

import 'package:flicker_mail/const_gen/assets.gen.dart';
import 'package:flicker_mail/l10n/translate_extension.dart';
import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flicker_mail/router/app_routes.dart';
import 'package:flicker_mail/view/inbox/email_message_details_screen.dart';
import 'package:flicker_mail/view/widgets/error_dialog.dart';
import 'package:flicker_mail/view/widgets/option_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> with AutomaticKeepAliveClientMixin<InboxScreen> {
  late Timer timer;
  EmailProvider get _emailProvider => context.read<EmailProvider>();

  void _onMessagePress(int mailId, int dbId) {
    context.go(AppRoutes.emailMessageDetailsScreen.path, extra: MailScreenArgs(mailId, dbId));
  }

  void _onDeletePress(int dbId) async {
    bool isDelete = await showDialog(
          context: context,
          builder: (context) => OptionDialog(
            title: context.l10n.confirmDeletion,
            content: "${context.l10n.areYouSureYouWantToDeleteThisEmail} ${context.l10n.thisActionCannotBeUndone}",
          ),
        ) ??
        false;
    if (isDelete) {
      bool didDelete = await _emailProvider.deleteSafelyMessage(dbId);
      if (!didDelete && mounted) {
        showDialog(
          context: context,
          builder: (context) => ErrorDialog(
            content: context.l10n.messageNotDeleted,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Consumer<EmailProvider>(
          builder: (BuildContext context, value, Widget? child) => Text(
            "${context.l10n.inbox} (${value.sortedMessages.length})",
          ),
        ),
        centerTitle: false,
      ),
      body: Consumer<EmailProvider>(
        builder: (context, mailProv, child) {
          return RefreshIndicator(
            onRefresh: mailProv.refreshInbox,
            child: mailProv.sortedMessages.isEmpty
                ? Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset(
                            Assets.images.emptyInbox.path,
                            width: 75,
                            height: 75,
                            color: Theme.of(context).colorScheme.primary,
                          ),
                          Text(
                            context.l10n.yourInboxIsEmpty,
                            textAlign: TextAlign.center,
                          )
                        ],
                      ),
                      ListView(
                        physics: const AlwaysScrollableScrollPhysics(),
                      ),
                    ],
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemBuilder: (BuildContext context, int index) => Card(
                      child: ListTile(
                        onTap: () =>
                            _onMessagePress(mailProv.sortedMessages[index].id, mailProv.sortedMessages[index].dbId),
                        title: Text(
                          mailProv.sortedMessages[index].from,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontWeight: mailProv.sortedMessages[index].didRead
                                    ? Theme.of(context).textTheme.titleLarge?.fontWeight
                                    : FontWeight.bold,
                              ),
                        ),
                        trailing: IconButton(
                            onPressed: () => _onDeletePress(mailProv.sortedMessages[index].dbId),
                            icon: const Icon(Icons.delete_outline)),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              mailProv.sortedMessages[index].subject,
                              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                    fontWeight: mailProv.sortedMessages[index].didRead
                                        ? Theme.of(context).textTheme.titleMedium?.fontWeight
                                        : FontWeight.bold,
                                  ),
                            ),
                            Text(
                              DateFormat.yMMMd().add_jm().format(
                                    mailProv.sortedMessages[index].date,
                                  ),
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                          ],
                        ),
                      ),
                    ),
                    itemCount: mailProv.sortedMessages.length,
                  ),
          );
        },
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
