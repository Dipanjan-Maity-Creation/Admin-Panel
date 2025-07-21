import 'package:flutter/material.dart';

class PaymentsScreen extends StatefulWidget {
  @override
  _PaymentsManagementScreenState createState() => _PaymentsManagementScreenState();
}

class _PaymentsManagementScreenState extends State<PaymentsScreen> {
  TextEditingController _searchController = TextEditingController();

  // Sample payment data
  List<Map<String, dynamic>> payments = [
    {"id": "TXN001", "user": "Amit Sharma", "amount": "₹1200", "date": "2025-02-15", "status": "Successful"},
    {"id": "TXN002", "user": "Neha Gupta", "amount": "₹800", "date": "2025-02-14", "status": "Pending"},
    {"id": "TXN003", "user": "Rahul Mehta", "amount": "₹1500", "date": "2025-02-13", "status": "Failed"},
    {"id": "TXN004", "user": "Priya Singh", "amount": "₹600", "date": "2025-02-12", "status": "Successful"},
    {"id": "TXN005", "user": "Rohan Verma", "amount": "₹2500", "date": "2025-02-11", "status": "Successful"},
  ];

  List<Map<String, dynamic>> filteredPayments = [];

  @override
  void initState() {
    super.initState();
    filteredPayments = List.from(payments);
  }

  void filterPayments(String query) {
    setState(() {
      filteredPayments = payments.where((payment) {
        return payment["user"].toLowerCase().contains(query.toLowerCase()) ||
            payment["id"].toLowerCase().contains(query.toLowerCase()) ||
            payment["status"].toLowerCase().contains(query.toLowerCase());
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
                    filteredPayments = List.from(payments);
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Successful Payments"),
                onTap: () {
                  setState(() {
                    filteredPayments = payments.where((p) => p["status"] == "Successful").toList();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Pending Payments"),
                onTap: () {
                  setState(() {
                    filteredPayments = payments.where((p) => p["status"] == "Pending").toList();
                  });
                  Navigator.pop(context);
                },
              ),
              ListTile(
                title: Text("Failed Payments"),
                onTap: () {
                  setState(() {
                    filteredPayments = payments.where((p) => p["status"] == "Failed").toList();
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

  void exportPayments() {
    // Logic to export payment data (CSV or PDF generation)
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Export feature coming soon!"))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900], // Dark theme
      appBar: AppBar(
        title: Text("Payments Management"),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(icon: Icon(Icons.filter_list), onPressed: showFilterOptions),
          SizedBox(width: 10),
          ElevatedButton.icon(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
            icon: Icon(Icons.file_download, color: Colors.black),
            label: Text("Export", style: TextStyle(color: Colors.black)),
            onPressed: exportPayments,
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
              onChanged: filterPayments,
              decoration: InputDecoration(
                hintText: "Search Transactions...",
                hintStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.black54,
                prefixIcon: Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),

            // Payment Transactions List
            Expanded(
              child: ListView.builder(
                itemCount: filteredPayments.length,
                itemBuilder: (context, index) {
                  var payment = filteredPayments[index];
                  return Card(
                    color: Colors.black87,
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: CircleAvatar(
                        backgroundColor: payment["status"] == "Successful" ? Colors.green : (payment["status"] == "Pending" ? Colors.orange : Colors.red),
                        child: Icon(Icons.payment, color: Colors.white),
                      ),
                      title: Text(payment["user"], style: TextStyle(color: Colors.white, fontSize: 18)),
                      subtitle: Text("Transaction ID: ${payment["id"]} | Amount: ${payment["amount"]} | Date: ${payment["date"]}",
                          style: TextStyle(color: Colors.white70)),
                      trailing: Chip(
                        label: Text(payment["status"],
                            style: TextStyle(color: payment["status"] == "Successful" ? Colors.green : (payment["status"] == "Pending" ? Colors.orange : Colors.red))),
                        backgroundColor: Colors.black54,
                      ),
                      onTap: () {
                        // Navigate to Transaction Details Page
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
