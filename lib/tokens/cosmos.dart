import 'package:alan/alan.dart';
import 'package:alan/proto/cosmos/bank/v1beta1/export.dart';
import 'package:decimal/decimal.dart';

final _uatomInAtom = Decimal.fromInt(1000000);
final cosmosNetworkInfo = NetworkInfo.fromSingleHost(
  bech32Hrp: 'cosmos',
  host: 'https://rpc.one.theta-devnet.polypore.xyz',
);

/// Sends ATOM [amount] to the destination [address].
Future<void> sendAtom(
  String passphrase,
  String address,
  Decimal amount,
) async {
  // The wallet which is sending Atom.
  final wallet = Wallet.derive(passphrase.split(' '), cosmosNetworkInfo);

  // Create a message to send atom.
  final message = MsgSend.create()
    ..fromAddress = wallet.bech32Address
    ..toAddress = address;
  message.amount.add(
    Coin.create()
      ..denom = 'uatom'
      ..amount = (amount * _uatomInAtom).toBigInt().toString(),
  );

  // Sign the message and create a transaction.
  final signer = TxSigner.fromNetworkInfo(cosmosNetworkInfo);
  final tx = await signer.createAndSign(wallet, [message]);

  // Send the transaction.
  final txSender = TxSender.fromNetworkInfo(cosmosNetworkInfo);
  final response = await txSender.broadcastTx(tx);

  if (!response.isSuccessful) {
    throw Exception('Transaction failed with code ${response.code}');
  }
}