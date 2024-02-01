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
    return Scaffold(
      appBar: AppBar(title: Text("Inbox")),
      body: Consumer<InboxProvider>(
        builder: (context, mailProv, child) {
          if (mailProv.isInboxLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else {
            return mailProv.mailList.isEmpty
                ? RefreshIndicator(
                    onRefresh: mailProv.refreshInbox,
                    child: ListView(
                      physics: AlwaysScrollableScrollPhysics(),
                      children: [
                        SizedBox(
                          height: MediaQuery.of(context).size.height / 4,
                        ),
                        Image.asset("assets/images/empty_inbox.webp", width: 200, height: 200),
                      ],
                    ),
                  )
                : RefreshIndicator(
                    onRefresh: mailProv.refreshInbox,
                    child: ListView.separated(
                      padding: const EdgeInsets.all(12),
                      itemBuilder: (BuildContext context, int index) => index != 0
                          ? Divider(
                              color: Theme.of(context).dividerColor,
                              thickness: 1,
                            )
                          : Container(),
                      itemCount: mailProv.mailList.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return ListTile(
                          dense: true,
                          onTap: () => _onMailPress(context, mailProv.mailList[index].id),
                          title: Text("${mailProv.mailList[index].subject}"),
                          subtitle: Text("${mailProv.mailList[index].from}"),
                          trailing: Text(
                            DateFormat.yMMMd().add_jm().format(mailProv.mailList[index].date),
                          ),
                        );
                      },
                    ),
                  );
          }
        },
      ),
    );
  }
}
