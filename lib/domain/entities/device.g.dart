// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'device.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Device _$DeviceFromJson(Map<String, dynamic> json) => Device(
  id: json['_id'] as String,
  name: json['name'] as String,
  data: json['data'] as Map<String, dynamic>,
  user: json['user'] as String,
);

Map<String, dynamic> _$DeviceToJson(Device instance) => <String, dynamic>{
  '_id': instance.id,
  'name': instance.name,
  'data': instance.data,
  'user': instance.user,
};
