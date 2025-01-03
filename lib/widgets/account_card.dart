import 'package:flutter/material.dart';

class AccountCard extends StatelessWidget {
  final String accountName;
  final double balance;
  final double income;
  final double expense;

  AccountCard({
    required this.accountName,
    required this.balance,
    required this.income,
    required this.expense,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      decoration: BoxDecoration(
        color: const Color.fromARGB(255, 0, 0, 0),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            accountName,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 8),
          Text(
            'Total Balance',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade300),
          ),
          Text(
            'Rs$balance',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Income\nRs$income',
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
              Text(
                'Expense\nRs$expense',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
