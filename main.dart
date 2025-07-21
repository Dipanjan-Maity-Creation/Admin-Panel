import 'package:flutter/material.dart';
import 'package:admin_panel_yaammy/Screens/orders.dart';
import 'package:admin_panel_yaammy/Screens/restaurants.dart';
import 'package:admin_panel_yaammy/Screens/delivery_pertners.dart';
import 'package:admin_panel_yaammy/Screens/Analysis.dart';
import 'package:admin_panel_yaammy/Screens/Banners.dart';
import 'package:admin_panel_yaammy/Screens/Categories.dart';
import 'package:admin_panel_yaammy/Screens/Commissions.dart';
import 'package:admin_panel_yaammy/Screens/Cupons.dart';
import 'package:admin_panel_yaammy/Screens/Grocery.dart';
import 'package:admin_panel_yaammy/Screens/Liquor.dart';
import 'package:admin_panel_yaammy/Screens/Payments.dart';
import 'package:admin_panel_yaammy/Screens/Support.dart';
import 'package:admin_panel_yaammy/Screens/users.dart';
import 'package:admin_panel_yaammy/Screens/setting.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

// Placeholder for Order Details Screen
class OrderDetailsScreen extends StatelessWidget {
  final Map<String, dynamic> order;
  const OrderDetailsScreen({required this.order});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Order #${order["id"]}")),
      body: Center(child: Text("Order Details for ${order["id"]} - Coming Soon!")),
    );
  }
}

// Placeholder for missing screens
class PlaceholderScreen extends StatelessWidget {
  final String title;
  const PlaceholderScreen({required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text("$title - Coming Soon!", style: Theme.of(context).textTheme.headlineMedium)),
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: Replace hardcoded Firebase options with environment variables (e.g., using flutter_dotenv)
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: 'AIzaSyA3DAh9FUYe9lrfbKQdpBkolTTtsZDLTu0',
      appId: '1:459719339034:web:2cb83497ac5872f383b5a3',
      messagingSenderId: 'G-ZJVHWM9MRZ',
      projectId: 'yaammy-63136',
    ),
  );

  runApp(AdminPanelApp());
}

class AdminPanelApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Yaammy Admin',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Colors.grey[900],
        cardTheme: CardTheme(
          color: Colors.grey[800],
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.black87,
          elevation: 0,
          titleTextStyle: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 32,
            fontWeight: FontWeight.normal,
            color: Color.fromRGBO(212, 82, 42, 1),
          ),
          iconTheme: IconThemeData(color: Colors.white),
        ),
        textTheme: TextTheme(
          headlineLarge: TextStyle(
            fontFamily: 'Inter',
            fontSize: 17.9,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
          headlineMedium: TextStyle(
            fontFamily: 'Inter',
            fontSize: 16.5,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
          headlineSmall: TextStyle(
            fontFamily: 'Inter',
            fontSize: 12.7,
            fontWeight: FontWeight.normal,
            color: Colors.white70,
          ),
          bodyLarge: TextStyle(
            fontFamily: 'Inter',
            fontSize: 22.3,
            fontWeight: FontWeight.normal,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontFamily: 'Inter',
            fontSize: 13.3,
            fontWeight: FontWeight.normal,
            color: Colors.white70,
          ),
          bodySmall: TextStyle(
            fontFamily: 'Inter',
            fontSize: 11.8,
            fontWeight: FontWeight.normal,
            color: Colors.white70,
          ),
          labelLarge: TextStyle(
            fontFamily: 'Inter',
            fontSize: 14.7,
            fontWeight: FontWeight.normal,
            color: Colors.white70,
          ),
          labelMedium: TextStyle(
            fontFamily: 'Open Sans',
            fontSize: 14,
            fontWeight: FontWeight.normal,
            color: Color.fromRGBO(212, 82, 42, 1),
          ),
        ),
      ),
      home: AdminDashboard(),
    );
  }
}

class AdminDashboard extends StatefulWidget {
  @override
  _AdminDashboardState createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  int _selectedIndex = 0;
  bool _showQuickActions = false; // State to control QuickActionsPanel visibility

