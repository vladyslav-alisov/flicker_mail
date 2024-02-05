import 'package:email_validator/email_validator.dart';
import 'package:flicker_mail/providers/email_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class NewEmailScreen extends StatefulWidget {
  const NewEmailScreen({Key? key, required this.availableDomainList}) : super(key: key);

  final List<String> availableDomainList;

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
  late List<String> _availableDomainList;

  @override
  void dispose() {
    super.dispose();
    _domainController.dispose();
    _loginController.dispose();
  }

  void _init() async {
    _availableDomainList = widget.availableDomainList;
    _selectedDomainIndex = 0;
    if (_availableDomainList.isNotEmpty) {
      _domainController = TextEditingController(text: _availableDomainList.first);
      _loginController = TextEditingController();
    } else {
      _domainController = TextEditingController(text: "1secmail.com");
      _loginController = TextEditingController();
    }
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
          title: const Text("Error"),
          content: Text(result.errorMsg ?? "Something went wrong"),
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
        builder: (context) => const AlertDialog(
          title: Text("Error"),
          content: Text("Email is not valid"),
        ),
      );
      setState(() => _isActivatingEmail = false);
      return;
    }

    var response = await _emailProvider.saveNewEmail(
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              Text(
                "New email",
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 12.0),
              Flexible(
                child: TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    suffixIcon: Padding(padding: const EdgeInsets.all(15), child: Text("@${_domainController.text}")),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter some text';
                    }
                    return null;
                  },
                  controller: _loginController,
                  enabled: true,
                ),
              ),
              const SizedBox(height: 24.0),
              Text(
                "Available domains",
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
              const SizedBox(height: 24),
              Row(
                children: [
                  Flexible(
                    child: ElevatedButton(
                      onPressed: _onGenerateRandomEmailPress,
                      child: _isRandomEmailGenerating
                          ? const CupertinoActivityIndicator()
                          : const Text(
                              "Generate random email",
                              textAlign: TextAlign.center,
                            ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Flexible(
                    child: ElevatedButton(
                      onPressed: _onEmailActivate,
                      child: _isActivatingEmail
                          ? const CupertinoActivityIndicator()
                          : const Text(
                              "Activate new email",
                              textAlign: TextAlign.center,
                            ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
