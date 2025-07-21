import 'package:flutter/material.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool isDarkMode = false;
  bool notificationsEnabled = true;
  String selectedLanguage = "English";

  List<String> languages = ["English", "Hindi", "Bengali", "Spanish"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        title: Text("Settings"),
        backgroundColor: Colors.black87,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Profile Section
            Card(
              color: Colors.black54,
              child: ListTile(
                leading: CircleAvatar(
                  backgroundImage: AssetImage("assets/admin.jpg"),
                ),
                title: Text("Admin Name", style: TextStyle(color: Colors.white)),
                subtitle: Text("admin@example.com", style: TextStyle(color: Colors.white70)),
                trailing: Icon(Icons.edit, color: Colors.white),
                onTap: () {
                  // Add edit profile functionality
                },
              ),
            ),

            SizedBox(height: 20),

            // Theme Mode
            SwitchListTile(
              title: Text("Dark Mode", style: TextStyle(color: Colors.white)),
              subtitle: Text("Enable dark mode theme", style: TextStyle(color: Colors.white70)),
              value: isDarkMode,
              onChanged: (bool value) {
                setState(() {
                  isDarkMode = value;
                });
              },
              activeColor: Colors.blueAccent,
            ),

            // Notifications
            SwitchListTile(
              title: Text("Notifications", style: TextStyle(color: Colors.white)),
              subtitle: Text("Receive app notifications", style: TextStyle(color: Colors.white70)),
              value: notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  notificationsEnabled = value;
                });
              },
              activeColor: Colors.blueAccent,
            ),

            // Language Selection
            ListTile(
              title: Text("Language", style: TextStyle(color: Colors.white)),
              subtitle: Text(selectedLanguage, style: TextStyle(color: Colors.white70)),
              trailing: DropdownButton<String>(
                value: selectedLanguage,
                dropdownColor: Colors.black,
                items: languages
                    .map((String lang) => DropdownMenuItem(
                  value: lang,
                  child: Text(lang, style: TextStyle(color: Colors.white)),
                ))
                    .toList(),
                onChanged: (String? newLang) {
                  setState(() {
                    selectedLanguage = newLang!;
                  });
                },
              ),
            ),

            Divider(color: Colors.white54),

            // Security Section
            ListTile(
              leading: Icon(Icons.lock, color: Colors.white),
              title: Text("Change Password", style: TextStyle(color: Colors.white)),
              onTap: () {
                // Navigate to Change Password Page
              },
            ),
            ListTile(
              leading: Icon(Icons.privacy_tip, color: Colors.white),
              title: Text("Privacy Settings", style: TextStyle(color: Colors.white)),
              onTap: () {
                // Navigate to Privacy Settings Page
              },
            ),

            Divider(color: Colors.white54),

            // Logout Button
            ListTile(
              leading: Icon(Icons.logout, color: Colors.redAccent),
              title: Text("Logout", style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
              onTap: () {
                // Handle Logout
              },
            ),
          ],
        ),
      ),
    );
  }
}
