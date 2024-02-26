import 'dart:async';

import 'package:flicker_mail/l10n/translate_extension.dart';
import 'package:flicker_mail/models/mail/mailbox.dart';
import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flicker_mail/view/email/create_new_email.dart';
import 'package:flicker_mail/view/widgets/option_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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

  void _onInactiveEmailPress(int dbId) async {
    bool isConfirm = await showDialog(
      context: context,
      builder: (context) => OptionDialog(
        title: context.l10n.confirmAction,
        content: context.l10n.areYouSureYouWantToUseThisEmail,
      ),
    );
    if (isConfirm) {
      await _emailProvider.activateEmail(dbId);
    }
  }

  void _onNewEmailPress() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 50,
          left: 12,
          right: 12,
          top: 12,
        ),
        child: NewEmailScreen(
          availableDomainList: _emailProvider.availableDomains,
        ),
      ),
    );
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

  Future<bool> _onConfirmDismiss(int id) async {
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

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: _onNewEmailPress,
        child: const Icon(Icons.add),
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
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          RichText(
                            text: TextSpan(
                              text: context.l10n.activeEmail,
                              style: Theme.of(context).textTheme.titleMedium,
                              children: [
                                if (value.activeEmail.label.isNotEmpty)
                                  TextSpan(
                                    text: " (${value.activeEmail.label})",
                                    style: Theme.of(context).textTheme.titleSmall,
                                  ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 4),
                          SelectionArea(
                            child: GestureDetector(
                              onTap: () => _onCopyPress(value.activeEmail.email),
                              child: Text(
                                value.activeEmail.email,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleLarge
                                    ?.copyWith(color: Theme.of(context).primaryColor),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(
              color: Theme.of(context).dividerColor,
              thickness: 1,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton.icon(
                  onPressed: () => _onCopyPress(value.activeEmail.email),
                  label: Text(
                    context.l10n.copy,
                  ),
                  icon: const Icon(Icons.copy),
                ),
                TextButton.icon(
                  onPressed: () => _onSharePress(value.activeEmail.email),
                  label: Text(
                    context.l10n.share,
                  ),
                  icon: const Icon(Icons.share),
                ),
                TextButton.icon(
                  onPressed: () => _onQRGeneratePress(value.activeEmail.email),
                  label: Text(
                    context.l10n.qr,
                  ),
                  icon: const Icon(Icons.qr_code),
                ),
              ],
            ),
            Divider(
              color: Theme.of(context).dividerColor,
              thickness: 1,
            ),
            value.inactiveEmails.isNotEmpty
                ? Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Text(
                      context.l10n.savedEmails,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  )
                : Container(),
            value.inactiveEmails.isNotEmpty
                ? Expanded(
                    child: ListView.separated(
                      separatorBuilder: (BuildContext context, int index) => Divider(
                        color: Theme.of(context).dividerColor,
                        thickness: 1,
                      ),
                      itemCount: value.inactiveEmails.length,
                      itemBuilder: (context, index) => Dismissible(
                        background: Container(
                          color: Colors.red,
                          child: const Align(
                            alignment: Alignment.centerRight,
                            child: Padding(
                              padding: EdgeInsets.only(right: 16),
                              child: Icon(Icons.delete),
                            ),
                          ),
                        ),
                        confirmDismiss: (direction) => _onConfirmDismiss(value.inactiveEmails[index].isarId),
                        direction: DismissDirection.endToStart,
                        key: Key(
                          value.inactiveEmails[index].generateID,
                        ),
                        child: ListTile(
                          onTap: () => _onInactiveEmailPress(value.inactiveEmails[index].isarId),
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              if (value.inactiveEmails[index].label.isNotEmpty) ...[
                                Text(
                                  value.inactiveEmails[index].label,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                                const SizedBox(height: 2),
                              ],
                              Text(
                                value.inactiveEmails[index].email,
                                style: Theme.of(context).textTheme.titleMedium,
                              ),
                            ],
                          ),
                          subtitle: Text(
                            context.l10n.createdDate(
                              _dateFormat.format(value.inactiveEmails[index].generatedAt),
                            ),
                          ),
                          trailing: _checkIfDomainIsActive(value.inactiveEmails[index])
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
                  )
                : Container(),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class IconTextButton extends StatelessWidget {
  const IconTextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
