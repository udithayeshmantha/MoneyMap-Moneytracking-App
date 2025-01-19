import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  final TextEditingController _nameController = TextEditingController();
  User? user = FirebaseAuth.instance.currentUser;

  @override
  void initState() {
    super.initState();
    _loadUserName();
  }

  Future<void> _loadUserName() async {
    if (user != null) {
      DocumentSnapshot userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .get();
      if (userDoc.exists) {
        setState(() {
          _nameController.text = userDoc['name'] ?? '';
        });
      }
    }
  }

  Future<void> _updateUserName() async {
    if (user != null) {
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .update({
        'name': _nameController.text,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Name updated successfully')),
      );
    }
  }

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
            subtitle: "Edit your name",
            onTap: () {
              _showEditNameDialog();
            },
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

  void _showEditNameDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Edit Name'),
          content: TextField(
            controller: _nameController,
            decoration: InputDecoration(
              hintText: 'Enter your name',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                _updateUserName();
                Navigator.of(context).pop();
              },
              child: Text('Save'),
            ),
          ],
        );
      },
    );
  }
}
