import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:money_tracking_app/components/bottom_nav_bar.dart';
import 'package:money_tracking_app/models/userdetails.dart';
import 'package:money_tracking_app/services/firestore_service.dart';

String greeting() {
  var hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Morning';
  }
  if (hour < 17) {
    return 'Afternoon';
  }
  return 'Evening';
}

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    final UserDetails userDetails = Get.arguments as UserDetails;
    final FirestoreService _firestoreService = FirestoreService();

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 17, 24),
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: StreamBuilder<List<UserDetails>>(
        stream: _firestoreService.getUsers(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          final users = snapshot.data ?? [];
          return ListView.builder(
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return ListTile(
                title: Text(user.name),
              );
            },
          );
        },
      ),
    );
  }
}
