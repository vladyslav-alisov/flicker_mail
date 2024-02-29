import 'dart:async';

import 'package:flicker_mail/l10n/translate_extension.dart';
import 'package:flicker_mail/models/mail/mailbox.dart';
import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flicker_mail/router/app_routes.dart';
import 'package:flicker_mail/view/email/new_email_screen.dart';
import 'package:flicker_mail/view/email/widgets/edit_label_dialog.dart';
import 'package:flicker_mail/view/widgets/option_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class MailboxScreen extends StatefulWidget {
  const MailboxScreen({super.key});

  @override
  State<MailboxScreen> createState() => _MailboxScreenState();
}

class _MailboxScreenState extends State<MailboxScreen> with AutomaticKeepAliveClientMixin<MailboxScreen> {
  EmailProvider get _emailProvider => context.read<EmailProvider>();

  final DateFormat _dateFormat = DateFormat.yMMMd().add_jm();

  bool _checkIfDomainIsActive(Email email) {
    return _emailProvider.availableDomains.contains(email.domain);
  }

  void _onEditPress(String label, int dbId) async {
    await showDialog(
      context: context,
      builder: (context) => EditLabelDialog(
        initLabel: label,
        id: dbId,
      ),
    );
  }

  Future<bool> _onDeletePress(int id) async {
    bool isDelete = await showDialog(
          context: context,
          builder: (context) => OptionDialog(
            title: context.l10n.confirmDeletion,
            content: "${context.l10n.areYouSureYouWantToDeleteThisEmail} ${context.l10n.thisActionCannotBeUndone}",
          ),
        ) ??
        false;

    if (isDelete) {
      bool result = await _emailProvider.removeEmail(id);
      return result;
    } else {
      return isDelete;
    }
  }

  void _onEmailPress(Email email) async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return CupertinoActionSheet(
          actions: [
            CupertinoActionSheetAction(
              onPressed: () {
                context.pop();
                _onActivateEmailPress(email.isarId);
              },
              isDefaultAction: true,
              child: Text(context.l10n.activate),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                context.pop();
                _onCopyPress(email.email);
              },
              child: Text(context.l10n.copy),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                context.pop();
                _onSharePress(email.email);
              },
              child: Text(context.l10n.share),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                context.pop();
                _onQRGeneratePress(email.email);
              },
              child: Text(context.l10n.qr),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                context.pop();
                _onEditPress(email.label, email.isarId);
              },
              child: Text(context.l10n.editLabel),
            ),
            CupertinoActionSheetAction(
              onPressed: () {
                context.pop();
                _onDeletePress(email.isarId);
              },
              isDestructiveAction: true,
              child: Text(context.l10n.delete),
            ),
          ],
          cancelButton: CupertinoActionSheetAction(
            onPressed: () => context.pop(),
            child: Text(context.l10n.cancel),
          ),
        );
      },
    );
  }

  _onActivateEmailPress(int dbId) async {
    await _emailProvider.activateEmail(dbId);
  }

  void _onNewEmailPress() async {
    context.go(AppRoutes.newEmailScreen.path);
  }

  void _onQRGeneratePress(String email) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: SizedBox(
          width: 200,
          height: 200,
          child: Center(
            child: QrImageView(
              data: email,
              version: QrVersions.auto,
            ),
          ),
        ),
      ),
    );
  }

  void _onCopyPress(String email) async {
    await Clipboard.setData(ClipboardData(text: email));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(
        context.l10n.copiedToYourClipboard,
      ),
      duration: const Duration(seconds: 1),
    ));
  }

  void _onSharePress(String email) async {
    Share.share(email);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _onNewEmailPress,
        child: const Icon(
          Icons.add,
        ),
      ),
      appBar: AppBar(
        title: Text(
          context.l10n.email,
        ),
        centerTitle: false,
      ),
      body: Consumer<EmailProvider>(
        builder: (context, value, child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if (value.activeEmail.label.isNotEmpty)
                        Text(
                          value.activeEmail.label,
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      const SizedBox(height: 4),
                      GestureDetector(
                        onTap: () => _onCopyPress(value.activeEmail.email),
                        child: Text(
                          value.activeEmail.email,
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(color: Theme.of(context).primaryColor),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          IconButton(
                            onPressed: () => _onEditPress(value.activeEmail.label, value.activeEmail.isarId),
                            icon: Icon(Icons.edit_outlined, color: Theme.of(context).primaryColor),
                          ),
                          IconButton(
                            onPressed: () => _onQRGeneratePress(value.activeEmail.email),
                            icon: Icon(Icons.qr_code, color: Theme.of(context).primaryColor),
                          ),
                          IconButton(
                            onPressed: () => _onSharePress(value.activeEmail.email),
                            icon: Icon(Icons.share, color: Theme.of(context).primaryColor),
                          ),
                          IconButton(
                            onPressed: () => _onCopyPress(value.activeEmail.email),
                            icon: Icon(Icons.copy, color: Theme.of(context).primaryColor),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (BuildContext context, int index) => Divider(
                  color: Theme.of(context).dividerColor,
                  thickness: 1,
                ),
                itemCount: value.inactiveEmails.length,
                itemBuilder: (context, index) => ListTile(
                  onTap: () => _onEmailPress(value.sortedByDateInactiveEmails[index]),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (value.sortedByDateInactiveEmails[index].label.isNotEmpty) ...[
                        Text(
                          value.sortedByDateInactiveEmails[index].label,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(height: 4),
                      ],
                      Text(
                        value.sortedByDateInactiveEmails[index].email,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    context.l10n.createdDate(
                      _dateFormat.format(value.sortedByDateInactiveEmails[index].generatedAt),
                    ),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).hintColor),
                  ),
                  trailing: _checkIfDomainIsActive(value.sortedByDateInactiveEmails[index])
                      ? null
                      : Padding(
                          padding: const EdgeInsets.only(right: 12.0),
                          child: Tooltip(
                            margin: const EdgeInsets.all(24.0),
                            textAlign: TextAlign.center,
                            showDuration: const Duration(seconds: 10),
                            triggerMode: TooltipTriggerMode.tap,
                            message: context.l10n.attentionThisDisposableEmailAddressHasExpired,
                            child: Icon(
                              Icons.info_outline,
                              color: Theme.of(context).colorScheme.error,
                            ),
                          ),
                        ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}
