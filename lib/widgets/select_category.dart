import 'package:flutter/material.dart';

class SelectCategory extends StatefulWidget {
  const SelectCategory({super.key});

  @override
  State<SelectCategory> createState() => _SelectCategoryState();
}

class _SelectCategoryState extends State<SelectCategory> {
  String? selectedCategory;

  // List of categories
  final List<Map<String, dynamic>> categories = [
    {"name": "Housing", "icon": Icons.home, "color": Colors.blue},
    {
      "name": "Transportation",
      "icon": Icons.directions_car,
      "color": Colors.orange
    },
    {"name": "Food", "icon": Icons.restaurant, "color": Colors.red},
    {"name": "Utilities", "icon": Icons.flash_on, "color": Colors.yellow},
    {
      "name": "Insurance",
      "icon": Icons.health_and_safety,
      "color": Colors.green
    },
    {
      "name": "Medical & Healthcare",
      "icon": Icons.medical_services,
      "color": Colors.purple
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Align(
          alignment: Alignment.centerLeft,
          child: Text(
            "Select Category",
            style: TextStyle(
                color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 10),
        Wrap(
          spacing: 10,
          children: categories
              .map((category) => _categoryChip(
                    category["name"],
                    category["icon"],
                    category["color"],
                  ))
              .toList(),
        ),
      ],
    );
  }

  Widget _categoryChip(String name, IconData icon, Color iconColor) {
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategory = name;
        });
      },
      child: Chip(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(color: Colors.transparent)),
        avatar: Icon(icon, color: iconColor),
        label: Text(name, style: const TextStyle(color: Colors.white)),
        backgroundColor: selectedCategory == name
            ? const Color(0xffcdbdfb)
            : Colors.grey[800],
      ),
    );
  }
}
