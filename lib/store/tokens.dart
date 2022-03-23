import 'package:flutter/material.dart';
import 'package:polywallet/tokens/tokens.dart';

class TokenState extends ChangeNotifier {
  final Map<Token, TokenMeta> _tokenMap = {};

  TokenMeta get cosmos => _tokenMap[Token.cosmos] ?? TokenMeta(units: 0);

  TokenMeta? get ethereum => _tokenMap[Token.ethereum] ?? TokenMeta(units: 0);

  TokenMeta? get polygon => _tokenMap[Token.polygon] ?? TokenMeta(units: 0);

  TokenMeta? get solana => _tokenMap[Token.solana] ?? TokenMeta(units: 0);

  /// Load the balance for the token.
  Future<void> loadBalance(
    BuildContext context, {
    required Token token,
  }) async {}
}

/// The information about a token in the context of the wallet.
class TokenMeta {
  /// The balance of the token for the wallet.
  final int units;

  TokenMeta({required this.units});
}
