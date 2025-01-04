import 'package:flutter/material.dart';
import 'package:money_tracking_app/components/bottom_nav_bar.dart';
import 'package:money_tracking_app/widgets/edit_category_dialog.dart';

class Categories extends StatefulWidget {
  const Categories({Key? key}) : super(key: key);

  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  final List<Map<String, Object>> categories = [
    {"icon": Icons.home, "name": "Housing", "budget": "No budget", "color": Colors.blue},
    {"icon": Icons.directions_car, "name": "Transportation", "budget": "No budget", "color": Colors.green},
    {"icon": Icons.restaurant, "name": "Food", "budget": "No budget", "color": Colors.red},
    {"icon": Icons.flash_on, "name": "Utilities", "budget": "No budget", "color": Colors.yellow},
    {"icon": Icons.health_and_safety, "name": "Insurance", "budget": "No budget", "color": Colors.purple},
    {"icon": Icons.medical_services, "name": "Medical & Healthcare", "budget": "No budget", "color": Colors.orange},
    {"icon": Icons.savings, "name": "Saving, Investing, & Debt Payments", "budget": "No budget", "color": Colors.pink},
    {"icon": Icons.shopping_cart, "name": "Personal Spending", "budget": "No budget", "color": Colors.brown},
    {"icon": Icons.tv, "name": "Recreation & Entertainment", "budget": "No budget", "color": Colors.cyan},
  ];

  @override
  Widget build(BuildContext context) {
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
              backgroundColor: (category['color'] as Color).withOpacity(0.1),
              child: Icon(
                category['icon'] as IconData,
                color: category['color'] as Color,
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
              _showEditCategoryDialog(
                context,
                category,
                (updatedCategory) {
                  setState(() {
                    categories[index] = updatedCategory.cast<String, Object>();
                  });
                },
              );
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddCategoryDialog(context),
        backgroundColor: const Color(0xff4b3887),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
    );
  }


  void _showEditCategoryDialog(BuildContext context, Map<String, Object> category, Function(Map<String, dynamic>) onSave) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return EditCategoryDialog(
          name: category['name'] as String,
          budget: category['budget'] as String,
          icon: category['icon'] as IconData,
          color: category['color'] as Color,
          onSave: onSave,
        );
      },
    );
  }
}

 void _showAddCategoryDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddCategoryDialog();
      },
    );
  }



class AddCategoryDialog extends StatefulWidget {
  @override
  _AddCategoryDialogState createState() => _AddCategoryDialogState();
}

class _AddCategoryDialogState extends State<AddCategoryDialog> {
  Color selectedColor = Colors.primaries[0];
  IconData selectedIcon = Icons.category;

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
              "New Category",
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
              decoration: InputDecoration(
                labelText: "Budget",
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
                }).toList(),
              ),
            ),
            SizedBox(height: 16),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Icons.category,
                  Icons.home,
                  Icons.directions_car,
                  Icons.restaurant,
                  Icons.flash_on,
                  Icons.health_and_safety,
                  Icons.medical_services,
                  Icons.savings,
                  Icons.shopping_cart,
                  Icons.tv,
                ].map((icon) {
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
                          color: selectedIcon == icon
                              ? Colors.white
                              : Colors.white70,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle save action
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
}
