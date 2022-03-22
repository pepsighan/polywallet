import 'package:flutter/material.dart';
import 'package:polywallet/store/tokens.dart';

class SendPage extends StatefulWidget {
  const SendPage({Key? key, required this.token}) : super(key: key);

  final Token token;

  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  final _recipientField = TextEditingController();
  final _amountField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send ${widget.token.ticker}'),
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        children: [
          Container(
            margin: const EdgeInsets.only(top: 24),
            child: TextField(
              controller: _recipientField,
              decoration: const InputDecoration(
                label: Text('Recipient Address'),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: TextField(
              controller: _amountField,
              decoration: InputDecoration(
                label: Text('${widget.token.ticker} Amount'),
                border: const OutlineInputBorder(),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(top: 16),
            child: ElevatedButton(
              onPressed: () {},
              child: const Text('Send'),
            ),
          )
        ],
      ),
    );
  }
}
