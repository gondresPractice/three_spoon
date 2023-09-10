import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:tiga_sendok_app/data/service/api_service.dart';

import '../model/repositories_response.dart';

class OrderRepositories {
  Future<RepositoriesResponse> getListOrder() async {
    final services = GetIt.I.get<ApiService>();

    late RepositoriesResponse response;

    try {
      await services.getListOrder().then((value) {
        response = RepositoriesResponse(
            statusCode: 200, isSuccess: true, dataResponse: value);
      });
      debugPrint('sucess repo');
      return response;
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 401) {
          response = RepositoriesResponse(
              statusCode: 401, isSuccess: false, dataResponse: e.error);

          debugPrint('401 repo');
        } else if (e.response?.statusCode == 404) {
          response = RepositoriesResponse(
              statusCode: 404, isSuccess: false, dataResponse: e.toString());

          debugPrint('404 repo');
        }
      } else {
        response = RepositoriesResponse(
            statusCode: 500, isSuccess: false, dataResponse: e.toString());

        debugPrint('status code 500');
      }
    }
    response = RepositoriesResponse(
        statusCode: 500, isSuccess: false, dataResponse: 'failed to connect');

    debugPrint('status code 500');

    return response;
  }

  Future<RepositoriesResponse> getListProduct() async {
    final services = GetIt.I.get<ApiService>();

    late RepositoriesResponse response;

    try {
      await services.getListProduct().then((value) {
        response = RepositoriesResponse(
            statusCode: 200, isSuccess: true, dataResponse: value);
      });
      debugPrint('sucess repo');
      return response;
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 401) {
          response = RepositoriesResponse(
              statusCode: 401, isSuccess: false, dataResponse: e.error);

          debugPrint('401 repo');
        } else if (e.response?.statusCode == 404) {
          response = RepositoriesResponse(
              statusCode: 404, isSuccess: false, dataResponse: e.toString());

          debugPrint('404 repo');
        }
      } else {
        response = RepositoriesResponse(
            statusCode: 500, isSuccess: false, dataResponse: e.toString());

        debugPrint('status code 500');
      }
    }
    response = RepositoriesResponse(
        statusCode: 500, isSuccess: false, dataResponse: 'failed to connect');

    debugPrint('status code 500');

    return response;
  }

  Future<RepositoriesResponse> createNewOrder(
      int customerId, int productId, int quantity, int price) async {
    final services = GetIt.I.get<ApiService>();

    late RepositoriesResponse response;

    try {
      await services
          .createNewOrder(customerId, productId, quantity, price)
          .then((value) {
        response = RepositoriesResponse(
            statusCode: 200, isSuccess: true, dataResponse: value);
      });
      debugPrint('sucess repo');
      return response;
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 401) {
          response = RepositoriesResponse(
              statusCode: 401, isSuccess: false, dataResponse: e.error);

          debugPrint('401 repo');
        } else if (e.response?.statusCode == 404) {
          response = RepositoriesResponse(
              statusCode: 404, isSuccess: false, dataResponse: e.toString());

          debugPrint('404 repo');
        }
      } else {
        response = RepositoriesResponse(
            statusCode: 500, isSuccess: false, dataResponse: e.toString());

        debugPrint('status code 500');
      }
    }
    response = RepositoriesResponse(
        statusCode: 500, isSuccess: false, dataResponse: 'failed to connect');

    debugPrint('status code 500');

    return response;
  }

  Future<RepositoriesResponse> updateOrder(int orderId, int customerId,
      int productId, int quantity, int price) async {
    final services = GetIt.I.get<ApiService>();

    late RepositoriesResponse response;

    try {
      await services
          .updateOrder(orderId, customerId, productId, quantity, price)
          .then((value) {
        response = RepositoriesResponse(
            statusCode: 200, isSuccess: true, dataResponse: value);
      });
      debugPrint('sucess repo');
      return response;
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 401) {
          response = RepositoriesResponse(
              statusCode: 401, isSuccess: false, dataResponse: e.error);

          debugPrint('401 repo');
        } else if (e.response?.statusCode == 404) {
          response = RepositoriesResponse(
              statusCode: 404, isSuccess: false, dataResponse: e.toString());

          debugPrint('404 repo');
        }
      } else {
        response = RepositoriesResponse(
            statusCode: 500, isSuccess: false, dataResponse: e.toString());

        debugPrint('status code 500');
      }
    }
    response = RepositoriesResponse(
        statusCode: 500, isSuccess: false, dataResponse: 'failed to connect');

    debugPrint('status code 500');

    return response;
  }

  Future<RepositoriesResponse> changeStatusPay(int orderId) async {
    final services = GetIt.I.get<ApiService>();

    late RepositoriesResponse response;

    try {
      await services.changeStatusPay(orderId).then((value) {
        response = RepositoriesResponse(
            statusCode: 200, isSuccess: true, dataResponse: value);
      });
      debugPrint('sucess repo');
      return response;
    } catch (e) {
      if (e is DioError) {
        if (e.response?.statusCode == 401) {
          response = RepositoriesResponse(
              statusCode: 401, isSuccess: false, dataResponse: e.error);

          debugPrint('401 repo');
        } else if (e.response?.statusCode == 404) {
          response = RepositoriesResponse(
              statusCode: 404, isSuccess: false, dataResponse: e.toString());

          debugPrint('404 repo');
        }
      } else {
        response = RepositoriesResponse(
            statusCode: 500, isSuccess: false, dataResponse: e.toString());

        debugPrint('status code 500');
      }
    }
    response = RepositoriesResponse(
        statusCode: 500, isSuccess: false, dataResponse: 'failed to connect');

    debugPrint('status code 500');

    return response;
  }
}
