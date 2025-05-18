# Project Structure

```
lib/
├── core/                     # Core functionality and utilities
│   ├── constants/           # App-wide constants
│   ├── error/              # Error handling
│   ├── network/            # Network related code
│   ├── theme/              # App theme
│   ├── utils/              # Utility functions
│   └── widgets/            # Reusable widgets
│
├── features/               # Feature-based modules
│   ├── auth/              # Authentication feature
│   │   ├── data/         # Data layer
│   │   ├── domain/       # Domain layer
│   │   └── presentation/ # Presentation layer
│   ├── farmdashboard/    # Farm Dashboard feature
│   ├── disease/          # Disease detection feature
│   ├── chat_bot/         # Chat bot feature
│   └── camera/           # Camera feature
│
├── shared/                # Shared resources
│   ├── models/           # Shared data models
│   └── services/         # Shared services
│
└── main.dart             # Application entry point
```

## Directory Structure Explanation

### core/
Contains all the core functionality and utilities that are used throughout the application.

### features/
Each feature is a self-contained module following clean architecture principles:
- data/: Data layer (repositories, data sources)
- domain/: Business logic layer (entities, use cases)
- presentation/: UI layer (screens, widgets, state management)

### shared/
Contains resources that are shared across multiple features.

### main.dart
The entry point of the application. 