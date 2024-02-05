import 'package:dio/dio.dart';
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
          title: const Text("Error"),
          content: Text(e.message ?? "Unknown error"),
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
        title: Text("Mail"),
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
                      MailDetailsSection(title: "From:", value: _mailDetails!.from),
                      Divider(
                        color: Theme.of(context).dividerColor,
                        thickness: 1,
                      ),
                      MailDetailsSection(title: "Subject:", value: _mailDetails!.subject),
                      Divider(
                        color: Theme.of(context).dividerColor,
                        thickness: 1,
                      ),
                      Text(
                        "Message:",
                        style: Theme.of(context).textTheme.titleSmall!,
                      ),
                      const SizedBox(height: 12),
                      HtmlWidget(
                        _mailDetails?.htmlBody ?? "",
                        onTapUrl: _onTapUrl,
                        buildAsync: true,
                      ),
                    ],
                  ),
                )
              : const Center(
                  child: Text("No data found"),
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
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(context).textTheme.titleSmall!,
        ),
        const SizedBox(width: 10),
        Flexible(
          child: GestureDetector(
            onTap: () async {
              await Clipboard.setData(ClipboardData(text: value));
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied to your clipboard !')));
            },
            child: Text(
              value,
              style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).primaryColor),
            ),
          ),
        ),
      ],
    );
  }
}
