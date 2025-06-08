# Move core files
Move-Item -Path "lib/service/api_service.dart" -Destination "lib/core/network/api_client/" -Force
Move-Item -Path "lib/ui/widgets/*" -Destination "lib/core/widgets/" -Force
Move-Item -Path "lib/config/*" -Destination "lib/core/config/" -Force
Move-Item -Path "lib/responsive/*" -Destination "lib/core/utils/helpers/" -Force

# Move auth files
Move-Item -Path "lib/presentation/welcome/screens/*" -Destination "lib/features/auth/presentation/pages/" -Force
Move-Item -Path "lib/presentation/welcome/widgets/*" -Destination "lib/features/auth/presentation/widgets/" -Force
Move-Item -Path "lib/data/repositories/user_repository.dart" -Destination "lib/features/auth/data/repositories/" -Force
Move-Item -Path "lib/domain/entities/app_user_entity.dart" -Destination "lib/features/auth/domain/entities/" -Force
Move-Item -Path "lib/domain/usecases/user_usecase.dart" -Destination "lib/features/auth/domain/usecases/" -Force

# Move farmdashboard files
Move-Item -Path "lib/presentation/dashboard/screens/*" -Destination "lib/features/farmdashboard/presentation/pages/" -Force
Move-Item -Path "lib/presentation/dashboard/widgets/*" -Destination "lib/features/farmdashboard/presentation/widgets/" -Force
Move-Item -Path "lib/data/repositories/sensor_repository.dart" -Destination "lib/features/farmdashboard/data/repositories/" -Force
Move-Item -Path "lib/domain/entities/sensor_data.dart" -Destination "lib/features/farmdashboard/domain/entities/" -Force
Move-Item -Path "lib/domain/usecases/sensor_usecase.dart" -Destination "lib/features/farmdashboard/domain/usecases/" -Force

# Move shared files
Move-Item -Path "lib/domain/entities/base_response.dart" -Destination "lib/shared/models/" -Force
Move-Item -Path "lib/domain/entities/base_response.g.dart" -Destination "lib/shared/models/" -Force

# Move app files
Move-Item -Path "lib/app/app.dart" -Destination "lib/app/" -Force
Move-Item -Path "lib/app/bootstrap.dart" -Destination "lib/app/" -Force
Move-Item -Path "lib/app/firebase_options.dart" -Destination "lib/app/config/" -Force

# Clean up empty directories
Get-ChildItem -Path "lib" -Recurse -Directory | Where-Object { $_.GetFiles().Count -eq 0 } | Remove-Item -Recurse -Force

# Remove generated files
Remove-Item -Path "lib/**/*.g.dart" -Force
Remove-Item -Path "lib/**/*.freezed.dart" -Force
Remove-Item -Path "lib/**/*.mocks.dart" -Force 