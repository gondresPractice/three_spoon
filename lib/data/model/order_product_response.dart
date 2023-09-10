import 'package:json_annotation/json_annotation.dart';

part 'order_product_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class OrderProductResponse {
  String? qty;
  String? price;
  int? total;
  bool? isPaid;
  String? createdAt;
  int? id;

  OrderProductResponse(
      {this.qty, this.price, this.total, this.isPaid, this.createdAt, this.id});

  OrderProductResponse.fromJson(Map<String, dynamic> json) {
    qty = json['qty'];
    price = json['price'];
    total = json['total'];
    isPaid = json['is_paid'];
    createdAt = json['created_at'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['qty'] = this.qty;
    data['price'] = this.price;
    data['total'] = this.total;
    data['is_paid'] = this.isPaid;
    data['created_at'] = this.createdAt;
    data['id'] = this.id;
    return data;
  }
}
