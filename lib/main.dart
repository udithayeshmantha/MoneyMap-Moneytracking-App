import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracking_app/services/auth_service.dart';
import 'package:money_tracking_app/router/router.dart';
import 'package:flutter/services.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(AuthService()); // Initialize AuthService
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "MoneyMap",
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
        useMaterial3: true,
      ),
      initialRoute: '/',
      getPages: RouterClass().routes,
      unknownRoute: GetPage(
        name: '/notfound',
        page: () => const Scaffold(
          body: Center(
            child: Text('This Page Not Found!'),
          ),
        ),
      ),
    );
  }
}
