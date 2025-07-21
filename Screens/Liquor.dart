import 'package:flutter/material.dart';

class LiquorScreen extends StatefulWidget {
  @override
  _LiquorManagementScreenState createState() => _LiquorManagementScreenState();
}

class _LiquorManagementScreenState extends State<LiquorScreen> {
  TextEditingController _searchController = TextEditingController();

  // Sample liquor store data
  List<Map<String, dynamic>> liquorStores = [
    {"id": "L001", "name": "Royal Liquor", "location": "Kolkata", "contact": "+91 9876543210", "status": "Active", "orders": 150},
    {"id": "L002", "name": "Cheers Wines", "location": "Delhi", "contact": "+91 8765432109", "status": "Inactive", "orders": 60},
    {"id": "L003", "name": "High Spirits", "location": "Mumbai", "contact": "+91 9988776655", "status": "Active", "orders": 250},
    {"id": "L004", "name": "Vintage Liquor", "location": "Bangalore", "contact": "+91 9123456789", "status": "Pending", "orders": 90},
  ];

  List<Map<String, dynamic>> filteredLiquorStores = [];

  @override
  void initState() {
    super.initState();
    filteredLiquorStores = List.from(liquorStores);
  }

  void filterLiquorStores(String query) {
    setState(() {
      filteredLiquorStores = liquorStores.where((store) {
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
                    filteredLiquorStores = List.from(liquorStores);
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Active Stores"),
                onTap: () {
                  setState(() {
                    filteredLiquorStores = liquorStores.where((r) => r["status"] == "Active").toList();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Inactive Stores"),
                onTap: () {
                  setState(() {
                    filteredLiquorStores = liquorStores.where((r) => r["status"] == "Inactive").toList();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("High Sales (> 100)"),
                onTap: () {
                  setState(() {
                    filteredLiquorStores = liquorStores.where((r) => r["orders"] > 100).toList();
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
      backgroundColor: Colors.grey[900], // Dark theme
      appBar: AppBar(
        title: Text("Liquor Management"),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(icon: Icon(Icons.filter_list), onPressed: showFilterOptions),
          SizedBox(width: 10),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.blueAccent),
            icon: Icon(Icons.add, color: Colors.white),
            label: Text("Add Liquor Store", style: TextStyle(color: Colors.white)),
            onPressed: () {
              // Add Liquor Store Logic
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
              onChanged: filterLiquorStores,
              decoration: InputDecoration(
                hintText: "Search Liquor Stores...",
                hintStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.black54,
                prefixIcon: Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),

            // Liquor Stores List
            Expanded(
              child: ListView.builder(
                itemCount: filteredLiquorStores.length,
                itemBuilder: (context, index) {
                  var store = filteredLiquorStores[index];
                  return Card(
                    color: Colors.black87,
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.orangeAccent,
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
                        // Navigate to Liquor Store Details Page
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
