import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracking_app/controller/bottom_nav_bar_controller.dart';

class BottomNavBar extends StatelessWidget {
  BottomNavBar({Key? key}) : super(key: key);

  // Initialize the controller
  final BottomNavController controller = Get.put(BottomNavController());

  @override
  Widget build(BuildContext context) {
    return Obx(() => SizedBox(
          height: 70,
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: const Color.fromARGB(255, 54, 54, 54),
            elevation: 0,
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.white,
            showUnselectedLabels: true,
            currentIndex:
                controller.selectedIndex.value, // Observe selectedIndex
            onTap: (index) => controller.navigateTo(index), // Navigate on tap
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.account_balance_wallet),
                label: "Accounts",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.category),
                label: "Categories",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings),
                label: "Settings",
              ),
            ],
          ),
        ));
  }
}
