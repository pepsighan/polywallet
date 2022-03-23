import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:polywallet/store/wallet.dart';
import 'package:polywallet/tokens/cosmos.dart';
import 'package:polywallet/tokens/ethereum.dart';
import 'package:polywallet/tokens/polygon.dart';
import 'package:polywallet/tokens/solana.dart';
import 'package:polywallet/tokens/tokens.dart';
import 'package:provider/provider.dart';
import 'package:solana/solana.dart';

final _tokenBalance = {
  Token.cosmos: getAtomBalance,
  Token.ethereum: getEtherBalance,
  Token.polygon: getMaticBalance,
  Token.solana: getSolBalance,
};

/// Defines the state of each token for the wallet.
class TokenState extends ChangeNotifier {
  final Map<Token, TokenMeta> _tokenMap = {};

  /// Gets the information for a given token.
  TokenMeta get(Token token) {
    return _tokenMap[token] ?? TokenMeta(token: token, balance: BigInt.zero);
  }

  /// Load the balance for the token.
  Future<void> loadBalance(
    BuildContext context, {
    required Token token,
  }) async {
    final mnemonic = WalletState.of(context).mnemonic!;
    final getBalance = _tokenBalance[token]!;
    final balance = await getBalance(mnemonic);
    _tokenMap[token] = TokenMeta(token: token, balance: balance);
    notifyListeners();
  }

  /// Loads the balance for all the tokens.
  Future<void> loadAllBalances(BuildContext context) async {
    await Future.wait(Token.values.map((e) => loadBalance(context, token: e)));
  }

  /// Gets the TokenState from the context.
  static TokenState of(BuildContext context) {
    return Provider.of<TokenState>(context, listen: false);
  }
}

/// The information about a token in the context of the wallet.
class TokenMeta {
  /// The token to which this object pertains to.
  final Token token;

  /// The balance of the token for the wallet in the most basic unit.
  final BigInt balance;

  TokenMeta({required this.token, required this.balance});

  /// Balance of the token in the main unit.
  String balanceInPrimaryUnit() {
    switch (token) {
      case Token.cosmos:
        return (Decimal.fromBigInt(balance) / uatomInAtom)
            .toDecimal()
            .toString();
      case Token.ethereum:
        return (Decimal.fromBigInt(balance) / weiInEth).toDecimal().toString();
      case Token.polygon:
        return (Decimal.fromBigInt(balance) / weiInMatic)
            .toDecimal()
            .toString();
      case Token.solana:
        return (Decimal.fromBigInt(balance) / Decimal.fromInt(lamportsPerSol))
            .toDecimal()
            .toString();
    }
  }
}
