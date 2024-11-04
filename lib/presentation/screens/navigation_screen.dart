import 'dart:async';

import 'package:flicker_mail/core/l10n/translate_extension.dart';
import 'package:flicker_mail/presentation/providers/adv_provider.dart';
import 'package:flicker_mail/presentation/providers/email_provider.dart';
import 'package:flicker_mail/presentation/screens/email/email_screen.dart';
import 'package:flicker_mail/presentation/screens/inbox/inbox_screen.dart';
import 'package:flicker_mail/presentation/screens/settings/settings_screen.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:provider/provider.dart';

class NavigationScreen extends StatefulWidget {
  const NavigationScreen({Key? key}) : super(key: key);

  @override
  State<NavigationScreen> createState() => _NavigationScreenState();
}

class _NavigationScreenState extends State<NavigationScreen> with WidgetsBindingObserver {
  final InternetConnectionChecker _connectionChecker = InternetConnectionChecker();

  late int _selectedIndex;
  late PageController _pageController;
  late Timer _timer;

  StreamSubscription<InternetConnectionStatus>? subscription;

  EmailProvider get _emailProvider => context.read<EmailProvider>();

  AdvProvider get _advProvider => context.read<AdvProvider>();

  WidgetsBinding get _widgetBinding => WidgetsBinding.instance;

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    _pageController = PageController(initialPage: _selectedIndex);
    _widgetBinding.addObserver(this);
    _advProvider.loadAd();
    _emailProvider.refreshInbox();
    _timer = Timer.periodic(const Duration(seconds: 5), _onRefreshInbox);
    subscription = _connectionChecker.onStatusChange.listen(_handleOnInternetConnectionChange);
  }

  @override
  void dispose() {
    _widgetBinding.removeObserver(this);
    _stopRefresh();
    _pageController.dispose();
    if (subscription != null) {
      subscription!.cancel();
      subscription = null;
    }
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      _setRefresh();
    } else {
      _stopRefresh();
    }
  }

  void _handleOnInternetConnectionChange(InternetConnectionStatus status) {
    if (status == InternetConnectionStatus.connected) {
      _setRefresh();
      ScaffoldMessenger.of(context).clearMaterialBanners();
    } else {
      _stopRefresh();
      _showNoInternetBanner();
    }
  }

  void _showNoInternetBanner() {
    ScaffoldMessenger.of(context).showMaterialBanner(
      MaterialBanner(
        elevation: 0.1,
        padding: const EdgeInsets.all(8),
        leadingPadding: const EdgeInsets.all(8),
        content: Text(
          context.l10n.oopsNoInternetConnectionYouWont,
          style: const TextStyle(color: Colors.white),
        ),
        leading: const Icon(
          Icons.error_outline,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        actions: <Widget>[
          TextButton(
            onPressed: () => ScaffoldMessenger.of(context).clearMaterialBanners(),
            child: Text(
              context.l10n.dismiss,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  _setRefresh() {
    if (!_timer.isActive) _timer = Timer.periodic(const Duration(seconds: 5), _onRefreshInbox);
  }

  _stopRefresh() {
    if (_timer.isActive) _timer.cancel();
  }

  void _onRefreshInbox(Timer timer) {
    _emailProvider.refreshInbox();
  }

  final List<Widget> _destinations = [
    const MailboxScreen(),
    const InboxScreen(),
    const SettingsScreen(),
  ];

  void _onDestinationSelected(int i) async {
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
          BottomNavigationBarItem(icon: const Icon(Icons.email), label: context.l10n.mailbox),
          BottomNavigationBarItem(
            icon: Consumer<EmailProvider>(
              builder: (context, value, child) => Badge(
                label: Text(value.unreadInboxMessages.toString()),
                isLabelVisible: value.unreadInboxMessages != 0,
                child: const Icon(Icons.inbox),
              ),
            ),
            label: context.l10n.inbox,
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.settings),
            label: context.l10n.settings,
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _destinations,
            ),
          ),
          Consumer<AdvProvider>(
            builder: (context, value, child) => value.bannerAd != null
                ? SizedBox(
                    width: double.infinity,
                    height: AdSize.banner.height.toDouble(),
                    child: AdWidget(ad: value.bannerAd!),
                  )
                : Container(),
          ),
        ],
      ),
    );
  }
}
