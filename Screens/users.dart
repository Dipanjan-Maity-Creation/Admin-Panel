import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(home: UsersScreen()));
}

class UsersScreen extends StatefulWidget {
  @override
  _UsersScreenState createState() => _UsersScreenState();
}

class _UsersScreenState extends State<UsersScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> users = [];
  List<Map<String, dynamic>> filteredUsers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchUsers();
  }

  /// 🔥 Fetch users in real-time from Firestore (including location)
  void fetchUsers() {
    setState(() {
      isLoading = true;
    });

    _firestore.collection("users").orderBy("createdAt", descending: true).snapshots().listen((snapshot) {
      if (snapshot.docs.isEmpty) {
        print("⚠️ No users found in Firestore.");
      } else {
        List<Map<String, dynamic>> userList = snapshot.docs.map((doc) {
          var data = doc.data();
          var locationData = data["location"] ?? {}; // 🌍 Get location map

          return {
            "id": doc.id,
            "name": data["name"] ?? "Unknown",
            "email": data["email"] ?? "No Email",
            "contact": data["contact"] ?? "No Contact",
            "status": data["status"] ?? "Pending",
            "orders": data["orders"] ?? 0,
            "createdAt": data["createdAt"] ?? Timestamp.now(),
            "photoURL": data["photoURL"] ?? "",
            "location": locationData.isNotEmpty
                ? "${locationData["address"]} (Lat: ${locationData["latitude"]}, Lng: ${locationData["longitude"]})"
                : "Location Not Available", // 🗺️ Format location
          };
        }).toList();

        setState(() {
          users = userList;
          filteredUsers = List.from(users);
          isLoading = false;
        });
        print("✅ Users fetched successfully: ${users.length}");
      }
    }, onError: (error) {
      setState(() {
        isLoading = false;
      });
      print("🔥 Firestore Fetch Error: $error");
    });
  }

  /// 🚨 Delete user from Firestore
  void deleteUser(String userId) async {
    bool confirmDelete = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Delete User?"),
          content: Text("Are you sure you want to delete this user? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: Text("Delete", style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );

    if (confirmDelete == true) {
      try {
        await _firestore.collection("users").doc(userId).delete();
        fetchUsers(); // Refresh the list
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("User deleted successfully.")));
      } catch (error) {
        print("❌ Error deleting user: $error");
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error deleting user.")));
      }
    }
  }

  /// 📅 Format Firestore Timestamp to readable Date
  String formatTimestamp(Timestamp timestamp) {
    DateTime date = timestamp.toDate();
    return "${date.day}/${date.month}/${date.year}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Users Management"),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(icon: Icon(Icons.refresh), onPressed: fetchUsers),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // 🔎 Search Bar
            TextField(
              controller: _searchController,
              onChanged: (query) {
                setState(() {
                  filteredUsers = users.where((user) {
                    return user["name"].toLowerCase().contains(query.toLowerCase()) ||
                        user["email"].toLowerCase().contains(query.toLowerCase()) ||
                        user["contact"].contains(query);
                  }).toList();
                });
              },
              decoration: InputDecoration(
                hintText: "Search Users...",
                hintStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.black54,
                prefixIcon: Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),

            // 👥 Users List
            Expanded(
              child: isLoading
                  ? Center(child: CircularProgressIndicator(color: Colors.orange))
                  : filteredUsers.isEmpty
                  ? Center(child: Text("No users found", style: TextStyle(color: Colors.white)))
                  : SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: DataTable(
                  columns: [
                    DataColumn(label: Text('Name', style: TextStyle(color: Colors.yellow))),
                    DataColumn(label: Text('Email Id', style: TextStyle(color: Colors.yellow))),
                    DataColumn(label: Text('Contact No', style: TextStyle(color: Colors.yellow))),
                    DataColumn(label: Text('Join Date', style: TextStyle(color: Colors.yellow))),
                    DataColumn(label: Text('Orders', style: TextStyle(color: Colors.yellow))),
                    DataColumn(label: Text('Location', style: TextStyle(color: Colors.yellow))), // 🌍 Show Location
                    DataColumn(label: Text('Actions', style: TextStyle(color: Colors.red))), // 🗑️ Delete Button
                  ],
                  rows: filteredUsers.map((user) {
                    return DataRow(cells: [
                      DataCell(Text(user["name"], style: TextStyle(color: Colors.white))),
                      DataCell(Text(user["email"], style: TextStyle(color: Colors.white))),
                      DataCell(Text(user["contact"], style: TextStyle(color: Colors.white))),
                      DataCell(Text(formatTimestamp(user["createdAt"]), style: TextStyle(color: Colors.white))),
                      DataCell(Text(user["orders"].toString(), style: TextStyle(color: Colors.white))),
                      DataCell(Text(user["location"], style: TextStyle(color: Colors.white))), // 🌍 Show full address
                      DataCell(
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => deleteUser(user["id"]), // 🚨 Delete User
                        ),
                      ),
                    ]);
                  }).toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
