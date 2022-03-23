import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polywallet/store/wallet.dart';
import 'package:polywallet/tokens.dart';

class ReceivePage extends StatefulWidget {
  const ReceivePage({Key? key, required this.token}) : super(key: key);

  final Token token;

  @override
  State<ReceivePage> createState() => _ReceivePageState();
}

class _ReceivePageState extends State<ReceivePage> {
  late Future<void> _future;

  @override
  void initState() {
    super.initState();
    final mnemonic = WalletState.of(context).passphrase;
    _future = widget.token.publicAddressForMnemonic(mnemonic!);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Receive ${widget.token.ticker}'),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) => ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            Container(
              margin: const EdgeInsets.only(top: 24),
              child: Text(
                'Your Wallet Address',
                style: theme.textTheme.headline6,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 32),
              child: FractionallySizedBox(
                widthFactor: 0.8,
                child: Text(
                  snapshot.connectionState == ConnectionState.done
                      ? snapshot.data as String
                      : '',
                  textAlign: TextAlign.center,
                  style: theme.textTheme.subtitle1,
                ),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 32),
              child: Text(
                'Send only ${widget.token.asString} (${widget.token.ticker}) '
                'to this address. Sending any other coins may result in '
                'permanent lost.',
                style: theme.textTheme.caption,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 8),
              child: ElevatedButton(
                onPressed: () {
                  Clipboard.setData(ClipboardData(
                    text: snapshot.connectionState == ConnectionState.done
                        ? snapshot.data as String
                        : '',
                  ));
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('Copied your wallet address to clipboard.'),
                    backgroundColor: Colors.green,
                  ));
                },
                child: const Text('Copy'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
