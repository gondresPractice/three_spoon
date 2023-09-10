import 'package:flutter/cupertino.dart';
import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:tiga_sendok_app/data/service/api_service.dart';

import '../model/repositories_response.dart';

class PreLoginRepositories {
  Future<RepositoriesResponse> registerUser(
      String name, String username, String password) async {
    final services = GetIt.I.get<ApiService>();

    late RepositoriesResponse response;

    try {
      await services.registerUser(name, username, password).then((value) {
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

  Future<RepositoriesResponse> loginUser(
      String username, String password) async {
    final services = GetIt.I.get<ApiService>();

    late RepositoriesResponse response;

    try {
      await services.loginUser(username, password).then((value) {
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
