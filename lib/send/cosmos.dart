import 'package:alan/alan.dart';
import 'package:alan/proto/cosmos/bank/v1beta1/export.dart';

const _uatomInAtom = 1000000;
final _networkInfo = NetworkInfo.fromSingleHost(
  bech32Hrp: 'cosmos',
  host: 'https://rpc.one.theta-devnet.polypore.xyz',
);

/// Sends ATOM [amount] to the destination [address].
Future<void> sendAtom(
  String passphrase,
  String address,
  double amount,
) async {
  // The wallet which is sending Atom.
  final wallet = Wallet.derive(passphrase.split(' '), _networkInfo);

  // Create a message to send atom.
  final message = MsgSend.create()
    ..fromAddress = wallet.bech32Address
    ..toAddress = address;
  message.amount.add(
    Coin.create()
      ..denom = 'uatom'
      ..amount = (amount * _uatomInAtom).toInt().toString(),
  );

  // Sign the message and create a transaction.
  final signer = TxSigner.fromNetworkInfo(_networkInfo);
  final tx = await signer.createAndSign(wallet, [message]);

  // Send the transaction.
  final txSender = TxSender.fromNetworkInfo(_networkInfo);
  final response = await txSender.broadcastTx(tx);

  if (!response.isSuccessful) {
    throw Exception('Transaction failed with code ${response.code}');
  }
}