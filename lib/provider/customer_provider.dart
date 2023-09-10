import 'package:flutter/cupertino.dart';
import 'package:tiga_sendok_app/data/model/create_customer_response.dart';
import 'package:tiga_sendok_app/data/model/customer_response.dart';
import 'package:tiga_sendok_app/data/model/login_response.dart';
import 'package:tiga_sendok_app/data/model/register_response.dart';
import 'package:tiga_sendok_app/data/repository/customer_repository.dart';
import 'package:tiga_sendok_app/data/repository/pre_login_repository.dart';
import 'package:tiga_sendok_app/data/service/api_service.dart';
import 'package:tiga_sendok_app/utils/shared_pref.dart';

class CustomerProvider extends ChangeNotifier {
  final ApiService _apiService;

  CustomerProvider(this._apiService);

  final CustomerRepositories customerRepositories = CustomerRepositories();

  int statusCode = 0;
  bool isLoading = true;
  bool isSuccess = false;
  String message = '';
  List<Data> listCustomer = [];

  Future<void> getListCustomer() async {
    await customerRepositories.getListCustomer().then((value) {
      statusCode = value.statusCode;
      notifyListeners();
      if (value.statusCode == 200 &&
          value.isSuccess &&
          value.dataResponse is CustomerResponse) {
        final res = value.dataResponse as CustomerResponse;
        res.data?.forEach((element) {
          listCustomer.add(element);
        });
        isLoading = false;
        isSuccess = true;
        notifyListeners();
      } else {
        message = value.dataResponse.toString();
        print('failed ${message}');
        isSuccess = false;
        isLoading = false;
        notifyListeners();
      }
    });
    print('status code$statusCode');
  }

  Future<void> createNewCustomer(
      String name, String gender, int phoneNum) async {
    await customerRepositories
        .createNewCustomer(name, gender, phoneNum)
        .then((value) {
      statusCode = value.statusCode;
      notifyListeners();
      if (value.statusCode == 200 &&
          value.isSuccess &&
          value.dataResponse is CreateCustomerResponse) {
        final res = value.dataResponse as CreateCustomerResponse;
        isSuccess = true;
        notifyListeners();
        print('success ${res}');
      } else {
        message = value.dataResponse.toString();
        print('failed ${message}');
        isSuccess = false;
        isLoading = false;
        print('failed ${message}');
        notifyListeners();
      }
    });
    print('status code$statusCode');
  }

  Future<void> updateCustomer(
      int customerId, String name, String gender, int phoneNum) async {
    await customerRepositories
        .updateCustomer(customerId, name, gender, phoneNum)
        .then((value) {
      statusCode = value.statusCode;
      notifyListeners();
      if (value.statusCode == 200 &&
          value.isSuccess &&
          value.dataResponse is CreateCustomerResponse) {
        final res = value.dataResponse as CreateCustomerResponse;
        isSuccess = true;
        notifyListeners();
        print('success ${res}');
      } else {
        message = value.dataResponse.toString();
        print('failed ${message}');
        isSuccess = false;
        isLoading = false;
        print('failed ${message}');
        notifyListeners();
      }
    });
    print('status code$statusCode');
  }

  Future<void> deleteCustomer(int id) async {
    await customerRepositories.deleteCustomer(id).then((value) {
      notifyListeners();
      if (value.statusCode == 200 && value.isSuccess) {
        isSuccess = true;
        notifyListeners();
        print('success delete');
      } else {
        message = value.dataResponse.toString();
        print('failed ${message}');
        isSuccess = false;
        isLoading = false;
        print('failed ${message}');
        notifyListeners();
      }
    });
  }
}
