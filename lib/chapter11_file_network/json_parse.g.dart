// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'json_parse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BasicMapWithObject2 _$BasicMapWithObject2FromJson(Map<String, dynamic> json) {
  return BasicMapWithObject2(json['code'] as int, json['result'],
      json['message'], Man.fromJson(json['data'] as Map<String, dynamic>));
}

Map<String, dynamic> _$BasicMapWithObject2ToJson(
        BasicMapWithObject2 instance) =>
    <String, dynamic>{
      'code': instance.code,
      'result': instance.result,
      'message': instance.message,
      'data': instance.data
    };

Man _$ManFromJson(Map<String, dynamic> json) {
  return Man(json['name'], json['age'] as int);
}

Map<String, dynamic> _$ManToJson(Man instance) =>
    <String, dynamic>{'name': instance.name, 'age': instance.age};
