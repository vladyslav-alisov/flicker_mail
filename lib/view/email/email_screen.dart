import 'dart:async';

import 'package:flicker_mail/l10n/translate_extension.dart';
import 'package:flicker_mail/models/mail/mailbox.dart';
import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flicker_mail/router/app_routes.dart';
import 'package:flicker_mail/view/email/create_new_email.dart';
import 'package:flicker_mail/view/widgets/option_dialog.dart';
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

  void _onActiveEmailPress() {
    context.go(AppRoutes.savedEmailsScreen.path);
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
          mainAxisAlignment: MainAxisAlignment.center,
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
                              onTap: () => _onActiveEmailPress(),
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
