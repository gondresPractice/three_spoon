import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:provider/provider.dart';
import 'package:tiga_sendok_app/data/service/api_service.dart';
import 'package:tiga_sendok_app/page/login_screen.dart';
import 'package:tiga_sendok_app/page/register_screen.dart';
import 'package:tiga_sendok_app/provider/customer_provider.dart';
import 'package:tiga_sendok_app/provider/order_provider.dart';
import 'package:tiga_sendok_app/provider/pre_login_provider.dart';
import 'package:tiga_sendok_app/utils/app_services.dart';
import 'package:dio/dio.dart';
import 'package:tiga_sendok_app/utils/widgets/button_widgets.dart';
import 'package:tiga_sendok_app/utils/widgets/get_widgets.dart';
import 'utils/service_util.dart';
import 'package:tiga_sendok_app/base/base_url.dart' as basePath;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final dio = Dio();
  final service = ApiService(Dio());
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PreLoginProvider(service),
      child: ChangeNotifierProvider(
        create: (context) => CustomerProvider(service),
        child: ChangeNotifierProvider(
          create: (context) => OrderProvider(service),
          child: MaterialApp(
            title: 'Flutter Demo',
            theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
              useMaterial3: false,
            ),
            home: const MyHomePage(title: 'Flutter Demo Home Page'),
            debugShowCheckedModeBanner: false,
          ),
        ),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final serviceUtil = ServiceUtil();

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }

  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

  @override
  void initState() {
    registerAppServices();
    super.initState();
  }

  Future<void> registerAppServices() async {
    serviceUtil.initNetwork();
    final appServices = AppServices(GetIt.I.get<Dio>());
    await appServices.registerPickupClientToken(basePath.baseUrl);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GetWidget().getLogoImage(300, 450),
            ButtonPrimary(btnClick: _navigateToRegister, text: "Register"),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: ButtonOutline(btnClick: _navigateToLogin, text: "Login"),
            )
          ],
        ),
      ),
    );
  }
}
