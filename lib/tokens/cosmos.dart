import 'package:alan/alan.dart';
import 'package:alan/proto/cosmos/bank/v1beta1/export.dart' as bank;
import 'package:decimal/decimal.dart';

final uatomInAtom = Decimal.fromInt(1000000);
final cosmosNetworkInfo = NetworkInfo.fromSingleHost(
  bech32Hrp: 'cosmos',
  host: 'https://rpc.sentry-01.theta-testnet.polypore.xyz',
);
final _bankClient = bank.QueryClient(cosmosNetworkInfo.gRPCChannel);

/// Sends ATOM [amount] to the destination [address].
Future<void> sendAtom(
  String mnemonic,
  String address,
  Decimal amount,
) async {
  // The wallet which is sending Atom.
  final wallet = Wallet.derive(mnemonic.split(' '), cosmosNetworkInfo);

  // Create a message to send atom.
  final message = bank.MsgSend.create()
    ..fromAddress = wallet.bech32Address
    ..toAddress = address;
  message.amount.add(
    Coin.create()
      ..denom = 'uatom'
      ..amount = (amount * uatomInAtom).toBigInt().toString(),
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

/// Gets the Atom balance in uAtom.
Future<BigInt> getAtomBalance(String mnemonic) async {
  final wallet = Wallet.derive(mnemonic.split(' '), cosmosNetworkInfo);

  final response = await _bankClient.balance(bank.QueryBalanceRequest(
    address: wallet.bech32Address,
    denom: 'uatom',
  ));

  return BigInt.parse(response.balance.amount);
}
