// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_product_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderProductResponse _$OrderProductResponseFromJson(
        Map<String, dynamic> json) =>
    OrderProductResponse(
      qty: json['qty'] as String?,
      price: json['price'] as String?,
      total: json['total'] as int?,
      isPaid: json['is_paid'] as bool?,
      createdAt: json['created_at'] as String?,
      id: json['id'] as int?,
    );

Map<String, dynamic> _$OrderProductResponseToJson(
        OrderProductResponse instance) =>
    <String, dynamic>{
      'qty': instance.qty,
      'price': instance.price,
      'total': instance.total,
      'is_paid': instance.isPaid,
      'created_at': instance.createdAt,
      'id': instance.id,
    };
