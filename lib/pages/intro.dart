import 'package:flutter/material.dart';
import 'package:polywallet/pages/onboarding.dart';
import 'package:polywallet/store/wallet.dart';

class IntroPage extends StatefulWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  State<IntroPage> createState() => _IntroPageState();
}

class _IntroPageState extends State<IntroPage> {
  late Future<void> _initialization;

  @override
  void initState() {
    super.initState();
    _initialization = WalletState.of(context).initializeState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _initialization,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // TODO: Provide a proper loading indicator.
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        // TODO: Routing based on whether a wallet is created or not.
        return const OnboardingPage();
      },
    );
  }
}
