// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUserModel _$AppUserModelFromJson(Map<String, dynamic> json) => AppUserModel(
  id: json['id'] as String,
  email: json['email'] as String,
  username: json['username'] as String,
  image: json['image'] as String,
  token: json['token'] as String?,
);

Map<String, dynamic> _$AppUserModelToJson(AppUserModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'image': instance.image,
      'token': instance.token,
    };