  final List<Widget> _pages = [
    DashboardScreen(), // Dashboard
    OrderManagementPage(), // Orders
    RestaurantsScreen(), // Restaurants
    DeliveryPartnersPage(), // Delivery Partners
    UsersScreen(), // User Management
    PaymentsScreen(), // Payments
    SupportScreen(), // Support/Feedback
    SettingsScreen(), // Settings
    AnalysisScreen(), // Analysis
    CategoriesScreen(), // Category
    GroceryScreen(), // Grocery
    LiquorScreen(), // Liquor
    CouponsScreen(), // Coupons
    BannersScreen(), // Banners
    CommissionsScreen(), // Commission
  ];

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Yaammy",
                  semanticsLabel: "Yaammy Admin Title",
                ),
                Text(
                  "Fast and Fresh Delivery",
                  style: Theme.of(context).textTheme.labelMedium,
                  semanticsLabel: "Yaammy Tagline",
                ),
              ],
            ),
            Spacer(),
            Semantics(
              label: "Notifications Button",
              child: IconButton(
                icon: Icon(
                  Icons.notifications,
                  color: _showQuickActions ? Colors.blueAccent : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    _showQuickActions = !_showQuickActions;
                  });
                },
                tooltip: "Notifications",
              ),
            ),
            SizedBox(width: 10),
            Semantics(
              label: "Admin Profile Picture",
              child: CircleAvatar(
                backgroundImage: AssetImage('assets/admin.jpg'),
              ),
            ),
          ],
        ),
      ),
      drawer: isMobile
          ? Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.black87),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Yaammy",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 32,
                      fontWeight: FontWeight.normal,
                      color: Color.fromRGBO(212, 82, 42, 1),
                    ),
                  ),
                  Text(
                    "Fast and Fresh Delivery",
                    style: TextStyle(
                      fontFamily: 'Open Sans',
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Color.fromRGBO(212, 82, 42, 1),
                    ),
                  ),
                ],
              ),
            ),
            ..._buildNavigationItems(),
          ],
        ),
      )
          : null,
      body: Row(
        children: [
          if (!isMobile)
            SingleChildScrollView(
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: MediaQuery.of(context).size.height),
                child: IntrinsicHeight(
                  child: NavigationRail(
                    minWidth: 200,
                    selectedIndex: _selectedIndex,
                    onDestinationSelected: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                    },
                    labelType: NavigationRailLabelType.all,
                    backgroundColor: Colors.black87,
                    selectedIconTheme: IconThemeData(color: Colors.blueAccent),
                    unselectedIconTheme: IconThemeData(color: Colors.white70),
                    selectedLabelTextStyle: TextStyle(
                      fontFamily: 'Inter',
                      color: Colors.blueAccent,
                      fontSize: 14.7,
                    ),
                    unselectedLabelTextStyle: TextStyle(
                      fontFamily: 'Inter',
                      color: Colors.white70,
                      fontSize: 14.7,
                    ),
                    destinations: [
                      NavigationRailDestination(
                        icon: Icon(Icons.dashboard),
                        label: Text('Dashboard'),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.shopping_cart),
                        label: Text('Orders'),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.restaurant),
                        label: Text('Restaurants'),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.delivery_dining),
                        label: Text('Delivery Partner'),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.people),
                        label: Text('Users'),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.payment),
                        label: Text('Payments'),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.support),
                        label: Text('Support/Feedback'),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.settings),
                        label: Text('Settings'),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.analytics),
                        label: Text('Analysis'),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.category),
                        label: Text('Category'),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.local_grocery_store),
                        label: Text('Grocery'),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.local_bar),
                        label: Text('Liquor'),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.card_giftcard),
                        label: Text('Coupons'),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.image),
                        label: Text('Banners'),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      ),
                      NavigationRailDestination(
                        icon: Icon(Icons.monetization_on),
                        label: Text('Commission'),
                        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          Expanded(child: _pages[_selectedIndex]),
          if (!isMobile && _showQuickActions) QuickActionsPanel(),
        ],
      ),
      bottomNavigationBar: isMobile
          ? Container(
        color: Colors.black87,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildBottomNavItem(Icons.dashboard, 'Dashboard', 0),
              _buildBottomNavItem(Icons.shopping_cart, 'Orders', 1),
              _buildBottomNavItem(Icons.restaurant, 'Restaurants', 2),
              _buildBottomNavItem(Icons.delivery_dining, 'Delivery', 3),
              _buildBottomNavItem(Icons.people, 'Users', 4),
              _buildBottomNavItem(Icons.payment, 'Payments', 5),
              _buildBottomNavItem(Icons.support, 'Support', 6),
              _buildBottomNavItem(Icons.settings, 'Settings', 7),
              _buildBottomNavItem(Icons.analytics, 'Analysis', 8),
              _buildBottomNavItem(Icons.category, 'Category', 9),
              _buildBottomNavItem(Icons.local_grocery_store, 'Grocery', 10),
              _buildBottomNavItem(Icons.local_bar, 'Liquor', 11),
              _buildBottomNavItem(Icons.card_giftcard, 'Coupons', 12),
              _buildBottomNavItem(Icons.image, 'Banners', 13),
              _buildBottomNavItem(Icons.monetization_on, 'Commission', 14),
            ],
          ),
        ),
      )
          : BottomAppBar(
        color: Colors.black87,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "System Status: Online",
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.green,
                  fontSize: 16,
                ),
                semanticsLabel: "System Status Online",
              ),
              Text(
                "Last Sync: 02:19 PM, May 18, 2025",
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.white,
                  fontSize: 16,
                ),
                semanticsLabel: "Last Sync at 02:19 PM, May 18, 2025",
              ),
              Text(
                "Admins Online: 3",
                style: TextStyle(
                  fontFamily: 'Inter',
                  color: Colors.blueAccent,
                  fontSize: 16,
                ),
                semanticsLabel: "Admins Online: 3",
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBottomNavItem(IconData icon, String label, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
        child: Row(
          children: [
            Icon(
              icon,
              color: _selectedIndex == index ? Colors.blueAccent : Colors.white70,
              size: 24,
            ),
            SizedBox(width: 8),
            Text(
              label,
              style: TextStyle(
                fontFamily: 'Inter',
                fontSize: 12,
                color: _selectedIndex == index ? Colors.blueAccent : Colors.white70,
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildNavigationItems() {
    final List<Map<String, dynamic>> items = [
      {"icon": Icons.dashboard, "label": "Dashboard", "index": 0},
      {"icon": Icons.shopping_cart, "label": "Orders", "index": 1},
      {"icon": Icons.restaurant, "label": "Restaurants", "index": 2},
      {"icon": Icons.delivery_dining, "label": "Delivery Partner", "index": 3},
      {"icon": Icons.people, "label": "Users", "index": 4},
      {"icon": Icons.payment, "label": "Payments", "index": 5},
      {"icon": Icons.support, "label": "Support/Feedback", "index": 6},
      {"icon": Icons.settings, "label": "Settings", "index": 7},
      {"icon": Icons.analytics, "label": "Analysis", "index": 8},
      {"icon": Icons.category, "label": "Category", "index": 9},
      {"icon": Icons.local_grocery_store, "label": "Grocery", "index": 10},
      {"icon": Icons.local_bar, "label": "Liquor", "index": 11},
      {"icon": Icons.card_giftcard, "label": "Coupons", "index": 12},
      {"icon": Icons.image, "label": "Banners", "index": 13},
      {"icon": Icons.monetization_on, "label": "Commission", "index": 14},
    ];

    return items.map((item) {
      return ListTile(
        leading: Icon(
          item["icon"],
          color: _selectedIndex == item["index"] ? Colors.blueAccent : Colors.white70,
        ),
        title: Text(
          item["label"],
          style: TextStyle(
            fontFamily: 'Inter',
            color: _selectedIndex == item["index"] ? Colors.blueAccent : Colors.white70,
            fontSize: 14.7,
          ),
        ),
        onTap: () {
          setState(() {
            _selectedIndex = item["index"];
          });
          Navigator.pop(context);
        },
      );
    }).toList();
  }
}

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  _DashboardScreenState createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  String _searchQuery = "";
  String _selectedFilter = "Today";

  List<Map<String, dynamic>> _orders = [
    {"id": "#12345", "customer": "Sarah Johnson", "restaurant": "Pizza Palace", "amount": "\$35.99", "status": "Delivered"},
    {"id": "#12344", "customer": "Mike Smith", "restaurant": "Burger King", "amount": "\$24.50", "status": "In Progress"},
    {"id": "#12343", "customer": "Emily Brown", "restaurant": "Sushi Express", "amount": "\$52.75", "status": "Cancelled"},
  ];

  List<Map<String, dynamic>> _metrics = [
    {"title": "1,234", "subtitle": "Total Orders", "details": "New: 45\nPending: 89\nComplete: 1,100", "trend": "8.2% vs last week"},
    {"title": "\$45,678", "subtitle": "Total Revenue", "details": "", "trend": "12.5% vs last week"},
    {"title": "89", "subtitle": "Active Restaurants", "details": "", "trend": "4.3% vs last week"},
    {"title": "156", "subtitle": "Active Drivers", "details": "", "trend": "6.8% vs last week"},
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    // TODO: Replace with actual Firestore integration
    // var ordersSnapshot = await FirebaseFirestore.instance.collection("orders").get();
    // var metricsSnapshot = await FirebaseFirestore.instance.collection("metrics").get();
    // setState(() {
    //   _orders = ordersSnapshot.docs.map((doc) => doc.data()).toList();
    //   _metrics = metricsSnapshot.docs.map((doc) => doc.data()).toList();
    // });
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = MediaQuery.of(context).size.width < 600;
    return Container(
      alignment: Alignment.topCenter,
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: isMobile ? 12 : 16, vertical: isMobile ? 12 : 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Dashboard",
                style: Theme.of(context).textTheme.headlineLarge,
                semanticsLabel: "Dashboard Title",
              ),
              SizedBox(height: isMobile ? 8 : 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  _buildFilterButton("Today", isMobile),
                  _buildFilterButton("Yesterday", isMobile),
                  _buildFilterButton("Weekly", isMobile),
                  _buildFilterButton("Monthly", isMobile),
                  _buildFilterButton("Yearly", isMobile),
                  _buildFilterButton("Date Choose", isMobile),
                ],
              ),
              SizedBox(height: isMobile ? 12 : 16),
              // Stat Cards
              Wrap(
                spacing: isMobile ? 12 : 16,
                runSpacing: isMobile ? 12 : 16,
                children: [
                  _buildStatCard(
                    title: _metrics[0]["title"],
                    subtitle: _metrics[0]["subtitle"],
                    details: _metrics[0]["details"],
                    trend: _metrics[0]["trend"],
                    width: isMobile ? double.infinity : 268,
                  ),
                  _buildStatCard(
                    title: _metrics[1]["title"],
                    subtitle: _metrics[1]["subtitle"],
                    details: _metrics[1]["details"],
                    trend: _metrics[1]["trend"],
                    width: isMobile ? double.infinity : 268,
                  ),
                  _buildStatCard(
                    title: _metrics[2]["title"],
                    subtitle: _metrics[2]["subtitle"],
                    details: _metrics[2]["details"],
                    trend: _metrics[2]["trend"],
                    width: isMobile ? double.infinity : 268,
                  ),
                  _buildStatCard(
                    title: _metrics[3]["title"],
                    subtitle: _metrics[3]["subtitle"],
                    details: _metrics[3]["details"],
                    trend: _metrics[3]["trend"],
                    width: isMobile ? double.infinity : 268,
                  ),
                ],
              ),
              SizedBox(height: isMobile ? 16 : 24),
              Divider(color: Colors.grey),
              SizedBox(height: isMobile ? 12 : 16),
              // Orders Overview and Revenue Overview in a single row
              isMobile
                  ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Orders Overview",
                    style: Theme.of(context).textTheme.headlineMedium,
                    semanticsLabel: "Orders Overview Subsection",
                  ),
                  SizedBox(height: isMobile ? 12 : 16),
                  _buildOrdersChart(isMobile),
                  SizedBox(height: isMobile ? 16 : 24),
                  Text(
                    "Revenue Overview",
                    style: Theme.of(context).textTheme.headlineMedium,
                    semanticsLabel: "Revenue Overview Section",
                  ),
                  SizedBox(height: isMobile ? 12 : 16),
                  _buildRevenueChart(isMobile),
                ],
              )
                  : Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Orders Overview",
                          style: Theme.of(context).textTheme.headlineMedium,
                          semanticsLabel: "Orders Overview Subsection",
                        ),
                        SizedBox(height: 16),
                        _buildOrdersChart(isMobile),
                      ],
                    ),
                  ),
                  SizedBox(width: 24),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Revenue Overview",
                          style: Theme.of(context).textTheme.headlineMedium,
                          semanticsLabel: "Revenue Overview Section",
                        ),
                        SizedBox(height: 16),
                        _buildRevenueChart(isMobile),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: isMobile ? 16 : 24),
              Divider(color: Colors.grey),
              SizedBox(height: isMobile ? 12 : 16),
              // Recent Orders
              Text(
                "Recent Orders",
                style: Theme.of(context).textTheme.headlineMedium,
                semanticsLabel: "Recent Orders Subsection",
              ),
              SizedBox(height: isMobile ? 12 : 16),
              Container(
                decoration: BoxDecoration(
                  color: Colors.grey[800],
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              style: Theme.of(context).textTheme.bodyMedium,
                              decoration: InputDecoration(
                                hintText: "Search orders...",
                                hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(8),
                                  borderSide: BorderSide(color: Colors.grey),
                                ),
                                contentPadding: EdgeInsets.symmetric(horizontal: 16),
                                filled: true,
                                fillColor: Colors.grey[700],
                              ),
                              onChanged: (value) {
                                setState(() {
                                  _searchQuery = value.toLowerCase();
                                });
                              },
                            ),
                          ),
                          SizedBox(width: 8),
                          Container(
                            width: 96,
                            height: 42,
                            decoration: BoxDecoration(
                              color: Colors.grey[700],
                              borderRadius: BorderRadius.circular(8.75),
                              border: Border.all(color: Colors.grey),
                            ),
                            child: Center(
                              child: Text(
                                "Filter",
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(height: 1, color: Colors.grey),
                    _buildOrderTable(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildFilterButton(String label, bool isMobile) {
    bool isSelected = _selectedFilter == label;
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedFilter = label;
        });
      },
      child: Container(
        width: isMobile ? 90 : label == "Date Choose" ? 106 : label == "Yesterday" ? 96 : label == "Weekly" ? 79 : label == "Monthly" ? 85 : label == "Yearly" ? 73 : 70,
        height: 39,
        decoration: BoxDecoration(
          color: isSelected ? Colors.black : Colors.grey[700],
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
          child: Text(
            label,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: Colors.white70),
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required String title,
    required String subtitle,
    required String details,
    required String trend,
    double width = 268,
  }) {
    return SizedBox(
      width: width,
      height: 180, // Fixed height for all stat cards
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.grey[800],
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  subtitle,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                SizedBox(height: 8),
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                if (details.isNotEmpty) ...[
                  SizedBox(height: 8),
                  Text(
                    details,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ],
            ),
            Row(
              children: [
                Icon(Icons.arrow_upward, size: 12, color: Colors.green),
                SizedBox(width: 4),
                Text(
                  trend,
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 12.7,
                    color: Colors.green,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrdersChart(bool isMobile) {
    // Sample data: orders per day (Mon-Sun)
    final List<FlSpot> orderSpots = [
      FlSpot(0, 150), // Mon
      FlSpot(1, 200), // Tue
      FlSpot(2, 180), // Wed
      FlSpot(3, 220), // Thu
      FlSpot(4, 250), // Fri
      FlSpot(5, 270), // Sat
      FlSpot(6, 230), // Sun
    ];

    return Container(
      height: 417,
      width: isMobile ? double.infinity : 559,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(16),
      child: LineChart(
        LineChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 50,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(0.3),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 40,
                interval: 50,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return Text('0', style: TextStyle(color: Colors.white70, fontSize: 10));
                    case 50:
                      return Text('50', style: TextStyle(color: Colors.white70, fontSize: 10));
                    case 100:
                      return Text('100', style: TextStyle(color: Colors.white70, fontSize: 10));
                    case 150:
                      return Text('150', style: TextStyle(color: Colors.white70, fontSize: 10));
                    case 200:
                      return Text('200', style: TextStyle(color: Colors.white70, fontSize: 10));
                    case 250:
                      return Text('250', style: TextStyle(color: Colors.white70, fontSize: 10));
                    case 300:
                      return Text('300', style: TextStyle(color: Colors.white70, fontSize: 10));
                  }
                  return Text('');
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return Text('Mon', style: TextStyle(color: Colors.white70, fontSize: 11.8));
                    case 1:
                      return Text('Tue', style: TextStyle(color: Colors.white70, fontSize: 11.8));
                    case 2:
                      return Text('Wed', style: TextStyle(color: Colors.white70, fontSize: 11.8));
                    case 3:
                      return Text('Thu', style: TextStyle(color: Colors.white70, fontSize: 11.8));
                    case 4:
                      return Text('Fri', style: TextStyle(color: Colors.white70, fontSize: 11.8));
                    case 5:
                      return Text('Sat', style: TextStyle(color: Colors.white70, fontSize: 11.8));
                    case 6:
                      return Text('Sun', style: TextStyle(color: Colors.white70, fontSize: 11.8));
                  }
                  return Text('');
                },
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          minX: 0,
          maxX: 6,
          minY: 0,
          maxY: 300,
          lineBarsData: [
            LineChartBarData(
              spots: orderSpots,
              isCurved: true,
              color: Colors.blueAccent,
              barWidth: 3,
              belowBarData: BarAreaData(
                show: true,
                color: Colors.blueAccent.withOpacity(0.2),
              ),
              dotData: FlDotData(show: false),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRevenueChart(bool isMobile) {
    // Sample data: revenue per day (Mon-Sun)
    final List<double> revenueValues = [
      4000, // Mon
      4500, // Tue
      4200, // Wed
      5000, // Thu
      5500, // Fri
      6000, // Sat
      5200, // Sun
    ];

    return Container(
      height: 415,
      width: isMobile ? double.infinity : 557,
      decoration: BoxDecoration(
        color: Colors.grey[800],
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(8),
      ),
      padding: EdgeInsets.all(16),
      child: BarChart(
        BarChartData(
          gridData: FlGridData(
            show: true,
            drawVerticalLine: false,
            horizontalInterval: 1000,
            getDrawingHorizontalLine: (value) {
              return FlLine(
                color: Colors.grey.withOpacity(0.3),
                strokeWidth: 1,
              );
            },
          ),
          titlesData: FlTitlesData(
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                reservedSize: 50,
                interval: 1000,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return Text('0', style: TextStyle(color: Colors.white70, fontSize: 11.9));
                    case 1000:
                      return Text('1,000', style: TextStyle(color: Colors.white70, fontSize: 10.6));
                    case 2000:
                      return Text('2,000', style: TextStyle(color: Colors.white70, fontSize: 10.2));
                    case 3000:
                      return Text('3,000', style: TextStyle(color: Colors.white70, fontSize: 10.2));
                    case 4000:
                      return Text('4,000', style: TextStyle(color: Colors.white70, fontSize: 10.2));
                    case 5000:
                      return Text('5,000', style: TextStyle(color: Colors.white70, fontSize: 10.2));
                    case 6000:
                      return Text('6,000', style: TextStyle(color: Colors.white70, fontSize: 10.2));
                    case 7000:
                      return Text('7,000', style: TextStyle(color: Colors.white70, fontSize: 10.6));
                  }
                  return Text('');
                },
              ),
            ),
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 1,
                getTitlesWidget: (value, meta) {
                  switch (value.toInt()) {
                    case 0:
                      return Text('Mon', style: TextStyle(color: Colors.white70, fontSize: 11.6));
                    case 1:
                      return Text('Tue', style: TextStyle(color: Colors.white70, fontSize: 11.6));
                    case 2:
                      return Text('Wed', style: TextStyle(color: Colors.white70, fontSize: 11.1));
                    case 3:
                      return Text('Thu', style: TextStyle(color: Colors.white70, fontSize: 11.5));
                    case 4:
                      return Text('Fri', style: TextStyle(color: Colors.white70, fontSize: 11.2));
                    case 5:
                      return Text('Sat', style: TextStyle(color: Colors.white70, fontSize: 10.9));
                    case 6:
                      return Text('Sun', style: TextStyle(color: Colors.white70, fontSize: 10.9));
                  }
                  return Text('');
                },
              ),
            ),
            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          borderData: FlBorderData(show: false),
          minY: 0,
          maxY: 7000,
          barGroups: List.generate(revenueValues.length, (index) {
            return BarChartGroupData(
              x: index,
              barRods: [
                BarChartRodData(
                  toY: revenueValues[index],
                  color: Colors.greenAccent,
                  width: 16,
                  borderRadius: BorderRadius.circular(4),
                ),
              ],
            );
          }),
        ),
      ),
    );
  }

  Widget _buildOrderTable() {
    return Table(
      columnWidths: const {
        0: FlexColumnWidth(1.5),
        1: FlexColumnWidth(2),
        2: FlexColumnWidth(2),
        3: FlexColumnWidth(1.5),
        4: FlexColumnWidth(2),
      },
      children: [
        TableRow(
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
          ),
          children: [
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Order ID',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white70),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Customer',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white70),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Restaurant',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white70),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Amount',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white70),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Status',
                style: Theme.of(context).textTheme.headlineSmall?.copyWith(color: Colors.white70),
              ),
            ),
          ],
        ),
        ..._orders
            .where((order) =>
        _searchQuery.isEmpty ||
            order["id"].toLowerCase().contains(_searchQuery) ||
            order["customer"].toLowerCase().contains(_searchQuery) ||
            order["restaurant"].toLowerCase().contains(_searchQuery))
            .map((order) => _buildOrderRow(
          order["id"],
          order["customer"],
          order["restaurant"],
          order["amount"],
          order["status"],
        ))
            .toList(),
      ],
    );
  }

  TableRow _buildOrderRow(String id, String customer, String restaurant, String amount, String status) {
    Color statusColor = Colors.grey;
    Color statusBgColor = Colors.grey[700]!;
    if (status == 'Delivered') {
      statusColor = Color.fromRGBO(102, 162, 125, 1);
      statusBgColor = Colors.green.withOpacity(0.2);
    } else if (status == 'In Progress') {
      statusColor = Color.fromRGBO(179, 143, 83, 1);
      statusBgColor = Colors.orange.withOpacity(0.2);
    } else if (status == 'Cancelled') {
      statusColor = Color.fromRGBO(188, 95, 95, 1);
      statusBgColor = Colors.red.withOpacity(0.2);
    }

    return TableRow(
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey.shade300)),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(id, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(customer, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(restaurant, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Text(amount, style: Theme.of(context).textTheme.bodyMedium),
        ),
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            decoration: BoxDecoration(
              color: statusBgColor,
              borderRadius: BorderRadius.circular(9),
            ),
            child: Text(
              status,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: statusColor),
            ),
          ),
        ),
      ],
    );
  }
}

