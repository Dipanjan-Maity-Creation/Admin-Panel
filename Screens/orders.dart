import 'package:flutter/material.dart';

class OrderManagementPage extends StatefulWidget {
  @override
  _OrderManagementPageState createState() => _OrderManagementPageState();
}

class _OrderManagementPageState extends State<OrderManagementPage> {
  String selectedDateFilter = "Today";
  String selectedCategory = "All";
  bool isAscending = true;

  List<Map<String, dynamic>> orders = [
    {
      "orderId": "#ORD001",
      "customer": "Rahul Sharma",
      "restaurant": "Tandoori Bites",
      "amount": "₹500",
      "status": "Pending",
      "deliveryPartner": "Not Assigned",
      "time": "10:30 AM",
      "category": "Food",
    },
    {
      "orderId": "#ORD002",
      "customer": "Priya Verma",
      "restaurant": "Liquor Point",
      "amount": "₹1,200",
      "status": "Out for Delivery",
      "deliveryPartner": "Amit Kumar",
      "time": "11:00 AM",
      "category": "Liquor",
    },
  ];

  void toggleSorting() {
    setState(() {
      isAscending = !isAscending;
      orders.sort((a, b) =>
      isAscending ? a["time"].compareTo(b["time"]) : b["time"].compareTo(a["time"]));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Row(
          children: [
            Text("Order Management"),
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
          children: [
            // Top Filters
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
                    items: ["Today", "Choose a Date", "This Month", "This Year"]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e, style: TextStyle(color: Colors.white))))
                        .toList(),
                    onChanged: (value) => setState(() => selectedDateFilter = value!),
                  ),
                  SizedBox(width: 20),

                  // Category Filter
                  DropdownButton<String>(
                    dropdownColor: Colors.black,
                    value: selectedCategory,
                    icon: Icon(Icons.filter_list, color: Colors.white),
                    items: ["All", "Food", "Liquor", "Grocery"]
                        .map((e) => DropdownMenuItem(value: e, child: Text(e, style: TextStyle(color: Colors.white))))
                        .toList(),
                    onChanged: (value) => setState(() => selectedCategory = value!),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Summary Statistics
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildSummaryCard("Total Orders", "10,240", Icons.shopping_cart),
                _buildSummaryCard("Total Revenue", "₹1,200,000", Icons.currency_rupee),
                _buildSummaryCard("Restaurants", "340", Icons.restaurant),
                _buildSummaryCard("Delivery Partners", "120", Icons.delivery_dining),
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
                  Expanded(child: Text("Order ID", style: TextStyle(color: Colors.white))),
                  Expanded(child: Text("Customer", style: TextStyle(color: Colors.white))),
                  Expanded(child: Text("Restaurant", style: TextStyle(color: Colors.white))),
                  Expanded(child: Text("Amount", style: TextStyle(color: Colors.white))),
                  Expanded(child: Text("Status", style: TextStyle(color: Colors.white))),
                  Expanded(child: Text("Category", style: TextStyle(color: Colors.white))),
                  Expanded(child: Text("Delivery Partner", style: TextStyle(color: Colors.white))),
                  Expanded(child: Text("Actions", style: TextStyle(color: Colors.white))),
                ],
              ),
            ),

            // Order List
            Expanded(
              child: ListView.builder(
                itemCount: orders.length,
                itemBuilder: (context, index) {
                  var order = orders[index];
                  return Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.white54)),
                      color: index.isEven ? Colors.grey[850] : Colors.grey[800],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(order['orderId'], style: TextStyle(color: Colors.white))),
                        Expanded(child: Text(order['customer'], style: TextStyle(color: Colors.white))),
                        Expanded(child: Text(order['restaurant'], style: TextStyle(color: Colors.white))),
                        Expanded(child: Text(order['amount'], style: TextStyle(color: Colors.white))),
                        Expanded(
                            child: Text(order['status'],
                                style: TextStyle(
                                    color: order['status'] == "Pending"
                                        ? Colors.yellow
                                        : order['status'] == "Delivered"
                                        ? Colors.green
                                        : order['status'] == "Canceled"
                                        ? Colors.red
                                        : Colors.orange))),
                        Expanded(child: Text(order['category'], style: TextStyle(color: Colors.white))),
                        Expanded(child: Text(order['deliveryPartner'], style: TextStyle(color: Colors.white))),

                        // Actions Column
                        Expanded(
                          child: Row(
                            children: [
                              IconButton(
                                  icon: Icon(Icons.visibility, color: Colors.blue),
                                  onPressed: () {}),
                              IconButton(
                                  icon: Icon(Icons.edit, color: Colors.orange),
                                  onPressed: () {}),
                              IconButton(
                                  icon: Icon(Icons.cancel, color: Colors.red),
                                  onPressed: () {}),
                              IconButton(
                                  icon: Icon(Icons.swap_horiz, color: Colors.green),
                                  onPressed: () {}),
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
      width: 160,
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
