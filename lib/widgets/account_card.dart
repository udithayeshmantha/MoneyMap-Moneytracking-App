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
      height: 210,
      decoration: BoxDecoration(
        color: const Color.fromRGBO(23, 42, 46, 1),
        borderRadius: BorderRadius.circular(16),
      ),
      padding: const EdgeInsets.all(16.0),
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
                    color: Colors.white),
              ),
              PopupMenuButton<String>(
                color: Colors.grey[900],
                onSelected: (value) {
                  if (value == 'Edit') {
                    // Handle edit action
                    print('Edit selected');
                  } else if (value == 'Delete') {
                    // Handle delete action
                    print('Delete selected');
                  }
                },
                itemBuilder: (BuildContext context) {
                  return {'Edit', 'Delete'}.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(
                        choice,
                        style: TextStyle(
                            color: Colors.white), // Change text color here
                      ),
                    );
                  }).toList();
                },
                icon: Icon(
                  Icons.more_vert,
                  color: Colors.white,
                ),
              )
            ],
          ),
          SizedBox(height: 8),
          Text(
            'Total Balance',
            style: TextStyle(
                fontSize: 16, color: const Color.fromARGB(255, 248, 244, 244)),
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
              Text(
                'Income\nRs${income.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.green, fontSize: 16),
              ),
              Text(
                'Expense\nRs${expense.toStringAsFixed(2)}',
                style: TextStyle(color: Colors.red, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
