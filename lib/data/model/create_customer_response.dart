import 'package:json_annotation/json_annotation.dart';

part 'create_customer_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class CreateCustomerResponse {
  String? uuid;
  String? name;
  String? gender;
  String? phone;
  int? id;

  CreateCustomerResponse(
      {this.uuid, this.name, this.gender, this.phone, this.id});

  CreateCustomerResponse.fromJson(Map<String, dynamic> json) {
    uuid = json['uuid'];
    name = json['name'];
    gender = json['gender'];
    phone = json['phone'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['uuid'] = this.uuid;
    data['name'] = this.name;
    data['gender'] = this.gender;
    data['phone'] = this.phone;
    data['id'] = this.id;
    return data;
  }
}
