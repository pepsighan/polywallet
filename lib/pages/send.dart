import 'package:decimal/decimal.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:polywallet/send/send.dart';
import 'package:polywallet/tokens.dart';
import 'package:polywallet/widgets/loadingspinner.dart';

class SendPage extends StatefulWidget {
  const SendPage({Key? key, required this.token}) : super(key: key);

  final Token token;

  @override
  State<SendPage> createState() => _SendPageState();
}

class _SendPageState extends State<SendPage> {
  final _formKey = GlobalKey<FormState>();
  final _recipientField = TextEditingController();
  final _amountField = TextEditingController();

  bool _isSending = false;

  Future<void> _onSend() async {
    final valid = _formKey.currentState?.validate();
    if (valid != true) {
      return;
    }

    setState(() {
      _isSending = true;
    });

    final address = _recipientField.text;
    try {
      final amount = Decimal.parse(_amountField.text);
      await send(context,
          token: widget.token, address: address, amount: amount);
      _formKey.currentState!.reset();
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Successfully sent ${widget.token.ticker}.'),
        backgroundColor: Colors.green,
      ));
    } catch (err) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Failed to send ${widget.token.ticker}.'),
        backgroundColor: Colors.red,
      ));
      rethrow;
    } finally {
      setState(() {
        _isSending = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Send ${widget.token.ticker}'),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          children: [
            Container(
              margin: const EdgeInsets.only(top: 24),
              child: TextFormField(
                controller: _recipientField,
                decoration: const InputDecoration(
                  label: Text('Recipient Address'),
                  border: OutlineInputBorder(),
                ),
                validator: (text) => text?.isEmpty ?? true ? 'Required' : null,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: TextFormField(
                controller: _amountField,
                decoration: InputDecoration(
                  label: Text('${widget.token.ticker} Amount'),
                  border: const OutlineInputBorder(),
                ),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'^\d*\.?\d*$'))
                ],
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                  signed: false,
                ),
                validator: (text) => (double.tryParse(text ?? '') ?? 0) == 0
                    ? 'Provide an amount'
                    : null,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: ElevatedButton(
                onPressed: !_isSending ? _onSend : null,
                child: _isSending ? const LoadingSpinner() : const Text('Send'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
