import 'package:dio/dio.dart';
import 'package:flicker_mail/l10n/translate_extension.dart';
import 'package:flicker_mail/models/mail/mail_details.dart';
import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class MailScreenArgs {
  final int mailId;

  MailScreenArgs(this.mailId);
}

class MailScreen extends StatefulWidget {
  MailScreen({Key? key, required MailScreenArgs args})
      : mailId = args.mailId,
        super(key: key);

  final int mailId;

  @override
  State<MailScreen> createState() => _MailScreenState();
}

class _MailScreenState extends State<MailScreen> {
  bool _isLoading = false;

  MailDetails? _mailDetails;

  EmailProvider get _emailProvider => context.read<EmailProvider>();

  @override
  void initState() {
    super.initState();
    _initData();
  }

  Future<bool> _onTapUrl(String url) async {
    Uri uri = Uri.parse(url);
    bool didLaunch = await launchUrl(uri);
    return didLaunch;
  }

  _initData() async {
    try {
      _isLoading = true;
      _mailDetails = await _emailProvider.getMailDetails(widget.mailId);
      setState(() => _isLoading = false);
    } on DioException catch (e) {
      setState(() => _isLoading = false);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(
            context.l10n.error,
          ),
          content: Text(
            e.message ?? context.l10n.unknownError,
          ),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.mail),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12.0),
            child: Tooltip(
              margin: const EdgeInsets.all(24.0),
              textAlign: TextAlign.center,
              showDuration: const Duration(seconds: 10),
              triggerMode: TooltipTriggerMode.tap,
              message: context.l10n.attachmentsAreNotAvailableInThisVersionOfTheApp,
              child: const Icon(Icons.help_outline),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _mailDetails != null
              ? SelectionArea(
                  child: ListView(
                    padding: const EdgeInsets.all(12),
                    children: [
                      const SizedBox(height: 12),
                      MailDetailsSection(
                        title: "${context.l10n.from}:",
                        value: _mailDetails!.from,
                      ),
                      Divider(
                        color: Theme.of(context).dividerColor,
                        thickness: 1,
                      ),
                      MailDetailsSection(
                        title: "${context.l10n.subject}:",
                        value: _mailDetails!.subject,
                      ),
                      Divider(
                        color: Theme.of(context).dividerColor,
                        thickness: 1,
                      ),
                      const SizedBox(height: 12),
                      HtmlWidget(
                        _mailDetails!.body,
                        onTapUrl: _onTapUrl,
                        buildAsync: true,
                      ),
                    ],
                  ),
                )
              : Center(
                  child: Text(
                    context.l10n.noDataFound,
                  ),
                ),
    );
  }
}

class MailDetailsSection extends StatelessWidget {
  const MailDetailsSection({Key? key, required this.title, required this.value}) : super(key: key);

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await Clipboard.setData(ClipboardData(text: value));
        if (!context.mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              context.l10n.copiedToYourClipboard,
            ),
          ),
        );
      },
      child: RichText(
        text: TextSpan(
          text: title,
          style: Theme.of(context).textTheme.titleSmall!,
          children: [
            TextSpan(
              text: " $value",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
