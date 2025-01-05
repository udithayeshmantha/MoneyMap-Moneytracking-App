import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/account_card.dart';

class AccountsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 17, 24),
      appBar: AppBar(
        toolbarHeight: 75,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Accounts',
          style: TextStyle(
            color: Colors.white,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('accounts').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(
                  child: Text('Error fetching data',
                      style: TextStyle(color: Colors.white)));
            }
            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(
                  child: Text('No accounts available',
                      style: TextStyle(color: Colors.white)));
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                var account =
                    snapshot.data!.docs[index].data() as Map<String, dynamic>;
                return AccountCard(
                  accountName: account['name'] ?? 'Unknown',
                  balance: (account['balance'] as num).toDouble(),
                  income: (account['income'] as num).toDouble(),
                  expense: (account['expense'] as num).toDouble(),
                  onDelete: () => _deleteAccount(snapshot.data!.docs[index].id),
                  onEdit: () => _showEditAccountDialog(
                      context, snapshot.data!.docs[index].id),
                );
              },
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddAccountDialog(context),
        backgroundColor: Color(0xff4b3887),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }

  void _deleteAccount(String id) {
    FirebaseFirestore.instance.collection('accounts').doc(id).delete();
  }

  void _showAddAccountDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddAccountDialog();
      },
    );
  }

  void _showEditAccountDialog(BuildContext context, String id) {
    // Implement the edit account dialog
  }
}

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
