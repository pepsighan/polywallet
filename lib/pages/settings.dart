import 'package:flutter/material.dart';
import 'package:polywallet/pages/intro.dart';
import 'package:polywallet/store/wallet.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<void> _onLogout() async {
    // Go to intro page once logged out.
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const IntroPage()),
      (route) => false,
    );
    await WalletState.of(context).logout();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: ListView(
        children: [
          Container(
            margin: const EdgeInsets.only(top: 16, left: 16, right: 16),
            child: OutlinedButton(
              onPressed: _onLogout,
              child: const Text('Logout'),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 4, left: 16, right: 16),
            child: Text(
              'Once logged out, you will need your recovery phrase to setup '
              'this wallet again.',
              style: theme.textTheme.caption,
            ),
          )
        ],
      ),
    );
  }
}
