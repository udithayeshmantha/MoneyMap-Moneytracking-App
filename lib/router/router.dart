import 'package:get/get.dart';
import 'package:money_tracking_app/screens/Landing.dart';
import 'package:money_tracking_app/screens/accounts.dart';
import 'package:money_tracking_app/screens/categories.dart';
import 'package:money_tracking_app/screens/home.dart';
import 'package:money_tracking_app/screens/login.dart';
import 'package:money_tracking_app/screens/settings_screen.dart';

class RouterClass {
  final List<GetPage> routes = [
    GetPage( name: '/', page: () => Landing(),),
    GetPage( name: '/login', page: () => Login(),),
    GetPage( name: '/home',page: () =>  Home(),),
    GetPage( name: '/accounts',page: () =>  AccountsScreen(),),
    GetPage( name: '/categories',page: () =>  Categories(),),
    GetPage( name: '/settings',page: () =>  SettingsScreen(),),
    
  ];
}