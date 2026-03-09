# Pressly – Smart Laundry Management App

A professional, production-ready Flutter + Firebase laundry management application. Pressly allows customers to seamlessly place laundry orders and provides administrators with a powerful dashboard to manage pricing, track orders, and view business analytics.

## Features

- **Firebase Authentication**: Secure login and registration for customers and admins.
- **Admin Role Detection**: Specialized access for administrators.
- **Admin Dashboard**: Real-time management of business operations.
- **Laundry Price Management**: Admins can update service pricing dynamically.
- **Address Management**: Users can save and manage multiple pickup/delivery addresses.
- **Order Creation**: Simple and intuitive flow for placing new laundry orders.
- **Order History**: Detailed view of past and active orders for both users and admins.
- **Firestore Backend**: Real-time data synchronization and persistent storage.
- **Riverpod State Management**: Robust and scalable state management for a smooth UX.

## Tech Stack

- **Flutter**: UI Framework
- **Dart**: Programming Language
- **Firebase Authentication**: User identity management
- **Cloud Firestore**: Scalable NoSQL database
- **Riverpod**: State management & Dependency Injection
- **GoRouter**: Declarative routing system
- **fpdart**: Functional programming utilities
- **Freezed**: Immutable entities and code generation

## Project Structure

The project follows a **Clean Architecture** approach with a **feature-first** structure:

- `lib/core`: Shared logic, global providers, and core utilities.
    - `/routing`: GoRouter setup and app navigation logic.
    - `/theme`: App colors, typography, and styling configurations.
    - `/error`: Centralized failure and exception handling.
    - `/widgets`: Common UI components used across the app.
- `lib/features/auth`: User authentication (Login, Register, Password Reset).
- `lib/features/admin`: Admin-specific dashboard and management tools.
- `lib/features/laundry`: Service and pricing management logic.
- `lib/features/order`: Order creation, processing, and history.
- `lib/features/profile`: User account management and address settings.
- `lib/features/home`: Main application landing and navigation.

## How to Run the Project

Follow these steps to set up and run the project locally.

### Prerequisites

1.  **Install Flutter**: Follow the [official Flutter installation guide](https://docs.flutter.dev/get-started/install).
2.  **Verify Installation**:
    ```bash
    flutter doctor
    ```

### Running the App

1.  **Clone the repository**:
    ```bash
    git clone https://github.com/Inddiannerd/Pressly.git
    ```
2.  **Navigate to project directory**:
    ```bash
    cd Pressly
    ```
3. **Install dependencies**:
    ```bash
    flutter pub get
    ```
4. **Generate code** (if needed):
    ```bash
    dart run build_runner build --delete-conflicting-outputs
    ```
5. **Run the app**:
    ```bash
    flutter run
    ```


### Device Preparation

To run the app on a physical phone:
- **Developer Mode**: Enabled on your device.
- **USB Debugging**: Enabled via Developer Options.
- **Connection**: Device must be connected via USB or wireless debugging.

## Admin Login

To access administrative features, use the following credentials:

- **Admin Email**: `vanshpatel29626@gmail.com`

*Note: Any other registered email will be treated as a standard customer account.*

---
Built with ❤️ by Vansh Patel
