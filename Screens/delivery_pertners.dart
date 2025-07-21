import 'package:flutter/material.dart';

class DeliveryPartnersPage extends StatefulWidget {
  @override
  _DeliveryPartnersPageState createState() => _DeliveryPartnersPageState();
}

class _DeliveryPartnersPageState extends State<DeliveryPartnersPage> {
  String selectedStatus = "All";
  double selectedRating = 0;
  DateTimeRange? selectedDateRange;
  TextEditingController searchController = TextEditingController();

  List<Map<String, dynamic>> partners = [
    {
      "id": "#DP001",
      "name": "Ravi Kumar",
      "contact": "9876543210",
      "email": "ravi@example.com",
      "location": "Kolkata, WB",
      "assignedOrders": "5",
      "totalOrders": 120,
      "rating": 4.5,
      "status": "Online",
      "joiningDate": "12 Jan 2023"
    },
    {
      "id": "#DP002",
      "name": "Amit Das",
      "contact": "8765432109",
      "email": "amit@example.com",
      "location": "Delhi, DL",
      "assignedOrders": "3",
      "totalOrders": 95,
      "rating": 4.2,
      "status": "Blocked",
      "joiningDate": "25 Mar 2022"
    },
  ];

  void applyFilters() {
    setState(() {
      // Logic to filter delivery partners based on selected filters
    });
  }

  void showEditModal(Map<String, dynamic> partner) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit Partner - ${partner['name']}"),
        content: Text("Edit Form Here"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(onPressed: () {}, child: Text("Save"))
        ],
      ),
    );
  }

  void showBlockModal(Map<String, dynamic> partner) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Block Partner"),
        content: Text("Are you sure you want to block/unblock ${partner['name']}?"),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: Text("Cancel")),
          ElevatedButton(onPressed: () {}, child: Text("Confirm"))
        ],
      ),
    );
  }

  void showAssignOrdersModal() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Assign Orders"),
        content: Text("Assign orders dropdown will appear here"),
        actions: [ElevatedButton(onPressed: () => Navigator.pop(context), child: Text("Close"))],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Row(
          children: [
            Text("Delivery Partner Management"),
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
            // Search & Filter Panel
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: searchController,
                    decoration: InputDecoration(
                      hintText: "Search by Name, ID, or Contact Number",
                      prefixIcon: Icon(Icons.search),
                      filled: true,
                      fillColor: Colors.white,
                      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                    ),
                  ),
                ),
                SizedBox(width: 10),
                DropdownButton<String>(
                  value: selectedStatus,
                  items: ["All", "Online", "Offline", "Blocked"]
                      .map((status) => DropdownMenuItem(value: status, child: Text(status)))
                      .toList(),
                  onChanged: (value) {
                    setState(() => selectedStatus = value!);
                    applyFilters();
                  },
                ),
                SizedBox(width: 10),
                Slider(
                  value: selectedRating,
                  min: 0,
                  max: 5,
                  divisions: 5,
                  label: selectedRating.toString(),
                  onChanged: (value) {
                    setState(() => selectedRating = value);
                    applyFilters();
                  },
                ),
                SizedBox(width: 10),
                ElevatedButton.icon(
                  icon: Icon(Icons.date_range),
                  label: Text("Pick Date"),
                  onPressed: () async {
                    DateTimeRange? picked = await showDateRangePicker(
                      context: context,
                      firstDate: DateTime(2020),
                      lastDate: DateTime.now(),
                    );
                    if (picked != null) {
                      setState(() => selectedDateRange = picked);
                      applyFilters();
                    }
                  },
                ),
              ],
            ),
            SizedBox(height: 20),

            // Table Header
            Container(
              padding: EdgeInsets.all(8),
              color: Colors.black87,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text("Partner ID", style: TextStyle(color: Colors.white))),
                  Expanded(child: Text("Full Name", style: TextStyle(color: Colors.white))),
                  Expanded(child: Text("Contact Number", style: TextStyle(color: Colors.white))),
                  Expanded(child: Text("Email Address", style: TextStyle(color: Colors.white))),
                  Expanded(child: Text("Location", style: TextStyle(color: Colors.white))),
                  Expanded(child: Text("Assigned Orders", style: TextStyle(color: Colors.white))),
                  Expanded(child: Text("Total Delivered", style: TextStyle(color: Colors.white))),
                  Expanded(child: Text("Rating", style: TextStyle(color: Colors.white))),
                  Expanded(child: Text("Status", style: TextStyle(color: Colors.white))),
                  Expanded(child: Text("Joining Date", style: TextStyle(color: Colors.white))),
                  Expanded(child: Text("Actions", style: TextStyle(color: Colors.white))),
                ],
              ),
            ),

            // Table Rows
            Expanded(
              child: ListView.builder(
                itemCount: partners.length,
                itemBuilder: (context, index) {
                  var partner = partners[index];
                  return Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.white54)),
                      color: index.isEven ? Colors.grey[850] : Colors.grey[800],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(child: Text(partner['id'], style: TextStyle(color: Colors.white))),
                        Expanded(child: Text(partner['name'], style: TextStyle(color: Colors.white))),
                        Expanded(child: Text(partner['contact'], style: TextStyle(color: Colors.white))),
                        Expanded(child: Text(partner['email'], style: TextStyle(color: Colors.white))),
                        Expanded(child: Text(partner['location'], style: TextStyle(color: Colors.white))),
                        Expanded(child: Text(partner['assignedOrders'], style: TextStyle(color: Colors.white))),
                        Expanded(child: Text("${partner['totalOrders']}", style: TextStyle(color: Colors.white))),
                        Expanded(child: Text("${partner['rating']}", style: TextStyle(color: Colors.white))),
                        Expanded(
                          child: Text(
                            partner['status'],
                            style: TextStyle(color: partner['status'] == "Blocked" ? Colors.red : Colors.green),
                          ),
                        ),
                        Expanded(child: Text(partner['joiningDate'], style: TextStyle(color: Colors.white))),
                        Expanded(
                          child: Row(
                            children: [
                              IconButton(icon: Icon(Icons.visibility, color: Colors.blue), onPressed: () {}),
                              IconButton(icon: Icon(Icons.edit, color: Colors.green), onPressed: () => showEditModal(partner)),
                              IconButton(icon: Icon(Icons.block, color: Colors.red), onPressed: () => showBlockModal(partner)),
                              IconButton(icon: Icon(Icons.assignment, color: Colors.orange), onPressed: showAssignOrdersModal),
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
}
