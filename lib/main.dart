import 'package:flutter/material.dart';
import 'package:money_tracking_app/screens/Landing.dart';
import 'package:flutter/services.dart';
import 'package:money_tracking_app/screens/accounts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MoneyMap",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      home:  AccountsScreen(),
    );
  }
}
