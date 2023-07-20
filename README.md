# Bon Voyage - Travel Ecommerce App

Bon Voyage is an exceptional travel ecommerce app designed to enhance your travel planning and booking experience. The app combines the power of both Plaid and Stripe APIs, giving you the flexibility to choose your preferred payment method. Plaid allows for secure bank account verification, while Stripe provides seamless payment processing. The app also leverages Firebase Authentication, Firestore Database, and Firebase Storage to efficiently manage user accounts, travel information, and media. With Cloud Functions handling server-side logic, Bon Voyage offers comprehensive functionality for your travel needs.

## Features

- **Secure User Authentication**: Register and log in to the app using Firebase Authentication for a safe and personalized experience.
- **Travel Listings**: Browse and explore a wide range of travel destinations and services in the app.
- **Travel Details**: Access detailed information and media for each travel destination or service.
- **Travel Booking**: Add travel options to the cart and proceed to a secure and seamless payment process using either the Plaid API for bank account verification or the Stripe payment gateway.
- **Order History**: Keep track of past travel bookings and access booking details.

## Getting Started

To get started with Bon Voyage, follow the steps below:

### Prerequisites

- Xcode: Ensure you have the latest version of Xcode installed on your macOS system.

### Installation with Swift Package Manager (SPM)

1. Clone the Bon Voyage repository to your local machine using the following command:

```bash
git clone https://github.com/HardiB-Salih/Bon-Voyage-iOS.git
```

2. Navigate to the project directory:

```bash
cd bon-voyage
```

3. Open the Xcode project:

```bash
xed .
```

4. Once the project is open in Xcode, navigate to `File` > `Swift Packages` > `Update to Latest Package Versions` to fetch and update the required dependencies.

5. Build and run the app using the desired simulator or connected device.

### Firebase Configuration

Create a Firebase project on the Firebase Console and configure the necessary services (Authentication, Firestore, Storage). Add the `GoogleService-Info.plist` file to the Xcode project for Firebase integration.

### Stripe and Plaid Configuration

Sign up for Stripe and Plaid accounts to obtain the necessary API keys for payment processing and bank account verification. Update the Stripe and Plaid API keys in the app for full functionality.

## Screenshots

<div style="display: flex; justify-content: space-between;">
  <img src="https://filedn.com/lgYM5v25LH64Wknu6KIrjpj/Client%20Project/Innovative%20Candor/GitHub/BonVoyage/Home.png" alt="Home" width="300">
  <img src="https://filedn.com/lgYM5v25LH64Wknu6KIrjpj/Client%20Project/Innovative%20Candor/GitHub/BonVoyage/Detail.png" alt="Travel Details" width="250">
</div>

## Feedback and Support

For any issues or suggestions for improvement, please open an issue on the GitHub repository. Your feedback and contributions are valuable to enhance Bon Voyage.

## License

Bon Voyage is open-source and distributed under the [MIT License](https://innovativecandor.com/mit_license/). You are free to use, modify, and distribute the code as per the terms of the license.

---

Thank you for exploring Bon Voyage! We hope the app helps you plan and book unforgettable travel experiences. Should you have any further inquiries or need assistance, feel free to reach out. Happy travels and bon voyage! 🚀🌎✈️
