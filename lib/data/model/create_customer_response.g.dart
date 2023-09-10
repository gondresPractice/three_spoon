// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_customer_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateCustomerResponse _$CreateCustomerResponseFromJson(
        Map<String, dynamic> json) =>
    CreateCustomerResponse(
      uuid: json['uuid'] as String?,
      name: json['name'] as String?,
      gender: json['gender'] as String?,
      phone: json['phone'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$CreateCustomerResponseToJson(
        CreateCustomerResponse instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'name': instance.name,
      'gender': instance.gender,
      'phone': instance.phone,
      'id': instance.id,
    };
