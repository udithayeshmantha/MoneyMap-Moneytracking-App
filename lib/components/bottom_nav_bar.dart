import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:money_tracking_app/services/auth_service.dart';
import 'package:money_tracking_app/services/auth_service.dart';
import 'package:money_tracking_app/screens/accounts.dart';
import 'package:money_tracking_app/screens/categories.dart';
import 'package:money_tracking_app/screens/home.dart';
import 'package:money_tracking_app/screens/settings_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({Key? key}) : super(key: key);

  @override
  _BottomNavBarState createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _selectedIndex = 0;
  static final List<Widget> _widgetOptions = <Widget>[
    Home(),
    AccountsScreen(),
    Categories(),
    SettingsScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: AuthService.to.resetInactivityTimer,
      onPanDown: (_) => AuthService.to.resetInactivityTimer(),
      child: Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          color: Colors.black,
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8.0),
            child: GNav(
              backgroundColor: Colors.black,
              color: Colors.white,
              activeColor: Colors.white,
              padding: const EdgeInsets.all(16),
              tabBackgroundColor: const Color.fromARGB(255, 29, 29, 29),
              gap: 8,
              selectedIndex: _selectedIndex,
              onTabChange: (index) {
                setState(() {
                  _selectedIndex = index;
                });
                AuthService.to.resetInactivityTimer();
              },
              tabs: const [
                GButton(
                  icon: Icons.home_outlined,
                  text: 'Home',
                ),
                GButton(
                  icon: Icons.account_balance_wallet_outlined,
                  text: 'Accounts',
                ),
                GButton(
                  icon: Icons.category_outlined,
                  text: 'Categories',
                ),
                GButton(
                  icon: Icons.settings_outlined,
                  text: 'Settings',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
