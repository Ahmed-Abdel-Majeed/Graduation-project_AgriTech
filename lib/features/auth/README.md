# Authentication Feature

This feature follows clean architecture principles with the following structure:

```
auth/
├── data/                  # Data Layer
│   ├── datasources/      # Remote and local data sources
│   ├── models/           # Data models
│   └── repositories/     # Repository implementations
│
├── domain/               # Domain Layer
│   ├── entities/         # Business objects
│   ├── repositories/     # Repository interfaces
│   └── usecases/        # Business logic use cases
│
└── presentation/         # Presentation Layer
    ├── bloc/            # State management
    ├── pages/           # UI pages
    └── widgets/         # Feature-specific widgets
``` 