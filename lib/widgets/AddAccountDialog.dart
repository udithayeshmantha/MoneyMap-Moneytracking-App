import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:money_tracking_app/screens/accounts.dart';

class AddAccountDialog extends StatefulWidget {
  @override
  _AddAccountDialogState createState() => _AddAccountDialogState();
}


class _AddAccountDialogState extends State<AddAccountDialog> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _holderNameController = TextEditingController();
  final TextEditingController _accountNumberController =
      TextEditingController();

  Color selectedColor = Colors.primaries[0];
  IconData selectedIcon = Icons.person;

  final FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: Colors.grey[900],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "New Account",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Icon(selectedIcon, color: selectedColor),
                SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _nameController,
                    decoration: InputDecoration(
                      labelText: "Name",
                      labelStyle: TextStyle(color: Colors.white70),
                      filled: true,
                      fillColor: Colors.grey[800],
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            TextField(
              controller: _holderNameController,
              decoration: InputDecoration(
                labelText: "Holder name",
                labelStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _accountNumberController,
              decoration: InputDecoration(
                labelText: "A/C Number",
                labelStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.grey[800],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: Colors.primaries.map((color) {
                  return _buildColorSelector(color);
                }).toList(),
              ),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Icons.person,
                  Icons.account_balance,
                  Icons.credit_card,
                  Icons.savings,
                  Icons.wallet_travel,
                  Icons.attach_money,
                ].map((icon) {
                  return _buildIconSelector(icon);
                }).toList(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                await _saveAccountToFirestore();
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                child: Text("Save"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildColorSelector(Color color) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedColor = color;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        child: CircleAvatar(
          backgroundColor: color,
          radius: 16,
          child: selectedColor == color
              ? Icon(Icons.check, color: Colors.white, size: 16)
              : null,
        ),
      ),
    );
  }

  Widget _buildIconSelector(IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedIcon = icon;
        });
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        child: CircleAvatar(
          backgroundColor: Colors.grey[800],
          radius: 16,
          child: Icon(
            icon,
            color: selectedIcon == icon ? Colors.white : Colors.white70,
          ),
        ),
      ),
    );
  }

  Future<void> _saveAccountToFirestore() async {
    final accountData = {
      'name': _nameController.text,
      'holderName': _holderNameController.text,
      'accountNumber': _accountNumberController.text,
      'color': selectedColor.value,
      'icon': selectedIcon.codePoint,
      'balance': 0,
      'income': 0,
      'expense': 0,
    };

    try {
      DocumentReference docRef =
          await db.collection('accounts').add(accountData);
      print('Account added with ID: ${docRef.id}');
    } catch (e) {
      print('Error adding account: $e');
    }
  }
}