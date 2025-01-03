import 'package:flutter/material.dart';
import 'package:money_tracking_app/screens/Landing.dart';
import 'package:flutter/services.dart';
<<<<<<< HEAD
import 'package:money_tracking_app/screens/accounts.dart';
=======
import 'package:money_tracking_app/screens/home.dart';
import 'package:money_tracking_app/screens/login.dart';
>>>>>>> 3cdf425209cd31115ecd1d3bb98e139ffed45977

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
<<<<<<< HEAD
      home:  AccountsScreen(),
=======
      home: const Home(),
>>>>>>> 3cdf425209cd31115ecd1d3bb98e139ffed45977
    );
  }
}
