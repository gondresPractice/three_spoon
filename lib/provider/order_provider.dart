import 'package:flutter/cupertino.dart';
import 'package:tiga_sendok_app/data/model/order_product_response.dart';
import 'package:tiga_sendok_app/data/model/order_response.dart' as DataOrder;
import 'package:tiga_sendok_app/data/model/product_response.dart'
    as DataProduct;
import 'package:tiga_sendok_app/data/repository/customer_repository.dart';
import 'package:tiga_sendok_app/data/repository/pre_login_repository.dart';
import 'package:tiga_sendok_app/data/service/api_service.dart';
import 'package:tiga_sendok_app/utils/shared_pref.dart';

import '../data/repository/order_repository.dart';

class OrderProvider extends ChangeNotifier {
  final ApiService _apiService;

  OrderProvider(this._apiService);

  final OrderRepositories orderRepositories = OrderRepositories();

  int statusCode = 0;
  bool isLoading = true;
  bool isSuccess = false;
  String message = '';
  List<DataOrder.Data> listOrder = [];
  List<DataProduct.Data> listProduct = [];

  Future<void> getListOrder() async {
    await orderRepositories.getListOrder().then((value) {
      statusCode = value.statusCode;
      notifyListeners();
      if (value.statusCode == 200 &&
          value.isSuccess &&
          value.dataResponse is DataOrder.OrderResponse) {
        final res = value.dataResponse as DataOrder.OrderResponse;
        res.data?.forEach((element) {
          listOrder.add(element);
        });
        isSuccess = true;
        isLoading = false;
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

  Future<void> getListProduct() async {
    await orderRepositories.getListProduct().then((value) {
      statusCode = value.statusCode;
      notifyListeners();
      if (value.statusCode == 200 &&
          value.isSuccess &&
          value.dataResponse is DataProduct.ProductResponse) {
        final res = value.dataResponse as DataProduct.ProductResponse;
        res.data?.forEach((element) {
          listProduct.add(element);
        });
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

  Future<void> createNewOrder(
      int customerId, int productId, int quantity, int price) async {
    isLoading = true;
    await orderRepositories
        .createNewOrder(customerId, productId, quantity, price)
        .then((value) {
      statusCode = value.statusCode;
      notifyListeners();
      if (value.statusCode == 200 &&
          value.isSuccess &&
          value.dataResponse is OrderProductResponse) {
        final res = value.dataResponse as OrderProductResponse;
        isSuccess = true;
        notifyListeners();
        print('success ${res}');
      } else {
        message = value.dataResponse.toString();
        isSuccess = false;
        isLoading = false;
        print('failed ${message}');
        notifyListeners();
      }
    });
    print('status code$statusCode');
  }

  Future<void> updateOrder(int orderId, int customerId, int productId,
      int quantity, int price) async {
    isLoading = true;
    await orderRepositories
        .updateOrder(orderId, customerId, productId, quantity, price)
        .then((value) {
      statusCode = value.statusCode;
      notifyListeners();
      if (value.statusCode == 200 &&
          value.isSuccess &&
          value.dataResponse is OrderProductResponse) {
        final res = value.dataResponse as OrderProductResponse;
        isSuccess = true;
        notifyListeners();
        print('success ${res}');
      } else {
        message = value.dataResponse.toString();
        isSuccess = false;
        isLoading = false;
        print('failed ${message}');
        notifyListeners();
      }
    });
    print('status code$statusCode');
  }

  Future<void> changeStatusPay(int orderId) async {
    isLoading = true;
    await orderRepositories.changeStatusPay(orderId).then((value) {
      statusCode = value.statusCode;
      notifyListeners();
      if (value.statusCode == 200 &&
          value.isSuccess &&
          value.dataResponse is OrderProductResponse) {
        final res = value.dataResponse as OrderProductResponse;
        isSuccess = true;
        notifyListeners();
        print('success ${res}');
      } else {
        message = value.dataResponse.toString();
        isSuccess = false;
        isLoading = false;
        print('failed ${message}');
        notifyListeners();
      }
    });
    print('status code$statusCode');
  }
}