class QuickActionsPanel extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 250,
      color: Colors.black26,
      child: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("notifications").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Error loading notifications", style: TextStyle(color: Colors.white)));
          }
          var notifications = snapshot.data?.docs ?? [];
          return ListView(
            padding: EdgeInsets.all(16),
            children: [
              Text(
                "Quick Actions",
                style: Theme.of(context).textTheme.headlineLarge,
                semanticsLabel: "Quick Actions Section",
              ),
              SizedBox(height: 10),
              ExpansionTile(
                title: Text(
                  "Pending Approvals",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                children: [
                  ListTile(
                    title: Text(
                      "New Restaurant Approval",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    onTap: () {
                      // TODO: Navigate to RestaurantsScreen for approval
                    },
                  ),
                  ListTile(
                    title: Text(
                      "Driver Verification",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    onTap: () {
                      // TODO: Navigate to DeliveryPartnersPage for verification
                    },
                  ),
                ],
              ),
              ExpansionTile(
                title: Text(
                  "Recent Notifications",
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                children: notifications.isEmpty
                    ? [
                  ListTile(
                    title: Text(
                      "No notifications",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                ]
                    : notifications.map((doc) {
                  return ListTile(
                    title: Text(
                      doc["message"] ?? "Notification",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                    onTap: () {
                      // TODO: Handle notification action
                    },
                  );
                }).toList(),
              ),
            ],
          );
        },
      ),
    );
  }
}