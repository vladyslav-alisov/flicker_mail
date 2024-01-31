import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flicker_mail/view/email/create_new_email.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:share_plus/share_plus.dart';

class MailboxScreen extends StatefulWidget {
  const MailboxScreen({super.key});

  @override
  State<MailboxScreen> createState() => _MailboxScreenState();
}

class _MailboxScreenState extends State<MailboxScreen> with AutomaticKeepAliveClientMixin<MailboxScreen> {
  void _onNewEmailPress() async {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        ),
      ),
      // clipBehavior: Clip.antiAliasWithSaveLayer,
      builder: (context) => Padding(
        padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 50, left: 12, right: 12, top: 12),
        child: NewEmailScreen(),
      ),
    );
  }

  void _onCopyPress(String email) async {
    await Clipboard.setData(ClipboardData(text: email));
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied to your clipboard !')));
  }

  void _onSharePress(String email) async {
    Share.share(email);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: ListView(
          padding: const EdgeInsets.all(12),
          children: [
            Text(
              "Email",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            Consumer<EmailProvider>(
              builder: (context, value, child) => Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Active email: ${value.activeEmail.email}", style: Theme.of(context).textTheme.titleMedium),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      IconButton(
                        onPressed: () => _onCopyPress(value.activeEmail.email),
                        icon: const Icon(Icons.copy),
                      ),
                      IconButton(
                        onPressed: () => _onSharePress(value.activeEmail.email),
                        icon: const Icon(Icons.share),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                  child: OutlinedButton(
                    onPressed: _onNewEmailPress,
                    child: const Text("New email"),
                  ),
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
