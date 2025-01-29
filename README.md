📌 Overview
Many online stores price their products differently, making it difficult for customers to find the best deal. Pricer simplifies this by aggregating price data from various websites, allowing users to compare prices in one place.

🚀 Features
✅ Search for any product and compare prices across multiple stores.
✅ Web scraping technology to gather real-time prices.
✅ User-friendly interface for easy navigation.
✅ Secure authentication using Firebase.
✅ Built with Django for the backend and Flutter for the frontend.

🛠️ Tech Stack
Backend: Django, Python, Web Scraping
Frontend: Flutter
Database: Firebase, MySQL
Hosting: Google Cloud / AWS

📦 Installation
1️⃣ Clone the Repository
bash
Copy
Edit
git clone https://github.com/shehabismai10/pricer.git
cd pricer
2️⃣ Set Up the Backend (Django)
bash
Copy
Edit
# Create a virtual environment
python -m venv venv
source venv/bin/activate  # (On Windows use `venv\Scripts\activate`)

# Install dependencies
pip install -r requirements.txt

# Run migrations
python manage.py migrate

# Start the server
python manage.py runserver
3️⃣ Set Up the Frontend (Flutter)
bash
Copy
Edit
cd frontend
flutter pub get
flutter run
📌 Usage
1️⃣ Open the application and enter a product name in the search bar.
2️⃣ The app fetches and displays prices from multiple websites.
3️⃣ Click on a product to view details and purchase from the best-priced store.

📜 License
This project is open-source under the MIT License.

