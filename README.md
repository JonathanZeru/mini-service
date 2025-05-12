# Mini Service Booking App (Frontend Only)

A Flutter app that allows users to manage a list of services with full CRUD functionality using a public REST API. Built with GetX for state management and follows Clean Architecture principles.

## Features

### Core Features
- View a list of services
- View service details
- Add new service
- Edit existing service
- Delete service

### Service Model
Each service includes:
- `name` – String
- `category` – String
- `price` – double
- `imageUrl` – String
- `availability` – boolean
- `duration` – int (minutes)
- `rating` – double (1.0 to 5.0)

### Architecture
- Follows **Clean Architecture**:
  - `presentation/`
  - `domain/`
  - `data/`
- Uses **GetX** for:
  - State management
  - Routing and navigation
  - Bindings and Dependency Injection

### API
- Consumes public REST API from [MockAPI](https://mockapi.io/) (or [crudcrud.com](https://crudcrud.com/))

### UI/UX Highlights
- Clean and intuitive interface
- Responsive layout across devices
- Loading indicators and snackbar/toast notifications
- Form validation with inline error messages and disabled buttons for invalid forms

## Bonus Features
- Search and filter by category, price, or rating
- Offline support using SharedPreferences
- Pagination/lazy loading
- Hero animations between list and detail pages
- Multi-language support with GetX i18n
- Basic login simulation

## Folder Structure

lib/
│
├── core/                     # Core application infrastructure
│   ├── errors/               # Custom exceptions and failures
│   │   ├── exceptions.dart   # Application exceptions
│   │   └── failures.dart     # Failure classes
│   │
│   ├── local/                # Local storage
│   │   └── hive_manager.dart # Hive database manager
│   │
│   ├── network/              # Network layer
│   │   └── api_provider.dart # API communication
│   │
│   ├── theme/                # Theme configuration
│   │   └── app_theme.dart    # Light/dark themes
│   │
│   ├── translations/         # Internationalization
│   │   └── app_translations.dart # Language files
│   │
│   └── utils/                # Utilities and helpers
│       ├── constants.dart    # App constants
│       └── ui_helpers.dart   # UI utilities
│
├── data/                     # Data layer implementation
│   ├── models/               # Data models (DTOs)
│   └── repositories/         # Repository implementations
│
├── domain/                   # Business logic layer
│   ├── repositories/         # Repository contracts
│   └── usecases/             # Business use cases
│       ├── auth/             # Authentication use cases
│       ├── category/         # Category use cases
│       └── service/          # Service use cases
│
└── presentation/             # UI layer
    ├── bindings/             # Dependency bindings
    │
    ├── controllers/          # State controllers
    │
    ├── pages/                # Application screens
    │   ├── auth/             # Authentication screens
    │   │
    │   ├── categories/       # Category management
    │   │   ├── widgets/      # Category widgets
    │   │   │   ├── category_detail/  # Detail view components
    │   │   │   └── category_form/    # Form components
    │   │   ├── categories_view.dart
    │   │   ├── category_details_page.dart
    │   │   └── category_form_page.dart
    │   │
    │   ├── home/             # Home screen
    │   │   ├── widgets/      # Home widgets
    │   │   └── home_view.dart
    │   │
    │   ├── service/          # Service management
    │   │   ├── widgets/      # Service widgets
    │   │   │   ├── service_detail/  # Detail view components
    │   │   │   └── service_form/    # Form components
    │   │   ├── service_details_page.dart
    │   │   └── service_form_page.dart
    │   │
    │   ├── settings/         # App settings
    │   │   ├── widgets/      # Settings widgets
    │   │   └── settings_view.dart
    │   │
    │   ├── splash/           # Splash screen
    │   │   └── splash_page.dart
    │   │
    │   ├── main_layout.dart  # Main app scaffold
    │   └── splash.dart       # Splash screen entry
    │
    ├── routes/               # Navigation configuration
    │   ├── app_pages.dart    # Page definitions
    │   └── app_routes.dart   # Route names
    │
    └── widgets/              # Reusable UI components