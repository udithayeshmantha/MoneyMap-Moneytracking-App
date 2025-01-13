import 'package:flutter/material.dart';
import 'package:money_tracking_app/components/bottom_nav_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 17, 24),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text(
          "Settings",
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
        backgroundColor: Colors.transparent,
        elevation: 0,
        toolbarHeight: 75,
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          _buildSettingItem(
            icon: Icons.person,
            iconColor: Colors.purple,
            title: "Name",
            subtitle: "Udith",
          ),
          _buildSettingItem(
            icon: Icons.currency_rupee,
            iconColor: Colors.purple,
            title: "Currency",
            subtitle: "Sri Lanka Rupee",
          ),
          _buildSettingItem(
            icon: Icons.download,
            iconColor: Colors.purple,
            title: "Export",
            subtitle: "Export to file",
          ),
          _buildSettingItem(
            icon: Icons.upload,
            iconColor: Colors.purple,
            title: "Import",
            subtitle: "Import from backup file",
          ),
          _buildSettingItem(
            icon: Icons.logout,
            iconColor: Colors.red,
            title: "Logout",
            subtitle: "Sign out of your account",
            onTap: () {
              // Add your logout logic here
              // For example, you can navigate to the login screen
              Navigator.pushReplacementNamed(context, '/Landing');
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: iconColor,
          child: Icon(
            icon,
            color: Colors.white,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(color: Colors.grey, fontSize: 14),
        ),
        onTap: onTap,
      ),
    );
  }
}
