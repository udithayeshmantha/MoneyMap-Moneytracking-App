import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:money_tracking_app/widgets/custom_text_field.dart';
import 'package:money_tracking_app/widgets/select_account.dart';
import 'package:money_tracking_app/widgets/select_category.dart';

class NewTransactionScreen extends StatefulWidget {
  const NewTransactionScreen({Key? key}) : super(key: key);

  @override
  _NewTransactionScreenState createState() => _NewTransactionScreenState();
}

class _NewTransactionScreenState extends State<NewTransactionScreen> {
  bool isIncome = true; // Toggle between Income and Expense
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  String? selectedCategory;
  String title = '';
  String description = '';
  double amount = 0.0;

  final _firestore = FirebaseFirestore.instance;

  Future<void> _saveTransaction() async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      if (user == null) {
        throw Exception("User not logged in");
      }

      String uid = user.uid;
      String type = isIncome ? 'income' : 'expense';
      String formattedDate = "${selectedDate.toLocal()}".split(' ')[0];
      String formattedTime = selectedTime.format(context);

      // Save transaction to Firestore under the user's UID
      await _firestore
          .collection('users')
          .doc(uid)
          .collection('transactions')
          .add({
        'title': title,
        'description': description,
        'amount': amount,
        'date': formattedDate,
        'time': formattedTime,
        'type': type,
        'category': selectedCategory,
      });

      // Update balance with retry logic
      DocumentReference balanceDoc = _firestore
          .collection('users')
          .doc(uid)
          .collection('balance')
          .doc('main');

      const int maxRetries = 5;
      int retryCount = 0;
      bool success = false;

      while (retryCount < maxRetries && !success) {
        try {
          await _firestore.runTransaction((transaction) async {
            DocumentSnapshot snapshot = await transaction.get(balanceDoc);
            if (!snapshot.exists) {
              await balanceDoc.set({'balance': 0.0});
              snapshot = await transaction.get(balanceDoc);
            }
            double currentBalance = (snapshot['balance'] as num).toDouble();
            double updatedBalance =
                isIncome ? currentBalance + amount : currentBalance - amount;

            transaction.update(balanceDoc, {'balance': updatedBalance});
          });
          success = true;
        } catch (e) {
          retryCount++;
          if (retryCount == maxRetries) {
            throw Exception(
                "Failed to update balance after $maxRetries attempts");
          }
        }
      }

      Navigator.pop(context);
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save transaction: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "New Transaction",
            style: TextStyle(color: Colors.white, fontSize: 20),
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isIncome = true;
                                selectedCategory = null;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: isIncome
                                    ? const Color(0xffcdbdfb)
                                    : Colors.transparent,
                                border:
                                    Border.all(color: const Color(0xffcdbdfb)),
                              ),
                              child: const Text(
                                "Income",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isIncome = false;
                                selectedCategory = null;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 12),
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: !isIncome
                                    ? const Color(0xffcdbdfb)
                                    : Colors.transparent,
                                border:
                                    Border.all(color: const Color(0xffcdbdfb)),
                              ),
                              child: const Text(
                                "Expense",
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: "Title",
                      hintText: "Enter transaction title",
                      onChanged: (value) => setState(() => title = value),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: "Description",
                      hintText: "Enter transaction description",
                      onChanged: (value) => setState(() => description = value),
                    ),
                    const SizedBox(height: 20),
                    CustomTextField(
                      label: "Rs 0.0",
                      hintText: "Enter amount",
                      keyboardType: TextInputType.number,
                      onChanged: (value) => setState(
                          () => amount = double.tryParse(value) ?? 0.0),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              DateTime? pickedDate = await showDatePicker(
                                context: context,
                                initialDate: selectedDate,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2100),
                              );
                              if (pickedDate != null) {
                                setState(() {
                                  selectedDate = pickedDate;
                                });
                              }
                            },
                            child: _dateOrTimeContainer("Date",
                                "${selectedDate.toLocal()}".split(' ')[0]),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: GestureDetector(
                            onTap: () async {
                              TimeOfDay? pickedTime = await showTimePicker(
                                context: context,
                                initialTime: selectedTime,
                              );
                              if (pickedTime != null) {
                                setState(() {
                                  selectedTime = pickedTime;
                                });
                              }
                            },
                            child: _dateOrTimeContainer(
                                "Time", selectedTime.format(context)),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    SelectAccount(),
                    const SizedBox(height: 20),
                    SelectCategory(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _saveTransaction,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[800],
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                child: const Text(
                  "Save Transaction",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 20, 17, 24),
    );
  }

  Widget _dateOrTimeContainer(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(label == "Date" ? Icons.calendar_today : Icons.access_time,
              color: const Color(0xffcdbdfb)),
          const SizedBox(width: 10),
          Text(value, style: const TextStyle(color: Colors.white60)),
        ],
      ),
    );
  }
}
