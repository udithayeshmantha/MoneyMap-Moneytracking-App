import 'package:get/get.dart';

class BottomNavController extends GetxController {
  // Reactive selectedIndex
  var selectedIndex = 0.obs;

  // Method to handle navigation
  void navigateTo(int index) {
    selectedIndex.value = index;

    switch (index) {
      case 0:
        Get.toNamed('/home');
        break;
      case 1:
        Get.toNamed('/accounts');
        break;
      case 2:
        Get.toNamed('/categories');
        break;
      case 3:
        Get.toNamed('/settings');
        break;
      default:
        throw Exception('Invalid index');
    }
  }
}
