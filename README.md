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

├── data/

│   ├── datasources/

│   └── repositories/

├── domain/

│   ├── entities/

│   ├── repositories/

│   └── usecases/

├── presentation/

│   ├── bindings/

│   ├── controllers/

│   ├── pages/

│   └── widgets/

├── core/

│   ├── constants/

│   └── utils/

└── main.dart
