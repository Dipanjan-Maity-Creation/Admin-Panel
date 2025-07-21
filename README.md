# 🍽️ Yaammy Admin Panel – Food Delivery App Dashboard (Flutter + Firebase)

## 📌 Overview

**Yaammy Admin Panel** is a modern, responsive Flutter-based web dashboard tailored to manage a comprehensive food delivery system. Built on **Flutter Web** and powered by **Firebase**, it offers a centralized interface to efficiently monitor and control operations including customer management, restaurant and delivery partner onboarding, orders, analytics, banners, coupons, and more.

> This admin panel is part of a full-stack solution that includes:
> - 📱 Customer App  
> - 🏪 Restaurant App  
> - 🚚 Delivery Partner App  
> - 🛒 Grocery & Liquor Modules *(optional)*  
> - 🖥️ Admin Web Panel *(this project)*

---

## 🚀 Features

### 🛠 Admin Capabilities
- 📦 View and manage all food delivery orders
- 💰 Track platform revenue, commissions, and payment cycles
- 🏪 Manage restaurants, delivery partners, and food categories
- 🎯 Add/edit/delete banners and coupon codes
- 📊 Visual analytics via charts using `fl_chart`
- 📬 Respond to support tickets and user feedback
- ⚙️ Configure refund policies, settings, and system options

### 🔐 Authentication
- Firebase Authentication for admin login
- Secure login session management

### 📈 Dashboard Cards
- Total Orders  
- Revenue Summary  
- Registered Restaurants  
- Delivery Partners Count

### 🧭 Side Navigation Menu
- Dashboard  
- Orders  
- Users  
- Restaurants  
- Delivery Partners  
- Banners  
- Coupon Codes  
- Commission Charges  
- Categories  
- Support / Feedback  
- Analysis  
- Settings

---

## 🧱 Tech Stack

| Layer        | Technology                  |
|--------------|------------------------------|
| Frontend     | Flutter Web (Material UI)    |
| Backend      | Firebase (Firestore, Auth)   |
| State Mgmt   | `setState` / Provider (optional) |
| Charts       | `fl_chart`                   |
| Routing      | `Navigator`, `Drawer`        |

---

## 📂 Project Structure

admin_panel_yaammy/
├── lib/
│ ├── screens/ # Page-level widgets (e.g., Orders, Dashboard)
│ ├── components/ # Reusable UI components (e.g., DashboardCard)
│ ├── utils/ # Constants, helpers, Firebase config
│ ├── main.dart # App entry point
├── web/ # Web assets & Firebase configs
├── pubspec.yaml # Flutter dependencies
└── README.md # Project documentation

yaml
Copy
Edit

---

## 🔧 Setup & Installation

### 1. Prerequisites
- Flutter SDK (≥ 3.10)
- Firebase project (Web App enabled)
- Firestore & Firebase Auth enabled in Firebase Console

### 2. Clone & Install
```bash
git clone https://github.com/your-username/admin_panel_yaammy.git
cd admin_panel_yaammy
flutter pub get
3. Firebase Configuration
Add your firebase_options.dart or initialize Firebase using:

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
🔔 Push notifications for new orders/support tickets

📤 Export order/revenue data as CSV

👥 Multi-admin role support (Super Admin, Support, etc.)

🌗 Light/Dark mode toggle

💳 Razorpay refund integration from dashboard

🙌 Contributing
We welcome contributions!

Fork this repository

Create a branch:

bash
Copy
Edit
git checkout -b feature/your-feature
Commit your changes:

bash
Copy
Edit
git commit -m "Add your feature"
Push to GitHub:

bash
Copy
Edit
git push origin feature/your-feature
Open a Pull Request

📄 License
Licensed under the MIT License.
See the LICENSE file for full details.

📬 Contact
Questions or suggestions? Reach out to the team:

📧 Email: support@yaammy.io

🌐 Website: https://yaammy.io

🧑‍💻 Maintainer: Dipanjan Maity

Built with ❤️ using Flutter and Firebase to power the next-gen food delivery experience.

yaml
Copy
Edit

---

Let me know if you'd like to:
- Add badge icons (e.g., Build Passing, Firebase Deployed, etc.)
- Include deployment instructions (e.g., Firebase Hosting)
- Generate a downloadable `README.md` file  
- Or prepare a pitch/description for investors or Play Store listing.
