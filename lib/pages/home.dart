import 'package:flutter/material.dart';
import 'package:polywallet/pages/settings.dart';
import 'package:polywallet/pages/token.dart';
import 'package:polywallet/store/tokens.dart';
import 'package:polywallet/tokens/tokens.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    TokenState.of(context).loadAllBalances(context);
  }

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
          leading: Image.asset(
            Token.values[index].asset,
            width: 40,
            height: 40,
          ),
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
