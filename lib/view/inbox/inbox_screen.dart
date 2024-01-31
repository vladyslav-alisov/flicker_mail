import 'package:flicker_mail/providers/inbox_provider.dart';
import 'package:flicker_mail/router/app_routes.dart';
import 'package:flicker_mail/view/inbox/mail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InboxScreen extends StatelessWidget {
  const InboxScreen({Key? key}) : super(key: key);

  void _onMailPress(BuildContext context, int mailId) {
    context.go(AppRoutes.mailScreen.path, extra: MailScreenArgs(mailId));
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Consumer<InboxProvider>(
          builder: (context, mailProv, child) {
            return mailProv.isInboxLoading
                ? const Center(
                    child: CupertinoActivityIndicator(),
                  )
                : RefreshIndicator(
                    onRefresh: mailProv.refreshInbox,
                    child: ListView(
                      padding: const EdgeInsets.all(12),
                      children: [
                        Text(
                          "Inbox",
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        const SizedBox(height: 12),
                        ...List.generate(
                          mailProv.mailList.length,
                          (index) => ListTile(
                            onTap: () => _onMailPress(context, mailProv.mailList[index].id),
                            title: Text("Subject: ${mailProv.mailList[index].subject}"),
                            subtitle: Text("From: ${mailProv.mailList[index].from}"),
                            trailing: Text(
                              DateFormat.yMMMd().add_jm().format(mailProv.mailList[index].date),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
          },
        ),
      ),
    );
  }
}
