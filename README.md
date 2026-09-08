# Food Delivery App

A Flutter food ordering app with Firebase authentication, Firestore data storage, Stripe payments, a customer wallet, and an admin panel.

## Features

- User signup, login, logout, and password reset
- Pizza, Burger, Chinese, and Mexican food categories
- Food search and item details
- Quantity and delivery-address selection
- Wallet top-ups with Stripe
- Order history and status tracking
- User profile and account deletion
- Admin login, order management, and user management

## Tech Stack

- Flutter and Dart
- Firebase Authentication
- Cloud Firestore
- Stripe
- Shared Preferences

## Setup

1. Clone the repository:

   ```bash
   git clone https://github.com/AliZaidiSyed/fooddeliveryapp.git
   cd fooddeliveryapp
   ```

2. Install dependencies:

   ```bash
   flutter pub get
   ```

3. Connect the app to Firebase and enable Email/Password Authentication and Cloud Firestore:

   ```bash
   dart pub global activate flutterfire_cli
   flutterfire configure
   ```

4. Add the required images to the `images/` folder and register it in `pubspec.yaml`:

   ```yaml
   flutter:
     assets:
       - images/
   ```

5. Configure Stripe securely, then run:

   ```bash
   flutter run
   ```

## Main Packages

```yaml
firebase_core:
firebase_auth:
cloud_firestore:
flutter_stripe:
http:
shared_preferences:
curved_navigation_bar:
random_string:
intl:
```


## Author

[AliZaidiSyed](https://github.com/AliZaidiSyed)
