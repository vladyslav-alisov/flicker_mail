import 'package:flicker_mail/const_gen/assets.gen.dart';
import 'package:flicker_mail/l10n/translate_extension.dart';
import 'package:flicker_mail/models/email_message/email_message.dart';
import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flicker_mail/view/inbox/widgets/message_list.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';

class MessageSearchDelegate extends SearchDelegate {
  MessageSearchDelegate({required List<EmailMessage> messages}) : _messages = messages;

  final List<EmailMessage> _messages;
  List<EmailMessage> _results = <EmailMessage>[];

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query.isEmpty ? close(context, null) : query = '',
        ),
      ];

  @override
  Widget? buildLeading(BuildContext context) => IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () => close(context, null),
      );

  @override
  Widget buildResults(BuildContext context) {
    return FutureBuilder(
      future: context.read<EmailProvider>().searchMessages(query),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('${context.l10n.error}: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const NoDataWidget();
        } else {
          return MessageList(messages: snapshot.data!);
        }
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    _results = _messages.where((EmailMessage emailMessage) {
      final String email = emailMessage.email.toLowerCase();
      final String body = emailMessage.body.toLowerCase();
      final String input = query.toLowerCase();

      return email.contains(input) || body.contains(input);
    }).toList();

    return _results.isEmpty ? const NoDataWidget() : MessageList(messages: _results);
  }
}

class NoDataWidget extends StatelessWidget {
  const NoDataWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LottieBuilder.asset(
            Assets.animations.noData.path,
            width: 150,
            height: 150,
          ),
          Text(
            context.l10n.noDataFound,
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
