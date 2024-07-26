import 'package:dio/dio.dart';
import 'package:flicker_mail/const_gen/assets.gen.dart';
import 'package:flicker_mail/l10n/translate_extension.dart';
import 'package:flicker_mail/models/email/email.dart';
import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flicker_mail/router/app_routes.dart';
import 'package:flicker_mail/view/email/widgets/edit_label_dialog.dart';
import 'package:flicker_mail/view/widgets/success_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:sentry_flutter/sentry_flutter.dart';
import 'package:share_plus/share_plus.dart';
import 'package:url_launcher/url_launcher.dart';

final Uri _url = Uri.parse("https://www.1secmail.com/");

class MailboxScreen extends StatefulWidget {
  const MailboxScreen({super.key});

  @override
  State<MailboxScreen> createState() => _MailboxScreenState();
}

class _MailboxScreenState extends State<MailboxScreen> with AutomaticKeepAliveClientMixin<MailboxScreen> {
  EmailProvider get _emailProvider => context.read<EmailProvider>();

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

  void _onNewEmailPress() async {
    try {
      var dio = Dio();
      await dio.get("aojwndamwld");
    } catch (exception, stackTrace) {
      print("hello");

      await Sentry.captureException(
        exception,
        stackTrace: stackTrace,
      );
    }
    // context.go(AppRoutes.newEmailScreen.path);
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
        content: SuccessSnackBarContent(
          text: context.l10n.copiedToYourClipboard,
        ),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _onSharePress(String email) async {
    Share.share(email);
  }

  void _onHistoryPress() {
    context.go(AppRoutes.emailArchiveScreen.path);
  }

  void _on1secMailPress() async {
    await launchUrl(_url);
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.email,
        ),
        centerTitle: false,
      ),
      body: SingleChildScrollView(
        child: Consumer<EmailProvider>(
          builder: (context, value, child) => Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          context.l10n.freeTemporaryEmail,
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w500),
                        ),
                        GestureDetector(
                          onTap: _on1secMailPress,
                          child: Text.rich(
                            TextSpan(
                              text: context.l10n.protectYourPrivacyAndBeatSpam,
                              style: Theme.of(context).textTheme.titleMedium,
                              children: [
                                TextSpan(
                                  text: "1secmail.com API. ",
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleMedium
                                      ?.copyWith(color: Theme.of(context).colorScheme.primary),
                                ),
                                TextSpan(
                                  text: context.l10n.instantlyCreateDisposableEmailAddresses,
                                  style: Theme.of(context).textTheme.titleMedium,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                GestureDetector(
                  onTap: _onHistoryPress,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            Assets.images.logoTb.path,
                            width: 100,
                            height: 100,
                          ),
                          if (value.activeEmail.label.trim().isNotEmpty) ...[
                            Text(
                              value.activeEmail.label,
                              style: Theme.of(context).textTheme.titleSmall,
                            ),
                            const SizedBox(height: 12),
                          ],
                          Text(
                            value.activeEmail.email,
                            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                  color: Theme.of(context).colorScheme.primary,
                                ),
                          ),
                          if (!_checkIfDomainIsActive(_emailProvider.activeEmail))
                            Padding(
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
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: CustomActionButton(
                            onPressed: () => _onEditPress(value.activeEmail.label, value.activeEmail.isarId),
                            iconData: Icons.edit_outlined,
                            label: context.l10n.editLabel,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomActionButton(
                            onPressed: () => _onQRGeneratePress(value.activeEmail.email),
                            iconData: Icons.qr_code,
                            label: context.l10n.qr,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: CustomActionButton(
                            onPressed: () => _onSharePress(value.activeEmail.email),
                            iconData: Icons.share,
                            label: context.l10n.share,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: CustomActionButton(
                            onPressed: () => _onCopyPress(value.activeEmail.email),
                            iconData: Icons.copy,
                            label: context.l10n.copy,
                          ),
                        ),
                      ],
                    ),
                    CustomActionButton(
                      onPressed: _onNewEmailPress,
                      iconData: Icons.add,
                      label: context.l10n.createNewEmail,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class CustomActionButton extends StatelessWidget {
  const CustomActionButton({
    super.key,
    this.onPressed,
    required this.iconData,
    required this.label,
  });

  final Function()? onPressed;
  final IconData iconData;
  final String label;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(iconData, color: Theme.of(context).primaryColor),
      label: Text(label),
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
      ),
    );
  }
}
