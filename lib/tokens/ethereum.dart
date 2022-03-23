import 'package:bip39/bip39.dart';
import 'package:decimal/decimal.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

final _httpClient = Client();
final _ethClient = Web3Client(
  'https://rinkeby.infura.io/v3/a18f3fa67e9045bea156ec40f5fb65df',
  _httpClient,
);

final _weiInEth = Decimal.fromInt(10).pow(18);

/// Sends ETH [amount] to the destination [address].
Future<void> sendEther(
  String mnemonic,
  String address,
  Decimal amount,
) async {
  final privateKey = EthPrivateKey.fromHex(mnemonicToSeedHex(mnemonic));
  await _ethClient.sendTransaction(
    privateKey,
    Transaction(
      to: EthereumAddress.fromHex(address),
      value: EtherAmount.fromUnitAndValue(
        EtherUnit.wei,
        (amount * _weiInEth).toBigInt(),
      ),
    ),
  );
}

/// Gets the ETH balance in Wei.
Future<BigInt> getEtherBalance(String mnemonic) async {
  final privateKey = EthPrivateKey.fromHex(mnemonicToSeedHex(mnemonic));
  final balance = await _ethClient.getBalance(privateKey.address);
  return balance.getInWei;
}
