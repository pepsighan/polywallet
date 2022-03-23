import 'package:flutter/material.dart';
import 'package:polywallet/pages/settings.dart';
import 'package:polywallet/pages/token.dart';
import 'package:polywallet/tokens.dart';

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
      body: ListView.separated(
        separatorBuilder: (context, index) =>
            Divider(key: Key(index.toString()), height: 0),
        itemBuilder: (context, index) => ListTile(
          key: Key(index.toString()),
          // TODO: Show proper icons and coin value.
          leading: const CircleAvatar(child: Icon(Icons.currency_bitcoin)),
          title: Text(Token.values[index].asString),
          trailing: Text('0 ${Token.values[index].ticker}'),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 4,
            horizontal: 16,
          ),
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => TokenPage(token: Token.values[index]),
              ),
            );
          },
        ),
        itemCount: Token.values.length,
      ),
    );
  }
}
