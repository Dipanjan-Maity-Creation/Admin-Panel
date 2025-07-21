import 'package:flutter/material.dart';

class SupportScreen extends StatefulWidget {
  @override
  _SupportFeedbackScreenState createState() => _SupportFeedbackScreenState();
}

class _SupportFeedbackScreenState extends State<SupportScreen> {
  TextEditingController _searchController = TextEditingController();
  String selectedFilter = "All"; // Default filter

  // Sample support tickets & feedback
  List<Map<String, dynamic>> supportTickets = [
    {"id": "#001", "user": "John Doe", "message": "App crashes on order checkout!", "status": "Pending"},
    {"id": "#002", "user": "Alice Smith", "message": "Unable to add payment method.", "status": "Resolved"},
    {"id": "#003", "user": "David Lee", "message": "Delivery was delayed by 2 hours!", "status": "Pending"},
  ];

  List<Map<String, dynamic>> filteredTickets = [];

  @override
  void initState() {
    super.initState();
    filteredTickets = List.from(supportTickets);
  }

  void filterTickets(String query) {
    setState(() {
      filteredTickets = supportTickets.where((ticket) {
        return ticket["user"].toLowerCase().contains(query.toLowerCase()) ||
            ticket["message"].toLowerCase().contains(query.toLowerCase()) ||
            ticket["status"].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void resolveTicket(int index) {
    setState(() {
      supportTickets[index]["status"] = "Resolved";
      filteredTickets = List.from(supportTickets);
    });

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Ticket ${supportTickets[index]["id"]} marked as Resolved!"))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Support & Feedback"),
        backgroundColor: Colors.black87,
        actions: [
          DropdownButton<String>(
            value: selectedFilter,
            dropdownColor: Colors.black,
            icon: Icon(Icons.filter_list, color: Colors.white),
            items: ["All", "Pending", "Resolved"]
                .map((e) => DropdownMenuItem(value: e, child: Text(e, style: TextStyle(color: Colors.white))))
                .toList(),
            onChanged: (filter) {
              setState(() {
                selectedFilter = filter!;
                if (filter == "All") {
                  filteredTickets = List.from(supportTickets);
                } else {
                  filteredTickets = supportTickets.where((ticket) => ticket["status"] == filter).toList();
                }
              });
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
              onChanged: filterTickets,
              decoration: InputDecoration(
                hintText: "Search Tickets...",
                hintStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.black54,
                prefixIcon: Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),

            // Support Ticket List
            Expanded(
              child: ListView.builder(
                itemCount: filteredTickets.length,
                itemBuilder: (context, index) {
                  var ticket = filteredTickets[index];
                  return Card(
                    color: Colors.black87,
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: Icon(Icons.help_outline, color: Colors.blueAccent, size: 30),
                      title: Text(ticket["user"], style: TextStyle(color: Colors.white, fontSize: 18)),
                      subtitle: Text(ticket["message"], style: TextStyle(color: Colors.white70)),
                      trailing: ticket["status"] == "Pending"
                          ? ElevatedButton(
                        style: ElevatedButton.styleFrom(backgroundColor: Colors.greenAccent),
                        onPressed: () => resolveTicket(index),
                        child: Text("Resolve"),
                      )
                          : Text("Resolved", style: TextStyle(color: Colors.greenAccent, fontWeight: FontWeight.bold)),
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
