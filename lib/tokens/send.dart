import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:polywallet/store/wallet.dart';
import 'package:polywallet/tokens/cosmos.dart';
import 'package:polywallet/tokens/ethereum.dart';
import 'package:polywallet/tokens/polygon.dart';
import 'package:polywallet/tokens/solana.dart';
import 'package:polywallet/tokens/tokens.dart';

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
  final mnemonic = WalletState.of(context).mnemonic;
  if (mnemonic == null) {
    throw Exception('cannot send if no wallet');
  }

  final sender = _tokenSender[token]!;
  return await sender(mnemonic, address, amount);
}
