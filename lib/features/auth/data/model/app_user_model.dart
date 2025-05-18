// lib/features/auth/data/models/app_user_model.dart
import 'package:agri/features/auth/domain/entities/app_user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'app_user_model.g.dart';
@JsonSerializable()
class AppUserModel extends AppUserEntity {
  AppUserModel({
    required super.id,
    required super.email,
    required super.username,
    required super.image,
  });

  factory AppUserModel.fromJson(Map<String, dynamic> json) =>
      _$AppUserModelFromJson(json);

  Map<String, dynamic> toJson() => _$AppUserModelToJson(this);

  // تحويل الـ Model إلى Entity


  AppUserEntity toEntity() {
    return AppUserEntity(
      token: token,
      id: id,
      email: email,
      username: username,
      image: image,
    );
  }
}
