import 'dart:async';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService extends GetxService {
  static AuthService get to => Get.find();
  Timer? _inactivityTimer;

  @override
  void onInit() {
    super.onInit();
    _startInactivityTimer();
  }

  void _startInactivityTimer() {
    _inactivityTimer?.cancel();
    
    _inactivityTimer = Timer(const Duration(minutes: 10), _handleInactivity);
  }

  void _handleInactivity() {
    FirebaseAuth.instance.signOut();
    Get.offAllNamed('/login');
  }

  void resetInactivityTimer() {
    _startInactivityTimer();
  }

  @override
  void onClose() {
    _inactivityTimer?.cancel();
    super.onClose();
  }
}
