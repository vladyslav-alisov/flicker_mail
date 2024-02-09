import 'package:flicker_mail/l10n/translate_extension.dart';
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
  final List<String> _availableDomainList = [];

  EmailProvider get _emailProvider => context.read<EmailProvider>();
  final DateFormat _dateFormat = DateFormat.yMMMd().add_jm();

  @override
  void initState() {
    super.initState();
    _emailProvider.getDomainList().then((value) => _availableDomainList.addAll(value));
  }

  _onInactiveEmailPress(int dbId) async {
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
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 50, left: 12, right: 12, top: 12),
        child: NewEmailScreen(availableDomainList: _availableDomainList),
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
    );
    if (isDelete) {
      bool result = await _emailProvider.removeEmail(id);
      return result;
    } else {
      return isDelete;
    }
  }

  @override
  Widget build(BuildContext context) {
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
                          Text(
                            context.l10n.activeEmail,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(height: 4),
                          GestureDetector(
                            onTap: () => _onCopyPress(value.activeEmail.email),
                            child: Text(
                              value.activeEmail.email,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(color: Theme.of(context).primaryColor),
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
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                context.l10n.savedEmails,
                style: Theme.of(context).textTheme.titleMedium,
              ),
            ),
            Expanded(
              child: ListView(
                children: List.generate(
                  value.inactiveEmails.length,
                  (index) => Dismissible(
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
                      value.inactiveEmails[index].generatedAt.toString() +
                          value.inactiveEmails[index].isarId.toString(),
                    ),
                    child: ListTile(
                      onTap: () => _onInactiveEmailPress(value.inactiveEmails[index].isarId),
                      title: Text(value.inactiveEmails[index].email),
                      subtitle: Text(
                        context.l10n.createdDate(
                          _dateFormat.format(value.inactiveEmails[index].generatedAt),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
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
