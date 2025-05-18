import 'package:json_annotation/json_annotation.dart';
part 'base_response.g.dart';

@JsonSerializable()
class BaseResponse {
  final String? message;

  BaseResponse({this.message});

  factory BaseResponse.fromJson(Map<String, dynamic> json) =>
      _$BaseResponseFromJson(json);

  Map<String, dynamic> toJson() => _$BaseResponseToJson(this);
}
