import 'package:flutter/material.dart';

class GroceryScreen extends StatefulWidget {
  @override
  _GroceryManagementScreenState createState() => _GroceryManagementScreenState();
}

class _GroceryManagementScreenState extends State<GroceryScreen> {
  TextEditingController _searchController = TextEditingController();

  // Sample grocery data
  List<Map<String, dynamic>> groceryStores = [
    {"id": "G001", "name": "Fresh Mart", "location": "Kolkata", "contact": "+91 9876543210", "status": "Active", "orders": 120},
    {"id": "G002", "name": "Green Grocery", "location": "Delhi", "contact": "+91 8765432109", "status": "Inactive", "orders": 45},
    {"id": "G003", "name": "Daily Needs", "location": "Mumbai", "contact": "+91 9988776655", "status": "Active", "orders": 200},
    {"id": "G004", "name": "Super Fresh", "location": "Bangalore", "contact": "+91 9123456789", "status": "Pending", "orders": 90},
  ];

  List<Map<String, dynamic>> filteredGroceries = [];

  @override
  void initState() {
    super.initState();
    filteredGroceries = List.from(groceryStores);
  }

  void filterGroceries(String query) {
    setState(() {
      filteredGroceries = groceryStores.where((store) {
        return store["name"].toLowerCase().contains(query.toLowerCase()) ||
            store["location"].toLowerCase().contains(query.toLowerCase()) ||
            store["contact"].contains(query);
      }).toList();
    });
  }

  void showFilterOptions() {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: Wrap(
            children: [
              ListTile(
                title: Text("Show All"),
                onTap: () {
                  setState(() {
                    filteredGroceries = List.from(groceryStores);
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Active Stores"),
                onTap: () {
                  setState(() {
                    filteredGroceries = groceryStores.where((r) => r["status"] == "Active").toList();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Inactive Stores"),
                onTap: () {
                  setState(() {
                    filteredGroceries = groceryStores.where((r) => r["status"] == "Inactive").toList();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("High Orders (> 100)"),
                onTap: () {
                  setState(() {
                    filteredGroceries = groceryStores.where((r) => r["orders"] > 100).toList();
                  });
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Dark background
      appBar: AppBar(
        title: Text("Grocery Management"),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(icon: Icon(Icons.filter_list), onPressed: showFilterOptions),
          SizedBox(width: 10),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
            icon: Icon(Icons.add, color: Colors.white),
            label: Text("Add Grocery", style: TextStyle(color: Colors.white)),
            onPressed: () {
              // Add Grocery Store Logic
            },
          ),
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
              onChanged: filterGroceries,
              decoration: InputDecoration(
                hintText: "Search Grocery Stores...",
                hintStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.black54,
                prefixIcon: Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),

            // Grocery Stores List
            Expanded(
              child: ListView.builder(
                itemCount: filteredGroceries.length,
                itemBuilder: (context, index) {
                  var store = filteredGroceries[index];
                  return Card(
                    color: Colors.black87,
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.greenAccent,
                        child: Text(store["name"][0], style: TextStyle(color: Colors.white)),
                      ),
                      title: Text(store["name"], style: TextStyle(color: Colors.white, fontSize: 18)),
                      subtitle: Text("Location: ${store["location"]} | Contact: ${store["contact"]} | Orders: ${store["orders"]}",
                          style: TextStyle(color: Colors.white70)),
                      trailing: Chip(
                        label: Text(store["status"],
                            style: TextStyle(color: store["status"] == "Active" ? Colors.green : Colors.red)),
                        backgroundColor: Colors.black54,
                      ),
                      onTap: () {
                        // Navigate to Grocery Details Page
                      },
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
