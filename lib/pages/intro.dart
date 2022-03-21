import 'package:flutter/material.dart';
import 'package:polywallet/pages/home.dart';
import 'package:polywallet/pages/onboarding.dart';
import 'package:polywallet/store/wallet.dart';
import 'package:provider/provider.dart';

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

        // Depending upon whether the user has a wallet initialized or not,
        // show appropriate starting pages.
        return Selector<WalletState, bool>(
          selector: (context, state) => state.hasWallet,
          builder: (context, hasWallet, _) =>
              hasWallet ? const HomePage() : const OnboardingPage(),
        );
      },
    );
  }
}
