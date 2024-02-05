import 'package:flicker_mail/models/mail/mail.dart';
import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flicker_mail/router/app_routes.dart';
import 'package:flicker_mail/view/inbox/mail_screen.dart';
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
    return Scaffold(
      appBar: AppBar(
        actions: const [
          Padding(
            padding: EdgeInsets.all(8.0),
            child: Tooltip(
              margin: EdgeInsets.all(24.0),
              textAlign: TextAlign.center,
              showDuration: Duration(seconds: 10),
              triggerMode: TooltipTriggerMode.tap,
              message: "Each message will be automatically deleted after 120 minutes",
              child: Icon(Icons.help_outline),
            ),
          ),
        ],
        title: Selector<EmailProvider, List<Mail>>(
          builder: (BuildContext context, value, Widget? child) => Text("Inbox (${value.length})"),
          selector: (p0, p1) => p1.mailList,
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
                          Image.asset("assets/images/empty_inbox.png",
                              width: 200, height: 200, color: Theme.of(context).colorScheme.primary),
                          const Text(
                            "Your inbox is empty",
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
