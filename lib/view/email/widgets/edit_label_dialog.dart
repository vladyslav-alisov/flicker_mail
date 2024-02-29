import 'package:flicker_mail/l10n/translate_extension.dart';
import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class EditLabelDialog extends StatefulWidget {
  const EditLabelDialog({Key? key, required this.initLabel, required this.id}) : super(key: key);

  final String initLabel;
  final int id;

  @override
  State<EditLabelDialog> createState() => _EditLabelDialogState();
}

class _EditLabelDialogState extends State<EditLabelDialog> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _labelController;
  EmailProvider get _emailProvider => context.read<EmailProvider>();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _labelController = TextEditingController(text: widget.initLabel);
  }

  void _onConfirmPress() async {
    if (_isLoading) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      await _emailProvider.changeEmailLabel(widget.id, _labelController.text);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(
                Icons.check_outlined,
                color: Colors.green,
              ),
              const SizedBox(width: 4),
              Text("${context.l10n.successfullyChangedLabel}!"),
            ],
          ),
        ),
      );
      context.pop();
    } catch (e) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(context.l10n.error),
          content: Text(e.toString()),
        ),
      );
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: AlertDialog(
        title: Text(
          context.l10n.editLabel,
        ),
        content: TextFormField(
          controller: _labelController,
          validator: (value) => (value?.length ?? 0) < 25 ? null : "max 25 characters",
        ),
        actions: [
          TextButton(
            onPressed: () => context.pop(),
            child: Text(
              context.l10n.cancel,
            ),
          ),
          TextButton(
            onPressed: _onConfirmPress,
            child: Text(
              context.l10n.confirm,
            ),
          ),
        ],
      ),
    );
  }
}
