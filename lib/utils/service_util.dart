import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';

class ServiceUtil {
  final get = GetIt.instance;

  static String accessType = 'rpm_express_shipment';
  static String applicationJson = 'application/json';

  void initNetwork() {
    final dio = Dio();

    dio.options.headers['Accept'] = applicationJson;

    if (!get.isRegistered<Dio>()) {
      get.registerSingleton<Dio>(dio);
    }
  }
}
