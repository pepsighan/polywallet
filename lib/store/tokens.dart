/// All the supported tokens in the wallet.
enum Token {
  bitcoin,
  cosmos,
  ethereum,
  near,
  polygon,
  solana,
}

const _tokenAsString = {
  Token.bitcoin: 'Bitcoin',
  Token.cosmos: 'Cosmos',
  Token.ethereum: 'Ethereum',
  Token.near: 'Near',
  Token.polygon: 'Polygon',
  Token.solana: 'Solana',
};

extension TokenExtension on Token {
  /// Gets the printable value of Token.
  String get asString => _tokenAsString[this]!;
}
