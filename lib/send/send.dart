import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:polywallet/send/cosmos.dart';
import 'package:polywallet/send/ethereum.dart';
import 'package:polywallet/send/polygon.dart';
import 'package:polywallet/send/solana.dart';
import 'package:polywallet/store/wallet.dart';
import 'package:polywallet/tokens.dart';

const _tokenSender = {
  Token.cosmos: sendAtom,
  Token.ethereum: sendEther,
  Token.polygon: sendMatic,
  Token.solana: sendSol,
};

/// Sends the amount of Tokens to the given address from the user's wallet.
Future<void> send(
  BuildContext context, {
  required Token token,
  required String address,
  required Decimal amount,
}) async {
  final passphrase = WalletState.of(context).passphrase;
  if (passphrase == null) {
    throw Exception('cannot send if no wallet');
  }

  final sender = _tokenSender[token]!;
  return await sender(passphrase, address, amount);
}
