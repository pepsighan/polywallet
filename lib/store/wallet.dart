import 'package:bip39/bip39.dart';
import 'package:flutter/material.dart';

/// State for the current wallet of the app.
class WalletState extends ChangeNotifier {
  String? _passphrase;

  /// The passphrase of the current wallet.
  String? get passphrase => _passphrase;

  /// Generates a passphrase for a new wallet.
  void generateWalletPassphrase() {
    _passphrase = generateMnemonic();
    notifyListeners();
  }

  /// Restores a passphrase for an existing wallet.
  void restoreWalletPassphrase(String passphrase) {
    final isValid = validateMnemonic(passphrase);
    if (isValid) {
      _passphrase = passphrase;
      notifyListeners();
    }
  }

  /// Logs out and removes this wallet from the app.
  Future<void> logout() async {
    _passphrase = null;
    notifyListeners();
  }
}
