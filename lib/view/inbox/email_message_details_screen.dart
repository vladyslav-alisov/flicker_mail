import 'package:dio/dio.dart';
import 'package:flicker_mail/l10n/translate_extension.dart';
import 'package:flicker_mail/models/email_message/email_message.dart';
import 'package:flicker_mail/models/message_attachment/message_attachment.dart';
import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flicker_mail/view/inbox/widgets/custom_circular_avatar.dart';
import 'package:flicker_mail/view/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';

class MailScreenArgs {
  final EmailMessage emailMessage;

  MailScreenArgs(this.emailMessage);
}

class EmailMessageDetailsScreen extends StatefulWidget {
  EmailMessageDetailsScreen({Key? key, required MailScreenArgs args})
      : emailMessage = args.emailMessage,
        super(key: key);

  final EmailMessage emailMessage;

  @override
  State<EmailMessageDetailsScreen> createState() => _EmailMessageDetailsScreenState();
}

class _EmailMessageDetailsScreenState extends State<EmailMessageDetailsScreen> {
  bool _isLoading = false;
  late final WebViewController _controller;

  late EmailMessage _emailMessage;

  EmailProvider get _emailProvider => context.read<EmailProvider>();

  @override
  void initState() {
    super.initState();
    _controller = WebViewController();
    _initData();
  }

  _initData() async {
    try {
      _isLoading = true;
      _emailMessage = widget.emailMessage;

      await _controller.loadHtmlString(_emailMessage.body);
      if (!widget.emailMessage.didRead) {
        await _emailProvider.updateDidRead(widget.emailMessage.dbId);
      }
    } on DioException catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => ErrorDialog(
          content: e.message ?? context.l10n.unknownError,
        ),
      );
    } catch (e) {
      rethrow;
    } finally {
      setState(() => _isLoading = false);
    }
  }

  void _onFilePress(MessageAttachment messageAttachment) async {
    try {
      await Share.shareXFiles(
        [
          XFile(
            messageAttachment.filePath,
            name: messageAttachment.filename,
            mimeType: messageAttachment.filename.split(".").last,
          ),
        ],
      );
    } catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => const ErrorDialog(content: "File is not available"),
      );
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
          : Column(
              children: [
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        _emailMessage.subject.trim().isEmpty ? "(${context.l10n.noSubject})" : _emailMessage.subject,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 12),
                      ListTile(
                        titleAlignment: ListTileTitleAlignment.titleHeight,
                        contentPadding: EdgeInsets.zero,
                        leading: CustomCircularAvatar(name: _emailMessage.from),
                        title: Text(
                          _emailMessage.from,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        subtitle: Text(context.l10n.toEmail(_emailMessage.email)),
                        trailing: Text(
                          _emailMessage.formattedDate,
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ),
                      if (_emailMessage.attachments.isNotEmpty) ...[
                        Divider(
                          color: Theme.of(context).dividerColor,
                          thickness: 1,
                        ),
                        Wrap(
                          children: List.generate(
                            _emailMessage.attachments.length,
                            (index) {
                              return GestureDetector(
                                  onTap: () => _onFilePress(_emailMessage.attachments[index]),
                                  child: FileContainer(attachment: _emailMessage.attachments[index]));
                            },
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                Expanded(
                  child: WebViewWidget(
                    controller: _controller,
                  ),
                ),
              ],
            ),
    );
  }
}

class FileContainer extends StatelessWidget {
  const FileContainer({Key? key, required this.attachment}) : super(key: key);

  final MessageAttachment attachment;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Icon(Icons.file_copy),
            const SizedBox(
              height: 2,
            ),
            Text(attachment.filename),
          ],
        ),
      ),
    );
  }
}
