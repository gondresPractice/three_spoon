import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:tiga_sendok_app/data/service/api_service.dart';
import 'package:tiga_sendok_app/utils/dio_interceptor.dart';

class AppServices {
  final Dio dio;

  AppServices(this.dio);

  final get = GetIt.I;

  registerPickupClientToken(String url) async {
    // get.unregister<LoginService>();
    dio.interceptors.clear();

    dio.interceptors.add(LogInterceptor(
        responseBody: true,
        requestBody: true,
        requestHeader: true,
        error: true));
    dio.interceptors.add(DioInterceptor());
    if (!get.isRegistered<ApiService>()) {
      get.registerFactory(() => ApiService(dio, baseUrl: url));
    } else {
      get.unregister<ApiService>();
      get.registerFactory(() => ApiService(dio, baseUrl: url));
    }

    //   if (!get.isRegistered<LoginService>()) {
    //     get.registerFactory(() => LoginService(dio, baseUrl: url));
    //   } else {
    //     get.unregister<LoginService>();

    //     get.registerFactory(() => LoginService(dio, baseUrl: url));
    //   }
    // }
  }
}
