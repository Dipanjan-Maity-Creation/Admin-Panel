import 'package:flutter/material.dart';

class CategoriesScreen extends StatefulWidget {
  @override
  _CategoriesManagementScreenState createState() => _CategoriesManagementScreenState();
}

class _CategoriesManagementScreenState extends State<CategoriesScreen> {
  TextEditingController _searchController = TextEditingController();

  // Sample categories data
  List<Map<String, dynamic>> categories = [
    {"id": "C001", "name": "Fast Food", "icon": Icons.fastfood, "status": "Active", "date": "2025-02-15"},
    {"id": "C002", "name": "Beverages", "icon": Icons.local_cafe, "status": "Active", "date": "2025-02-10"},
    {"id": "C003", "name": "Desserts", "icon": Icons.cake, "status": "Inactive", "date": "2025-01-25"},
    {"id": "C004", "name": "Groceries", "icon": Icons.local_grocery_store, "status": "Active", "date": "2025-02-01"},
  ];

  List<Map<String, dynamic>> filteredCategories = [];

  @override
  void initState() {
    super.initState();
    filteredCategories = List.from(categories);
  }

  void filterCategories(String query) {
    setState(() {
      filteredCategories = categories.where((category) {
        return category["name"].toLowerCase().contains(query.toLowerCase()) ||
            category["status"].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void addCategory() {
    // Logic for adding a new category (e.g., open a form dialog)
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Add category feature coming soon!"))
    );
  }

  void editCategory(String categoryId) {
    // Logic for editing the category
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Edit category $categoryId coming soon!"))
    );
  }

  void deleteCategory(String categoryId) {
    setState(() {
      categories.removeWhere((category) => category["id"] == categoryId);
      filteredCategories = List.from(categories);
    });

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Category $categoryId deleted!"))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Categories Management"),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: addCategory), // Add category button
          SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Search Bar
            TextField(
              controller: _searchController,
              onChanged: filterCategories,
              decoration: InputDecoration(
                hintText: "Search Categories...",
                hintStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.black54,
                prefixIcon: Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),

            // Category List
            Expanded(
              child: ListView.builder(
                itemCount: filteredCategories.length,
                itemBuilder: (context, index) {
                  var category = filteredCategories[index];
                  return Card(
                    color: Colors.black87,
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: Icon(category["icon"], color: Colors.blueAccent, size: 30),
                      title: Text(category["name"], style: TextStyle(color: Colors.white, fontSize: 18)),
                      subtitle: Text("Status: ${category["status"]} | Date: ${category["date"]}",
                          style: TextStyle(color: Colors.white70)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blueAccent),
                            onPressed: () => editCategory(category["id"]),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () => deleteCategory(category["id"]),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
