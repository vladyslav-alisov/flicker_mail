import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flicker_mail/api/network/sec_mail_api/temp_mail_network_service.dart';
import 'package:flicker_mail/l10n/translate_extension.dart';
import 'package:flicker_mail/models/message_attachment/message_attachment.dart';
import 'package:flicker_mail/models/message_details/message_details.dart';
import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flicker_mail/view/inbox/widgets/mail_details_section.dart';
import 'package:flicker_mail/view/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:file_picker/file_picker.dart';

class MailScreenArgs {
  final int messageId;
  final int messageDbId;

  MailScreenArgs(this.messageId, this.messageDbId);
}

class EmailMessageDetailsScreen extends StatefulWidget {
  EmailMessageDetailsScreen({Key? key, required MailScreenArgs args})
      : messageId = args.messageId,
        messageDbId = args.messageDbId,
        super(key: key);

  final int messageId;
  final int messageDbId;

  @override
  State<EmailMessageDetailsScreen> createState() => _EmailMessageDetailsScreenState();
}

class _EmailMessageDetailsScreenState extends State<EmailMessageDetailsScreen> {
  bool _isLoading = false;
  late final WebViewController _controller;

  MessageDetails? _mailDetails;

  EmailProvider get _emailProvider => context.read<EmailProvider>();

  @override
  void initState() {
    super.initState();
    _initData();
    _controller = WebViewController();
  }

  _initData() async {
    try {
      _isLoading = true;
      MessageDetails mailDetails = await _emailProvider.getEmailMessageDetails(
        widget.messageId,
        widget.messageDbId,
      );

      _mailDetails = mailDetails;
      await _controller.loadHtmlString(mailDetails.body);
      await _emailProvider.updateDidRead(widget.messageDbId);
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
          : _mailDetails != null
              ? Column(
                  children: [
                    const SizedBox(height: 12),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
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
                          if (_mailDetails!.attachments.isNotEmpty) ...[
                            Divider(
                              color: Theme.of(context).dividerColor,
                              thickness: 1,
                            ),
                            Wrap(
                              children: List.generate(
                                _mailDetails!.attachments.length,
                                (index) {
                                  return GestureDetector(
                                      onTap: () => _onFilePress(_mailDetails!.attachments[index]),
                                      child: FileContainer(attachment: _mailDetails!.attachments[index]));
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
                )
              : Center(
                  child: Text(
                    context.l10n.noDataFound,
                  ),
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
