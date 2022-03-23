import 'package:bip39/bip39.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:provider/provider.dart';

const _secureStorage = FlutterSecureStorage();
const _mnemonicKey = 'walletMnemonic';

/// State for the current wallet of the app.
class WalletState extends ChangeNotifier {
  String? _mnemonic;

  /// The mnemonic of the current wallet.
  String? get mnemonic => _mnemonic;

  /// If the user has a wallet.
  bool get hasWallet => _mnemonic != null;

  /// Initializes the state from the persisted state.
  Future<void> initializeState() async {
    _mnemonic = await _secureStorage.read(key: _mnemonicKey);
    notifyListeners();
  }

  /// Restores a mnemonic for an existing wallet.
  Future<void> restoreWalletMnemonic(String mnemonic) async {
    final isValid = validateMnemonic(mnemonic);
    if (isValid) {
      _mnemonic = mnemonic;
      await _secureStorage.write(key: _mnemonicKey, value: _mnemonic);
      notifyListeners();
    }
  }

  /// Logs out and removes this wallet from the app.
  Future<void> logout() async {
    _mnemonic = null;
    // Do not remember anything for the current user.
    await _secureStorage.deleteAll();
    notifyListeners();
  }

  /// Gets the WalletState from the context.
  static WalletState of(BuildContext context) {
    return Provider.of<WalletState>(context, listen: false);
  }
}
