import 'package:flutter/material.dart';

class CouponsScreen extends StatefulWidget {
  @override
  _CouponsManagementScreenState createState() => _CouponsManagementScreenState();
}

class _CouponsManagementScreenState extends State<CouponsScreen> {
  TextEditingController _searchController = TextEditingController();

  // Sample coupons data
  List<Map<String, dynamic>> coupons = [
    {"code": "SAVE20", "discount": "20%", "expiry": "2025-03-01", "status": "Active"},
    {"code": "WELCOME50", "discount": "50%", "expiry": "2025-02-28", "status": "Active"},
    {"code": "FREESHIP", "discount": "Free Shipping", "expiry": "2025-04-15", "status": "Inactive"},
    {"code": "SUMMER10", "discount": "10%", "expiry": "2025-06-30", "status": "Active"},
  ];

  List<Map<String, dynamic>> filteredCoupons = [];

  @override
  void initState() {
    super.initState();
    filteredCoupons = List.from(coupons);
  }

  void filterCoupons(String query) {
    setState(() {
      filteredCoupons = coupons.where((coupon) {
        return coupon["code"].toLowerCase().contains(query.toLowerCase()) ||
            coupon["discount"].toLowerCase().contains(query.toLowerCase()) ||
            coupon["status"].toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  void generateNewCoupon() {
    // Logic for adding a new coupon (e.g., open a form dialog)
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Coupon generation feature coming soon!"))
    );
  }

  void editCoupon(String code) {
    // Logic for editing the coupon
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Edit coupon $code coming soon!"))
    );
  }

  void deleteCoupon(String code) {
    setState(() {
      coupons.removeWhere((coupon) => coupon["code"] == code);
      filteredCoupons = List.from(coupons);
    });

    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Coupon $code deleted!"))
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Coupon Management"),
        backgroundColor: Colors.black87,
        actions: [
          IconButton(icon: Icon(Icons.add), onPressed: generateNewCoupon), // Generate new coupon
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
              onChanged: filterCoupons,
              decoration: InputDecoration(
                hintText: "Search Coupons...",
                hintStyle: TextStyle(color: Colors.white70),
                filled: true,
                fillColor: Colors.black54,
                prefixIcon: Icon(Icons.search, color: Colors.white),
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
              ),
              style: TextStyle(color: Colors.white),
            ),
            SizedBox(height: 20),

            // Coupons List
            Expanded(
              child: ListView.builder(
                itemCount: filteredCoupons.length,
                itemBuilder: (context, index) {
                  var coupon = filteredCoupons[index];
                  return Card(
                    color: Colors.black87,
                    elevation: 5,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    child: ListTile(
                      leading: Icon(Icons.card_giftcard, color: Colors.blueAccent, size: 30),
                      title: Text(coupon["code"], style: TextStyle(color: Colors.white, fontSize: 18)),
                      subtitle: Text("Discount: ${coupon["discount"]} | Expiry: ${coupon["expiry"]}",
                          style: TextStyle(color: Colors.white70)),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.edit, color: Colors.blueAccent),
                            onPressed: () => editCoupon(coupon["code"]),
                          ),
                          IconButton(
                            icon: Icon(Icons.delete, color: Colors.redAccent),
                            onPressed: () => deleteCoupon(coupon["code"]),
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
