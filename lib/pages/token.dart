import 'package:flutter/material.dart';
import 'package:polywallet/store/tokens.dart';

class TokenPage extends StatelessWidget {
  const TokenPage({Key? key, required this.token}) : super(key: key);

  final Token token;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(token.asString),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          Container(
            margin: const EdgeInsets.only(top: 32),
            child: const CircleAvatar(
              child: Icon(Icons.currency_bitcoin, size: 32),
              minRadius: 32,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: Text(
              '0 ${token.ticker}',
              style: theme.textTheme.headline6,
              textAlign: TextAlign.center,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 32),
            child: Row(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(right: 8),
                    child: OutlinedButton(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.arrow_upward),
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            child: const Text('Send'),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(left: 8),
                    child: OutlinedButton(
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Icons.arrow_downward),
                          Container(
                            margin: const EdgeInsets.only(left: 8),
                            child: const Text('Receive'),
                          ),
                        ],
                      ),
                      onPressed: () {},
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
