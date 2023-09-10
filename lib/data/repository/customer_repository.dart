import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:tiga_sendok_app/data/service/api_service.dart';

import '../model/repositories_response.dart';

class CustomerRepositories {
  Future<RepositoriesResponse> getListCustomer() async {
    final services = GetIt.I.get<ApiService>();

    late RepositoriesResponse response;

    try {
      await services.getListCustomer().then((value) {
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

  Future<RepositoriesResponse> createNewCustomer(
      String name, String gender, int phoneNum) async {
    final services = GetIt.I.get<ApiService>();

    late RepositoriesResponse response;

    try {
      await services.createNewCustomer(name, gender, phoneNum).then((value) {
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

  Future<RepositoriesResponse> updateCustomer(
      int customerId, String name, String gender, int phoneNum) async {
    final services = GetIt.I.get<ApiService>();

    late RepositoriesResponse response;

    try {
      await services
          .updateCustomer(customerId, name, gender, phoneNum)
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

  Future<RepositoriesResponse> deleteCustomer(int id) async {
    final services = GetIt.I.get<ApiService>();

    late RepositoriesResponse response;

    try {
      await services.deleteCustomer(id).then((value) {
        response = RepositoriesResponse(
            statusCode: 200, isSuccess: true, dataResponse: null);
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
