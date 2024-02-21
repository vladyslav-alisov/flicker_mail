import 'dart:async';

import 'package:flicker_mail/l10n/translate_extension.dart';
import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flicker_mail/router/app_routes.dart';
import 'package:flicker_mail/view/inbox/mail_screen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> with WidgetsBindingObserver {
  late Timer timer;
  EmailProvider get _emailProvider => context.read<EmailProvider>();

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _emailProvider.refreshInbox();
      _setRefresh();
    } else {
      timer.cancel();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _emailProvider.refreshInbox();
    _setRefresh();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    timer.cancel();
    super.dispose();
  }

  _setRefresh() {
    timer = Timer.periodic(const Duration(seconds: 5), (timer) {
      _emailProvider.refreshInbox();
    });
  }

  void _onMailPress(BuildContext context, int mailId) {
    context.go(AppRoutes.mailScreen.path, extra: MailScreenArgs(mailId));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Tooltip(
              margin: const EdgeInsets.all(24.0),
              textAlign: TextAlign.center,
              showDuration: const Duration(seconds: 10),
              triggerMode: TooltipTriggerMode.tap,
              message: context.l10n.eachMessageWillBeAutoDeletedAfterTime,
              child: const Icon(Icons.help_outline),
            ),
          ),
        ],
        title: Consumer<EmailProvider>(
          builder: (BuildContext context, value, Widget? child) => Text(
            "${context.l10n.inbox} (${value.mailList.length})",
          ),
        ),
        centerTitle: false,
      ),
      body: Consumer<EmailProvider>(
        builder: (context, mailProv, child) {
          return RefreshIndicator(
            onRefresh: mailProv.refreshInbox,
            child: mailProv.mailList.isEmpty
                ? Stack(
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Image.asset(
                            "assets/images/empty_inbox.png",
                            width: 200,
                            height: 200,
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
                : ListView.separated(
                    padding: const EdgeInsets.all(12),
                    separatorBuilder: (BuildContext context, int index) => Divider(
                      color: Theme.of(context).dividerColor,
                      thickness: 1,
                    ),
                    itemBuilder: (BuildContext context, int index) => ListTile(
                      onTap: () => _onMailPress(context, mailProv.mailList[index].id),
                      title: Text(mailProv.mailList[index].subject),
                      subtitle: Text(mailProv.mailList[index].from),
                      trailing: Text(
                        DateFormat.yMMMd().add_jm().format(mailProv.mailList[index].date),
                      ),
                    ),
                    itemCount: mailProv.mailList.length,
                  ),
          );
        },
      ),
    );
  }
}
