import 'package:flicker_mail/const_gen/assets.gen.dart';
import 'package:flicker_mail/l10n/translate_extension.dart';
import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flicker_mail/view/inbox/widgets/message_list.dart';
import 'package:flicker_mail/view/inbox/widgets/message_search_delegate.dart';
import 'package:flicker_mail/view/widgets/error_dialog.dart';
import 'package:flicker_mail/view/widgets/option_dialog.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> with AutomaticKeepAliveClientMixin<InboxScreen> {
  EmailProvider get _emailProvider => context.read<EmailProvider>();

  void _onDeleteAllPress() async {
    bool response = await showDialog(
          context: context,
          builder: (context) => OptionDialog(
            title: context.l10n.confirmDeletion,
            content: context.l10n.areYouSureYouWantToDeleteAllMessagesForThisEmail,
          ),
        ) ??
        false;
    if (!response) return;
    bool didDelete = await _emailProvider.deleteSafelyAllMessages();
    if (!didDelete && mounted) {
      showDialog(
        context: context,
        builder: (context) => ErrorDialog(
          content: context.l10n.failedToDeleteMessages,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<EmailProvider>(builder: (context, emailProv, child) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            "${context.l10n.inbox} (${emailProv.sortedMessages.length})",
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => showSearch(
                context: context,
                delegate: MessageSearchDelegate(
                  messages: emailProv.sortedMessages,
                ),
              ),
            ),
            IconButton(
              icon: const Icon(Icons.delete_sweep_outlined),
              onPressed: _onDeleteAllPress,
            ),
          ],
          centerTitle: false,
        ),
        body: RefreshIndicator(
          onRefresh: emailProv.refreshInbox,
          child: emailProv.sortedMessages.isEmpty
              ? Stack(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        LottieBuilder.asset(
                          Assets.animations.noData.path,
                          width: 150,
                          height: 150,
                        ),
                        Text(
                          context.l10n.yourInboxIsEmpty,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    ListView(
                      physics: const AlwaysScrollableScrollPhysics(),
                    ),
                  ],
                )
              : MessageList(
                  messages: emailProv.sortedMessages,
                ),
        ),
      );
    });
  }

  @override
  bool get wantKeepAlive => true;
}
