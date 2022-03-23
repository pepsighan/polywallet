import 'package:alan/alan.dart' as alan;
import 'package:bip39/bip39.dart';
import 'package:polywallet/tokens/cosmos.dart';
import 'package:solana/solana.dart';
import 'package:web3dart/web3dart.dart';

/// All the supported tokens in the wallet.
enum Token {
  cosmos,
  ethereum,
  polygon,
  solana,
}

const _tokenAsString = {
  Token.cosmos: 'Cosmos',
  Token.ethereum: 'Ethereum',
  Token.polygon: 'Polygon',
  Token.solana: 'Solana',
};

const _tokenTicker = {
  Token.cosmos: 'ATOM',
  Token.ethereum: 'ETH',
  Token.polygon: 'MATIC',
  Token.solana: 'SOL',
};

const _tokenAsset = {
  Token.cosmos: 'assets/crypto/atom.png',
  Token.ethereum: 'assets/crypto/eth.png',
  Token.polygon: 'assets/crypto/matic.png',
  Token.solana: 'assets/crypto/sol.png',
};

extension TokenExtension on Token {
  /// Gets the printable value of Token.
  String get asString => _tokenAsString[this]!;

  /// Gets the ticker name of the Token.
  String get ticker => _tokenTicker[this]!;

  /// Gets the logo asset of the Token.
  String get asset => _tokenAsset[this]!;

  /// Gets the public address of the token for the given [mnemonic].
  Future<String> publicAddressForMnemonic(String mnemonic) async {
    switch (this) {
      case Token.cosmos:
        return alan.Wallet.derive(mnemonic.split(' '), cosmosNetworkInfo)
            .bech32Address;
      case Token.ethereum:
      case Token.polygon:
        return EthPrivateKey.fromHex(mnemonicToSeedHex(mnemonic)).address.hex;
      case Token.solana:
        final keypair = await Ed25519HDKeyPair.fromMnemonic(mnemonic);
        return keypair.address;
    }
  }
}
