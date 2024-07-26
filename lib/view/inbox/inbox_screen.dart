import 'package:flicker_mail/const_gen/assets.gen.dart';
import 'package:flicker_mail/l10n/translate_extension.dart';
import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flicker_mail/view/inbox/widgets/message_list.dart';
import 'package:flicker_mail/view/inbox/widgets/message_search_delegate.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class InboxScreen extends StatefulWidget {
  const InboxScreen({Key? key}) : super(key: key);

  @override
  State<InboxScreen> createState() => _InboxScreenState();
}

class _InboxScreenState extends State<InboxScreen> with AutomaticKeepAliveClientMixin<InboxScreen> {
  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Consumer<EmailProvider>(
      builder: (context, emailProv, child) => Scaffold(
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
          ],
          centerTitle: false,
        ),
        body: RefreshIndicator(
          onRefresh: emailProv.refreshInbox,
          child: emailProv.sortedMessages.isEmpty
              ? Stack(
                  children: [
                    // Center(
                    //   child: LottieBuilder.asset(
                    //     Assets.animations.noData.path,
                    //     width: 150,
                    //     height: 150,
                    //   ),
                    // ),

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
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
