import 'package:flutter/material.dart';
import 'package:polywallet/store/wallet.dart';
import 'package:polywallet/tokens/cosmos.dart';
import 'package:polywallet/tokens/ethereum.dart';
import 'package:polywallet/tokens/polygon.dart';
import 'package:polywallet/tokens/solana.dart';
import 'package:polywallet/tokens/tokens.dart';

final _tokenBalance = {
  Token.cosmos: getAtomBalance,
  Token.ethereum: getEtherBalance,
  Token.polygon: getMaticBalance,
  Token.solana: getSolBalance,
};

/// Defines the state of each token for the wallet.
class TokenState extends ChangeNotifier {
  final Map<Token, TokenMeta> _tokenMap = {};

  TokenMeta get cosmos =>
      _tokenMap[Token.cosmos] ?? TokenMeta(balance: BigInt.zero);

  TokenMeta? get ethereum =>
      _tokenMap[Token.ethereum] ?? TokenMeta(balance: BigInt.zero);

  TokenMeta? get polygon =>
      _tokenMap[Token.polygon] ?? TokenMeta(balance: BigInt.zero);

  TokenMeta? get solana =>
      _tokenMap[Token.solana] ?? TokenMeta(balance: BigInt.zero);

  /// Load the balance for the token.
  Future<void> loadBalance(
    BuildContext context, {
    required Token token,
  }) async {
    final mnemonic = WalletState.of(context).mnemonic!;
    final getBalance = _tokenBalance[token]!;
    final balance = await getBalance(mnemonic);
    _tokenMap[token] = TokenMeta(balance: balance);
    notifyListeners();
  }
}

/// The information about a token in the context of the wallet.
class TokenMeta {
  /// The balance of the token for the wallet in the most basic unit.
  final BigInt balance;

  TokenMeta({required this.balance});
}
