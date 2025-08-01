import 'package:flicker_mail/core/l10n/translate_extension.dart';
import 'package:flicker_mail/domain/models/email_message.dart';
import 'package:flicker_mail/presentation/providers/email_provider.dart';
import 'package:flicker_mail/presentation/screens/inbox/widgets/message_list.dart';
import 'package:flicker_mail/presentation/screens/inbox/widgets/no_data_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageSearchDelegate extends SearchDelegate {
  MessageSearchDelegate({required List<EmailMessage> messages}) : _messages = messages;

  final List<EmailMessage> _messages;
  List<EmailMessage> _results = <EmailMessage>[];

  @override
  List<Widget>? buildActions(BuildContext context) => [
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () => query.trim().isEmpty ? close(context, null) : query = '',
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
