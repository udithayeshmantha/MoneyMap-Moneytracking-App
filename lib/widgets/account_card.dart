import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  final String accountName;
  final double balance;
  final double income;
  final double expense;
  final VoidCallback onDelete;
  final VoidCallback onEdit;

  AccountCard({
    required this.accountName,
    required this.balance,
    required this.income,
    required this.expense,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: const Color.fromRGBO(23, 42, 46, 1),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                accountName,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              PopupMenuButton<String>(
                color: Colors.grey[900],
                onSelected: (value) {
                  if (value == 'Edit') {
                    onEdit();
                  } else if (value == 'Delete') {
                    onDelete();
                  }
                },
                itemBuilder: (context) {
                  return {'Edit', 'Delete'}.map((choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(
                        choice,
                        style: TextStyle(
                          color: choice == 'Delete' ? Colors.red : Colors.white,
                        ),
                      ),
                    );
                  }).toList();
                },
                icon: Icon(Icons.more_vert, color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Total Balance',
            style: TextStyle(fontSize: 16, color: Colors.white70),
          ),
          Text(
            'Rs${balance.toStringAsFixed(2)}',
            style: TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildInfoText('Income', income, Colors.green),
              _buildInfoText('Expense', expense, Colors.red),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildInfoText(String label, double amount, Color color) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: TextStyle(color: Colors.white, fontSize: 12)),
        Text(
          'Rs${amount.toStringAsFixed(2)}',
          style: TextStyle(
              color: color, fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
