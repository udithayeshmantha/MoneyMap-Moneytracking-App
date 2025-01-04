import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:money_tracking_app/models/userdetails.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    Future<void> _login() async {
      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
<<<<<<< HEAD
        final userDetails = UserDetails(
          name: nameController.text,
          id: '',
          email: emailController.text.trim(),
        );
=======
        final userDetails =
            UserDetails(name: userCredential.user?.displayName ?? 'User');
>>>>>>> 62096b4e8d12b91238cb3a73a3d4e15dc9c8c533
        Get.toNamed('/bottomnavbar', arguments: userDetails);
      } on FirebaseAuthException catch (e) {
        String message;
        if (e.code == 'user-not-found') {
          message = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          message = 'Wrong password provided.';
        } else {
          message = 'An error occurred: ${e.message}';
        }
        Get.snackbar(
          'Error',
          message,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } catch (e) {
        Get.snackbar(
          'Error',
          e.toString(),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 17, 24),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.account_balance_wallet_outlined,
              color: Colors.white,
              size: 80.0,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Hi! welcome to Fintracker',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            const Text(
              'Please log in to continue',
              style: TextStyle(color: Colors.white70, fontSize: 16.0),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: emailController,
              decoration: _inputDecoration('Email', Icons.email),
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: 20.0),
            TextField(
              controller: passwordController,
              decoration: _inputDecoration('Password', Icons.lock),
              style: const TextStyle(color: Colors.white),
              cursorColor: Colors.white,
              obscureText: true,
            ),
            const SizedBox(height: 40.0),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (emailController.text.isEmpty ||
                      passwordController.text.isEmpty) {
                    Get.snackbar(
                      'Error',
                      'All fields are required',
                      snackPosition: SnackPosition.BOTTOM,
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  } else {
                    _login();
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 15.0),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Login',
                        style: TextStyle(fontSize: 18.0, color: Colors.black)),
                    SizedBox(width: 10.0),
                    Icon(Icons.arrow_forward, color: Colors.black),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  InputDecoration _inputDecoration(String label, IconData icon) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.white),
      filled: true,
      fillColor: Colors.grey[900],
      prefixIcon: Icon(icon, color: Colors.white),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.white),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
        borderSide: const BorderSide(color: Colors.white, width: 2.0),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
    );
  }
}
