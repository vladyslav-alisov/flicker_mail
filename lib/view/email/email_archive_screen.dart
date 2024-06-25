import 'package:flicker_mail/l10n/translate_extension.dart';
import 'package:flicker_mail/models/email/email.dart';
import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flicker_mail/router/app_routes.dart';
import 'package:flicker_mail/view/email/widgets/edit_label_dialog.dart';
import 'package:flicker_mail/view/widgets/error_dialog.dart';
import 'package:flicker_mail/view/widgets/option_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:share_plus/share_plus.dart';

class EmailArchiveScreen extends StatefulWidget {
  const EmailArchiveScreen({Key? key}) : super(key: key);

  static final DateFormat _dateFormat = DateFormat.yMMMd().add_jm();

  @override
  State<EmailArchiveScreen> createState() => _EmailArchiveScreenState();
}

class _EmailArchiveScreenState extends State<EmailArchiveScreen> {
  EmailProvider get _emailProvider => context.read<EmailProvider>();

  EmailProvider get _emailProviderW => context.watch<EmailProvider>();

  void _onNewEmailPress() async {
    context.go(AppRoutes.newEmailScreen.path);
  }

  void _onActivateEmailPress(int dbId) async {
    try {
      await _emailProvider.activateEmail(dbId);
    } catch (e) {
      if (mounted) {
        showDialog(
          context: context,
          builder: (context) => ErrorDialog(content: e.toString()),
        );
      }
    } finally {
      if (mounted) context.pop();
    }
  }

  bool _checkIfDomainIsActive(Email email) {
    return _emailProvider.availableDomains.contains(email.domain);
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
      bool result = await _emailProvider.deleteEmail(id);
      return result;
    } else {
      return isDelete;
    }
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
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          context.l10n.copiedToYourClipboard,
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _onSharePress(String email) async {
    Share.share(email);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.emailArchive)),
      body: _emailProviderW.inactiveEmails.isEmpty
          ? Padding(
              padding: const EdgeInsets.all(12.0),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      context.l10n.looksLikeYouHaveUsedADisposableEmail,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 4),
                    ElevatedButton(
                      onPressed: _onNewEmailPress,
                      child: Text(
                        context.l10n.createNewEmail,
                      ),
                    ),
                  ],
                ),
              ),
            )
          : ListView.separated(
              padding: const EdgeInsets.all(16),
              separatorBuilder: (BuildContext context, int index) => const SizedBox(height: 8),
              itemCount: _emailProviderW.inactiveEmails.length,
              itemBuilder: (context, index) => Card(
                child: ListTile(
                  onTap: () => _onEmailPress(_emailProvider.sortedByDateInactiveEmails[index]),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (_emailProvider.sortedByDateInactiveEmails[index].label.isNotEmpty) ...[
                        Text(
                          _emailProvider.sortedByDateInactiveEmails[index].label,
                          style: Theme.of(context).textTheme.labelLarge,
                        ),
                        const SizedBox(height: 4),
                      ],
                      Text(
                        _emailProvider.sortedByDateInactiveEmails[index].email,
                        style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).primaryColor),
                      ),
                    ],
                  ),
                  subtitle: Text(
                    context.l10n.createdDate(
                      EmailArchiveScreen._dateFormat
                          .format(_emailProvider.sortedByDateInactiveEmails[index].generatedAt),
                    ),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Theme.of(context).hintColor),
                  ),
                  trailing: _checkIfDomainIsActive(_emailProvider.sortedByDateInactiveEmails[index])
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
            ),
    );
  }
}
