import 'package:bip39/bip39.dart';
import 'package:flutter/material.dart';
import 'package:polywallet/pages/intro.dart';
import 'package:polywallet/store/wallet.dart';

class ExistingWalletPage extends StatefulWidget {
  const ExistingWalletPage({Key? key}) : super(key: key);

  @override
  State<ExistingWalletPage> createState() => _ExistingWalletPageState();
}

class _ExistingWalletPageState extends State<ExistingWalletPage> {
  final _formKey = GlobalKey<FormState>();
  final _recoveryPhraseController = TextEditingController();

  Future<void> _onContinue() async {
    if (_formKey.currentState?.validate() == false) {
      return;
    }

    // Store the wallet private keys locally.
    final wallet = WalletState.of(context);
    wallet.restoreWalletPassphrase(_recoveryPhraseController.text);

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Recover Wallet'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.only(top: 8, left: 16, right: 16),
          children: [
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: TextFormField(
                controller: _recoveryPhraseController,
                minLines: 4,
                maxLines: 4,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Recovery phrase',
                  helperText: 'Provide recovery phrase of your wallet.',
                ),
                validator: (text) => !validateMnemonic(text ?? '')
                    ? 'Invalid recovery phrase.'
                    : null,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 32),
              child: ElevatedButton(
                onPressed: _onContinue,
                child: const Text('Continue'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
