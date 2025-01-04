import 'package:flutter/material.dart';

class EditCategoryDialog extends StatefulWidget {
  final String name;
  final String budget;
  final IconData icon;
  final Color color;
  final Function(Map<String, dynamic>) onSave;

  const EditCategoryDialog({
    Key? key,
    required this.name,
    required this.budget,
    required this.icon,
    required this.color,
    required this.onSave,
  }) : super(key: key);

  @override
  _EditCategoryDialogState createState() => _EditCategoryDialogState();
}

class _EditCategoryDialogState extends State<EditCategoryDialog> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController budgetController = TextEditingController();
  late Color selectedColor;
  late IconData selectedIcon;

  @override
  void initState() {
    super.initState();
    nameController.text = widget.name;
    budgetController.text = widget.budget;
    selectedColor = widget.color;
    selectedIcon = widget.icon;
  }

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
              "Edit Category",
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
                    controller: nameController,
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
              controller: budgetController,
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
                widget.onSave({
                  "name": nameController.text,
                  "budget": budgetController.text.isEmpty
                      ? "No budget"
                      : budgetController.text,
                  "icon": selectedIcon,
                  "color": selectedColor,
                });
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
