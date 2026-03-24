# 🏷️ Pricer - Smart Price Comparison Engine

## 📖 Overview
**Pricer** is a powerful full-stack solution designed to help users track and compare product prices across multiple e-commerce platforms in real-time. By leveraging advanced **Web Scraping**, Pricer ensures users always find the best deals, saving both time and money.

---

## 🚀 Key Features
* 🔍 **Real-Time Search**: Instant price comparison across various online stores.
* 🕷️ **Dynamic Web Scraping**: Custom Python scripts to fetch live price updates from target websites.
* 📱 **Cross-Platform UI**: Beautifully designed frontend built with **Flutter** for a seamless mobile/web experience.
* 🔐 **Secure Auth**: Integrated with **Firebase Authentication** for robust user management.
* 📊 **Hybrid Data Management**: Utilizing **MySQL** for relational product data and **Firebase** for real-time features.

---

## 🛠️ Tech Stack

### Backend & Scraping
* **Django (Python)**: Robust REST API and business logic.
* **BeautifulSoup / Selenium**: For extracting real-time price data.
* **MySQL**: Relational database for structured product information.

### Frontend & Mobile
* **Flutter (Dart)**: Single codebase for a consistent cross-platform UI.
* **Firebase**: Real-time database and secure user authentication.

---

## 📦 Installation & Setup

### 1️⃣ Clone the Repository
```bash
git clone [https://github.com/shehabismai10/pricer.git](https://github.com/shehabismai10/pricer.git)
cd pricer
2️⃣ Backend Setup (Django)
Bash
# Create and activate virtual environment
python -m venv venv
# Linux/macOS: source venv/bin/activate 
# Windows: venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt

# Run migrations and start server
python manage.py migrate
python manage.py runserver
3️⃣ Frontend Setup (Flutter)
Bash
cd frontend
flutter pub get
flutter run
📂 Project Structure
Plaintext
Pricer/
├── backend/            # Django Project (API & Scrapers)
│   ├── core/           # Main settings & routing
│   ├── api/            # REST Endpoints for products
│   └── scrapers/       # Python scripts for price extraction
├── frontend/           # Flutter Application
│   ├── lib/            # UI Components & State Management
│   └── assets/         # Images and Fonts
└── requirements.txt    # Backend dependencies
📌 Usage
Search: Enter a product name in the search bar.

Compare: View a consolidated list of prices from different vendors.

Redirect: Click on any product to go directly to the store and complete your purchase.

Distributed under the MIT License. See LICENSE for more information.

👨‍💻 Developed by Shehab Ismail
