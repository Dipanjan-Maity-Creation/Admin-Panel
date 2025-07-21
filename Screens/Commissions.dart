import 'package:flutter/material.dart';

class CommissionsScreen extends StatefulWidget {
  @override
  _CommissionsManagementScreenState createState() => _CommissionsManagementScreenState();
}

class _CommissionsManagementScreenState extends State<CommissionsScreen> {
  TextEditingController _searchController = TextEditingController();

  // Sample commission data
  List<Map<String, dynamic>> commissions = [
    {"type": "Food Orders", "percentage": "10%", "fixedFee": "\$2", "status": "Active"},
    {"type": "Grocery Orders", "percentage": "8%", "fixedFee": "\$1.5", "status": "Active"},
    {"type": "Liquor Orders", "percentage": "12%", "fixedFee": "\$3", "status": "Inactive"},
    {"type": "Restaurant Partner", "percentage": "15%", "fixedFee": "\$0", "status": "Active"},
  ];

  List<Map<String, dynamic>> filteredCommissions = [];

  @override
  void initState() {
    super.initState();
    filteredCommissions = List.from(commissions);
  }

  void filterCommissions(String query) {
    setState(() {
      filteredCommissions = commissions.where((commission) {
        return commission["type"].toLowerCase().contains(query.toLowerCase()) ||
            commission["percentage"].toLowerCase().contains(query.toLowerCase()) ||
            commission["status"].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void addNewCommission() {
    // Logic for adding a new commission (e.g., open a form dialog)
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("New commission setup coming soon!"))
    );
  }

  void editCommission(String type) {
    // Logic for editing the commission
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Edit commission for $type coming soon!"))
    );
  }

  void deleteCommission(String type) {
    setState(() {
      commissions.removeWhere((commission) => commission["type"] == type);
      filteredCommissions = List.from(commissions);
    });

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Commission for $type deleted!"))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Commissions & Charges"),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: addNewCommission), // Add commission
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
              onChanged: filterCommissions,
              decoration: InputDecoration(
                hintText: "Search Commission Types...",
                hintStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.black54,
                prefixIcon: Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),

            // Commission List
            Expanded(
              child: ListView.builder(
                itemCount: filteredCommissions.length,
                itemBuilder: (context, index) {
                  var commission = filteredCommissions[index];
                  return Card(
                    color: Colors.black87,
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: Icon(Icons.monetization_on, color: Colors.blueAccent, size: 30),
                      title: Text(commission["type"], style: TextStyle(color: Colors.white, fontSize: 18)),
                      subtitle: Text(
                        "Percentage: ${commission["percentage"]} | Fixed Fee: ${commission["fixedFee"]}",
                        style: TextStyle(color: Colors.white70),
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blueAccent),
                            onPressed: () => editCommission(commission["type"]),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () => deleteCommission(commission["type"]),
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
