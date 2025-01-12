import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:money_tracking_app/widgets/AddAccountDialog.dart';
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
