# Create features directory
New-Item -ItemType Directory -Force -Path "lib/features"

# Create feature directories
$features = @(
    "auth",
    "farmdashboard",
    "disease",
    "chat_bot",
    "camera"
)

foreach ($feature in $features) {
    $featureDirs = @(
        "lib/features/$feature/presentation/pages",
        "lib/features/$feature/presentation/widgets",
        "lib/features/$feature/presentation/controllers",
        "lib/features/$feature/data/repositories",
        "lib/features/$feature/data/models",
        "lib/features/$feature/domain/entities",
        "lib/features/$feature/domain/usecases"
    )
    
    foreach ($dir in $featureDirs) {
        New-Item -ItemType Directory -Force -Path $dir
    }
}

# Create feature README files
foreach ($feature in $features) {
    $readmeContent = @"
# $feature Feature

This feature module handles the $feature functionality, following Clean Architecture principles.

## Directory Structure

### Data Layer (`/data`)
- `repositories/`: Data repositories
- `models/`: Data models and DTOs
- API implementations
- Local storage implementations

### Domain Layer (`/domain`)
- `entities/`: Business entities
- `usecases/`: Business logic use cases
- Repository interfaces
- Domain models

### Presentation Layer (`/presentation`)
- `pages/`: Screen implementations
- `widgets/`: Feature-specific widgets
- `controllers/`: State management
- View models
"@
    Set-Content -Path "lib/features/$feature/README.md" -Value $readmeContent
}

# Create core README files
$coreReadmeContent = @"
# Core Module

This directory contains core functionality and utilities used across the application.

## Directory Structure

### Constants (`/constants`)
- Application-wide constants
- Environment variables
- API endpoints
- Theme constants

### Error (`/error`)
- `exceptions/`: Custom exceptions
- `failures/`: Error handling and failure classes

### Network (`/network`)
- `api_client/`: API client implementation
- `interceptors/`: Network interceptors for logging, authentication, etc.

### Utils (`/utils`)
- `constants/`: Utility constants
- `helpers/`: Helper functions and utilities
- Date formatting
- String manipulation
- Validation helpers

### Widgets (`/widgets`)
- `buttons/`: Reusable button widgets
- `cards/`: Card widgets
- `dialogs/`: Dialog widgets
- Other shared UI components

### Config (`/config`)
- App configuration
- Theme configuration
- Route configuration
- Environment configuration
"@
Set-Content -Path "lib/core/README.md" -Value $coreReadmeContent

# Create shared README file
$sharedReadmeContent = @"
# Shared Module

This directory contains shared resources used across multiple features.

## Directory Structure

### Models (`/models`)
- Shared data models
- Base response models
- Common DTOs
- Shared entities

### Services (`/services`)
- Shared service implementations
- Common API clients
- Utility services
- Third-party service integrations

### Widgets (`/widgets`)
- Shared UI components
- Common layouts
- Reusable widgets
- Base widgets
"@
Set-Content -Path "lib/shared/README.md" -Value $sharedReadmeContent

# Create app README file
$appReadmeContent = @"
# App Module

This directory contains application-level code and configuration.

## Directory Structure

### Config (`/config`)
- App configuration
- Firebase configuration
- Environment configuration

### Theme (`/theme`)
- App theme configuration
- Color schemes
- Typography
- Styles

### Routes (`/routes`)
- Route definitions
- Navigation configuration
- Route guards
"@
Set-Content -Path "lib/app/README.md" -Value $appReadmeContent 