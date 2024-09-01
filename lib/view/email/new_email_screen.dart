import 'package:email_validator/email_validator.dart';
import 'package:flicker_mail/l10n/translate_extension.dart';
import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:in_app_review/in_app_review.dart';
import 'package:provider/provider.dart';

class NewEmailScreen extends StatefulWidget {
  const NewEmailScreen({Key? key}) : super(key: key);

  @override
  State<NewEmailScreen> createState() => _NewEmailScreenState();
}

class _NewEmailScreenState extends State<NewEmailScreen> {
  @override
  void initState() {
    super.initState();
    _init();
  }

  final _formKey = GlobalKey<FormState>();
  late TextEditingController _domainController;
  late TextEditingController _loginController;
  late TextEditingController _labelController;
  late List<String> _availableDomainList;

  @override
  void dispose() {
    super.dispose();
    _domainController.dispose();
    _loginController.dispose();
  }

  void _init() async {
    _availableDomainList = _emailProvider.availableDomains;
    _selectedDomainIndex = 0;

    _domainController = TextEditingController(
      text: _availableDomainList.isNotEmpty ? _availableDomainList.first : "1secmail.com",
    );

    _loginController = TextEditingController();
    _labelController = TextEditingController(text: "");
  }

  EmailProvider get _emailProvider => context.read<EmailProvider>();

  bool get _isLoading => _isActivatingEmail || _isRandomEmailGenerating;

  bool _isActivatingEmail = false;
  bool _isRandomEmailGenerating = false;

  int _selectedDomainIndex = 0;

  _onGenerateRandomEmailPress() async {
    if (_isLoading) return;
    setState(() => _isRandomEmailGenerating = true);
    final result = await _emailProvider.generateRandomEmail();
    if (result.errorMsg != null || result.data == null) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(context.l10n.error),
          content: Text(result.errorMsg ?? context.l10n.somethingWentWrong),
        ),
      );
    } else {
      final (String login, String domain) = result.data!;
      _domainController.text = domain;
      _loginController.text = login;
      int newIndex = _availableDomainList.indexWhere((element) => element == domain);
      if (newIndex != -1) {
        _selectedDomainIndex = newIndex;
      }
    }
    setState(() => _isRandomEmailGenerating = false);
  }

  _onEmailActivate() async {
    if (_isLoading) return;
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isActivatingEmail = true);
    bool isValidEmail = EmailValidator.validate("${_loginController.text}@${_domainController.text}", true, true);
    if (!isValidEmail) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(context.l10n.error),
          content: Text(context.l10n.emailIsNotValid),
        ),
      );
      setState(() => _isActivatingEmail = false);
      return;
    }

    bool isExist = await _emailProvider.checkIfEmailExist(
      _loginController.text,
      _domainController.text,
    );

    if (isExist) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(context.l10n.error),
          content: Text(context.l10n.emailIsAlreadySaved),
        ),
      );
      setState(() => _isActivatingEmail = false);
      return;
    }

    var response = await _emailProvider.saveNewEmail(
      _loginController.text.replaceAll(" ", ""),
      _domainController.text,
      _labelController.text,
    );

    if (response.errorMsg != null || response.data == null) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(context.l10n.error),
          content: Text(response.errorMsg ?? context.l10n.somethingWentWrong),
        ),
      );
      setState(() => _isActivatingEmail = false);
    } else {
      final InAppReview inAppReview = InAppReview.instance;

      try {
        if (await inAppReview.isAvailable()) {
          inAppReview.requestReview();
        }
      } finally {
        if (mounted) context.pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.newEmail),
      ),
      persistentFooterButtons: [
        SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: _onEmailActivate,
            child: _isActivatingEmail
                ? const CupertinoActivityIndicator()
                : Text(
                    context.l10n.activate,
                    textAlign: TextAlign.center,
                  ),
          ),
        ),
      ],
      body: GestureDetector(
        onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  Text(
                    "${context.l10n.label} (${context.l10n.optional})",
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    autocorrect: false,
                    textInputAction: TextInputAction.next,
                    validator: (value) => (value?.length ?? 0) < 25 ? null : "max 25 characters",
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      hintText: context.l10n.myEmail,
                    ),
                    controller: _labelController,
                  ),
                  const SizedBox(height: 24.0),
                  Text(
                    context.l10n.newEmail,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12.0),
                  TextFormField(
                    autocorrect: false,
                    decoration: InputDecoration(
                      filled: true,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      suffixIcon: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text("@${_domainController.text}"),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return context.l10n.pleaseEnterSomeText;
                      }
                      return null;
                    },
                    controller: _loginController,
                    enabled: true,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: _onGenerateRandomEmailPress,
                      child: _isRandomEmailGenerating
                          ? const CupertinoActivityIndicator()
                          : Text(
                              context.l10n.generateRandomEmail,
                              textAlign: TextAlign.center,
                            ),
                    ),
                  ),
                  Text(
                    context.l10n.availableDomains,
                    textAlign: TextAlign.start,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 12.0),
                  Wrap(
                    spacing: 5.0,
                    children: List<Widget>.generate(
                      _availableDomainList.length,
                      (int index) {
                        return ChoiceChip(
                          label: Text(_availableDomainList[index]),
                          selected: _selectedDomainIndex == index,
                          onSelected: (bool selected) {
                            setState(() {
                              _selectedDomainIndex = index;
                              _domainController.text = _availableDomainList[index];
                            });
                          },
                        );
                      },
                    ).toList(),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
