// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseModel<T> _$BaseModelFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    BaseModel<T>(
      requestId: json['requestId'] as String?,
      status: json['status'] as int?,
      desc: json['desc'] as String?,
      message: json['message'] as String?,
      data: _$nullableGenericFromJson(json['data'], fromJsonT),
      error: json['error'],
    );

Map<String, dynamic> _$BaseModelToJson<T>(
  BaseModel<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'requestId': instance.requestId,
      'desc': instance.desc,
      'message': instance.message,
      'status': instance.status,
      'data': _$nullableGenericToJson(instance.data, toJsonT),
      'error': instance.error,
    };

T? _$nullableGenericFromJson<T>(
  Object? input,
  T Function(Object? json) fromJson,
) =>
    input == null ? null : fromJson(input);

Object? _$nullableGenericToJson<T>(
  T? input,
  Object? Function(T value) toJson,
) =>
    input == null ? null : toJson(input);
