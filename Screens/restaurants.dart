import 'package:flutter/material.dart';

class RestaurantsScreen extends StatefulWidget {
  @override
  _RestaurantManagementPageState createState() => _RestaurantManagementPageState();
}

class _RestaurantManagementPageState extends State<RestaurantsScreen> {
  TextEditingController searchController = TextEditingController();
  String selectedDateFilter = "Today";
  String selectedStatus = "All";
  String selectedCuisine = "All";
  bool isAscending = true;

  List<Map<String, dynamic>> restaurants = [
    {
      "id": "#R001",
      "name": "Tandoori Bites",
      "location": "Kolkata, WB",
      "contact": "9876543210",
      "cuisine": "Indian",
      "status": "Active",
      "approval": "Approved",
      "ordersAccepted": 120,
      "ordersPending": 10
    },
    {
      "id": "#R002",
      "name": "Food Junction",
      "location": "Delhi, DL",
      "contact": "8765432109",
      "cuisine": "Chinese",
      "status": "Inactive",
      "approval": "Pending",
      "ordersAccepted": 80,
      "ordersPending": 20
    },
    {
      "id": "#R003",
      "name": "Spicy Tadka",
      "location": "Mumbai, MH",
      "contact": "7654321098",
      "cuisine": "Mexican",
      "status": "Active",
      "approval": "Rejected",
      "ordersAccepted": 150,
      "ordersPending": 5
    },
  ];

  void toggleSorting() {
    setState(() {
      isAscending = !isAscending;
      restaurants.sort((a, b) =>
      isAscending ? a["name"].compareTo(b["name"]) : b["name"].compareTo(a["name"]));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Row(
          children: [
            Text("Restaurant Management"),
            Spacer(),
            IconButton(icon: Icon(Icons.notifications), onPressed: () {}),
            SizedBox(width: 10),
            CircleAvatar(backgroundImage: AssetImage('assets/admin.jpg')),
          ],
        ),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filter Panel
            Container(
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(8)),
              child: Row(
                children: [
                  // Date Filter
                  DropdownButton<String>(
                    dropdownColor: Colors.black,
                    value: selectedDateFilter,
                    icon: Icon(Icons.calendar_today, color: Colors.white),
                    items: ["Today", "Choose a Date"]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e, style: TextStyle(color: Colors.white))))
                        .toList(),
                    onChanged: (value) => setState(() => selectedDateFilter = value!),
                  ),
                  SizedBox(width: 10),

                  // Status Filter
                  DropdownButton<String>(
                    dropdownColor: Colors.black,
                    value: selectedStatus,
                    icon: Icon(Icons.filter_list, color: Colors.white),
                    items: ["All", "Active", "Inactive"]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e, style: TextStyle(color: Colors.white))))
                        .toList(),
                    onChanged: (value) => setState(() => selectedStatus = value!),
                  ),
                  SizedBox(width: 10),

                  // Cuisine Filter
                  DropdownButton<String>(
                    dropdownColor: Colors.black,
                    value: selectedCuisine,
                    icon: Icon(Icons.fastfood, color: Colors.white),
                    items: ["All", "Indian", "Chinese", "Mexican"]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e, style: TextStyle(color: Colors.white))))
                        .toList(),
                    onChanged: (value) => setState(() => selectedCuisine = value!),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Summary Statistics
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSummaryCard("Total Active Restaurants", "200", Icons.store),
                _buildSummaryCard("Orders Accepted", "1,500", Icons.check_circle),
                _buildSummaryCard("Orders Pending", "250", Icons.pending_actions),
              ],
            ),

            SizedBox(height: 16),

            // Table Header
            Container(
              padding: EdgeInsets.all(8),
              color: Colors.black87,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                      child: GestureDetector(
                        onTap: toggleSorting,
                        child: Row(
                          children: [
                            Text("Restaurant Name", style: TextStyle(color: Colors.white)),
                            Icon(isAscending ? Icons.arrow_upward : Icons.arrow_downward, color: Colors.white, size: 16),
                          ],
                        ),
                      )),

                  Expanded(child: Text("Location", style: TextStyle(color: Colors.white))),
                  Expanded(child: Text("Contact", style: TextStyle(color: Colors.white))),
                  Expanded(child: Text("Cuisine", style: TextStyle(color: Colors.white))),
                  Expanded(child: Text("Orders Accepted", style: TextStyle(color: Colors.white))),
                  Expanded(child: Text("Orders Pending", style: TextStyle(color: Colors.white))),
                  Expanded(child: Text("Status", style: TextStyle(color: Colors.white))),
                  Expanded(child: Text("Approval", style: TextStyle(color: Colors.white))),
                  Expanded(child: Text("Actions", style: TextStyle(color: Colors.white))),
                ],
              ),
            ),

            // Restaurant List
            Expanded(
              child: ListView.builder(
                itemCount: restaurants.length,
                itemBuilder: (context, index) {
                  var restaurant = restaurants[index];
                  return Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.white54)),
                      color: index.isEven ? Colors.grey[850] : Colors.grey[800],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(restaurant['name'], style: TextStyle(color: Colors.white))),
                        Expanded(child: Text(restaurant['location'], style: TextStyle(color: Colors.white))),
                        Expanded(child: Text(restaurant['contact'], style: TextStyle(color: Colors.white))),
                        Expanded(child: Text(restaurant['cuisine'], style: TextStyle(color: Colors.white))),
                        Expanded(child: Text(restaurant['ordersAccepted'].toString(), style: TextStyle(color: Colors.green))),
                        Expanded(child: Text(restaurant['ordersPending'].toString(), style: TextStyle(color: Colors.red))),
                        Expanded(
                            child: Text(restaurant['status'],
                                style: TextStyle(color: restaurant['status'] == "Active" ? Colors.green : Colors.grey))),
                        Expanded(
                            child: Text(restaurant['approval'],
                                style: TextStyle(color: restaurant['approval'] == "Pending" ? Colors.yellow : restaurant['approval'] == "Rejected" ? Colors.red : Colors.green))),

                        // Actions
                        Expanded(
                          child: Row(
                            children: [
                              IconButton(icon: Icon(Icons.visibility, color: Colors.blue), onPressed: () {}),
                              IconButton(icon: Icon(Icons.edit, color: Colors.orange), onPressed: () {}),
                              IconButton(icon: Icon(Icons.check, color: Colors.green), onPressed: () {}),
                              IconButton(icon: Icon(Icons.cancel, color: Colors.red), onPressed: () {}),
                            ],
                          ),
                        ),
                      ],
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

  Widget _buildSummaryCard(String title, String value, IconData icon) {
    return Container(
      width: 180,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(color: Colors.grey[800], borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: [
          Icon(icon, color: Colors.blue, size: 32),
          SizedBox(width: 10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: TextStyle(color: Colors.white70, fontSize: 14)),
              Text(value, style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
            ],
          ),
        ],
      ),
    );
  }
}
