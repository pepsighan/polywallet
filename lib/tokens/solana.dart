import 'package:decimal/decimal.dart';
import 'package:solana/solana.dart';

final _rpcUrl = Uri.parse('https://api.devnet.solana.com');
final _websocketUrl = Uri.parse('ws://api.devnet.solana.com');
final _solanaClient =
    SolanaClient(rpcUrl: _rpcUrl, websocketUrl: _websocketUrl);

/// Sends SOL [amount] to the destination [address].
Future<void> sendSol(
  String mnemonic,
  String address,
  Decimal amount,
) async {
  final wallet = await Ed25519HDKeyPair.fromMnemonic(mnemonic);
  final lamports =
      (amount * Decimal.fromInt(lamportsPerSol)).toBigInt().toInt();
  await _solanaClient.transferLamports(
    source: wallet,
    destination: address,
    lamports: lamports,
  );
}

/// Gets the SOL balance in lamports.
Future<int> getSolBalance(String mnemonic) async {
  final wallet = await Ed25519HDKeyPair.fromMnemonic(mnemonic);
  return await _solanaClient.rpcClient.getBalance(wallet.address);
}
