🍽️ Yaammy Admin Panel - Food Delivery App Dashboard (Flutter + Firebase)
📌 Overview
Yaammy Admin Panel is a modern, responsive Flutter-based web dashboard built for managing a complete food delivery ecosystem. This includes customers, restaurants, delivery partners, orders, banners, coupons, commissions, and more. Designed to work seamlessly with Firebase as the backend, it provides powerful tools to oversee and control operations efficiently.

✅ This is part of a full-stack food delivery system including:

Customer App

Restaurant App

Delivery Partner App

Grocery & Liquor Module (optional)

Admin Web Panel (this project)

🚀 Features
🛠 Admin Capabilities
📦 View and manage orders

💰 Track revenue, commissions, and payments

🏪 Manage restaurants, delivery partners, and categories

🎯 Add/remove banners and coupon codes

📊 Visual analytics with bar charts (via fl_chart)

📬 Handle support requests and user feedback

⚙️ Access settings, refund policies, and platform configurations

🔐 Authentication
Firebase Auth for admin login

Secure login session management

📈 Dashboard Cards
Total Orders

Revenue Summary

Registered Restaurants

Delivery Partners Count

🧩 Side Navigation Panel
Includes:

Dashboard

Orders

Users

Restaurants

Delivery Partners

Banners

Coupon Codes

Commission Charges

Categories

Support / Feedback

Analysis

Settings

🧱 Tech Stack
Layer	Technology
Frontend	Flutter Web (Material UI)
Backend	Firebase (Firestore, Auth)
State	setState / Provider (optional)
Charts	fl_chart
Routing	Navigator, Drawer-based

📂 Project Structure
bash
Copy
Edit
admin_panel_yaammy/
├── lib/
│   ├── screens/           # Individual pages/screens
│   ├── components/        # Reusable widgets like DashboardCard
│   ├── utils/             # Helper functions/constants
│   ├── main.dart          # Entry point with AdminDashboard
├── pubspec.yaml           # Dependencies (fl_chart, firebase_core, etc.)
├── web/                   # Web support
└── README.md
🔧 Setup & Installation
1. Prerequisites
Flutter SDK (≥ 3.10)

Firebase project (configured for Web)

Enable Firestore & Authentication in Firebase

2. Clone & Install
bash
Copy
Edit
git clone https://github.com/your-username/admin_panel_yaammy.git
cd admin_panel_yaammy
flutter pub get
3. Firebase Configuration
Add your firebase_options.dart (auto-generated) or initialize manually using:

bash
Copy
Edit
flutterfire configure
4. Run the App
bash
Copy
Edit
flutter run -d chrome
🎯 Future Enhancements
Add push notifications to dashboard

Export CSV reports for orders and revenue

Multi-admin support with roles

UI theme switch (light/dark)

Integration with Razorpay for direct refunds

🙌 Contributing
Fork this repository

Create a feature branch: git checkout -b feature/your-feature

Commit changes: git commit -m "Add your feature"

Push to GitHub: git push origin feature/your-feature

Open a Pull Request

📄 License
This project is licensed under the MIT License. See LICENSE for more.

📬 Contact
Have questions or suggestions?

📧 Email: support@yaammy.io

🌐 Website: yaammy.io

🧑‍💻 Maintainer: Dipanjan Maity
