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

extension TokenExtension on Token {
  /// Gets the printable value of Token.
  String get asString => _tokenAsString[this]!;

  /// Gets the ticker name of the Token.
  String get ticker => _tokenTicker[this]!;
}
