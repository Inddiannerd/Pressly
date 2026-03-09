# Pressly App - Gemini Context

This document provides architectural guidance and project context for Gemini CLI when working on the Pressly App.

## Project Overview
The Pressly App is a production-ready Flutter application designed for managing laundry services. It follows **Clean Architecture** principles with a **feature-first** structure to ensure scalability, testability, and maintainability.

### Core Technologies
- **Flutter & Dart**: Cross-platform UI framework.
- **Riverpod (2.x)**: State management and dependency injection.
- **GoRouter**: Declarative routing system.
- **fpdart**: Functional programming utilities for error handling (Either/Result pattern).
- **Freezed**: Code generation for immutable entities and unions.
- **Firebase**: Backend services (Auth, Firestore).

## Architecture
The project is structured into three main layers within each feature:

1.  **Domain Layer (Pure Dart)**:
    - **Entities**: Immutable business objects (`freezed`).
    - **Repositories**: Abstract interfaces defining the contract for data operations.
    - **Use Cases**: Single-responsibility classes orchestrating business logic.
    - **Failures**: Domain-specific error types.

2.  **Data Layer**:
    - **Models**: Data transfer objects (DTOs) with serialization logic (extending entities).
    - **Repositories Implementation**: Implementation of domain repositories.
    - **Data Sources**: Remote (Firebase/APIs) and Local (Cache/DB) data providers.
    - **Exceptions**: Data-layer specific error handling.

3.  **Presentation Layer**:
    - **Widgets**: UI components (stateless or `ConsumerWidget`).
    - **Providers**: Riverpod state management (Notifiers, FutureProviders, etc.).
    - **Controllers/State**: State definitions for the UI.

4.  **Core**:
    - Shared utilities, theme configurations, routing setup, and global error handling.

## Directory Structure
```text
lib/
├── app/                # Main app entry and root widget
├── core/               # Shared logic (theme, routing, errors, etc.)
└── features/           # Feature-based modules (auth, home, etc.)
    └── <feature>/
        ├── data/       # Models, Repositories Impl, Data Sources
        ├── domain/     # Entities, Repositories Interfaces, Use Cases
        └── presentation/ # Widgets, Providers, Controllers
```

## Building and Running
### Prerequisites
- Flutter SDK installed.
- Firebase CLI configured for the project.

### Key Commands
- **Install Dependencies**: `flutter pub get`
- **Generate Code**: `dart run build_runner build --delete-conflicting-outputs`
- **Run the App**: `flutter run`
- **Run Tests**: `flutter test`
- **Linting**: `flutter analyze`

## Development Conventions
1.  **Immutability**: Always use `Freezed` for entities and state objects.
2.  **Error Handling**: Use `fpdart`'s `Either<Failure, Success>` for repository and use case methods. Avoid throwing exceptions to the presentation layer.
3.  **Dependency Injection**: Use Riverpod providers for all injections. Never instantiate repositories or data sources directly in widgets.
4.  **No Logic in UI**: Keep widgets lean. Business logic belongs in use cases, and UI logic belongs in Riverpod Notifiers.
5.  **Clean Code**: Follow the lints defined in `analysis_options.yaml` (includes `riverpod_lint` and `custom_lint`).

## Firestore Schema
The app uses a scalable Firestore structure:
- `users`: Auth UID as Doc ID.
- `addresses`: Sub-collection or top-level with `userId`.
- `orders`: Top-level with `userId` index.
- `service_types`: Public read-only configurations.
