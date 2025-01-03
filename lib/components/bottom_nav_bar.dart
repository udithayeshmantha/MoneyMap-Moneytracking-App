import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracking_app/controller/bottom_nav_bar_controller.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key}) : super(key: key);

  // Initialize the controller
  final BottomNavController controller = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => NavigationBarTheme(
          data: NavigationBarThemeData(
            indicatorColor: Colors.transparent,
            labelTextStyle: MaterialStateProperty.all(
              TextStyle(
                color: Colors.white, // Change this to your desired text color
              ),
            ),
          ),
          child: NavigationBar(
            labelBehavior: NavigationDestinationLabelBehavior.alwaysShow,
            surfaceTintColor: Colors.transparent,
            backgroundColor: Colors.transparent,
            selectedIndex:
                controller.selectedIndex.value, // Observe selectedIndex
            onDestinationSelected: (index) =>
                controller.navigateTo(index), // Navigate on tap
            destinations: const [
              NavigationDestination(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              NavigationDestination(
                icon: Icon(Icons.account_balance_wallet),
                label: "Accounts",
              ),
              NavigationDestination(
                icon: Icon(Icons.category),
                label: "Categories",
              ),
              NavigationDestination(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
            ],
          ),
        ));
  }
}
