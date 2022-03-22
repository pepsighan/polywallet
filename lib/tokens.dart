import 'package:flutter/cupertino.dart';
import 'package:polywallet/store/wallet.dart';

/// All the supported tokens in the wallet.
enum Token {
  cosmos,
  ethereum,
  polygon,
  solana,
}

const _tokenAsString = {
  Token.cosmos: 'Cosmos',
  Token.ethereum: 'Ethereum',
  Token.polygon: 'Polygon',
  Token.solana: 'Solana',
};

const _tokenTicker = {
  Token.cosmos: 'ATOM',
  Token.ethereum: 'ETH',
  Token.polygon: 'MATIC',
  Token.solana: 'SOL',
};

extension TokenExtension on Token {
  /// Gets the printable value of Token.
  String get asString => _tokenAsString[this]!;

  /// Gets the ticker name of the Token.
  String get ticker => _tokenTicker[this]!;
}

const _tokenSender = {
  Token.cosmos: _sendCosmos,
  Token.ethereum: _sendEther,
  Token.polygon: _sendMatic,
  Token.solana: _sendSol,
};

/// Sends the amount of Tokens to the given address from the user's wallet.
Future<void> send(
  BuildContext context, {
  required Token token,
  required String address,
  required double amount,
}) async {
  final passphrase = WalletState.of(context).passphrase;
  if (passphrase == null) {
    throw Exception('cannot send if no wallet');
  }

  final sender = _tokenSender[token]!;
  return await sender(passphrase, address, amount);
}

Future<void> _sendCosmos(
  String passphrase,
  String address,
  double amount,
) async {}

Future<void> _sendEther(
  String passphrase,
  String address,
  double amount,
) async {}

Future<void> _sendMatic(
  String passphrase,
  String address,
  double amount,
) async {}

Future<void> _sendSol(
  String passphrase,
  String address,
  double amount,
) async {}
