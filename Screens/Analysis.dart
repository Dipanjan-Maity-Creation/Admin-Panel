import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

class AnalysisScreen extends StatefulWidget {
  @override
  _AnalysisScreenState createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends State<AnalysisScreen> {
  String selectedFilter = "Monthly"; // Default filter option

  // Sample data
  final List<Map<String, dynamic>> metrics = [
    {"title": "Total Sales", "value": "\$1,200,000", "icon": Icons.attach_money},
    {"title": "Active Users", "value": "8,450", "icon": Icons.people},
    {"title": "New Orders", "value": "3,290", "icon": Icons.shopping_cart},
    {"title": "Revenue", "value": "\$345,600", "icon": Icons.monetization_on},
  ];

  void onFilterChanged(String filter) {
    setState(() {
      selectedFilter = filter;
    });
    // Fetch new data based on filter selection
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Business Analysis"),
        backgroundColor: Colors.black87,
        actions: [
          DropdownButton<String>(
            value: selectedFilter,
            dropdownColor: Colors.black,
            icon: Icon(Icons.filter_list, color: Colors.white),
            items: ["Today", "Weekly", "Monthly", "Yearly"]
                .map((e) => DropdownMenuItem(value: e, child: Text(e, style: TextStyle(color: Colors.white))))
                .toList(),
            onChanged: (String? newValue) {  // Fix: Allow nullable values
              if (newValue != null) {
                onFilterChanged(newValue);  // Call function only if not null
              }
            },
          ),

          SizedBox(width: 20),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Business Metrics Overview
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2, // 2 columns
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 3.5, // Adjust card size
              ),
              itemCount: metrics.length,
              itemBuilder: (context, index) {
                var item = metrics[index];
                return Card(
                  color: Colors.black87,
                  elevation: 5,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: Icon(item["icon"], color: Colors.blueAccent, size: 30),
                    title: Text(item["title"], style: TextStyle(color: Colors.white, fontSize: 16)),
                    subtitle: Text(item["value"], style: TextStyle(color: Colors.white70, fontSize: 20)),
                  ),
                );
              },
            ),
            SizedBox(height: 20),

            // Sales Trend Chart
            Text("Sales Trends", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Container(
              height: 200,
              padding: EdgeInsets.all(8),
              decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(10)),
              child: LineChart(
                LineChartData(
                  gridData: FlGridData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          List<String> labels = ["Jan", "Feb", "Mar", "Apr", "May"];
                          return Padding(
                            padding: EdgeInsets.only(top: 8),
                            child: Text(labels[value.toInt()], style: TextStyle(color: Colors.white70)),
                          );
                        },
                        reservedSize: 22,
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: [FlSpot(0, 5), FlSpot(1, 7), FlSpot(2, 8), FlSpot(3, 6), FlSpot(4, 10)],
                      isCurved: true,
                      color: Colors.blueAccent,
                      barWidth: 3,
                      belowBarData: BarAreaData(show: true, color: Colors.blueAccent.withOpacity(0.3)),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),

            // Order Distribution Pie Chart
            Text("Order Distribution", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 10),
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(color: Colors.black87, borderRadius: BorderRadius.circular(10)),
                child: PieChart(
                  PieChartData(
                    sections: [
                      PieChartSectionData(value: 40, title: "Food", color: Colors.blueAccent, radius: 50),
                      PieChartSectionData(value: 30, title: "Grocery", color: Colors.greenAccent, radius: 50),
                      PieChartSectionData(value: 20, title: "Liquor", color: Colors.redAccent, radius: 50),
                      PieChartSectionData(value: 10, title: "Other", color: Colors.orangeAccent, radius: 50),
                    ],
                    sectionsSpace: 4,
                    centerSpaceRadius: 40,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
