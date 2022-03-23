import 'package:bip39/bip39.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polywallet/pages/intro.dart';
import 'package:polywallet/store/wallet.dart';

class NewWalletPage extends StatefulWidget {
  const NewWalletPage({Key? key}) : super(key: key);

  @override
  State<NewWalletPage> createState() => _NewWalletPageState();
}

class _NewWalletPageState extends State<NewWalletPage> {
  final _mnemonic = generateMnemonic();

  Future<void> _onCopy() async {
    final primaryColor = Theme.of(context).primaryColor;

    await Clipboard.setData(ClipboardData(text: _mnemonic));
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: const Text('Copied the recovery phrase to clipboard.'),
      backgroundColor: primaryColor,
    ));
  }

  Future<void> _onContinue() async {
    WalletState.of(context).restoreWalletMnemonic(_mnemonic);

    // Now that the app the wallet is setup, remove all the previous
    // routes and go to the home page.
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const IntroPage()),
      (_) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final words = _mnemonic.split(' ');

    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Recovery Phrase'),
      ),
      body: ListView(
        padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
        children: [
          const Text(
            'Note down the recovery phrase for your wallet somewhere safe. '
            'If you lose access to this phrase then your wallet will be '
            'irrecoverable.',
            textAlign: TextAlign.center,
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              children: [
                for (final word in words)
                  Chip(
                    key: Key(word),
                    label: Text(word),
                  ),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 32),
            child: OutlinedButton(
              child: const Text('Copy'),
              onPressed: _onCopy,
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: ElevatedButton(
              onPressed: _onContinue,
              child: const Text('Continue'),
            ),
          )
        ],
      ),
    );
  }
}
