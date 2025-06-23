// lib/features/auth/data/models/app_user_model.dart
import 'package:agri/features/auth/domain/entities/app_user_entity.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:flutter/foundation.dart';
part 'app_user_model.g.dart';

@JsonSerializable()
class AppUserModel extends AppUserEntity {
  @override
  final String? token; 
  AppUserModel({
    required super.id,
    required super.email,
    required super.username,
    required super.image,
    this.token,
  }) : super(token: token);

  factory AppUserModel.fromJson(Map<String, dynamic> json) {
    debugPrint("Converting JSON to AppUserModel: $json");
    final model = _$AppUserModelFromJson(json);
    final token = json['token'] as String?;
    debugPrint("Token from JSON: $token");
    return AppUserModel(
      id: model.id,
      email: model.email,
      username: model.username,
      image: model.image,
      token: token,
    );
  }

  @override
  Map<String, dynamic> toJson() {
    final json = _$AppUserModelToJson(this);
    json['token'] = token; 
    debugPrint("Converting AppUserModel to JSON: $json");
    return json;
  }

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
