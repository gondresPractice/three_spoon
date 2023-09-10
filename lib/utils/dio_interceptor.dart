import 'package:dio/dio.dart';
import 'package:tiga_sendok_app/utils/shared_pref.dart';

class DioInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await SharedPref.getToken();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = "Bearer ${token}";
    }
    options.headers['Accept'] = 'application/json';
    super.onRequest(options, handler);
  }
}
