import 'package:dio/dio.dart';
import 'package:flicker_mail/models/mail/mail_details.dart';
import 'package:flicker_mail/providers/inbox_provider.dart';
import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flutter/material.dart';
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

  InboxProvider get _mailProvider => context.read<InboxProvider>();

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
      _mailDetails = await _mailProvider.getMailDetails(widget.mailId);
      setState(() => _isLoading = false);
    } on DioException catch (e) {
      setState(() => _isLoading = false);
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: Text(e.message ?? "Unknown"),
        ),
      );
    } catch (e) {
      rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : _mailDetails != null
                ? ListView(
                    padding: EdgeInsets.all(12),
                    children: [
                      Text(
                        "Mail details",
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      Text("From: ${_mailDetails!.from}"),
                      SizedBox(height: 5),
                      Text("Subject: ${_mailDetails!.subject}"),
                      SizedBox(height: 12),
                      HtmlWidget(_mailDetails?.htmlBody ?? "", onTapUrl: _onTapUrl),
                    ],
                  )
                : const Center(
                    child: Text("No data found"),
                  ),
      ),
    );
  }
}
