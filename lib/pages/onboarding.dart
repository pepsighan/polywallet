import 'package:flutter/material.dart';

class OnboardingPage extends StatelessWidget {
  const OnboardingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        physics: const ClampingScrollPhysics(),
        children: [
          Container(
            margin: const EdgeInsets.only(top: 160),
            child: Text(
              'Polywallet',
              style: theme.textTheme.headline3?.apply(
                color: theme.primaryColor,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          Text(
            'a fast multi-chain wallet',
            style: theme.textTheme.subtitle1?.apply(
              color: theme.hintColor,
            ),
            textAlign: TextAlign.center,
          ),
          Center(
            child: Container(
              width: 180,
              height: 180,
              alignment: Alignment.center,
              margin: const EdgeInsets.only(top: 48, bottom: 80),
              decoration: BoxDecoration(
                color: theme.primaryColor,
                borderRadius: BorderRadius.circular(16),
              ),
              child: const Icon(
                Icons.currency_bitcoin,
                color: Colors.white,
                size: 100,
              ),
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            child: const Text('Create a new wallet'),
          ),
          Container(
            margin: const EdgeInsets.only(top: 8),
            child: OutlinedButton(
              onPressed: () {},
              child: const Text('I already have a wallet'),
            ),
          ),
        ],
      ),
    );
  }
}
