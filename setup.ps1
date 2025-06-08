# Create main feature directories
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

# Create core directories
$coreDirs = @(
    "lib/core/constants",
    "lib/core/error/exceptions",
    "lib/core/error/failures",
    "lib/core/network/api_client",
    "lib/core/network/interceptors",
    "lib/core/utils/constants",
    "lib/core/utils/helpers",
    "lib/core/widgets/buttons",
    "lib/core/widgets/cards",
    "lib/core/widgets/dialogs",
    "lib/core/config/routes",
    "lib/core/config/theme"
)

foreach ($dir in $coreDirs) {
    New-Item -ItemType Directory -Force -Path $dir
}

# Create shared directories
$sharedDirs = @(
    "lib/shared/models",
    "lib/shared/services",
    "lib/shared/widgets"
)

foreach ($dir in $sharedDirs) {
    New-Item -ItemType Directory -Force -Path $dir
}

# Create app directories
$appDirs = @(
    "lib/app/config",
    "lib/app/theme",
    "lib/app/routes"
)

foreach ($dir in $appDirs) {
    New-Item -ItemType Directory -Force -Path $dir
} 