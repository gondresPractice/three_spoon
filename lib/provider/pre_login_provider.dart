import 'package:flutter/cupertino.dart';
import 'package:tiga_sendok_app/data/model/login_response.dart';
import 'package:tiga_sendok_app/data/model/register_response.dart';
import 'package:tiga_sendok_app/data/repository/pre_login_repository.dart';
import 'package:tiga_sendok_app/data/service/api_service.dart';
import 'package:tiga_sendok_app/utils/shared_pref.dart';

class PreLoginProvider extends ChangeNotifier {
  final ApiService _apiService;

  PreLoginProvider(this._apiService);

  final PreLoginRepositories preLoginRepositories = PreLoginRepositories();

  int statusCode = 0;
  bool isLoading = true;
  bool isSuccess = false;
  bool isLoadingCustomer = true;
  String message = '';

  String token = '';

  Future<void> register(String name, String email, String password) async {
    isLoading = true;
    await preLoginRepositories
        .registerUser(name, email, password)
        .then((value) {
      statusCode = value.statusCode;
      notifyListeners();
      if (value.statusCode == 200 &&
          value.isSuccess &&
          value.dataResponse is RegisterResponse) {
        final res = value.dataResponse as RegisterResponse;
        if (res.message != null) {
          isSuccess = true;
          token = res.accessToken.toString();
          SharedPref.setToken(token);
          !isLoading;
          isSuccess = true;
          print('success ${res.message}');
        } else {
          isSuccess = false;
          message = "The email has already taken";
          print('success ${message}');
        }
        notifyListeners();
      } else {
        message = value.dataResponse.toString();
        print('failed ${message}');
        isSuccess = false;
        isLoading;
        notifyListeners();
      }
    });
    notifyListeners();
    print('status code$statusCode');
  }

  Future<void> login(String email, String password) async {
    isLoading;
    await preLoginRepositories.loginUser(email, password).then((value) {
      statusCode = value.statusCode;
      notifyListeners();
      if (value.statusCode == 200 &&
          value.isSuccess &&
          value.dataResponse is LoginResponse) {
        final res = value.dataResponse as LoginResponse;
        token = res.accessToken.toString();
        SharedPref.setToken(token);
        !isLoading;
        isSuccess = true;
        notifyListeners();
      } else {
        message = value.dataResponse.toString();
        isSuccess = false;
        isLoading;
        notifyListeners();
      }
    });
    print('status code$statusCode');
  }
}
