# Create necessary directories if they don't exist
$directories = @(
    "lib/features/auth/presentation/pages",
    "lib/features/auth/presentation/widgets",
    "lib/features/auth/data/repositories",
    "lib/features/auth/domain/entities",
    "lib/features/auth/domain/usecases",
    "lib/features/disease/presentation/pages",
    "lib/features/disease/presentation/widgets",
    "lib/features/disease/data/repositories",
    "lib/features/disease/domain/entities",
    "lib/features/disease/domain/usecases",
    "lib/features/chat_bot/presentation/pages",
    "lib/features/chat_bot/presentation/widgets",
    "lib/features/chat_bot/data/repositories",
    "lib/features/chat_bot/domain/entities",
    "lib/features/chat_bot/domain/usecases",
    "lib/features/camera/presentation/pages",
    "lib/features/camera/presentation/widgets",
    "lib/features/camera/data/repositories",
    "lib/features/camera/domain/entities",
    "lib/features/camera/domain/usecases"
)

foreach ($dir in $directories) {
    New-Item -ItemType Directory -Force -Path $dir
}

# Move auth-related files
Move-Item -Path "lib/presentation/welcome/screens/*" -Destination "lib/features/auth/presentation/pages/" -Force
Move-Item -Path "lib/presentation/welcome/widgets/*" -Destination "lib/features/auth/presentation/widgets/" -Force
Move-Item -Path "lib/data/repositories/user_repository.dart" -Destination "lib/features/auth/data/repositories/" -Force
Move-Item -Path "lib/domain/entities/app_user_entity.dart" -Destination "lib/features/auth/domain/entities/" -Force
Move-Item -Path "lib/domain/usecases/user_usecase.dart" -Destination "lib/features/auth/domain/usecases/" -Force

# Move disease-related files
Move-Item -Path "lib/presentation/disease/screens/*" -Destination "lib/features/disease/presentation/pages/" -Force
Move-Item -Path "lib/presentation/disease/widgets/*" -Destination "lib/features/disease/presentation/widgets/" -Force
Move-Item -Path "lib/data/repositories/disease_repository.dart" -Destination "lib/features/disease/data/repositories/" -Force
Move-Item -Path "lib/domain/entities/disease_entity.dart" -Destination "lib/features/disease/domain/entities/" -Force
Move-Item -Path "lib/domain/usecases/disease_usecase.dart" -Destination "lib/features/disease/domain/usecases/" -Force

# Move chat bot-related files
Move-Item -Path "lib/presentation/chat/screens/*" -Destination "lib/features/chat_bot/presentation/pages/" -Force
Move-Item -Path "lib/presentation/chat/widgets/*" -Destination "lib/features/chat_bot/presentation/widgets/" -Force
Move-Item -Path "lib/data/repositories/chat_repository.dart" -Destination "lib/features/chat_bot/data/repositories/" -Force
Move-Item -Path "lib/domain/entities/chat_entity.dart" -Destination "lib/features/chat_bot/domain/entities/" -Force
Move-Item -Path "lib/domain/usecases/chat_usecase.dart" -Destination "lib/features/chat_bot/domain/usecases/" -Force

# Move camera-related files
Move-Item -Path "lib/presentation/camera/screens/*" -Destination "lib/features/camera/presentation/pages/" -Force
Move-Item -Path "lib/presentation/camera/widgets/*" -Destination "lib/features/camera/presentation/widgets/" -Force
Move-Item -Path "lib/data/repositories/camera_repository.dart" -Destination "lib/features/camera/data/repositories/" -Force
Move-Item -Path "lib/domain/entities/camera_entity.dart" -Destination "lib/features/camera/domain/entities/" -Force
Move-Item -Path "lib/domain/usecases/camera_usecase.dart" -Destination "lib/features/camera/domain/usecases/" -Force

# Move shared files
Move-Item -Path "lib/presentation/shared/*" -Destination "lib/shared/widgets/" -Force
Move-Item -Path "lib/data/remote/apis/*" -Destination "lib/core/network/api_client/" -Force

# Clean up empty directories
Get-ChildItem -Path "lib" -Recurse -Directory | Where-Object { $_.GetFiles().Count -eq 0 } | Remove-Item -Recurse -Force

# Remove generated files
Remove-Item -Path "lib/**/*.g.dart" -Force
Remove-Item -Path "lib/**/*.freezed.dart" -Force
Remove-Item -Path "lib/**/*.mocks.dart" -Force 