import 'package:dio/dio.dart';
import 'package:flicker_mail/models/mail/mail.dart';
import 'package:flicker_mail/models/mail/mailbox.dart';
import 'package:flicker_mail/providers/mail_provider.dart';
import 'package:flicker_mail/router/routes.dart';
import 'package:flicker_mail/view/mail_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class MailboxScreen extends StatefulWidget {
  const MailboxScreen({super.key});

  @override
  State<MailboxScreen> createState() => _MailboxScreenState();
}

class _MailboxScreenState extends State<MailboxScreen> {
  bool _isMailboxLoading = false;
  bool _isMailsLoading = false;

  Mailbox? _mailbox;
  List<Mail> _mails = [];

  final TextEditingController _emailController = TextEditingController();

  MailProvider get _mailProv => context.read<MailProvider>();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  void _initData() async {
    _isMailboxLoading = true;
    try {
      Mailbox mailbox = await _mailProv.getMailbox();
      List<Mail> mails = await _mailProv.getMails(mailbox);
      setState(() {
        _mailbox = mailbox;
        _mails = mails;
        _emailController.text = "${_mailbox!.login}@${_mailbox!.domain}";
        _isMailboxLoading = false;
      });
    } on DioException catch (e) {
      setState(() => _isMailboxLoading = false);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: Text(e.message ?? "Unknown"),
        ),
      );
    }
  }

  void _onRefreshPress() async {
    try {
      setState(() => _isMailsLoading = true);
      List<Mail> mails = await _mailProv.getMails(_mailbox!);
      setState(() {
        _mails = mails;
        _isMailsLoading = false;
      });
    } on DioException catch (e) {
      setState(() => _isMailboxLoading = false);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: Text(e.message ?? "Unknown"),
        ),
      );
    }
  }

  void _onNewEmailPress() async {
    setState(() => _isMailboxLoading = true);
    try {
      Mailbox mailbox = await _mailProv.getMailbox();
      List<Mail> mails = await _mailProv.getMails(mailbox);
      setState(() {
        _mailbox = mailbox;
        _mails = mails;
        _emailController.text = "${_mailbox!.login}@${_mailbox!.domain}";
        _isMailboxLoading = false;
      });
    } on DioException catch (e) {
      setState(() => _isMailboxLoading = false);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: Text(e.message ?? "Unknown"),
        ),
      );
    }
  }

  void _onMailPress(int mailId) {
    context.go(Routes.mailScreen.path, extra: MailScreenArgs(mailId, _mailbox!));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(AppLocalizations.of(context)!.helloWorld),
      ),
      body: _isMailboxLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView(
              padding: const EdgeInsets.all(12),
              children: [
                Row(
                  children: [
                    Flexible(
                      child: TextField(
                        readOnly: true,
                        controller: _emailController,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: _emailController.text)).then(
                          (_) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(content: Text('Copied to your clipboard !')));
                          },
                        );
                      },
                      icon: const Icon(Icons.copy),
                    )
                  ],
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Flexible(
                      child: OutlinedButton(
                        onPressed: _onNewEmailPress,
                        child: const Text("New email"),
                      ),
                    ),
                    Flexible(
                      child: OutlinedButton(
                        onPressed: _onRefreshPress,
                        child: _isMailsLoading ? const CupertinoActivityIndicator() : const Text("Refresh"),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                ...List.generate(
                  _mails.length,
                  (index) => ListTile(
                    onTap: () => _onMailPress(_mails[index].id),
                    title: Text(_mails[index].subject),
                    subtitle: Text(_mails[index].from),
                    leading: Text(
                      _mails[index].date.toString(),
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
