# Tua - Global Payments App

Tua is a mobile payments application built with Flutter that allows users to easily initiate money transfers from India to the USA. It provides a simple and convenient way for individuals and businesses to send money securely.

## Features

- **Sender Details:** Users can enter their personal information, including full name, email, phone number, national ID number, and address.
- **Sender's Bank Details:** Users can provide their bank information, including bank name, account number, and IFSC code.
- **Beneficiary Details:** Users can enter the recipient's account holder name, account number, bank name, Swift code, and routing number.
- **Amount Screen:** Users can specify the amount they wish to transfer, ensuring it falls within the range of $100 to $25,000 in USD.
- **Transfer Confirmation Screen:** After initiating the transfer, users receive a confirmation screen displaying the transfer ID.

## Installation

1. Clone the repository: `git clone https://github.com/singhpratham72/tua.git`
2. Change directory to the project: `cd tua`
3. Install dependencies: `flutter pub get`
4. Run the app: `flutter run`

## Technologies Used

- Flutter: A cross-platform framework for building mobile applications.
- Dart: The programming language used for developing Flutter applications.
- RESTful API: Integration with a backend API for handling form responses and initiating transfers.
- MongoDB: The database used for persistent storage of transfer data.

## Contact

For any inquiries or feedback, please contact us at singhpratham72@gmail.com.