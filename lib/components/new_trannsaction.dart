import 'package:flutter/material.dart';
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
  DateTime selectedDate = DateTime.now(); // Selected Date
  TimeOfDay selectedTime = TimeOfDay.now(); // Selected Time
  String? selectedCategory; // Currently selected category

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
                    // Income and Expense Toggle
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isIncome = true;
                                selectedCategory = null; // Reset category
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
                                selectedCategory = null; // Reset category
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

                    // Title TextField
                    CustomTextField("Title", "Enter transaction title"),
                    const SizedBox(height: 20),

                    // Description TextField
                    CustomTextField(
                        "Description", "Enter transaction description"),
                    const SizedBox(height: 20),

                    // Amount TextField
                    CustomTextField("Rs 0.0", "Enter amount",
                        keyboardType: TextInputType.number),
                    const SizedBox(height: 20),

                    // Date and Time Row
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
                        )),
                      ],
                    ),
                    const SizedBox(height: 20),
                    // Select Account Section
                    SelectAccount(),
                    const SizedBox(height: 20),
                    // Select Category Section
                    SelectCategory(),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),

          // Save Button
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Save transaction logic here
                },
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
          SizedBox(
            height: 15,
          )
        ],
      ),
      backgroundColor: const Color.fromARGB(255, 20, 17, 24),
    );
  }

  Widget _dateOrTimeContainer(String label, String value) {
    return Container(
      padding: const EdgeInsets.all(12),
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
