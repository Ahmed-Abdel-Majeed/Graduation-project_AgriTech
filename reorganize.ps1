# Create necessary directories
$directories = @(
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
    "lib/shared/models",
    "lib/shared/services",
    "lib/shared/widgets"
)

foreach ($dir in $directories) {
    New-Item -ItemType Directory -Force -Path $dir
}

# Move core files
Move-Item -Path "lib/service/api_service.dart" -Destination "lib/core/network/api_client/" -Force
Move-Item -Path "lib/ui/widgets/*" -Destination "lib/core/widgets/" -Force
Move-Item -Path "lib/config/*" -Destination "lib/core/config/" -Force
Move-Item -Path "lib/responsive/*" -Destination "lib/core/utils/helpers/" -Force

# Move dashboard files
Move-Item -Path "lib/presentation/dashboard/screens/*" -Destination "lib/features/farmdashboard/presentation/pages/" -Force
Move-Item -Path "lib/presentation/dashboard/widgets/*" -Destination "lib/features/farmdashboard/presentation/widgets/" -Force
Move-Item -Path "lib/data/repositories/sensor_repository.dart" -Destination "lib/features/farmdashboard/data/repositories/" -Force
Move-Item -Path "lib/domain/entities/sensor_data.dart" -Destination "lib/features/farmdashboard/domain/entities/" -Force
Move-Item -Path "lib/domain/usecases/sensor_usecase.dart" -Destination "lib/features/farmdashboard/domain/usecases/" -Force

# Move shared files
Move-Item -Path "lib/domain/entities/base_response.dart" -Destination "lib/shared/models/" -Force
Move-Item -Path "lib/domain/entities/base_response.g.dart" -Destination "lib/shared/models/" -Force 