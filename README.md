# MoneyMap - Money Tracking App

MoneyMap is a Flutter-based application designed to help users track their income and expenses effectively. The app uses Firebase Firestore for real-time database management and provides an intuitive user interface for financial management.

## Features

- **User Authentication**: Secure login and registration with Firebase Authentication.
- **Transaction Management**: Add, update, and delete income and expense transactions.
- **Real-time Balance Calculation**: Displays total balance, income, and expenses.
- **Transaction History**: View a detailed list of all transactions.
- **Custom Greetings**: Personalized greeting messages based on the time of day.

## Screenshots
(Include app screenshots here)

## Installation

1. **Clone the repository**:
   ```bash
   git clone https://github.com/udithayeshmantha/MoneyMap-Moneytracking-App.git
   cd MoneyMap-Moneytracking-App
   ```

2. **Install dependencies**:
   ```bash
   flutter pub get
   ```

3. **Configure Firebase**:
   - Set up a Firebase project at [Firebase Console](https://console.firebase.google.com/).
   - Download the `google-services.json` (for Android) and `GoogleService-Info.plist` (for iOS) files.
   - Place them in the respective `android/app` and `ios/Runner` directories.

4. **Run the app**:
   ```bash
   flutter run
   ```

## Usage

- Launch the app and log in or sign up.
- Add income and expense transactions.
- View your current balance, income, and expense totals.
- Navigate through transaction history.

## Firebase Configuration Notes

Ensure that Firestore rules are set up correctly:
```plaintext
service cloud.firestore {
  match /databases/{database}/documents {
    match /transactions/{transactionId} {
      allow read, write: if request.auth != null;
    }
  }
}
```

### Indexing
If you encounter errors related to Firestore indexing, create the necessary index using the link provided in the error message or refer to the [Firestore documentation](https://firebase.google.com/docs/firestore/query-data/indexing).

## Technologies Used
- **Flutter** for front-end development
- **Firebase Firestore** for real-time database
- **Firebase Authentication** for secure user management

## Contributing
Contributions are welcome! Please fork this repository and submit a pull request with your changes.

## License
This project is licensed under the MIT License. See the LICENSE file for details.

## Contact
Developed by [Udith Ayeshmantha](https://github.com/udithayeshmantha).

---
Thank you for using MoneyMap! If you have any questions or feedback, feel free to reach out.

