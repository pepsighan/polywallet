import 'package:bip39/bip39.dart';
import 'package:decimal/decimal.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

final _httpClient = Client();
final _ethClient = Web3Client(
  'https://rpc-mumbai.matic.today',
  _httpClient,
);

final weiInMatic = Decimal.fromInt(10).pow(18);

/// Sends MATIC [amount] to the destination [address].
Future<void> sendMatic(
  String mnemonic,
  String address,
  Decimal amount,
) async {
  final privateKey = EthPrivateKey.fromHex(mnemonicToEntropy(mnemonic));
  await _ethClient.sendTransaction(
    privateKey,
    Transaction(
      to: EthereumAddress.fromHex(address),
      value: EtherAmount.fromUnitAndValue(
        EtherUnit.wei,
        (amount * weiInMatic).toBigInt(),
      ),
    ),
    chainId: 80001, // Polygon Mumbai chain ID.
  );
}

/// Gets the MATIC balance in Wei.
Future<BigInt> getMaticBalance(String mnemonic) async {
  final privateKey = EthPrivateKey.fromHex(mnemonicToEntropy(mnemonic));
  final balance = await _ethClient.getBalance(privateKey.address);
  return balance.getInWei;
}
