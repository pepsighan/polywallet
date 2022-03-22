import 'package:flutter/material.dart';
import 'package:polywallet/pages/intro.dart';
import 'package:polywallet/store/tokens.dart';
import 'package:polywallet/store/wallet.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => WalletState()),
        ChangeNotifierProvider(create: (context) => TokenState()),
      ],
      child: MaterialApp(
        title: 'Polywallet',
        theme: ThemeData(
          primarySwatch: Colors.teal,
          useMaterial3: true,
          appBarTheme: const AppBarTheme(elevation: 0),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              minimumSize: MaterialStateProperty.all(const Size.fromHeight(44)),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: ButtonStyle(
              elevation: MaterialStateProperty.all(0),
              minimumSize: MaterialStateProperty.all(const Size.fromHeight(44)),
            ),
          ),
        ),
        home: const IntroPage(),
      ),
    );
  }
}
