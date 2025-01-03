import 'package:flutter/material.dart';
import 'package:money_tracking_app/components/bottom_nav_bar.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
            title: const Text(
            "Settings",
            style: TextStyle(color: Colors.white),
            ),
          centerTitle: false,
          backgroundColor: Colors.black,
          elevation: 0,
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
          ],
        ),
        bottomNavigationBar: BottomNavBar());
  }

  Widget _buildSettingItem({
    required IconData icon,
    required Color iconColor,
    required String title,
    required String subtitle,
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
        onTap: () {
          // Add actions for each setting if required
        },
      ),
    );
  }
}
