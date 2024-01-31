import 'package:email_validator/email_validator.dart';
import 'package:flicker_mail/models/mail/mailbox.dart';
import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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

  void _init() async {
    _isLoadingDomains = true;
    List<String> list = await _emailProvider.getDomainList();
    setState(() {
      _availableDomainList.addAll(list);
      _domainController.text = _availableDomainList.first;
      _isLoadingDomains = false;
    });
  }

  EmailProvider get _emailProvider => context.read<EmailProvider>();

  final List<String> _availableDomainList = [];
  bool get _isLoading => _isActivatingEmail || _isRandomEmailGenerating || _isLoadingDomains;
  bool _isActivatingEmail = false;
  bool _isRandomEmailGenerating = false;
  bool _isLoadingDomains = false;
  final TextEditingController _domainController = TextEditingController();
  final TextEditingController _loginController = TextEditingController();
  int _selectedDomainIndex = 0;

  _onGenerateRandomEmailPress() async {
    if (_isLoading) return;
    setState(() => _isRandomEmailGenerating = true);
    var result = await _emailProvider.generateNewEmail();
    if (result.errorMsg != null || result.data == null) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text("Error"),
          content: Text(result.errorMsg ?? "Something went wrong"),
        ),
      );
    } else {
      _domainController.text = result.data!.domain;
      _loginController.text = result.data!.login;
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
        builder: (context) => const AlertDialog(
          title: Text("Error"),
          content: Text("Email is not valid"),
        ),
      );
      setState(() => _isActivatingEmail = false);
      return;
    }

    var response = await _emailProvider.setNewEmail(
      _loginController.text.replaceAll(" ", ""),
      _domainController.text,
    );
    if (response.errorMsg != null || response.data == null) {
      if (!mounted) return;
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text("Error"),
          content: Text(response.errorMsg ?? "Something went wrong"),
        ),
      );
      setState(() => _isActivatingEmail = false);
    } else {
      if (!mounted) return;
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Flexible(
                    child: TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please enter some text';
                        }
                        return null;
                      },
                      controller: _loginController,
                    ),
                  ),
                  Flexible(
                    child: TextFormField(
                      decoration: InputDecoration(
                        prefix: Text("@"),
                      ),
                      controller: _domainController,
                      readOnly: true,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12.0),
              Text(
                "Available domains:",
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
              OutlinedButton(
                onPressed: _onGenerateRandomEmailPress,
                child: _isRandomEmailGenerating ? CupertinoActivityIndicator() : Text("Generate random email"),
              ),
              SizedBox(height: 12),
              OutlinedButton(
                onPressed: _onEmailActivate,
                child: _isActivatingEmail ? CupertinoActivityIndicator() : Text("Activate new email"),
              )
            ],
          ),
        ),
      ),
    );
  }
}
