import 'package:flutter/material.dart';
import 'package:money_tracking_app/components/bottom_nav_bar.dart';

class Categories extends StatelessWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // List of categories
    final categories = [
      {"icon": Icons.home, "name": "Housing", "budget": "No budget"},
      {
        "icon": Icons.directions_car,
        "name": "Transportation",
        "budget": "No budget"
      },
      {"icon": Icons.restaurant, "name": "Food", "budget": "No budget"},
      {"icon": Icons.flash_on, "name": "Utilities", "budget": "No budget"},
      {
        "icon": Icons.health_and_safety,
        "name": "Insurance",
        "budget": "No budget"
      },
      {
        "icon": Icons.medical_services,
        "name": "Medical & Healthcare",
        "budget": "No budget"
      },
      {
        "icon": Icons.savings,
        "name": "Saving, Investing, & Debt Payments",
        "budget": "No budget"
      },
      {
        "icon": Icons.shopping_cart,
        "name": "Personal Spending",
        "budget": "No budget"
      },
      {
        "icon": Icons.tv,
        "name": "Recreation & Entertainment",
        "budget": "No budget"
      },
    ];

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 20, 17, 24),
      appBar: AppBar(
        toolbarHeight: 75,
        automaticallyImplyLeading: false, // Remove the back button
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Categories",
            style: TextStyle(
              color: Colors.white,
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemCount: categories.length,
        itemBuilder: (context, index) {
          final category = categories[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.deepPurple.shade100,
              child: Icon(
                category['icon'] as IconData,
                color: Colors.deepPurple,
              ),
            ),
            title: Text(
              category['name'] as String,
              style: const TextStyle(color: Colors.white, fontSize: 18),
            ),
            subtitle: Text(
              category['budget'] as String,
              style: const TextStyle(color: Colors.white70),
            ),
            onTap: () {
              // Handle category tap (e.g., navigate to details page)
            },
          );
        },
        separatorBuilder: (context, index) => Divider(
          indent: 50,
          endIndent: 20,
          color: Colors.grey.shade800,
          thickness: 1,
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Handle floating button press
        },
        backgroundColor: Color(0xff4b3887),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
