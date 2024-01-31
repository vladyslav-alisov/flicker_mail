import 'package:flicker_mail/l10n/translate_extension.dart';
import 'package:flicker_mail/view/email/email_screen.dart';
import 'package:flicker_mail/view/inbox/inbox_screen.dart';
import 'package:flicker_mail/view/settings/settings_screen.dart';
import 'package:flutter/material.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> {
  late int _selectedIndex;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _pageController = PageController(initialPage: _selectedIndex);
  }

  final List<Widget> _destinations = [const MailboxScreen(), const InboxScreen(), const SettingsScreen()];

  void _onDestinationSelected(int i) {
    setState(() {
      _selectedIndex = i;
      _pageController.jumpToPage(i);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onDestinationSelected,
        currentIndex: _selectedIndex,
        items: [
          BottomNavigationBarItem(icon: const Icon(Icons.email), label: "Email"),
          BottomNavigationBarItem(icon: const Icon(Icons.inbox), label: "Inbox"),
          BottomNavigationBarItem(icon: const Icon(Icons.settings), label: context.l10n.settings),
        ],
      ),
      body: PageView(
        controller: _pageController,
        physics: const NeverScrollableScrollPhysics(),
        children: _destinations,
      ),
    );
  }
}