import 'package:json_annotation/json_annotation.dart';

part 'register_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class RegisterResponse {
  String? message;
  User? user;
  String? accessToken;
  String? tokenType;

  RegisterResponse({this.message, this.user, this.accessToken, this.tokenType});

  RegisterResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    user = json['user'] != null ? new User.fromJson(json['user']) : null;
    accessToken = json['access_token'];
    tokenType = json['token_type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['message'] = this.message;
    if (this.user != null) {
      data['user'] = this.user!.toJson();
    }
    data['access_token'] = this.accessToken;
    data['token_type'] = this.tokenType;
    return data;
  }
}

class User {
  String? name;
  String? email;
  int? id;

  User({this.name, this.email, this.id});

  User.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    email = json['email'];
    id = json['id'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['name'] = this.name;
    data['email'] = this.email;
    data['id'] = this.id;
    return data;
  }
}
