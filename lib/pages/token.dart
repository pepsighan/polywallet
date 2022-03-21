import 'package:flutter/material.dart';
import 'package:polywallet/store/tokens.dart';

class TokenPage extends StatelessWidget {
  const TokenPage({Key? key, required this.token}) : super(key: key);

  final Token token;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(token.asString),
      ),
    );
  }
}
