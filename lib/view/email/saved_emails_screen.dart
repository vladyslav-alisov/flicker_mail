import 'package:flicker_mail/l10n/translate_extension.dart';
import 'package:flicker_mail/models/mail/mailbox.dart';
import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flicker_mail/view/widgets/option_dialog.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class SavedEmailsScreen extends StatefulWidget {
  const SavedEmailsScreen({Key? key}) : super(key: key);

  @override
  State<SavedEmailsScreen> createState() => _SavedEmailsScreenState();
}

class _SavedEmailsScreenState extends State<SavedEmailsScreen> {
  EmailProvider get _emailProvider => context.read<EmailProvider>();
  final DateFormat _dateFormat = DateFormat.yMMMd().add_jm();

  bool _checkIfDomainIsActive(Email email) {
    return _emailProvider.availableDomains.contains(email.domain);
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
      if (mounted) context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.savedEmails,
        ),
        centerTitle: false,
      ),
      body: Consumer<EmailProvider>(
        builder: (context, value, child) => ListView.separated(
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
            confirmDismiss: (direction) => _onConfirmDismiss(value.sortedByDateInactiveEmails[index].isarId),
            direction: DismissDirection.endToStart,
            key: Key(
              value.sortedByDateInactiveEmails[index].generateID,
            ),
            child: ListTile(
              onTap: () => _onInactiveEmailPress(value.sortedByDateInactiveEmails[index].isarId),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (value.sortedByDateInactiveEmails[index].label.isNotEmpty) ...[
                    Text(
                      value.sortedByDateInactiveEmails[index].label,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 2),
                  ],
                  Text(
                    value.sortedByDateInactiveEmails[index].email,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
              subtitle: Text(
                context.l10n.createdDate(
                  _dateFormat.format(value.sortedByDateInactiveEmails[index].generatedAt),
                ),
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
        ),
      ),
    );
  }
}
