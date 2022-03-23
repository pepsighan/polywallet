import 'package:bip39/bip39.dart';
import 'package:http/http.dart';
import 'package:web3dart/web3dart.dart';

final _httpClient = Client();
final _ethClient = Web3Client(
  'https://rinkeby.infura.io/v3/a18f3fa67e9045bea156ec40f5fb65df',
  _httpClient,
);

const _weiInEth = 10 ^ 18;

/// Sends ETH [amount] to the destination [address].
Future<void> sendEther(
  String passphrase,
  String address,
  double amount,
) async {
  final privateKey = EthPrivateKey.fromHex(mnemonicToSeedHex(passphrase));
  await _ethClient.sendTransaction(
    privateKey,
    Transaction(
      to: EthereumAddress.fromHex(address),
      value: EtherAmount.fromUnitAndValue(
        EtherUnit.wei,
        (amount * _weiInEth).toInt(),
      ),
    ),
  );
}
