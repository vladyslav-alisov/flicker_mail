import 'package:dio/dio.dart';
import 'package:flicker_mail/models/mail/mail_details.dart';
import 'package:flicker_mail/models/mail/mailbox.dart';
import 'package:flicker_mail/providers/mail_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MailScreenArgs {
  final int mailId;
  final Mailbox mailbox;

  MailScreenArgs(this.mailId, this.mailbox);
}

class MailScreen extends StatefulWidget {
  MailScreen({Key? key, required MailScreenArgs args})
      : mailbox = args.mailbox,
        mailId = args.mailId,
        super(key: key);

  final int mailId;
  final Mailbox mailbox;

  @override
  State<MailScreen> createState() => _MailScreenState();
}

class _MailScreenState extends State<MailScreen> {
  bool _isLoading = false;

  MailDetails? _mailDetails;

  MailProvider get _mailProvider => context.read<MailProvider>();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  _initData() async {
    try {
      _isLoading = true;
      _mailDetails = await _mailProvider.getMailDetails(widget.mailbox, widget.mailId);
      setState(() => _isLoading = false);
    } on DioException catch (e) {
      setState(() => _isLoading = false);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text(e.message ?? "Unknown"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Mail details")),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : _mailDetails != null
              ? ListView(
                  children: [
                    Text("From: ${_mailDetails!.from}"),
                    Text("Subject: ${_mailDetails!.subject}"),
                    Text("Subject: ${_mailDetails!.textBody}"),
                  ],
                )
              : Center(
                  child: Text("No data found"),
                ),
    );
  }
}
