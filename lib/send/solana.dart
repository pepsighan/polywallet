import 'package:solana/solana.dart';

final _rpcUrl = Uri.parse('https://api.devnet.solana.com');
final _websocketUrl = Uri.parse('ws://api.devnet.solana.com');
final _solanaClient =
    SolanaClient(rpcUrl: _rpcUrl, websocketUrl: _websocketUrl);

/// Sends SOL [amount] to the destination [address].
Future<void> sendSol(
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