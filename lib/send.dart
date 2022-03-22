import 'package:flutter/material.dart';
import 'package:polywallet/store/wallet.dart';
import 'package:polywallet/tokens.dart';
import 'package:solana/solana.dart';

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

final _rpcUrl = Uri.parse('https://api.devnet.solana.com');
final _websocketUrl = Uri.parse('ws://api.devnet.solana.com');
final _solanaClient =
    SolanaClient(rpcUrl: _rpcUrl, websocketUrl: _websocketUrl);

/// Sends SOL [amount] to the destination [address].
Future<void> _sendSol(
  String passphrase,
  String address,
  double amount,
) async {
  final wallet = await Ed25519HDKeyPair.fromMnemonic(passphrase);
  final lamports = (amount * lamportsPerSol).toInt();
  await _solanaClient.transferLamports(
    source: wallet,
    destination: address,
    lamports: lamports,
  );
}
