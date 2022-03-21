import 'package:bip39/bip39.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

const _secureStorage = FlutterSecureStorage();
const _passphraseKey = 'walletPassphrase';

/// State for the current wallet of the app.
class WalletState extends ChangeNotifier {
  String? _passphrase;

  /// The passphrase of the current wallet.
  String? get passphrase => _passphrase;

  /// If the user has a wallet.
  bool get hasWallet => _passphrase != null;

  /// Initializes the state from the persisted state.
  Future<void> initializeState() async {
    _passphrase = await _secureStorage.read(key: _passphraseKey);
    notifyListeners();
  }

  /// Restores a passphrase for an existing wallet.
  Future<void> restoreWalletPassphrase(String passphrase) async {
    final isValid = validateMnemonic(passphrase);
    if (isValid) {
      _passphrase = passphrase;
      await _secureStorage.write(key: _passphraseKey, value: _passphrase);
      notifyListeners();
    }
  }

  /// Logs out and removes this wallet from the app.
  Future<void> logout() async {
    _passphrase = null;
    notifyListeners();
  }

  /// Gets the WalletState from the context.
  static WalletState of(BuildContext context) {
    return Provider.of<WalletState>(context, listen: false);
  }
}
