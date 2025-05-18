import 'package:json_annotation/json_annotation.dart';
part 'device.g.dart';

@JsonSerializable()
class Device {
  @JsonKey(name: '_id')
  final String id;
  final String name;
  final Map<String, dynamic> data;
  final String user;

  Device({
    required this.id,
    required this.name,
    required this.data,
    required this.user,
  });

  factory Device.fromJson(Map<String, dynamic> json) =>
      _$DeviceFromJson(json);
  Map<String, dynamic> toJson() => _$DeviceToJson(this);
}
