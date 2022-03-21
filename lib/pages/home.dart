import 'package:flutter/material.dart';
import 'package:polywallet/pages/settings.dart';
import 'package:polywallet/store/tokens.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Polywallet'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const SettingsPage()),
              );
            },
            icon: const Icon(Icons.account_balance_wallet_rounded),
          )
        ],
      ),
      body: ListView(
        children: [
          for (final token in Token.values)
            ListTile(
              key: Key(token.index.toString()),
              title: Text(token.asString),
            ),
        ],
      ),
    );
  }
}
